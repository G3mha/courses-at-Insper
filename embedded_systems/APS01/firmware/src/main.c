#include <asf.h>

#include "gfx_mono_ug_2832hsweg04.h"
#include "gfx_mono_text.h"
#include "sysfont.h"
// Includes
#include "mario.h"
#include "godfather.h"
#include "cantina.h"
#include "notes.h"

// Define buzzer
#define BUZZER_PIO      PIOA
#define BUZZER_PIO_ID    ID_PIOA
#define BUZZER_PIO_IDX   3
#define BUZZER_PIO_IDX_MASK  (1 << BUZZER_PIO_IDX)

// Define start/pause
#define START_PIO PIOD
#define START_PIO_ID ID_PIOD
#define START_PIO_IDX 28
#define START_PIO_IDX_MASK (1u << START_PIO_IDX)

// Define seleção
#define SELECAO_PIO PIOC
#define SELECAO_PIO_ID ID_PIOC
#define SELECAO_PIO_IDX 31
#define SELECAO_PIO_IDX_MASK (1u << SELECAO_PIO_IDX)

// Define LED
#define LED_1_PIO           PIOA
#define LED_1_PIO_ID        ID_PIOA
#define LED_1_PIO_IDX       0
#define LED_1_PIO_IDX_MASK  (1 << LED_1_PIO_IDX)

#define BAR_X 45
#define BAR_Y 16
#define BAR_WIDTH 50
#define BAR_HEIGHT 15
#define WIDTH_OLED 128
#define HEIGHT_OLED 32
#define TIME_BUZZER_TEST 5000.0

// Variaveis globais
volatile char but_pause_flag;
volatile char but_selecao_flag;

// CallBacks
void but_pause_callback()
{
	if (but_pause_flag)
	but_pause_flag = 0;
	else
	but_pause_flag = 1;
}

void but_selecao_callback()
{
	but_selecao_flag = 1;
}

typedef struct
{
	char name[32];
	int size;
	int tempo;
	int *melody;
} music ;

void play_music(music musica, int *pcurr_music);
void buzzer_test(int freq);
void tone(int freq, int time);
void led_on(void);
void led_off(void);
void gfx_clear(void);
void init(void);

/**
 * freq: Frequecia em Hz
 * time: Tempo em ms que o tom deve ser gerado
 */
void tone(int freq, int time){
    double periodo_s = (double) 1 / freq;
	int periodo_us = periodo_s * 1e6;

	int n_de_iter = time / (periodo_s * 1000);
	int cont = 0;
	while(cont < n_de_iter) {
		if (!but_pause_flag) {
			pio_set(BUZZER_PIO, BUZZER_PIO_IDX_MASK);
			delay_us(periodo_us / 2);
			pio_clear(BUZZER_PIO, BUZZER_PIO_IDX_MASK);
			delay_us(periodo_us / 2);
			cont++;	
		}
	}
}

// Recebe freq em hz e toca essa freq pelo tempo definido em TIME_BUZZER_TEST (padrao 5s = 5000ms)
void buzzer_test(int freq) {
	double periodo_s = (double) 1 / freq;
	int periodo_us = periodo_s * 1e6;
	int n_iter = TIME_BUZZER_TEST / (periodo_s * 1000);
	
	for (int i = 0; i < n_iter; i++) {
		pio_set(BUZZER_PIO, BUZZER_PIO_IDX_MASK);
		delay_us(periodo_us / 2);
		pio_clear(BUZZER_PIO, BUZZER_PIO_IDX_MASK);
		delay_us(periodo_us / 2);
	}
}

void led_on(void) {
	pio_clear(LED_1_PIO, LED_1_PIO_IDX_MASK);
}

void led_off(void) {
	pio_set(LED_1_PIO, LED_1_PIO_IDX_MASK);
}

void gfx_clear(void) {
	for (int x = 0; x < WIDTH_OLED; x++) {
		for (int y = 0; y < HEIGHT_OLED; y++) {
			gfx_mono_draw_pixel(x, y, GFX_PIXEL_CLR);
		}
	}
}

