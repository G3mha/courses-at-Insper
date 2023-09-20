/**
 * 5 semestre - Eng. da Computação - Insper
 * Rafael Corsi - rafael.corsi@insper.edu.br
 *
 * Projeto 0 para a placa SAME70-XPLD
 *
 * Objetivo :
 *  - Introduzir ASF e HAL
 *  - Configuracao de clock
 *  - Configuracao pino In/Out
 *
 * Material :
 *  - Kit: ATMEL SAME70-XPLD - ARM CORTEX M7
 */

/************************************************************************/
/* includes                                                             */
/************************************************************************/

#include "asf.h"

/************************************************************************/
/* defines                                                              */
/************************************************************************/


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
/* constants                                                            */
/************************************************************************/

/************************************************************************/
/* variaveis globais                                                    */
/************************************************************************/

/************************************************************************/
/* prototypes                                                           */
/************************************************************************/

void init(void);

/************************************************************************/
/* interrupcoes                                                         */
/************************************************************************/

/************************************************************************/
/* funcoes                                                              */
/************************************************************************/

// Function to start the uC
void init(void){
	// Initialize the board clock
	sysclk_init();

	// Deactivate WatchDog Timer
	WDT->WDT_MR = WDT_MR_WDDIS;
	
	// Activate the PIO that the LED connects
	// so we can control the LED.
	pmc_enable_periph_clk(LED1_PIO_ID);
	pmc_enable_periph_clk(LED2_PIO_ID);
	pmc_enable_periph_clk(LED3_PIO_ID);
	
	// Set LED_PIO as output (no multi drive and no pull-up resistor)
	pio_set_output(LED1_PIO, LED1_PIO_IDX_MASK, 0, 0, 0);
	pio_set_output(LED2_PIO, LED2_PIO_IDX_MASK, 0, 0, 0);
	pio_set_output(LED3_PIO, LED3_PIO_IDX_MASK, 0, 0, 0);
	
	// Initialize the PIO from SW
	pmc_enable_periph_clk(BUT1_PIO_ID);
	pmc_enable_periph_clk(BUT2_PIO_ID);
	pmc_enable_periph_clk(BUT3_PIO_ID);

	// Set the pin connected to SW as input with pull-up.
	pio_set_input(BUT1_PIO, BUT1_PIO_IDX_MASK, PIO_DEFAULT);
	pio_set_input(BUT2_PIO, BUT2_PIO_IDX_MASK, PIO_DEFAULT);
	pio_set_input(BUT3_PIO, BUT3_PIO_IDX_MASK, PIO_DEFAULT);
	
	// Activate the pull-up
	pio_pull_up(BUT1_PIO, BUT1_PIO_IDX_MASK, 1);
	pio_pull_up(BUT2_PIO, BUT2_PIO_IDX_MASK, 1);
	pio_pull_up(BUT3_PIO, BUT3_PIO_IDX_MASK, 1);
}

/************************************************************************/
/* Main                                                                 */
/************************************************************************/

// Funcao principal chamada na inicalizacao do uC.
int main(void)
{
	init();

	// super loop
	// embedded applications should not exit the while(1).
	while (1)
	{
		// Check value of the pin that SW is connected
		if (!pio_get(BUT1_PIO, PIO_INPUT, BUT1_PIO_IDX_MASK)) {
			// Blink LED
			for (int i = 0; i < 5; i++) {
				pio_clear(LED1_PIO, LED1_PIO_IDX_MASK); // Clean the pin for LED_PIO_PIN (on)
				delay_ms(100);
				pio_set(LED1_PIO, LED1_PIO_IDX_MASK); // Activate the pin for LED_PIO_PIN (off)
				delay_ms(100);
		  	}
	  	} 
		if (pio_get(BUT1_PIO, PIO_INPUT, BUT1_PIO_IDX_MASK)) {
			// Activate the LED_IDX pin (off)
			pio_set(LED1_PIO, LED1_PIO_IDX_MASK);
	  	}

		if (!pio_get(BUT2_PIO, PIO_INPUT, BUT2_PIO_IDX_MASK)) {
			// Blink LED
			for (int i = 0; i < 5; i++) {
				pio_clear(LED2_PIO, LED2_PIO_IDX_MASK); // Clean the pin for LED_PIO_PIN (on)
				delay_ms(100);
				pio_set(LED2_PIO, LED2_PIO_IDX_MASK); // Activate the pin for LED_PIO_PIN (off)
				delay_ms(100);
			}
	  	}
	  	if (pio_get(BUT2_PIO, PIO_INPUT, BUT2_PIO_IDX_MASK)) {
			// Activate the LED_IDX pin (off)
			pio_set(LED2_PIO, LED2_PIO_IDX_MASK);
		}

		if (!pio_get(BUT3_PIO, PIO_INPUT, BUT3_PIO_IDX_MASK)) {
			// Blink LED
			for (int i = 0; i < 5; i++) {
				pio_clear(LED3_PIO, LED3_PIO_IDX_MASK); // Clean the pin for LED_PIO_PIN (on)
				delay_ms(100);
				pio_set(LED3_PIO, LED3_PIO_IDX_MASK); // Activate the pin for LED_PIO_PIN (off)
				delay_ms(100);
		  	}
		}
	  	if (pio_get(BUT3_PIO, PIO_INPUT, BUT3_PIO_IDX_MASK)) {
			// Activate the LED_IDX pin (off)
			pio_set(LED3_PIO, LED3_PIO_IDX_MASK);
		}
	}
	return 0;
}
