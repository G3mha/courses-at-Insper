
/************************************************************************/
/* includes                                                             */
/************************************************************************/

#include <asf.h>
#include "gfx_mono_ug_2832hsweg04.h"
#include "gfx_mono_text.h"
#include "sysfont.h"
#include <string.h>

/************************************************************************/
/* defines                                                              */
/************************************************************************/
// LED1 da Placa
#define LED1_PIO           PIOA
#define LED1_PIO_ID        ID_PIOA
#define LED1_PIO_IDX       0
#define LED1_PIO_IDX_MASK (1 << LED1_PIO_IDX)

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
/* constants                                                            */
/************************************************************************/

/************************************************************************/
/* variaveis globais                                                    */
/************************************************************************/
/************************************************************************/
/* flags */
/************************************************************************/
volatile char but1_flag = 0;
volatile char but2_flag = 0;
volatile char but3_flag = 0;
volatile int frequency = 1;
/************************************************************************/
/* prototype                                                            */
/************************************************************************/
void but1_callback(void);
void but2_callback(void);
void but3_callback(void);
void handle_frequency(int is_up);
void io_init(void);
/************************************************************************/
/* handler / callbacks */
/************************************************************************/
void but1_callback(void) {
	but1_flag = !but1_flag;
}

void but2_callback(void) {
	but2_flag = !but2_flag;
}

void but3_callback(void) {
	but3_flag = !but3_flag;
}

void handle_frequency(int is_up) {
	if (frequency <= 10 && is_up) {
		frequency += 1;
	}
	if (frequency > 1 && !is_up) {
		frequency -= 1;
	}
};
/************************************************************************/
/* functions                                                              */
/************************************************************************/
void io_init(void) {
	// Inicializa clock do periférico PIO responsavel pelo LED1
	pmc_enable_periph_clk(LED1_PIO_ID);
	pio_configure(LED1_PIO, PIO_OUTPUT_0, LED1_PIO_IDX_MASK, PIO_DEBOUNCE);
	
  	// Inicializa clock do periférico PIO responsavel pelo botao
	pmc_enable_periph_clk(BUT1_PIO_ID);
	pmc_enable_periph_clk(BUT2_PIO_ID);
	pmc_enable_periph_clk(BUT3_PIO_ID);
	
	// Configura PIO para lidar com o pino do botão como entrada
  	// com pull-up	
	pio_configure(BUT1_PIO, PIO_INPUT, BUT1_PIO_IDX_MASK, PIO_PULLUP | PIO_DEBOUNCE);
	pio_configure(BUT2_PIO, PIO_INPUT, BUT2_PIO_IDX_MASK, PIO_PULLUP | PIO_DEBOUNCE);
	pio_configure(BUT3_PIO, PIO_INPUT, BUT3_PIO_IDX_MASK, PIO_PULLUP | PIO_DEBOUNCE);
  	pio_set_debounce_filter(BUT1_PIO, BUT1_PIO_IDX_MASK, 60);
  	pio_set_debounce_filter(BUT2_PIO, BUT2_PIO_IDX_MASK, 60);
  	pio_set_debounce_filter(BUT3_PIO, BUT3_PIO_IDX_MASK, 60);
	
	// Configura interrupção no pino referente ao botao e associa
	// função de callback caso uma interrupção for gerada
	// a função de callback é a: but_callback()
	pio_handler_set(BUT1_PIO, BUT1_PIO_ID, BUT1_PIO_IDX_MASK, PIO_IT_RISE_EDGE, but1_callback);
	pio_handler_set(BUT2_PIO, BUT2_PIO_ID, BUT2_PIO_IDX_MASK, PIO_IT_FALL_EDGE, but2_callback);
	pio_handler_set(BUT3_PIO, BUT3_PIO_ID, BUT3_PIO_IDX_MASK, PIO_IT_FALL_EDGE, but3_callback);

	// Ativa interrupção e limpa primeira IRQ gerada na ativacao
	pio_enable_interrupt(BUT1_PIO, BUT1_PIO_IDX_MASK);
	pio_enable_interrupt(BUT2_PIO, BUT2_PIO_IDX_MASK);
	pio_enable_interrupt(BUT3_PIO, BUT3_PIO_IDX_MASK);
  	pio_get_interrupt_status(BUT1_PIO);
  	pio_get_interrupt_status(BUT2_PIO);
  	pio_get_interrupt_status(BUT3_PIO);
	
	// Configura NVIC para receber interrupcoes do PIO do botao
  	// com prioridade 4 (quanto mais próximo de 0 maior)
  	NVIC_EnableIRQ(BUT1_PIO_ID);
	NVIC_EnableIRQ(BUT2_PIO_ID);
	NVIC_EnableIRQ(BUT3_PIO_ID);
	NVIC_SetPriority(BUT1_PIO_ID, 4);
	NVIC_SetPriority(BUT2_PIO_ID, 4);
	NVIC_SetPriority(BUT3_PIO_ID, 4);
}
/************************************************************************/
/* Main                                                                 */
/************************************************************************/
int main (void) {
	board_init();
	sysclk_init();
	delay_init();
	gfx_mono_ssd1306_init();
	io_init();

	while(1) {
		char str1[14];
		char str2[14];
		int base_time = 30000;
		int delay = 1000000/frequency;
		int max_i = (1000*base_time/delay);
		for (int i=0; i< max_i; i++) {
			if (but1_flag) {
				handle_frequency(1);
				gfx_mono_draw_string("+", 90,0, &sysfont);
				delay_ms(500);
				gfx_mono_draw_string(" ", 90,0, &sysfont);
				but1_flag = 0;
			}
			if (but3_flag) {
				handle_frequency(0);
				gfx_mono_draw_string("-", 20,0, &sysfont);
				delay_ms(500);
				gfx_mono_draw_string(" ", 20,0, &sysfont);
				but3_flag = 0;
			}
			delay = 1000000/frequency;
			max_i = (1000*base_time/delay);
			while(but2_flag==1){
				gfx_mono_draw_string("    PAUSE    ", 0,16, &sysfont);
			}
			but2_flag = 0;
			
			float temp = (13*i)/max_i;
			int progress = (int) temp;
			strcpy (str1," ");
			strcpy (str2,"xxxxxxxxxxxxx");
			strncat (str1, str2, progress);
			gfx_mono_draw_string("             ", 0,16, &sysfont);
			gfx_mono_draw_string(str1, 0,16, &sysfont);
			
			char snum[5];
			itoa(frequency, snum, 10);
			gfx_mono_draw_string(snum, 40,0, &sysfont);
			gfx_mono_draw_string("Hz", 60,0, &sysfont);

			pio_clear(LED1_PIO, LED1_PIO_IDX_MASK);
			delay_us(delay/2);
			pio_set(LED1_PIO, LED1_PIO_IDX_MASK);
			delay_us(delay/2);
		}			
		pmc_sleep(SAM_PM_SMODE_SLEEP_WFI);
	}
}
