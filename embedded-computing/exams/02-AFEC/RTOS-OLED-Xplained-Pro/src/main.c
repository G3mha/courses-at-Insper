#include <asf.h>
#include "conf_board.h"

#include "gfx_mono_ug_2832hsweg04.h"
#include "gfx_mono_text.h"
#include "sysfont.h"

/************************************************************************/
/* BOARD CONFIG                                                         */
/************************************************************************/

#define BUT_PLACA_PIO     PIOA
#define BUT_PLACA_PIO_ID  ID_PIOA
#define BUT_PLACA_PIO_PIN 11
#define BUT_PLACA_PIO_PIN_MASK (1 << BUT_PLACA_PIO_PIN)

#define AFEC_POT AFEC0
#define AFEC_POT_ID ID_AFEC0
#define AFEC_POT_CHANNEL 0 // Canal do pino PD30

/************************************************************************/
/* RTOS                                                                 */
/************************************************************************/

#define TASK_ADC_STACK_SIZE (1024 * 10 / sizeof(portSTACK_TYPE))
#define TASK_ADC_STACK_PRIORITY (tskIDLE_PRIORITY)

#define TASK_OLED_STACK_SIZE                (1024*6/sizeof(portSTACK_TYPE))
#define TASK_OLED_STACK_PRIORITY            (tskIDLE_PRIORITY)

extern void vApplicationStackOverflowHook(xTaskHandle *pxTask,  signed char *pcTaskName);
extern void vApplicationIdleHook(void);
extern void vApplicationTickHook(void);
extern void vApplicationMallocFailedHook(void);
extern void xPortSysTickHandler(void);

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
/* recursos RTOS                                                        */
/************************************************************************/

TimerHandle_t xTimer;
QueueHandle_t xQueueADC;
QueueHandle_t xQueueProc;

typedef struct {
	uint value;
} adcData;

/************************************************************************/
/* flags                                                                */
/************************************************************************/

volatile char flag_limpa_tela = 0;
volatile char flag_estado1 = 1;
volatile char flag_estado2 = 0;
volatile char flag_estado3 = 0;
volatile char flag_estado4 = 0;
volatile char flag_init_contagem = 0;
volatile char flag_init_contagem2 = 0;
volatile int contagem = 5;

/************************************************************************/
/* RTT                                                                  */
/************************************************************************/
static void RTT_init(float freqPrescale, uint32_t IrqNPulses, uint32_t rttIRQSource) {
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
	if (contagem > 0) {
		contagem--;
		configure_rtt_chronometer(1);
	} else {
		flag_limpa_tela = 1;
		flag_estado3 = 0;
		flag_estado4 = 1;
		flag_init_contagem2 = 1;
		contagem = 5;
	}
}

/************************************************************************/
/* prototypes                                                           */
/************************************************************************/

void but_callback(void);
static void BUT_init(void);
static void config_AFEC_pot(Afec *afec, uint32_t afec_id, uint32_t afec_channel,
                            afec_callback_t callback);
static void configure_console(void);

/************************************************************************/
/* handlers / callbacks                                                 */
/************************************************************************/

void but_callback(void) {
	flag_limpa_tela = 1; 
	if (flag_estado1) {
		flag_estado1 = 0;
		flag_estado2 = 1;
	}
	else if (flag_estado2) {
		flag_estado2 = 0;
		flag_estado3 = 1;
		flag_init_contagem = 1;
	} else if (flag_estado3) {
		rtt_disable_interrupt(RTT, RTT_MR_RTTINCIEN | RTT_MR_ALMIEN);
		flag_limpa_tela = 0;
		flag_estado1 = 1;
		flag_estado2 = 0;
		flag_estado3 = 0;
		flag_estado4 = 0;
		flag_init_contagem = 0;
		flag_init_contagem2 = 0;
		contagem = 5;
	}
}

static void AFEC_pot_callback(void) {
	adcData adc;
	adc.value = afec_channel_get_value(AFEC_POT, AFEC_POT_CHANNEL);
	BaseType_t xHigherPriorityTaskWoken = pdTRUE;
	xQueueSendFromISR(xQueueADC, &adc, &xHigherPriorityTaskWoken);
}