void play_music(music musica, int *pcurr_music) {
	int divider = 0, noteDuration = 0;
	const int wholenote = (60000 * 4) / musica.tempo;
	
	int *melody = musica.melody;
	int notes = musica.size;
	// iterate over the notes of the melody.
	gfx_mono_draw_string(musica.name, 0, 0, &sysfont);
	
	// Desenha retangulo para o progresso
	gfx_mono_draw_rect(BAR_X, BAR_Y, BAR_WIDTH, BAR_HEIGHT, GFX_PIXEL_SET);
	
	// Remember, the array is twice the number of notes (notes + durations)
	for (int thisNote = 0; thisNote < notes * 2; thisNote = thisNote + 2) {
		gfx_mono_draw_filled_rect(BAR_X, BAR_Y, BAR_WIDTH * thisNote/(notes * 2), BAR_HEIGHT, GFX_PIXEL_SET);

		// calculates the duration of each note
		divider = melody[thisNote + 1];
		noteDuration = (wholenote) / abs(divider);
		if (divider < 0) {
			noteDuration *= 1.5; // increases the duration in half for dotted notes
		}
		
		// Se aperta o botao de selecao de musica, incrementa a musica
		if (but_selecao_flag) {
			*pcurr_music = *pcurr_music + 1;
			if ((*pcurr_music) > 2) {
				*pcurr_music = 0;
			}
			but_selecao_flag = 0;
			break;
		}

		
		if (melody[thisNote] == REST) {
			led_off();
		} else {
			led_on();
		}
		// we only play the note for 90% of the duration, leaving 10% as a pause
		tone(melody[thisNote], noteDuration * 0.9);

		// Wait for the specified duration before playing the next note.
		led_off();
		delay_ms(noteDuration);

	}
	gfx_clear();
}


void init(void) {
	// Ativa o pino de controle do buzzer.
	pmc_enable_periph_clk(BUZZER_PIO_ID);
	pio_set_output(BUZZER_PIO, BUZZER_PIO_IDX_MASK, 0, 0, 0);
	
	// Inicializa PIO do botao start/pause
	pmc_enable_periph_clk(START_PIO_ID);
	pio_set_input(START_PIO, START_PIO_IDX_MASK, PIO_DEFAULT);
	pio_pull_up(START_PIO, START_PIO_IDX_MASK, 1);
		 
	pio_handler_set(START_PIO,
	START_PIO_ID,
	START_PIO_IDX_MASK,
	PIO_IT_RISE_EDGE,
	but_pause_callback);

	 // Ativa interrupção e limpa primeira IRQ gerada na ativacao
	 pio_enable_interrupt(START_PIO, START_PIO_IDX_MASK);
	 pio_get_interrupt_status(START_PIO);
	
	// Configura NVIC para receber interrupcoes do PIO do botao start/pause
	// com prioridade 4 (quanto mais próximo de 0 maior)
	NVIC_EnableIRQ(START_PIO_ID);
	NVIC_SetPriority(START_PIO_ID, 4);
	
	
	// Inicializa PIO do botao de selecao da musica
	pmc_enable_periph_clk(SELECAO_PIO_ID);
	pio_set_input(SELECAO_PIO, SELECAO_PIO_IDX_MASK, PIO_DEFAULT);
	pio_pull_up(SELECAO_PIO, SELECAO_PIO_IDX_MASK, 1);
	
	pio_handler_set(SELECAO_PIO,
	SELECAO_PIO_ID,
	SELECAO_PIO_IDX_MASK,
	PIO_IT_RISE_EDGE,
	but_selecao_callback);
	
	// Ativa interrupção e limpa primeira IRQ gerada na ativacao
	pio_enable_interrupt(SELECAO_PIO, SELECAO_PIO_IDX_MASK);
	pio_get_interrupt_status(SELECAO_PIO);
	
	
	// Configura NVIC para receber interrupcoes do PIO do botao start/pause
	// com prioridade 4 (quanto mais próximo de 0 maior)
	NVIC_EnableIRQ(SELECAO_PIO_ID);
	NVIC_SetPriority(SELECAO_PIO_ID, 4);
	
	// Ativa o PIO do led 1
	pmc_enable_periph_clk(LED_1_PIO_ID);
	pio_set_output(LED_1_PIO, LED_1_PIO_IDX_MASK, 1, 0, 0);
}

int main (void)
{
	board_init();
	sysclk_init();
	delay_init();
	init();

  // Init OLED
	gfx_mono_ssd1306_init();
  
    int size_mario = sizeof(melody_mario) / sizeof(melody_mario[0]) / 2;
	int size_godfather = sizeof(melody_godfather) / sizeof(melody_godfather[0]) / 2;
	int size_cantina = sizeof(melody_cantina) / sizeof(melody_cantina[0]) / 2;
	
	
	
	music mario = {"Mario theme", size_mario, MARIO_TEMPO, &melody_mario};
	music godfather = {"Godfather", size_godfather, GODFATHER_TEMPO, &melody_godfather};
	music cantina = {"Cantina", size_cantina, CANTINA_TEMPO, &melody_cantina};
	music musics[] = {mario, godfather, cantina};

	int curr_music = 0;

  /* Insert application code here, after the board has been initialized. */
	while(1) {
		play_music(musics[curr_music], &curr_music);
	}
}
