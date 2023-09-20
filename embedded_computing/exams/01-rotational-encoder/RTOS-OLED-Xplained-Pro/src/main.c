#include <asf.h>
#include "conf_board.h"

#include "gfx_mono_ug_2832hsweg04.h"
#include "gfx_mono_text.h"
#include "sysfont.h"

/* SW button in PD30 */
#define SW_PIO     PIOD
#define SW_PIO_ID  ID_PIOD
#define SW_PIO_PIN 30
#define SW_PIO_PIN_MASK (1 << SW_PIO_PIN)

/* DT in PA06 */
#define DT_PIO     PIOA
#define DT_PIO_ID  ID_PIOA
#define DT_PIO_PIN 6
#define DT_PIO_PIN_MASK (1 << DT_PIO_PIN)

/* CLK in PC19 */
#define CLK_PIO     PIOC
#define CLK_PIO_ID  ID_PIOC
#define CLK_PIO_PIN 19
#define CLK_PIO_PIN_MASK (1 << CLK_PIO_PIN)

/* LED in PC08 */
#define LED_PIO     PIOC
#define LED_PIO_ID  ID_PIOC
#define LED_PIO_PIN 8
#define LED_PIO_PIN_MASK (1 << LED_PIO_PIN)

/** RTOS  */
#define TASK_OLED_STACK_SIZE                (1024*6/sizeof(portSTACK_TYPE))
#define TASK_OLED_STACK_PRIORITY            (tskIDLE_PRIORITY)

#define TASK_PRINTCONSOLE_STACK_SIZE                (1024*6/sizeof(portSTACK_TYPE))
#define TASK_PRINTCONSOLE_STACK_PRIORITY            (tskIDLE_PRIORITY)

extern void vApplicationStackOverflowHook(xTaskHandle *pxTask,  signed char *pcTaskName);
extern void vApplicationIdleHook(void);
extern void vApplicationTickHook(void);
extern void vApplicationMallocFailedHook(void);
extern void xPortSysTickHandler(void);

/** prototypes */
static void task_oled(void *pvParameters);
static void task_sw(void *pvParameters);
static void task_rotation(void *pvParameters);
void sw_callback(void);
void rotation_callback(void);
static void peripheral_init(void);
static void RTT_init(float freqPrescale, uint32_t IrqNPulses, uint32_t rttIRQSource);
SemaphoreHandle_t xSWSemaphore;
SemaphoreHandle_t xDTSemaphore;
SemaphoreHandle_t xCLKSemaphore;

/************************************************************************/
/* RTOS application funcs                                               */
/************************************************************************/

extern void vApplicationStackOverflowHook(xTaskHandle *pxTask, signed char *pcTaskName) {
	printf("stack overflow %x %s\r\n", pxTask, (portCHAR *)pcTaskName);
	for (;;) {	}
}

extern void vApplicationIdleHook(void) { }

extern void vApplicationTickHook(void) { }

extern void vApplicationMallocFailedHook(void) {
	configASSERT( ( volatile void * ) NULL );
}

/************************************************************************/
/* flags                                                                */
/************************************************************************/
volatile char long_press_flag = 0;
volatile char cancel_long_press_flag = 0;
volatile char current_digit_flag = 1;
volatile char clk_flag = 0;
volatile char dt_flag = 0;
volatile char rotation_flag = 1;
volatile int digit1 = 0;
volatile int digit2 = 0;
volatile int digit3 = 0;
volatile int digit4 = 0;
/************************************************************************/
/* RTT                                                                  */
/************************************************************************/
/** 
 * Configura RTT
 *
 * arg0 pllPreScale  : Frequência na qual o contador irá incrementar
 * arg1 IrqNPulses   : Valor do alarme 
 * arg2 rttIRQSource : Pode ser uma 
 *     - 0: 
 *     - RTT_MR_RTTINCIEN: Interrupção por incremento (pllPreScale)
 *     - RTT_MR_ALMIEN : Interrupção por alarme
 */
static void RTT_init(float freqPrescale, uint32_t IrqNPulses, uint32_t rttIRQSource) {

  uint16_t pllPreScale = (int) (((float) 32768) / freqPrescale);
	
  rtt_sel_source(RTT, false);
  rtt_init(RTT, pllPreScale);
  
  if (rttIRQSource & RTT_MR_ALMIEN) {
	uint32_t ul_previous_time;
  	ul_previous_time = rtt_read_timer_value(RTT);
  	while (ul_previous_time == rtt_read_timer_value(RTT));
  	rtt_write_alarm_time(RTT, IrqNPulses+ul_previous_time);
  }

  /* config NVIC */
  NVIC_DisableIRQ(RTT_IRQn);
  NVIC_ClearPendingIRQ(RTT_IRQn);
  NVIC_SetPriority(RTT_IRQn, 4);
  NVIC_EnableIRQ(RTT_IRQn);

  /* Enable RTT interrupt */
  if (rttIRQSource & (RTT_MR_RTTINCIEN | RTT_MR_ALMIEN))
	rtt_enable_interrupt(RTT, rttIRQSource);
  else
	rtt_disable_interrupt(RTT, RTT_MR_RTTINCIEN | RTT_MR_ALMIEN);
		  
}

