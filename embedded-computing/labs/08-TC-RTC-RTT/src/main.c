/************************************************************************/
/* includes                                                             */
/************************************************************************/
#include <asf.h>
#include "conf_board.h"
#include "gfx_mono_ug_2832hsweg04.h"
#include "gfx_mono_text.h"
#include "sysfont.h"

/************************************************************************/
/* defines                                                              */
/************************************************************************/
// LED in PC08
#define LED_PIO           PIOC
#define LED_PIO_ID        ID_PIOC
#define LED_PIO_IDX       8
#define LED_PIO_IDX_MASK  (1 << LED_PIO_IDX)

// Configurations for the LED 1 (PA0)
#define LED1_PIO           PIOA                 // peripheral that controls the LED1
#define LED1_PIO_ID        ID_PIOA              // ID from peripheral PIOA (controls LED1)
#define LED1_PIO_IDX       0                    // ID from LED1 in PIO
#define LED1_PIO_IDX_MASK  (1 << LED1_PIO_IDX)   // Mask to CONTROL the LED1

// Configurations for the LED 2 (PC30)
#define LED2_PIO           PIOC                 // peripheral that controls the LED2
#define LED2_PIO_ID        ID_PIOC              // ID from peripheral PIOC (controls LED2)
#define LED2_PIO_IDX       30                    // ID from LED2 in PIO
#define LED2_PIO_IDX_MASK  (1 << LED2_PIO_IDX)   // Mask to CONTROL the LED2

// Configurations for the LED 3 (PB2)
#define LED3_PIO           PIOB                 // peripheral that controls the LED3
#define LED3_PIO_ID        ID_PIOB              // ID from peripheral PIOB (controls LED3)
#define LED3_PIO_IDX       2                    // ID from LED3 in PIO
#define LED3_PIO_IDX_MASK  (1 << LED3_PIO_IDX)   // Mask to CONTROL the LED3

// Configurations for the button 1 (PD28)
#define BUT1_PIO           PIOD               // peripheral that controls the BUT1
#define BUT1_PIO_ID        ID_PIOD            // ID from peripheral PIOD (controls BUT1) 
#define BUT1_PIO_IDX       28                 // ID from BUT1 in PIO
#define BUT1_PIO_IDX_MASK (1u << BUT1_PIO_IDX) // Already done

// Configurations for the button 2 (PC31)
#define BUT2_PIO           PIOC               // peripheral that controls the BUT2
#define BUT2_PIO_ID        ID_PIOC            // ID from peripheral PIOC (controls BUT2)
#define BUT2_PIO_IDX       31                 // ID from BUT2 in PIO
#define BUT2_PIO_IDX_MASK (1u << BUT2_PIO_IDX) // Already done

// Configurations for the button 3 (PA19)
#define BUT3_PIO           PIOA               // peripheral that controls the BUT3
#define BUT3_PIO_ID        ID_PIOA            // ID from peripheral PIOA (controls BUT3)
#define BUT3_PIO_IDX       19                 // ID from BUT3 in PIO
#define BUT3_PIO_IDX_MASK (1u << BUT3_PIO_IDX) // Already done

/************************************************************************/
/* RTOS                                                                 */
/************************************************************************/
#define TASK_OLED_STACK_SIZE                (1024*6/sizeof(portSTACK_TYPE))
#define TASK_OLED_STACK_PRIORITY            (tskIDLE_PRIORITY)

#define TASK_PISCA_LED_STACK_SIZE                (1024*6/sizeof(portSTACK_TYPE))
#define TASK_PISCA_LED_STACK_PRIORITY            (tskIDLE_PRIORITY)

extern void vApplicationStackOverflowHook(xTaskHandle *pxTask,  signed char *pcTaskName);
extern void vApplicationIdleHook(void);
extern void vApplicationTickHook(void);
extern void vApplicationMallocFailedHook(void);
extern void xPortSysTickHandler(void);

