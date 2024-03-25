#include <asf.h>
#include "conf_board.h"

#include "gfx_mono_ug_2832hsweg04.h"
#include "gfx_mono_text.h"
#include "sysfont.h"

#define OLED_height 32
#define OLED_width 120
#define time_min 2*0.000058

#define ECHO_PIO				PIOA //PA06
#define ECHO_PIO_ID			    ID_PIOA
#define ECHO_PIO_IDX			6
#define ECHO_PIO_IDX_MASK		(1 << ECHO_PIO_IDX)

#define TRIG_PIO				PIOD //PD30
#define TRIG_PIO_ID				ID_PIOD 
#define TRIG_PIO_IDX			30
#define TRIG_PIO_IDX_MASK		(1 << TRIG_PIO_IDX)

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
void echo_callback(void);

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
/* flags / constants                                                    */
/************************************************************************/
volatile int rise_flag = 1;
volatile int update_flag = 0;
volatile int fail_flag = 0;
volatile int distance = 0;
const uint16_t pllPreScale = 1.9;

/************************************************************************/
/* handlers / callbacks                                                 */
/************************************************************************/
void echo_callback(void) {
	if (rise_flag) { // rising edge
		rtt_init(RTT, pllPreScale); // start timer
	} else { // falling edge
		update_flag = 1; // set update flag
		uint32_t time = rtt_read_timer_value(RTT); // read timer
		if (time > 2 && time < 400) { // check if time is in range of 2us and 400us
			// calculate distance in m based on the equation: distance = (time * speed of sound) / 2
			distance = (time * 340000000) / 2;
		}
		if (time < 2) { // if time is less than 2us, wait and set distance to 0
			distance = 0;
		}
		else { // no measurement was possible
			fail_flag = 1; // if time is greater than 400us, set fail flag
		}
	}
	rise_flag = !rise_flag; // toggle rise flag
}

/************************************************************************/
/* TASKS                                                                */
/************************************************************************/

static void task_oled(void *pvParameters) {
  gfx_mono_draw_string("Measuring...", 0,16, &sysfont);

	uint32_t cont=0;
	for (;;)
	{
		char buf[3];
		
		cont++;
		
		sprintf(buf,"%03d",cont);
		gfx_mono_draw_string(buf, 0, 20, &sysfont);

		vTaskDelay(1000);
	}
}


static void task_printConsole(void *pvParameters) {
	
	uint32_t cont=0;
	for (;;)
	{		
		cont++;
		
		printf("%03d\n",cont);
		
		vTaskDelay(1000);
	}
}

/************************************************************************/
/* funcoes                                                              */
/************************************************************************/

void io_init(void) {	
	pmc_enable_periph_clk(TRIG_PIO_ID); // enable clock for Trigger
	pio_configure(TRIG_PIO, PIO_OUTPUT_0, TRIG_PIO_IDX_MASK, PIO_DEFAULT); // set Trigger as output
	
	pmc_enable_periph_clk(ECHO_PIO_ID); // enable clock for Echo
	pio_configure(ECHO_PIO, PIO_INPUT, ECHO_PIO_IDX_MASK, PIO_DEFAULT); // set Echo as input
	pio_handler_set(ECHO_PIO,ECHO_PIO_ID,ECHO_PIO_IDX_MASK,PIO_IT_EDGE,echo_callback); // set callback for Echo
	pio_enable_interrupt(ECHO_PIO, ECHO_PIO_IDX_MASK); // enable interrupt for Echo
	pio_get_interrupt_status(ECHO_PIO); // clear interrupt flag
	NVIC_EnableIRQ(ECHO_PIO_ID); // enable interrupt in NVIC
	NVIC_SetPriority(ECHO_PIO_ID, 4); // set priority
}

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

/************************************************************************/
/* main                                                                 */
/************************************************************************/


int main(void) {
	/* Initialize the SAM system */
	sysclk_init();
	board_init();
	io_init();
	delay_init();
	gfx_mono_ssd1306_init();

	WDT->WDT_MR = WDT_MR_WDDIS;
 
	for(int i = 0; i <= 300; i++) {
		if (i == 300) {
			i = 0; // reset counter
			pio_set(TRIG_PIO, TRIG_PIO_IDX_MASK); // set Trigger high
			delay_us(10); // wait 10us
			pio_clear(TRIG_PIO, TRIG_PIO_IDX_MASK); // set Trigger low
		}
		if (update_flag) { // if update flag is set
			update_flag = !update_flag; // toggle update flag
			if (fail_flag) { // if fail flag is set
				fail_flag = !fail_flag; // clear fail flag
				gfx_mono_draw_string("No measurement", 0, 16, &sysfont); // print no measurement
			} else { // if fail flag is not set
				char buf[3];
				sprintf(buf,"%03d",distance); // convert distance to string
				gfx_mono_draw_string(buf, 0, 16, &sysfont); // print distance
			}
		}
		delay_ms(1); // wait 1ms
	}
}
