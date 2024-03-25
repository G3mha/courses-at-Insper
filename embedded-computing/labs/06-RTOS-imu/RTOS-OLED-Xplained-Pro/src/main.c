/************************************************************************/
/* includes                                                             */
/************************************************************************/

#include <asf.h>
#include "conf_board.h"
#include "mcu6050.h"
#include "Fusion/Fusion.h"

#include "gfx_mono_ug_2832hsweg04.h"
#include "gfx_mono_text.h"
#include "sysfont.h"

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

/************************************************************************/
/* RTOS                                                                 */
/************************************************************************/
#define TASK_HOUSE_DOWN_STACK_SIZE                (1024*6/sizeof(portSTACK_TYPE))
#define TASK_HOUSE_DOWN_STACK_PRIORITY            (tskIDLE_PRIORITY)
#define TASK_IMU_STACK_SIZE                (1024*6/sizeof(portSTACK_TYPE))
#define TASK_IMU_STACK_PRIORITY            (tskIDLE_PRIORITY)
#define TASK_ORIENTACAO_STACK_SIZE                (1024*6/sizeof(portSTACK_TYPE))
#define TASK_ORIENTACAO_STACK_PRIORITY            (tskIDLE_PRIORITY)

extern void vApplicationStackOverflowHook(xTaskHandle *pxTask,  signed char *pcTaskName);
extern void vApplicationIdleHook(void);
extern void vApplicationTickHook(void);
extern void vApplicationMallocFailedHook(void);
extern void xPortSysTickHandler(void);

/************************************************************************/
/* Prototypes                                                           */
/************************************************************************/

void mcu6050_i2c_bus_init(void);
int8_t mcu6050_i2c_bus_write(uint8_t dev_addr, uint8_t reg_addr, uint8_t *reg_data, uint8_t cnt);
int8_t mcu6050_i2c_bus_read(uint8_t dev_addr, uint8_t reg_addr, uint8_t *reg_data, uint8_t cnt);
SemaphoreHandle_t xFallSemaphore;
QueueHandle_t xQueueOrientacao;
enum orientacao {
    ESQUERDA,
    FRENTE,
    DIREITA
};

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

/************************************************************************/
/* tasks                                                                */
/************************************************************************/