/************************************************************************/
/* prototypes                                                           */
/************************************************************************/
void but1_callback(void);
void but2_callback(void);
void but3_callback(void);
static void init(void);
void configure_rtt_chronometer(int timer_time);
void pin_toggle(Pio *pio, uint32_t mask);
void pisca_led(int n, int t);

typedef struct  {
  uint32_t year;
  uint32_t month;
  uint32_t day;
  uint32_t week;
  uint32_t hour;
  uint32_t minute;
  uint32_t second;
} calendar;

/************************************************************************/
/* flags                                                                */
/************************************************************************/
volatile char flag_pisca = 0;

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
/* handlers / callbacks                                                 */
/************************************************************************/
void but1_callback(void) {
	uint32_t current_hour, current_min, current_sec;
	uint32_t current_year, current_month, current_day, current_week;
	rtc_get_time(RTC, &current_hour, &current_min, &current_sec);
	rtc_get_date(RTC, &current_year, &current_month, &current_day, &current_week);
	rtc_set_date_alarm(RTC, 1, current_month, 1, current_day);
	rtc_set_time_alarm(RTC, 1, current_hour, 1, current_min, 1, current_sec + 20);
}

void but2_callback(void) {
}

void but3_callback(void) {
}

void TC1_Handler(void) {
	/** Interrupt handler for TC1 interrupt. */
	/**
	* Devemos indicar ao TC que a interrupção foi satisfeita.
	* Isso é realizado pela leitura do status do periférico
	**/
	volatile uint32_t status = tc_get_status(TC0, 1);
	printf("TC1_Handler\n\r");
	/** Muda o estado do LED (pisca) **/
	pin_toggle(LED1_PIO, LED1_PIO_IDX_MASK);  
}

void TC4_Handler(void) {
	/** Interrupt handler for TC1 interrupt. */
	/**
	* Devemos indicar ao TC que a interrupção foi satisfeita.
	* Isso é realizado pela leitura do status do periférico
	**/
	volatile uint32_t status2 = tc_get_status(TC1, 1);
	printf("TC2_Handler\n\r");
	/** Muda o estado do LED (pisca) **/
	pin_toggle(LED_PIO, LED_PIO_IDX_MASK);
}

void RTT_Handler(void) { // RTT interrupt handler (ISR) - this function will be called every 1 second
    uint32_t status = rtt_get_status(RTT);
	configure_rtt_chronometer(4);
	// pio get status write down
	if (pio_get(LED2_PIO, PIO_INPUT, LED2_PIO_IDX_MASK)) {
		pio_clear(LED2_PIO, LED2_PIO_IDX_MASK);
	} else {
		pio_set(LED2_PIO, LED2_PIO_IDX_MASK);
	}
}

void RTC_Handler(void) {
    uint32_t ul_status = rtc_get_status(RTC);
	
    /* Time or date alarm */
    if ((ul_status & RTC_SR_ALARM) == RTC_SR_ALARM) {
		flag_pisca = 1;
    }

    rtc_clear_status(RTC, RTC_SCCR_SECCLR);
    rtc_clear_status(RTC, RTC_SCCR_ALRCLR);
    rtc_clear_status(RTC, RTC_SCCR_ACKCLR);
    rtc_clear_status(RTC, RTC_SCCR_TIMCLR);
    rtc_clear_status(RTC, RTC_SCCR_CALCLR);
    rtc_clear_status(RTC, RTC_SCCR_TDERRCLR);
}

/************************************************************************/
/* tasks                                                                */
/************************************************************************/
static void task_oled(void *pvParameters) {
	gfx_mono_ssd1306_init();
	char buf[8] = "Loading ";
	uint32_t current_hour, current_min, current_sec;
	for (;;) {
		rtc_get_time(RTC, &current_hour, &current_min, &current_sec);
		sprintf(buf,"%d:%d:%d",current_hour,current_min,current_sec);
		gfx_mono_draw_string(buf, 0, 20, &sysfont);		
		vTaskDelay(500);
	}
}

