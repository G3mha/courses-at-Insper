/*
 * hardware.h
 *
 * Created: 18/05/2023 9:29:45
 *  Author: guifl
 */ 


#ifndef HARDWARE_H_
#define HARDWARE_H_

#include "asf.h"

#define SENSOR_PIO PIOA
#define SENSOR_PIO_ID ID_PIOA
#define SENSOR_IDX 19
#define SENSOR_IDX_MASK (1 << SENSOR_IDX)

#define AFEC_POT AFEC0
#define AFEC_POT_ID ID_AFEC0
#define AFEC_POT_CHANNEL 2 // Canal do pino PB3

#define RTT_FREQ 5000
#define TC_FREQ 500
#define TC_TIME_BETWEEN_PULSES 1000 / TC_FREQ

extern QueueHandle_t xPulseQueue;
extern QueueHandle_t xQueueADC;

void RTT_init(float freqPrescale, uint32_t IrqNPulses, uint32_t rttIRQSource);
void init_pins(void);
int bpm_avg(int bpm_vec[], int size);



#endif /* HARDWARE_H_ */