static void task_imu(void *pvParameters) {
	mcu6050_i2c_bus_init();
	/* buffer para recebimento de dados */
	uint8_t bufferRX[10];
	uint8_t bufferTX[10];
	uint8_t rtn; // resultado da função

	// realiza um probe para certificarmos que a conexao i2c esta ok 
	rtn = twihs_probe(TWIHS2, MPU6050_DEFAULT_ADDRESS);
    if (rtn != TWIHS_SUCCESS) {
        printf("[ERRO] [i2c] [probe] \n");
    } else {
        printf("[DADO] [i2c] probe OK\n" );
    }

	// Lê registrador WHO AM I
	rtn = mcu6050_i2c_bus_read(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_WHO_AM_I, bufferRX, 1);
	if (rtn != TWIHS_SUCCESS) {
		printf("[ERRO] [i2c] [read] \n");
	} else {
		printf("[DADO] [i2c] %x:%x", MPU6050_RA_WHO_AM_I, bufferRX[0]);
	}

	// Set Clock source
	bufferTX[0] = MPU6050_CLOCK_PLL_XGYRO;
	rtn = mcu6050_i2c_bus_write(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_PWR_MGMT_1, bufferTX, 1);
	if(rtn != TWIHS_SUCCESS)
		printf("[ERRO] [i2c] [write] \n");

	// Aceletromtro em 2G
	bufferTX[0] = MPU6050_ACCEL_FS_2 << MPU6050_ACONFIG_AFS_SEL_BIT; 
	rtn = mcu6050_i2c_bus_write(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_ACCEL_CONFIG, bufferTX, 1);
	if(rtn != TWIHS_SUCCESS)
		printf("[ERRO] [i2c] [write] \n");

	// Configura range giroscopio para operar com 250 °/s
	bufferTX[0] = 0x00; // 250 °/s
	rtn = mcu6050_i2c_bus_write(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_GYRO_CONFIG, bufferTX, 1);
	if(rtn != TWIHS_SUCCESS)
		printf("[ERRO] [i2c] [write] \n");

	int16_t  raw_acc_x, raw_acc_y, raw_acc_z;
	volatile uint8_t  raw_acc_xHigh, raw_acc_yHigh, raw_acc_zHigh;
	volatile uint8_t  raw_acc_xLow,  raw_acc_yLow,  raw_acc_zLow;
	float proc_acc_x, proc_acc_y, proc_acc_z;

	int16_t  raw_gyr_x, raw_gyr_y, raw_gyr_z;
	volatile uint8_t  raw_gyr_xHigh, raw_gyr_yHigh, raw_gyr_zHigh;
	volatile uint8_t  raw_gyr_xLow,  raw_gyr_yLow,  raw_gyr_zLow;
	float proc_gyr_x, proc_gyr_y, proc_gyr_z;
	float acc;
	FusionAhrs ahrs;
	FusionAhrsInitialise(&ahrs); 
	float delta_angle_roll;
	float delta_angle_pitch;
	float delta_angle_yaw;

	for (;;) {
		// Le valor do acc X High e Low
		mcu6050_i2c_bus_read(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_ACCEL_XOUT_H, &raw_acc_xHigh, 1);
		mcu6050_i2c_bus_read(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_ACCEL_XOUT_L, &raw_acc_xLow,  1);

		// Le valor do acc y High e  Low
		mcu6050_i2c_bus_read(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_ACCEL_YOUT_H, &raw_acc_yHigh, 1);
		mcu6050_i2c_bus_read(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_ACCEL_ZOUT_L, &raw_acc_yLow,  1);

		// Le valor do acc z HIGH e Low
		mcu6050_i2c_bus_read(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_ACCEL_ZOUT_H, &raw_acc_zHigh, 1);
		mcu6050_i2c_bus_read(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_ACCEL_ZOUT_L, &raw_acc_zLow,  1);

		// Dados são do tipo complemento de dois
		raw_acc_x = (raw_acc_xHigh << 8) | (raw_acc_xLow << 0);
		raw_acc_y = (raw_acc_yHigh << 8) | (raw_acc_yLow << 0);
		raw_acc_z = (raw_acc_zHigh << 8) | (raw_acc_zLow << 0);

		// Le valor do gyr X High e Low
		mcu6050_i2c_bus_read(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_GYRO_XOUT_H, &raw_gyr_xHigh, 1);
		mcu6050_i2c_bus_read(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_GYRO_XOUT_L, &raw_gyr_xLow,  1);

		// Le valor do gyr y High e  Low
		mcu6050_i2c_bus_read(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_GYRO_YOUT_H, &raw_gyr_yHigh, 1);
		mcu6050_i2c_bus_read(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_GYRO_ZOUT_L, &raw_gyr_yLow,  1);

		// Le valor do gyr z HIGH e Low
		mcu6050_i2c_bus_read(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_GYRO_ZOUT_H, &raw_gyr_zHigh, 1);
		mcu6050_i2c_bus_read(MPU6050_DEFAULT_ADDRESS, MPU6050_RA_GYRO_ZOUT_L, &raw_gyr_zLow,  1);

		// Dados são do tipo complemento de dois
		raw_gyr_x = (raw_gyr_xHigh << 8) | (raw_gyr_xLow << 0);
		raw_gyr_y = (raw_gyr_yHigh << 8) | (raw_gyr_yLow << 0);
		raw_gyr_z = (raw_gyr_zHigh << 8) | (raw_gyr_zLow << 0);

		// Dados em escala real
		proc_acc_x = (float)raw_acc_x/16384;
		proc_acc_y = (float)raw_acc_y/16384;
		proc_acc_z = (float)raw_acc_z/16384;
		// printf("acc_x: %f acc_y: %f acc_z: %f\r\n ", proc_acc_x, proc_acc_y, proc_acc_z);
		proc_gyr_x = (float)raw_gyr_x/131;
		proc_gyr_y = (float)raw_gyr_y/131;
		proc_gyr_z = (float)raw_gyr_z/131;
		// printf("gyr_x: %f gyr_y: %f gyr_z: %f\r\n ", proc_gyr_x, proc_gyr_y, proc_gyr_z);
		acc = (proc_acc_x*proc_acc_x + proc_acc_y*proc_acc_y + proc_acc_z*proc_acc_z);
		if (acc > 5) {
			// printf("acc: %f\r\n ", acc);
			xSemaphoreGive(xFallSemaphore);
		}
		const FusionVector gyroscope = {proc_gyr_x, proc_gyr_y, proc_gyr_z}; 
		const FusionVector accelerometer = {proc_acc_x, proc_acc_y, proc_acc_z};
		// Tempo entre amostras
		float dT = 0.1;

		// aplica o algoritmo
		FusionAhrsUpdateNoMagnetometer(&ahrs, gyroscope, accelerometer, dT);

		// dados em pitch roll e yaw
		const FusionEuler euler = FusionQuaternionToEuler(FusionAhrsGetQuaternion(&ahrs));
		
		enum orientacao orient;
		if (euler.angle.yaw < -30) {
			orient = DIREITA;
		} else if (euler.angle.yaw < 30) {
			orient = FRENTE;
		} else {
			orient = ESQUERDA;
		}
		BaseType_t xHigherPriorityTaskWoken = pdTRUE;
		xQueueSend(xQueueOrientacao, (void *)&orient, &xHigherPriorityTaskWoken);

		// uma amostra a cada 1ms
		vTaskDelay(1);
	}
}

static void task_house_down (void *pvParameters) {
	for (;;) {
		if (xSemaphoreTake(xFallSemaphore, portMAX_DELAY) == pdTRUE) {
			printf("Caiu\r\n");
		}
		vTaskDelay(1000);
	}
}