void configure_rtt_chronometer(int timer_time) {
    // Configure the RTT to generate an interrupt every 1 second
	int freqPrescale = 10;
    uint32_t IrqNPulses = freqPrescale * timer_time;
    RTT_init(freqPrescale, IrqNPulses, RTT_MR_ALMIEN);
}

void RTT_Handler(void) { // RTT interrupt handler (ISR) - this function will be called every 1 second
    uint32_t status = rtt_get_status(RTT);
	if (!cancel_long_press_flag) {
		long_press_flag = 1;
	}
}
/************************************************************************/
/* handlers / callbacks                                                 */
/************************************************************************/
void sw_callback(void) {
	if (pio_get(SW_PIO, PIO_INPUT, SW_PIO_PIN_MASK)) { // if rise edge
		if (long_press_flag) {
		} else {
			cancel_long_press_flag = 1;
		}
		BaseType_t xHigherPriorityTaskWoken = pdTRUE;
		xSemaphoreGiveFromISR(xSWSemaphore, &xHigherPriorityTaskWoken);
	} else { // if fall edge
		cancel_long_press_flag = 0;
		configure_rtt_chronometer(5);
	}
}

void rotation_callback(void) {
	if (rotation_flag) { // if both are high or low
		dt_flag = pio_get(DT_PIO, PIO_INPUT, DT_PIO_PIN_MASK);
		clk_flag = pio_get(CLK_PIO, PIO_INPUT, CLK_PIO_PIN_MASK);
	}
	rotation_flag = !rotation_flag;
	printf("DT: %d\r\n", dt_flag);
	printf("CLK: %d\r\n", clk_flag);
	if (clk_flag && !dt_flag) { // if fall edge in DT first
		BaseType_t xHigherPriorityTaskWoken = pdTRUE;
		xSemaphoreGiveFromISR(xDTSemaphore, &xHigherPriorityTaskWoken);
	} else if (!clk_flag && dt_flag) { // if fall edge in CLK first
		BaseType_t xHigherPriorityTaskWoken = pdTRUE;
		xSemaphoreGiveFromISR(xCLKSemaphore, &xHigherPriorityTaskWoken);
	}
}

/************************************************************************/
/* TASKS                                                                */
/************************************************************************/
static void task_sw(void *pvParameters) {
	for (;;) {
		if (xSemaphoreTake(xSWSemaphore, portMAX_DELAY) == pdTRUE) {
			if (long_press_flag) { // if the SW is pressed for more than 5 seconds
				digit1 = 0;
				digit2 = 0;
				digit3 = 0;
				digit4 = 0;
				long_press_flag = 0;
				current_digit_flag = 1;
			} else { // if it is a quick press
				current_digit_flag++;
				if (current_digit_flag > 4) current_digit_flag = 1;
			}
		}
	}
}

static void task_rotation(void *pvParameters) {
	for (;;) {
		// rotation in clockwise direction
		if (xSemaphoreTake(xCLKSemaphore, portMAX_DELAY) == pdTRUE) {
			if (current_digit_flag == 1) {
				digit1++;
				if (digit1 > 15) digit1 = 0;
			} else if (current_digit_flag == 2) {
				digit2++;
				if (digit2 > 15) digit2 = 0;
			} else if (current_digit_flag == 3) {
				digit3++;
				if (digit3 > 15) digit3 = 0;
			} else if (current_digit_flag == 4) {
				digit4++;
				if (digit4 > 15) digit4 = 0;
			}
		}
		// rotation in counter-clockwise direction
		if (xSemaphoreTake(xDTSemaphore, portMAX_DELAY) == pdTRUE) {
			printf("DT here: %d\r\n", dt_flag);
			if (current_digit_flag == 1) {
				digit1--;
				if (digit1 < 0) digit1 = 15;
			} else if (current_digit_flag == 2) {
				digit2--;
				if (digit2 < 0) digit2 = 15;
			} else if (current_digit_flag == 3) {
				digit3--;
				if (digit3 < 0) digit3 = 15;
			} else if (current_digit_flag == 4) {
				digit4--;
				if (digit4 < 0) digit4 = 15;
			}
		}
	}
}

