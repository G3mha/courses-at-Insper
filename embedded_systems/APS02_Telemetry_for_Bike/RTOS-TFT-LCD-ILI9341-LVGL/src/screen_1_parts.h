/*
 * screen_1_parts.h
 *
 * Created: 17/05/2021 18:20:54
 *  Author: guifl
 */ 


#ifndef SCREEN_1_PARTS_H_
#define SCREEN_1_PARTS_H_

#include "lvgl.h"
#include "asf.h"

// Se��o de velocidade
lv_obj_t *labelSpeedValue;
static lv_obj_t *labelSpeedUnit;
// Viagem
static lv_obj_t *labelViagemText;
lv_obj_t *labelViagemClock;
// Div de distancia
lv_obj_t *labelDistValue;
static lv_obj_t *labelDistUnit;
static lv_obj_t *labelDistTitle;
// Div de vel media.
lv_obj_t *labelVelMValue;
static lv_obj_t *labelVelMUnit;
static lv_obj_t *labelVelMTitle;
// Div de calorias
lv_obj_t *labelCalValue;
static lv_obj_t *labelCalUnit;
static lv_obj_t *labelCalTitle;
// wheel_animation
static lv_anim_t wheel_animation;
static lv_obj_t *img_wheel;
// Aceleration animation
static lv_obj_t *unidade_1;
static lv_obj_t *unidade_2;
static lv_obj_t *unidade_3;
#define START_BLOCK 40
#define HEIGHT_SQUARE 20
#define SPACE_BETWEEN HEIGHT_SQUARE + 6


static volatile int is_viagem_on;
extern QueueHandle_t xQueueViagem;


typedef struct{
	const lv_img_dsc_t *roda_logo;
	const lv_img_dsc_t *play_pause_button;
	const lv_img_dsc_t *stop_button;
} viagem_imgs;

void create_speed_section(lv_obj_t * screen, const lv_font_t *MontAltEL20, const lv_img_dsc_t *img_unidade);
void create_viagem_section(lv_obj_t *screen, const lv_font_t *MontAltEL20, viagem_imgs imgs);
void write_acceleration(float acceleration);


#endif /* SCREEN_1_PARTS_H_ */