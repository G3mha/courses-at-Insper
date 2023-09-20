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

/*  Default pin configuration (no attribute). */
#define _PIO_DEFAULT             (0u << 0)
/*  The internal pin pull-up is active. */
#define _PIO_PULLUP              (1u << 0)
/*  The internal glitch filter is active. */
#define _PIO_DEGLITCH            (1u << 1)
/*  The internal debouncing filter is active. */
#define _PIO_DEBOUNCE            (1u << 3)

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

/**
 * \brief Set a high output level on all the PIOs defined in ul_mask.
 * This has no immediate effects on PIOs that are not output, but the PIO
 * controller will save the value if they are changed to outputs.
 *
 * \param p_pio Pointer to a PIO instance.
 * \param ul_mask Bitmask of one or more pin(s) to configure.
 */
void _pio_set(Pio *p_pio, const uint32_t ul_mask)
{
	p_pio->PIO_SODR = ul_mask;
}

/**
 * \brief Set a low output level on all the PIOs defined in ul_mask.
 * This has no immediate effects on PIOs that are not output, but the PIO
 * controller will save the value if they are changed to outputs.
 *
 * \param p_pio Pointer to a PIO instance.
 * \param ul_mask Bitmask of one or more pin(s) to configure.
 */
void _pio_clear(Pio *p_pio, const uint32_t ul_mask)
{
	p_pio->PIO_CODR = ul_mask;
}

/**
 * \brief Configure PIO internal pull-up.
 *
 * \param p_pio Pointer to a PIO instance.
 * \param ul_mask Bitmask of one or more pin(s) to configure.
 * \param ul_pull_up_enable Indicates if the pin(s) internal pull-up shall be
 * configured.
 */
void _pio_pull_up(Pio *p_pio, const uint32_t ul_mask, const uint32_t ul_pull_up_enable)
{
	if (ul_pull_up_enable) {
		p_pio->PIO_PUER = ul_mask;
	} else {
		p_pio->PIO_PUDR = ul_mask;
	}
}

/**
 * \brief Configure one or more pin(s) or a PIO controller as inputs.
 * Optionally, the corresponding internal pull-up(s) and glitch filter(s) can
 * be enabled.
 *
 * \param p_pio Pointer to a PIO instance.
 * \param ul_mask Bitmask indicating which pin(s) to configure as input(s).
 * \param ul_attribute PIO attribute(s).
 */
void _pio_set_input(Pio *p_pio, const uint32_t ul_mask, const uint32_t ul_attribute)
{
	// use _pio_pull_up() to enable/disable pull-up
	_pio_pull_up(p_pio, ul_mask, ul_attribute);
	
	if (ul_attribute & PIO_PULLUP) {
		p_pio->PIO_IFER = ul_mask;
	} else {
		p_pio->PIO_IFDR = ul_mask;
	}	
}

/**
 * \brief Configure one or more pin(s) of a PIO controller as outputs, with
 * the given default value. Optionally, the multi-drive feature can be enabled
 * on the pin(s).
 *
 * \param p_pio Pointer to a PIO instance.
 * \param ul_mask Bitmask indicating which pin(s) to configure.
 * \param ul_default_level Default level on the pin(s).
 * \param ul_multidrive_enable Indicates if the pin(s) shall be configured as
 * open-drain.
 * \param ul_pull_up_enable Indicates if the pin shall have its pull-up
 * activated.
 */
void _pio_set_output(Pio *p_pio, const uint32_t ul_mask,
        const uint32_t ul_default_level,
        const uint32_t ul_multidrive_enable,
        const uint32_t ul_pull_up_enable)
{
	// use _pio_pull_up() to enable/disable pull-up
	_pio_pull_up(p_pio, ul_mask, ul_pull_up_enable);
	
	if (ul_default_level) {
		p_pio->PIO_SODR = ul_mask;
	} else {
		p_pio->PIO_CODR = ul_mask;
	}
	
	if (ul_multidrive_enable) {
		p_pio->PIO_MDER = ul_mask;
	} else {
		p_pio->PIO_MDDR = ul_mask;
	}
	
	p_pio->PIO_OER = ul_mask;
	p_pio->PIO_PER = ul_mask;
}