static void task_oled(void *pvParameters) {
	gfx_mono_ssd1306_init();
	uint32_t i = 0;
	volatile char temp = '0';
	char buf[6];
	char n1, n2, n3, n4;
	char hex_chars[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
	for (;;)
	{
		n1 = hex_chars[digit1];
		n2 = hex_chars[digit2];
		n3 = hex_chars[digit3];
		n4 = hex_chars[digit4];
		if (i % 2 == 0) { 
			// change the current number to underscore
			if (current_digit_flag == 1) {
				n1 = '_';
			} else if (current_digit_flag == 2) {
				n2 = '_';
			} else if (current_digit_flag == 3) {
				n3 = '_';
			} else if (current_digit_flag == 4) {
				n4 = '_';
			}
			sprintf(buf, "%c%c%c%c%c%c", '0', 'x', n1, n2, n3, n4);
		} else {
			sprintf(buf, "%c%c%c%c%c%c", '0', 'x', n1, n2, n3, n4);
		}
		if (i > 100) i = 0;

		gfx_mono_draw_string(buf, 0, 20, &sysfont);
		
		vTaskDelay(500);
		i++;
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

	/* Configure console UART. */
	stdio_serial_init(CONF_UART, &uart_serial_options);

	/* Specify that stdout should not be buffered. */
	setbuf(stdout, NULL);
}

static void peripheral_init(void) {
	/* conf botão como entrada */
	pio_configure(SW_PIO, PIO_INPUT, SW_PIO_PIN_MASK, PIO_PULLUP | PIO_DEBOUNCE);
	pio_configure(CLK_PIO, PIO_INPUT, CLK_PIO_PIN_MASK, PIO_PULLUP | PIO_DEBOUNCE);
	pio_configure(DT_PIO, PIO_INPUT, DT_PIO_PIN_MASK, PIO_PULLUP | PIO_DEBOUNCE);
	pio_set_debounce_filter(SW_PIO, SW_PIO_PIN_MASK, 60);
	pio_set_debounce_filter(CLK_PIO, CLK_PIO_PIN_MASK, 60);
	pio_set_debounce_filter(DT_PIO, DT_PIO_PIN_MASK, 60);
	
	
	pio_handler_set(SW_PIO,
					SW_PIO_ID,
					SW_PIO_PIN_MASK,
					PIO_IT_EDGE, // interrupt on both edges
					sw_callback);
	pio_handler_set(CLK_PIO,
					CLK_PIO_ID,
					CLK_PIO_PIN_MASK,
					PIO_IT_FALL_EDGE, // interrupt on both edges
					rotation_callback);
	pio_handler_set(DT_PIO,
					DT_PIO_ID,
					DT_PIO_PIN_MASK,
					PIO_IT_FALL_EDGE, // interrupt on both edges
					rotation_callback);

	pio_enable_interrupt(SW_PIO, SW_PIO_PIN_MASK);
	pio_enable_interrupt(CLK_PIO, CLK_PIO_PIN_MASK);
	pio_enable_interrupt(DT_PIO, DT_PIO_PIN_MASK);
	pio_get_interrupt_status(SW_PIO);
	pio_get_interrupt_status(CLK_PIO);
	pio_get_interrupt_status(DT_PIO);
	
	/* configura prioridae */
	NVIC_EnableIRQ(SW_PIO_ID);
	NVIC_EnableIRQ(CLK_PIO_ID);
	NVIC_EnableIRQ(DT_PIO_ID);
	NVIC_SetPriority(SW_PIO_ID, 4);
	NVIC_SetPriority(CLK_PIO_ID, 4);
	NVIC_SetPriority(DT_PIO_ID, 4);
}

/************************************************************************/
/* main                                                                 */
/************************************************************************/


int main(void) {
	/* Initialize the SAM system */
	sysclk_init();
	board_init();
	peripheral_init();

  	WDT->WDT_MR = WDT_MR_WDDIS;

	/* Initialize the console uart */
	configure_console();

	xSWSemaphore = xSemaphoreCreateBinary();
	xCLKSemaphore = xSemaphoreCreateBinary();
	xDTSemaphore = xSemaphoreCreateBinary();
 	if (xSWSemaphore == NULL | xCLKSemaphore == NULL | xDTSemaphore == NULL) {
    	printf("falha em criar os semaforos\r\n");
	}
	/* Create task to control oled */
	if (xTaskCreate(task_oled, "oled", TASK_OLED_STACK_SIZE, NULL, TASK_OLED_STACK_PRIORITY, NULL) != pdPASS) {
	  printf("Failed to create oled task\r\n");
	}

	if (xTaskCreate(task_sw, "sw", TASK_PRINTCONSOLE_STACK_SIZE, NULL, TASK_PRINTCONSOLE_STACK_PRIORITY, NULL) != pdPASS) {
		printf("Failed to create sw task\r\n");
	}

	if (xTaskCreate(task_rotation, "rotation", TASK_PRINTCONSOLE_STACK_SIZE, NULL, TASK_PRINTCONSOLE_STACK_PRIORITY, NULL) != pdPASS) {
		printf("Failed to create rotation task\r\n");
	}
	/* Start the scheduler. */
	vTaskStartScheduler();

  /* RTOS não deve chegar aqui !! */
	while(1){}

	/* Will only get here if there was insufficient memory to create the idle task. */
	return 0;
}