static void task_orientacao (void *pvParameters) {
	enum orientacao msg;
  	for (;;) {
		/* verifica se chegou algum dado na queue, e espera por 0 ticks */
		if (xQueueReceive(xQueueOrientacao, &msg, (TickType_t) 0)) {
			if (msg == DIREITA) { /* acende LED 3 */
				pio_set(LED1_PIO, LED1_PIO_IDX_MASK);
				pio_set(LED2_PIO, LED2_PIO_IDX_MASK);
			    pio_clear(LED3_PIO, LED3_PIO_IDX_MASK);
			} else if (msg == FRENTE) { /* acende LED 2 */
				pio_set(LED1_PIO, LED1_PIO_IDX_MASK);
				pio_set(LED3_PIO, LED3_PIO_IDX_MASK);
			    pio_clear(LED2_PIO, LED2_PIO_IDX_MASK);
			} else { /* acende LED 1 */
				pio_set(LED2_PIO, LED2_PIO_IDX_MASK);
				pio_set(LED3_PIO, LED3_PIO_IDX_MASK);
			    pio_clear(LED1_PIO, LED1_PIO_IDX_MASK);
			}
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

void mcu6050_i2c_bus_init(void) {
    twihs_options_t mcu6050_option;
    pmc_enable_periph_clk(ID_TWIHS2);

    /* Configure the options of TWI driver */
    mcu6050_option.master_clk = sysclk_get_cpu_hz();
    mcu6050_option.speed      = 40000;
    twihs_master_init(TWIHS2, &mcu6050_option);
	/** Enable TWIHS port to control PIO pins */
	pmc_enable_periph_clk(ID_PIOD);
	pio_set_peripheral(PIOD, PIO_TYPE_PIO_PERIPH_C, 1 << 28);
	pio_set_peripheral(PIOD, PIO_TYPE_PIO_PERIPH_C, 1 << 27);
}

int8_t mcu6050_i2c_bus_write(uint8_t dev_addr, uint8_t reg_addr, uint8_t *reg_data, uint8_t cnt) {
    int32_t ierror = 0x00;

    twihs_packet_t p_packet;
    p_packet.chip         = dev_addr;
    p_packet.addr[0]      = reg_addr;
    p_packet.addr_length  = 1;
    p_packet.buffer       = reg_data;
    p_packet.length       = cnt;

    ierror = twihs_master_write(TWIHS2, &p_packet);

    return (int8_t)ierror;
}

int8_t mcu6050_i2c_bus_read(uint8_t dev_addr, uint8_t reg_addr, uint8_t *reg_data, uint8_t cnt) {
    int32_t ierror = 0x00;

    twihs_packet_t p_packet;
    p_packet.chip         = dev_addr;
    p_packet.addr[0]      = reg_addr;
    p_packet.addr_length  = 1;
    p_packet.buffer       = reg_data;
    p_packet.length       = cnt;

	// TODO: Algum problema no SPI faz com que devemos ler duas vezes o registrador para
	//       conseguirmos pegar o valor correto.
    ierror = twihs_master_read(TWIHS2, &p_packet);

    return (int8_t)ierror;
}

void init(void) {
	/* Initialize the SAM system */
	board_init();

	// Initialize the board clock
	sysclk_init();

	/* Initialize the console uart */
	configure_console();

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
}

/************************************************************************/
/* main                                                                 */
/************************************************************************/

int main(void) {
	init();

	/* Create task to control imu */
	if (xTaskCreate(task_imu, "oled", TASK_IMU_STACK_SIZE, NULL, TASK_IMU_STACK_PRIORITY, NULL) != pdPASS) {
	  printf("Failed to create imu task\r\n");
	}

	/* cada espaço possui o tamanho de um inteiro*/
	xQueueOrientacao = xQueueCreate(32, sizeof(uint32_t));
	if (xQueueOrientacao == NULL) {
		printf("falha em criar as queues \n");
	}
	/* Create task to control imu */
	if (xTaskCreate(task_house_down, "house_down", TASK_HOUSE_DOWN_STACK_SIZE, NULL, TASK_HOUSE_DOWN_STACK_PRIORITY, NULL) != pdPASS) {
	  printf("Failed to create imu task\r\n");
	}

	/* Create task to control imu */
	if (xTaskCreate(task_orientacao, "orientacao", TASK_ORIENTACAO_STACK_SIZE, NULL, TASK_ORIENTACAO_STACK_PRIORITY, NULL) != pdPASS) {
	  printf("Failed to create imu task\r\n");
	}

	xFallSemaphore = xSemaphoreCreateBinary();
 	if (xFallSemaphore == NULL) {
    	printf("falha em criar os semaforos\r\n");
	}

	/* Start the scheduler. */
	vTaskStartScheduler();

  /* RTOS não deve chegar aqui !! */
	while(1){}

	/* Will only get here if there was insufficient memory to create the idle task. */
	return 0;
}