static void task_pisca_led(void *pvParameters) {
	for (;;) {
		if (flag_pisca) {
			pin_toggle(LED3_PIO, LED3_PIO_IDX_MASK);
			vTaskDelay(500);
			pin_toggle(LED3_PIO, LED3_PIO_IDX_MASK);
			flag_pisca = 0;
		}
		pmc_sleep(SAM_PM_SMODE_SLEEP_WFI);
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

void RTC_init(Rtc *rtc, uint32_t id_rtc, calendar t, uint32_t irq_type) {
	pmc_enable_periph_clk(ID_RTC);

	rtc_set_hour_mode(rtc, 0);

	rtc_set_date(rtc, t.year, t.month, t.day, t.week);
	rtc_set_time(rtc, t.hour, t.minute, t.second);

	NVIC_DisableIRQ(id_rtc);
	NVIC_ClearPendingIRQ(id_rtc);
	NVIC_SetPriority(id_rtc, 4);
	NVIC_EnableIRQ(id_rtc);

	rtc_enable_interrupt(rtc,  irq_type);
}

void TC_init(Tc * TC, int ID_TC, int TC_CHANNEL, int freq){
	/**
	* Configura TimerCounter (TC) para gerar uma interrupcao no canal (ID_TC e TC_CHANNEL)
	* na taxa de especificada em freq.
	* O TimerCounter é meio confuso
	* o uC possui 3 TCs, cada TC possui 3 canais
	*	TC0 : ID_TC0, ID_TC1, ID_TC2
	*	TC1 : ID_TC3, ID_TC4, ID_TC5
	*	TC2 : ID_TC6, ID_TC7, ID_TC8
	*
	**/
	uint32_t ul_div;
	uint32_t ul_tcclks;
	uint32_t ul_sysclk = sysclk_get_cpu_hz();

	/* Configura o PMC */
	pmc_enable_periph_clk(ID_TC);

	/** Configura o TC para operar em  freq hz e interrupçcão no RC compare */
	tc_find_mck_divisor(freq, ul_sysclk, &ul_div, &ul_tcclks, ul_sysclk);
	
	/** ATIVA clock canal 0 TC */
	if(ul_tcclks == 0 )
	pmc_enable_pck(PMC_PCK_6);
	
	tc_init(TC, TC_CHANNEL, ul_tcclks | TC_CMR_CPCTRG);
	tc_write_rc(TC, TC_CHANNEL, (ul_sysclk / ul_div) / freq);

	/* Configura NVIC*/
	NVIC_SetPriority(ID_TC, 4);
	NVIC_EnableIRQ((IRQn_Type) ID_TC);
	tc_enable_interrupt(TC, TC_CHANNEL, TC_IER_CPCS);
}

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

static void init(void) {
	/* Initialize the SAM system */
	sysclk_init();
	board_init();

  	WDT->WDT_MR = WDT_MR_WDDIS;

	/* Initialize the console uart */
	configure_console();

	/* BUT1 */
	pio_configure(BUT1_PIO, PIO_INPUT, BUT1_PIO_IDX_MASK, PIO_PULLUP | PIO_DEBOUNCE);
	pio_set_debounce_filter(BUT1_PIO, BUT1_PIO_IDX_MASK, 60);
	pio_handler_set(BUT1_PIO,
					BUT1_PIO_ID,
					BUT1_PIO_IDX_MASK,
					PIO_IT_FALL_EDGE,
					but1_callback);
	pio_enable_interrupt(BUT1_PIO, BUT1_PIO_IDX_MASK);
	pio_get_interrupt_status(BUT1_PIO);
	// pmc_enable_periph_clk(BUT1_PIO_ID);
	NVIC_EnableIRQ(BUT1_PIO_ID);
	NVIC_SetPriority(BUT1_PIO_ID, 4);
	
	/* BUT2 */
	pio_configure(BUT2_PIO, PIO_INPUT, BUT2_PIO_IDX_MASK, PIO_PULLUP | PIO_DEBOUNCE);
	pio_set_debounce_filter(BUT2_PIO, BUT2_PIO_IDX_MASK, 60);
	pio_handler_set(BUT2_PIO,
					BUT2_PIO_ID,
					BUT2_PIO_IDX_MASK,
					PIO_IT_FALL_EDGE,
					but2_callback);					
	pio_enable_interrupt(BUT2_PIO, BUT2_PIO_IDX_MASK);
	pio_get_interrupt_status(BUT2_PIO);
	// pmc_enable_periph_clk(BUT2_PIO_ID);
	NVIC_EnableIRQ(BUT2_PIO_ID);
	NVIC_SetPriority(BUT2_PIO_ID, 4);
	
	/* BUT1 */
	pio_configure(BUT3_PIO, PIO_INPUT, BUT3_PIO_IDX_MASK, PIO_PULLUP | PIO_DEBOUNCE);
	pio_set_debounce_filter(BUT3_PIO, BUT3_PIO_IDX_MASK, 60);
	pio_handler_set(BUT3_PIO,
					BUT3_PIO_ID,
					BUT3_PIO_IDX_MASK,
					PIO_IT_FALL_EDGE,
					but3_callback);
					
	pio_enable_interrupt(BUT3_PIO, BUT1_PIO_IDX_MASK);
	pio_get_interrupt_status(BUT3_PIO);
	// pmc_enable_periph_clk(BUT3_PIO_ID);
	NVIC_EnableIRQ(BUT3_PIO_ID);
	NVIC_SetPriority(BUT3_PIO_ID, 4);
	
	/* LED da placa */
	pmc_enable_periph_clk(LED_PIO_ID);
	pio_set_output(LED_PIO, LED_PIO_IDX_MASK, 0, 0, 0);


	/* LED1 */
	pmc_enable_periph_clk(LED1_PIO_ID);
	pio_set_output(LED1_PIO, LED1_PIO_IDX_MASK, 0, 0, 0);

	/* LED2 */
	pmc_enable_periph_clk(LED2_PIO_ID);
	pio_set_output(LED2_PIO, LED2_PIO_IDX_MASK, 0, 0, 0);
	
	/* LED3 */
	pmc_enable_periph_clk(LED3_PIO_ID);
	pio_set_output(LED3_PIO, LED3_PIO_IDX_MASK, 0, 0, 0);

	/* TC  */
	TC_init(TC0, ID_TC1, 1, 4); // Configure timer TC0, canal 1
	tc_start(TC0, 1);
	TC_init(TC1, ID_TC4, 1, 5); // Configure timer TC1, canal 1
	tc_start(TC1, 1);

	/* RTT */
	configure_rtt_chronometer(4);

	/* RTC */
	pio_set(LED3_PIO, LED3_PIO_IDX_MASK);
	calendar rtc_initial = {2023, 5, 4, 18, 11, 22, 1};
	RTC_init(RTC, ID_RTC, rtc_initial, RTC_IER_ALREN);
}

void pin_toggle(Pio *pio, uint32_t mask) {
	if (pio_get_output_data_status(pio, mask))
	pio_clear(pio, mask);
	else
	pio_set(pio, mask);
}

/************************************************************************/
/* main                                                                 */
/************************************************************************/
int main(void) {
	init();

	/* Create task to control oled */
	if (xTaskCreate(task_oled, "oled", TASK_OLED_STACK_SIZE, NULL, TASK_OLED_STACK_PRIORITY, NULL) != pdPASS) {
	  printf("Failed to create oled task\r\n");
	}
	
	if (xTaskCreate(task_pisca_led, "pisca_led", TASK_PISCA_LED_STACK_SIZE, NULL, TASK_PISCA_LED_STACK_PRIORITY, NULL) != pdPASS) {
		printf("Failed to create pisca_led task\r\n");
	}
	
	/* Start the scheduler. */
	vTaskStartScheduler();

  /* RTOS não deve chegar aqui !! */
	while(1){}

	/* Will only get here if there was insufficient memory to create the idle task. */
	return 0;
}
