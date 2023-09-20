#include "conf_board.h"
#include <asf.h>

/************************************************************************/
/* BOARD CONFIG                                                         */
/************************************************************************/

#define BUT_PIO PIOA
#define BUT_PIO_ID ID_PIOA
#define BUT_PIO_PIN 11
#define BUT_PIO_PIN_MASK (1 << BUT_PIO_PIN)

#define BUT1_XPLAINED_PIO PIOD
#define BUT1_XPLAINED_PIO_ID ID_PIOD
#define BUT1_XPLAINED_PIO_IDX 28
#define BUT1_XPLAINED_PIO_IDX_MASK (1 << BUT1_XPLAINED_PIO_IDX)

#define LED_PIO PIOC
#define LED_PIO_ID ID_PIOC
#define LED_PIO_IDX 8
#define LED_IDX_MASK (1 << LED_PIO_IDX)

#define USART_COM_ID ID_USART1
#define USART_COM USART1

/************************************************************************/
/* RTOS                                                                */
/************************************************************************/

#define TASK_LED_STACK_SIZE (4096 / sizeof(portSTACK_TYPE))
#define TASK_LED_STACK_PRIORITY (tskIDLE_PRIORITY)
#define TASK_BUT_STACK_SIZE (4096 / sizeof(portSTACK_TYPE))
#define TASK_BUT_STACK_PRIORITY (tskIDLE_PRIORITY)

extern void vApplicationStackOverflowHook(xTaskHandle *pxTask,
                                          signed char *pcTaskName);
extern void vApplicationIdleHook(void);
extern void vApplicationTickHook(void);
extern void vApplicationMallocFailedHook(void);
extern void xPortSysTickHandler(void);

/************************************************************************/
/* recursos RTOS                                                        */
/************************************************************************/

SemaphoreHandle_t xSemaphoreBut;
SemaphoreHandle_t xSemaphoreBut1;
QueueHandle_t xQueueLedFreq;
QueueHandle_t xQueueIncrement;

/************************************************************************/
/* prototypes local                                                     */
/************************************************************************/

void but_callback(void);
void but1_callback(void);
static void BUT_init(void);
void pin_toggle(Pio *pio, uint32_t mask);
static void USART1_init(void);
void LED_init(int estado);

/************************************************************************/
/* RTOS application funcs                                               */
/************************************************************************/

extern void vApplicationStackOverflowHook(xTaskHandle *pxTask,
                                          signed char *pcTaskName) {
  printf("stack overflow %x %s\r\n", pxTask, (portCHAR *)pcTaskName);
  for (;;) {
  }
}

extern void vApplicationIdleHook(void) { pmc_sleep(SAM_PM_SMODE_SLEEP_WFI); }

extern void vApplicationTickHook(void) {}

extern void vApplicationMallocFailedHook(void) {
  configASSERT((volatile void *)NULL);
}

/************************************************************************/
/* handlers / callbacks                                                 */
/************************************************************************/

void but_callback(void) {
  BaseType_t xHigherPriorityTaskWoken = pdFALSE;
  xSemaphoreGiveFromISR(xSemaphoreBut, &xHigherPriorityTaskWoken);
  int32_t increment = -100;
  xQueueSendFromISR(xQueueIncrement, (void *)&increment, &xHigherPriorityTaskWoken);
}

void but1_callback(void) {
  BaseType_t xHigherPriorityTaskWoken = pdFALSE;
  xSemaphoreGiveFromISR(xSemaphoreBut1, &xHigherPriorityTaskWoken);
  int32_t increment = 100;
  xQueueSendFromISR(xQueueIncrement, (void *)&increment, &xHigherPriorityTaskWoken);
}

/************************************************************************/
/* TASKS                                                                */
/************************************************************************/

static void task_led(void *pvParameters) {
  LED_init(1);
  uint32_t msg = 0;
  uint32_t delayMs = 2000;
  /* tarefas de um RTOS não devem retornar */
  for (;;) {
    /* verifica se chegou algum dado na queue, e espera por 0 ticks */
    if (xQueueReceive(xQueueLedFreq, &msg, (TickType_t) 0)) {
      /* chegou novo valor, atualiza delay ! */
      /* aqui eu poderia verificar se msg faz sentido (se esta no range certo)
       */
      /* converte ms -> ticks */
      delayMs = msg / portTICK_PERIOD_MS;
      printf("task_led: %d \n", delayMs);
    }
    /* pisca LED */
    pin_toggle(LED_PIO, LED_IDX_MASK);
    /* suspende por delayMs */
    vTaskDelay(delayMs);
  }
}