/************************************************************************/
/* tasks                                                                */
/************************************************************************/

static void task_oled(void *pvParameters) {
	gfx_mono_ssd1306_init();
	adcData adc;
	int32_t tempo_selecionado = 0;
	for (;;)
	{
		if (flag_limpa_tela) {
			gfx_mono_ssd1306_init();
			flag_limpa_tela = 0;
		}

		if (flag_estado1) {
			gfx_mono_draw_string("PRESSIONE PARA", 0, 0, &sysfont);
			gfx_mono_draw_string("AJUSTAR TEMPO", 0, 20, &sysfont);
		}

		if (flag_estado2) {
			char buf[5];
			if (xQueueReceive(xQueueProc, &(adc), 1000)) {
				tempo_selecionado = adc.value * 5;
			}
			sprintf(buf, "%05d", tempo_selecionado);
			gfx_mono_draw_string("AJUSTE!!!", 0, 0, &sysfont);
			gfx_mono_draw_string(buf, 0, 20, &sysfont);
		}

		if (flag_estado3) {
			if (flag_init_contagem) {
				configure_rtt_chronometer(1);
				flag_init_contagem = 0;
			}
			char texto_tempo_selecionado[5];
			sprintf(texto_tempo_selecionado, "%05d", tempo_selecionado);
			char texto_contagem[14];
			sprintf(texto_contagem, "CONTAGEM EM: %d", contagem);
			gfx_mono_draw_string(texto_contagem, 0, 0, &sysfont);
			gfx_mono_draw_string(texto_tempo_selecionado, 0, 20, &sysfont);
		}

		if (flag_estado4) {
			gfx_mono_ssd1306_init();
			char texto_tempo_selecionado2[5];
			sprintf(texto_tempo_selecionado2, "%05d", tempo_selecionado);
			gfx_mono_draw_string("CONTAGEM INICIADA!!!", 0, 0, &sysfont);
			gfx_mono_draw_string(texto_tempo_selecionado2, 0, 20, &sysfont);
			if (flag_init_contagem2) {
				tempo_selecionado = tempo_selecionado + 500;
				flag_init_contagem2 = 0;
			}
			tempo_selecionado = tempo_selecionado - 500;
			printf("%d\n", tempo_selecionado);
			if (tempo_selecionado < 0) {
				printf("entrou");
				flag_limpa_tela = 1;
				flag_estado1 = 1;
				flag_estado2 = 0;
				flag_estado3 = 0;
				flag_estado4 = 0;
				flag_init_contagem = 0;
				flag_init_contagem2 = 0;
				contagem = 5;
			} else {
				vTaskDelay(500);
			}
		}
	}
}


void vTimerCallback(TimerHandle_t xTimer) {
	afec_channel_enable(AFEC_POT, AFEC_POT_CHANNEL);
	afec_start_software_conversion(AFEC_POT);
}

static void task_adc(void *pvParameters) {
  // configura ADC e TC para controlar a leitura
	config_AFEC_pot(AFEC_POT, AFEC_POT_ID, AFEC_POT_CHANNEL, AFEC_pot_callback);
	xTimer = xTimerCreate("Timer", 100, pdTRUE, (void *)0, vTimerCallback);
	xTimerStart(xTimer, 0);
	// variável para recever dados da fila
	adcData adc;
	for (;;) {
    	// if (xQueueReceive(xQueueProc, &(adc), 1000)) {
      	// 	printf("ADC: %d \n", (adc.value*5));
		// }
	}
}