/**
 * \brief Return 1 if one or more PIOs of the given Pin instance currently have
 * a high level; otherwise returns 0. This method returns the actual value that
 * is being read on the pin. To return the supposed output value of a pin, use
 * pio_get_output_data_status() instead.
 *
 * \param p_pio Pointer to a PIO instance.
 * \param ul_type PIO type.
 * \param ul_mask Bitmask of one or more pin(s) to configure.
 *
 * \retval 1 at least one PIO currently has a high level.
 * \retval 0 all PIOs have a low level.
 */
uint32_t _pio_get(Pio *p_pio, const pio_type_t ul_type,
        const uint32_t ul_mask)
{
	if (ul_type == PIO_INPUT) {
		return (p_pio->PIO_PDSR & ul_mask);
	} else {
		return (p_pio->PIO_ODSR & ul_mask);
	}
}

void _delay_ms(uint32_t ul_dly_ticks)
{
	// delay_cycles() is a function that delays the uC for a number of cycles
	// cpu_ms_2_cy() is a function that converts milliseconds to cycles
	// sysclk_get_cpu_hz() is a function that returns the CPU clock frequency
	delay_cycles(cpu_ms_2_cy(ul_dly_ticks, sysclk_get_cpu_hz()));
}
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
	_pio_set_output(LED1_PIO, LED1_PIO_IDX_MASK, 0, 0, 0);
	_pio_set_output(LED2_PIO, LED2_PIO_IDX_MASK, 0, 0, 0);
	_pio_set_output(LED3_PIO, LED3_PIO_IDX_MASK, 0, 0, 0);
	
	// Initialize the PIO from SW
	pmc_enable_periph_clk(BUT1_PIO_ID);
	pmc_enable_periph_clk(BUT2_PIO_ID);
	pmc_enable_periph_clk(BUT3_PIO_ID);

	_pio_set_input(BUT1_PIO, BUT1_PIO_IDX_MASK, _PIO_PULLUP | _PIO_DEBOUNCE);
	_pio_set_input(BUT2_PIO, BUT2_PIO_IDX_MASK, _PIO_PULLUP | _PIO_DEBOUNCE);
	_pio_set_input(BUT3_PIO, BUT3_PIO_IDX_MASK, _PIO_PULLUP | _PIO_DEBOUNCE);

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
		if (!_pio_get(BUT1_PIO, PIO_INPUT, BUT1_PIO_IDX_MASK)) {
			// Blink LED
			for (int i = 0; i < 5; i++) {
				_pio_clear(LED1_PIO, LED1_PIO_IDX_MASK); // Clean the pin for LED_PIO_PIN (on)
				_delay_ms(100);
				_pio_set(LED1_PIO, LED1_PIO_IDX_MASK); // Activate the pin for LED_PIO_PIN (off)
				_delay_ms(100);
		  	}
	  	} 
		if (_pio_get(BUT1_PIO, PIO_INPUT, BUT1_PIO_IDX_MASK)) {
			// Activate the LED_IDX pin (off)
			_pio_set(LED1_PIO, LED1_PIO_IDX_MASK);
	  	}

		if (!_pio_get(BUT2_PIO, PIO_INPUT, BUT2_PIO_IDX_MASK)) {
			// Blink LED
			for (int i = 0; i < 5; i++) {
				_pio_clear(LED2_PIO, LED2_PIO_IDX_MASK); // Clean the pin for LED_PIO_PIN (on)
				_delay_ms(100);
				_pio_set(LED2_PIO, LED2_PIO_IDX_MASK); // Activate the pin for LED_PIO_PIN (off)
				_delay_ms(100);
			}
	  	}
	  	if (_pio_get(BUT2_PIO, PIO_INPUT, BUT2_PIO_IDX_MASK)) {
			// Activate the LED_IDX pin (off)
			_pio_set(LED2_PIO, LED2_PIO_IDX_MASK);
		}

		if (!_pio_get(BUT3_PIO, PIO_INPUT, BUT3_PIO_IDX_MASK)) {
			// Blink LED
			for (int i = 0; i < 5; i++) {
				_pio_clear(LED3_PIO, LED3_PIO_IDX_MASK); // Clean the pin for LED_PIO_PIN (on)
				_delay_ms(100);
				_pio_set(LED3_PIO, LED3_PIO_IDX_MASK); // Activate the pin for LED_PIO_PIN (off)
				_delay_ms(100);
		  	}
		}
	  	if (_pio_get(BUT3_PIO, PIO_INPUT, BUT3_PIO_IDX_MASK)) {
			// Activate the LED_IDX pin (off)
			_pio_set(LED3_PIO, LED3_PIO_IDX_MASK);
		}
	}
	return 0;
}