static void task_but(void *pvParameters) {
  BUT_init();
  uint32_t delayTicks = 2000;
  for (;;) {
    int32_t increment = 0;
    xQueueReceive(xQueueIncrement, &increment, (TickType_t) 0);
    if (increment != 0) {
      delayTicks += increment;
      increment = 0;
      xQueueSend(xQueueIncrement, (void *)&increment, 10);
      xQueueSend(xQueueLedFreq, (void *)&delayTicks, 10);
      // printf("task_but: %d \n", delayTicks);
      if (delayTicks == 100) {
        delayTicks = 900;
      }
      // printf("task_but: %d \n", delayTicks);
    }
  }
}

/************************************************************************/
/* funcoes                                                              */
/************************************************************************/


static void configure_console(void) {
  const usart_serial_options_t uart_serial_options = {
      .baudrate = CONF_UART_BAUDRATE,
      .charlength = CONF_UART_CHAR_LENGTH,
      .paritytype = CONF_UART_PARITY,
      .stopbits = CONF_UART_STOP_BITS,
  };
  stdio_serial_init(CONF_UART, &uart_serial_options);
  setbuf(stdout, NULL);
}

void pin_toggle(Pio *pio, uint32_t mask) {
  if (pio_get_output_data_status(pio, mask))
    pio_clear(pio, mask);
  else
    pio_set(pio, mask);
}

void LED_init(int estado){
	pmc_enable_periph_clk(LED_PIO_ID);
	pio_set_output(LED_PIO, LED_IDX_MASK, estado, 0, 0);
};


static void BUT_init(void) {
  pio_configure(BUT_PIO, PIO_INPUT, BUT_PIO_PIN_MASK, PIO_PULLUP);
  pio_configure(BUT1_XPLAINED_PIO, PIO_INPUT, BUT1_XPLAINED_PIO_IDX_MASK, PIO_PULLUP);
  pio_handler_set(BUT_PIO,BUT_PIO_ID,BUT_PIO_PIN_MASK,PIO_IT_FALL_EDGE,but_callback);
  pio_handler_set(BUT1_XPLAINED_PIO,BUT1_XPLAINED_PIO_ID,BUT1_XPLAINED_PIO_IDX_MASK,PIO_IT_FALL_EDGE,but1_callback);
  pio_enable_interrupt(BUT_PIO, BUT_PIO_PIN_MASK);
  pio_enable_interrupt(BUT1_XPLAINED_PIO, BUT1_XPLAINED_PIO_IDX_MASK);
  pio_get_interrupt_status(BUT_PIO);
  pio_get_interrupt_status(BUT1_XPLAINED_PIO);
  NVIC_EnableIRQ(BUT_PIO_ID);
  NVIC_EnableIRQ(BUT1_XPLAINED_PIO_ID);
  NVIC_SetPriority(BUT_PIO_ID, 4);
  NVIC_SetPriority(BUT1_XPLAINED_PIO_ID, 5);
}

/************************************************************************/
/* main                                                                 */
/************************************************************************/

int main(void) {
  sysclk_init();
  board_init();
  configure_console();
  printf("Sys init ok \n");
  /* Attempt to create a semaphore. */
  xSemaphoreBut = xSemaphoreCreateBinary();
  xSemaphoreBut1 = xSemaphoreCreateBinary();
  if (xSemaphoreBut == NULL || xSemaphoreBut1 == NULL)
    printf("falha em criar os semaforos \n");
  /* cria queue com 32 "espacos" */
  /* cada espaço possui o tamanho de um inteiro*/
  xQueueLedFreq = xQueueCreate(32, sizeof(uint32_t));
  xQueueIncrement = xQueueCreate(32, sizeof(uint32_t));
  if (xQueueLedFreq == NULL || xQueueIncrement == NULL)
    printf("falha em criar as queues \n");
  /* Create task to make led blink */
  if (xTaskCreate(task_led, "Led", TASK_LED_STACK_SIZE, NULL, TASK_LED_STACK_PRIORITY, NULL) != pdPASS) {
    printf("Failed to create test led task\r\n");
  } else {
     printf("task led created \r\n");
  }
  /* Create task to monitor processor activity */
  if (xTaskCreate(task_but, "BUT", TASK_BUT_STACK_SIZE, NULL, TASK_BUT_STACK_PRIORITY, NULL) != pdPASS) {
    printf("Failed to create UartTx task\r\n");
  } else {
     printf("task led but \r\n");  
  }
  /* Start the scheduler. */
  vTaskStartScheduler();
  /* RTOS não deve chegar aqui !! */
  while (1) {
  }
  /* Will only get here if there was insufficient memory to create the idle
   * task. */
  return 0;
}