static void task_proc(void *pvParameters) {
	int32_t current_reading = 0;
  	for (;;) {
    	if (xQueueReceive(xQueueADC, (void *)&current_reading, 1000)) {
			xQueueSend(xQueueProc, &current_reading, 0);
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

	/* Configure console UART. */
	stdio_serial_init(CONF_UART, &uart_serial_options);

	/* Specify that stdout should not be buffered. */
	setbuf(stdout, NULL);
}

static void BUT_init(void) {

	/* conf botão como entrada */
	pio_configure(BUT_PLACA_PIO, PIO_INPUT, BUT_PLACA_PIO_PIN_MASK, PIO_PULLUP | PIO_DEBOUNCE);
	pio_set_debounce_filter(BUT_PLACA_PIO, BUT_PLACA_PIO_PIN_MASK, 60);
	
	
	pio_handler_set(BUT_PLACA_PIO,
					BUT_PLACA_PIO_ID,
					BUT_PLACA_PIO_PIN_MASK,
					PIO_IT_FALL_EDGE,
					but_callback);
					
	pio_enable_interrupt(BUT_PLACA_PIO, BUT_PLACA_PIO_PIN_MASK);
	pio_get_interrupt_status(BUT_PLACA_PIO);
	
	/* configura prioridae */
	NVIC_EnableIRQ(BUT_PLACA_PIO_ID);
	NVIC_SetPriority(BUT_PLACA_PIO_ID, 4);
	
}

static void config_AFEC_pot(Afec *afec, uint32_t afec_id, uint32_t afec_channel,
                            afec_callback_t callback) {
	/*************************************
	* Ativa e configura AFEC
	*************************************/
	/* Ativa AFEC - 0 */
	afec_enable(afec);

	/* struct de configuracao do AFEC */
	struct afec_config afec_cfg;

	/* Carrega parametros padrao */
	afec_get_config_defaults(&afec_cfg);

	/* Configura AFEC */
	afec_init(afec, &afec_cfg);

	/* Configura trigger por software */
	afec_set_trigger(afec, AFEC_TRIG_SW);

	/*** Configuracao específica do canal AFEC ***/
	struct afec_ch_config afec_ch_cfg;
	afec_ch_get_config_defaults(&afec_ch_cfg);
	afec_ch_cfg.gain = AFEC_GAINVALUE_0;
	afec_ch_set_config(afec, afec_channel, &afec_ch_cfg);

	/*
	* Calibracao:
	* Because the internal ADC offset is 0x200, it should cancel it and shift
	down to 0.
	*/
	afec_channel_set_analog_offset(afec, afec_channel, 0x200);

	/***  Configura sensor de temperatura ***/
	struct afec_temp_sensor_config afec_temp_sensor_cfg;

	afec_temp_sensor_get_config_defaults(&afec_temp_sensor_cfg);
	afec_temp_sensor_set_config(afec, &afec_temp_sensor_cfg);

	/* configura IRQ */
	afec_set_callback(afec, afec_channel, callback, 1);
	NVIC_SetPriority(afec_id, 4);
	NVIC_EnableIRQ(afec_id);
}

/************************************************************************/
/* main                                                                 */
/************************************************************************/

int main(void) {
	/* Initialize the SAM system */
	sysclk_init();
	board_init();
	BUT_init();

  	WDT->WDT_MR = WDT_MR_WDDIS;

	/* Initialize the console uart */
	configure_console();

	xQueueADC = xQueueCreate(100, sizeof(adcData));
	if (xQueueADC == NULL)
		printf("falha em criar a queue xQueueADC \n");

	xQueueProc = xQueueCreate(100, sizeof(adcData));
	if (xQueueProc == NULL)
		printf("falha em criar a queue xQueueProc \n");

	if (xTaskCreate(task_adc, "ADC", TASK_ADC_STACK_SIZE, NULL,
					TASK_ADC_STACK_PRIORITY, NULL) != pdPASS) {
		printf("Failed to create test ADC task\r\n");
	}

	if (xTaskCreate(task_proc, "PROC", TASK_ADC_STACK_SIZE, NULL,
					TASK_ADC_STACK_PRIORITY, NULL) != pdPASS) {
		printf("Failed to create test PROC task\r\n");
	}

	/* Create task to control oled */
	if (xTaskCreate(task_oled, "oled", TASK_OLED_STACK_SIZE, NULL, TASK_OLED_STACK_PRIORITY, NULL) != pdPASS) {
	  printf("Failed to create oled task\r\n");
	}

	/* Start the scheduler. */
	vTaskStartScheduler();

  /* RTOS não deve chegar aqui !! */
	while(1){}

	/* Will only get here if there was insufficient memory to create the idle task. */
	return 0;
}
