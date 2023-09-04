/*
 * screen_1_parts.c
 *
 * Created: 17/05/2023 18:19:12
 *  Author: guifl
 */ 
#include "screen_1_parts.h"

LV_FONT_DECLARE(MontAltEL80);



void write_acceleration(float acceleration) {
	// Faixa de mov. uniforme -> Acerelacao em modulo menor que 0.01 km/h*s (equivalente a 36 km/h^2).
	// Abaixo disso desse m�dulo, podemos considerar uniforme, para evitar ruidos.
	if ((acceleration < 36) && (acceleration > -36)) {
		// Dentro da faixa de movimento uniforme
		lv_obj_add_flag(unidade_1, LV_OBJ_FLAG_HIDDEN);
		lv_obj_add_flag(unidade_3, LV_OBJ_FLAG_HIDDEN);
	} else if (acceleration >= 36) {
		// Acelerando
		lv_obj_add_flag(unidade_3, LV_OBJ_FLAG_HIDDEN);
		lv_obj_clear_flag(unidade_1, LV_OBJ_FLAG_HIDDEN);
	} else {
		// Desacelerando
		lv_obj_clear_flag(unidade_3, LV_OBJ_FLAG_HIDDEN);
		lv_obj_add_flag(unidade_1, LV_OBJ_FLAG_HIDDEN);
	}
}

void create_speed_section(lv_obj_t * screen, const lv_font_t *MontAltEL20, const lv_img_dsc_t *img_unidade) {
	static lv_style_t textStyle;
	lv_style_init(&textStyle);
	lv_style_set_border_width(&textStyle, 0);
	lv_style_set_text_color(&textStyle, lv_color_black());
	
	labelSpeedValue = lv_label_create(screen);
	lv_obj_align(labelSpeedValue, LV_ALIGN_LEFT_MID, 15, -85);
	lv_obj_add_style(labelSpeedValue, &textStyle, 0);
	lv_obj_set_style_text_font(labelSpeedValue, &MontAltEL80, LV_STATE_DEFAULT);
	lv_label_set_text_fmt(labelSpeedValue, "%.01f", 0.0);
	
	
	labelSpeedUnit = lv_label_create(screen);
	lv_obj_add_style(labelSpeedUnit, &textStyle, 0);
	lv_obj_align_to(labelSpeedUnit, labelSpeedValue, LV_ALIGN_OUT_RIGHT_MID, -2, -6);
	lv_obj_set_style_text_font(labelSpeedUnit, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text(labelSpeedUnit, "km/h");
	
	// Parte da aceleracao
	
	static lv_style_t style_inv;
	lv_style_init(&style_inv);
	lv_style_set_bg_opa(&style_inv, LV_OPA_TRANSP);
	lv_style_set_border_opa(&style_inv, LV_OPA_TRANSP);
	
	unidade_1 = lv_img_create(screen);
	lv_img_set_src(unidade_1, img_unidade);
	lv_obj_add_flag(unidade_1, LV_OBJ_FLAG_HIDDEN);
	lv_obj_align(unidade_1, LV_ALIGN_TOP_RIGHT, -10, START_BLOCK);
	
	unidade_2 = lv_img_create(screen);
	lv_img_set_src(unidade_2, img_unidade);
	lv_obj_align(unidade_2, LV_ALIGN_TOP_RIGHT, -10, START_BLOCK + SPACE_BETWEEN);
	
	unidade_3 = lv_img_create(screen);
	lv_img_set_src(unidade_3, img_unidade);
	lv_obj_add_flag(unidade_3, LV_OBJ_FLAG_HIDDEN);
	lv_obj_align_to(unidade_3, unidade_2, LV_ALIGN_OUT_BOTTOM_MID, 0, HEIGHT_SQUARE / 4);
	
	// Linha no meio do bloco central
	static lv_style_t style_line;
	lv_style_init(&style_line);
	lv_style_set_line_width(&style_line, 2);
	lv_style_set_bg_color(&style_line, lv_color_white());
	lv_style_set_line_color(&style_line, lv_color_black());
	lv_style_set_line_rounded(&style_line, true);

	static lv_point_t line_points[] = { {200, 0}, {230, 0} };
	lv_obj_t * line1;
	line1 = lv_line_create(screen);
	lv_line_set_points(line1, line_points, 2);     /*Set the points*/
	lv_obj_add_style(line1, &style_line, 0);
	lv_obj_center(line1);
	lv_obj_align(line1, LV_ALIGN_TOP_MID, 1, START_BLOCK + SPACE_BETWEEN + (HEIGHT_SQUARE / 2));
}


void create_dist_div(lv_obj_t *screen, const lv_font_t *MontAltEL20, lv_style_t *textStyle) {
	labelDistTitle = lv_label_create(screen);
	lv_obj_align(labelDistTitle, LV_ALIGN_RIGHT_MID, -72, 0);
	lv_obj_add_style(labelDistTitle, textStyle, 0);
	lv_obj_set_style_text_font(labelDistTitle, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text(labelDistTitle, "Dist.");
	
	labelDistValue = lv_label_create(screen);
	lv_obj_align_to(labelDistValue,labelDistTitle,  LV_ALIGN_OUT_BOTTOM_MID, 5, -2);
	lv_obj_add_style(labelDistValue, textStyle, 0);
	lv_obj_set_style_text_font(labelDistValue, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text_fmt(labelDistValue, "%.01f", 0.0);
	
	labelDistUnit = lv_label_create(screen);
	lv_obj_align_to(labelDistUnit, labelDistValue, LV_ALIGN_OUT_RIGHT_MID, 12, -2);
	lv_obj_add_style(labelDistUnit, textStyle, 0);
	lv_obj_set_style_text_font(labelDistUnit, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text(labelDistUnit, "km");
}

void create_velm_div(lv_obj_t *screen, const lv_font_t *MontAltEL20, lv_style_t *textStyle) {
	labelVelMTitle = lv_label_create(screen);
	lv_obj_align(labelVelMTitle, LV_ALIGN_RIGHT_MID, -28, 55);
	lv_obj_add_style(labelVelMTitle, textStyle, 0);
	lv_obj_set_style_text_font(labelVelMTitle, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text(labelVelMTitle, "Vel. med");
	
	labelVelMValue = lv_label_create(screen);
	lv_obj_align_to(labelVelMValue, labelVelMTitle,  LV_ALIGN_OUT_BOTTOM_MID, -20, 0);
	lv_obj_add_style(labelVelMValue, textStyle, 0);
	lv_obj_set_style_text_font(labelVelMValue, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text_fmt(labelVelMValue, "%.01f", 0.0);
	
	labelVelMUnit = lv_label_create(screen);
	lv_obj_align_to(labelVelMUnit, labelVelMValue, LV_ALIGN_OUT_RIGHT_MID, 8, -5);
	lv_obj_add_style(labelVelMUnit, textStyle, 0);
	lv_obj_set_style_text_font(labelVelMUnit, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text(labelVelMUnit, "km/h");
	
}

void create_cal_div(lv_obj_t *screen, const lv_font_t *MontAltEL20, lv_style_t *textStyle) {
}

void rotate_img(void *var, int32_t val) {
	lv_img_set_angle(var, val);
}

void handle_logo_animation(int is_playing) {
	if (is_playing) {
		lv_anim_init(&wheel_animation);
		lv_anim_set_var(&wheel_animation, img_wheel);
		lv_anim_set_values(&wheel_animation, 0, 3600);
		lv_anim_set_time(&wheel_animation, 1000);
		lv_anim_set_playback_time(&wheel_animation, 300);
		lv_anim_set_repeat_count(&wheel_animation, LV_ANIM_REPEAT_INFINITE);

		lv_anim_set_exec_cb(&wheel_animation, rotate_img);
		lv_anim_start(&wheel_animation);
	} else {
		lv_anim_del(img_wheel, rotate_img);
	}
}


static void play_pause_handler(lv_event_t * e) {
	lv_event_code_t code = lv_event_get_code(e);

	if(code == LV_EVENT_CLICKED) {
		if (is_viagem_on) {
			// Pause
			handle_logo_animation(0);
			is_viagem_on = 0;
			char sent_char = 'P';
			xQueueSend(xQueueViagem, &sent_char, 0);
		} else {
			// Play
			handle_logo_animation(1);
			is_viagem_on = 1;
			char sent_char = 'p';
			xQueueSend(xQueueViagem, &sent_char, 0);
		}
		LV_LOG_USER("Clicked");
	}
	else if(code == LV_EVENT_VALUE_CHANGED) {
		LV_LOG_USER("Toggled");
	}
}

static void stop_handler(lv_event_t * e) {
}


void create_viagem_section(lv_obj_t *screen, const lv_font_t *MontAltEL20, viagem_imgs imgs) {
	static lv_style_t textStyle;
	lv_style_init(&textStyle);
	lv_style_set_border_width(&textStyle, 0);
	lv_style_set_text_color(&textStyle, lv_color_black());
	
	labelViagemText = lv_label_create(screen);
	lv_obj_align(labelViagemText, LV_ALIGN_LEFT_MID, 5, -32);
	lv_obj_add_style(labelViagemText, &textStyle, 0);
	lv_obj_set_style_text_font(labelViagemText, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text(labelViagemText, "Viagem");
	
	// --------------------------- Tempo da viagem e indica��o visual que est� rodando ---------------------------
	labelViagemClock = lv_label_create(screen);
	lv_obj_align(labelViagemClock, LV_ALIGN_RIGHT_MID, -10, -32);
	lv_obj_add_style(labelViagemClock, &textStyle, 0);
	lv_obj_set_style_text_font(labelViagemClock, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text_fmt(labelViagemClock, "%02d:%02d", 0, 0);
	
	// Roda do logo.
	img_wheel = lv_img_create(screen);
	lv_img_set_src(img_wheel, imgs.roda_logo);
	lv_obj_align_to(img_wheel, labelViagemClock, LV_ALIGN_OUT_LEFT_MID, -20, 4);
	
	// --------------------------- Botoes do lado ---------------------------
	static lv_style_t style_def;
	lv_style_init(&style_def);
	lv_style_set_bg_color(&style_def, lv_color_white());
	lv_style_set_text_color(&style_def, lv_color_white());
	static lv_style_t style_pr;
	lv_style_init(&style_pr);
	lv_style_set_img_recolor_opa(&style_pr, LV_OPA_30);
	lv_style_set_img_recolor(&style_pr, lv_color_black());
	
	lv_obj_t *playPauseButton = lv_imgbtn_create(screen);
	lv_imgbtn_set_src(playPauseButton, LV_IMGBTN_STATE_RELEASED, imgs.play_pause_button, NULL, NULL);
	lv_obj_add_style(playPauseButton, &style_def, 0);
	lv_obj_add_style(playPauseButton, &style_pr, LV_STATE_PRESSED);
	lv_obj_add_event_cb(playPauseButton, play_pause_handler, LV_EVENT_ALL, NULL);
	lv_obj_align(playPauseButton, LV_ALIGN_LEFT_MID, 20, 70);
	
	// --------------------------- Criacao das divs ---------------------------
	create_dist_div(screen, MontAltEL20, &textStyle);
	create_velm_div(screen, MontAltEL20, &textStyle);
	
	// --------------------------- Linhas de divisao ---------------------------
	static lv_style_t style_line;
	lv_style_init(&style_line);
	lv_style_set_line_width(&style_line, 2);
	lv_style_set_bg_color(&style_line, lv_color_white());
	lv_style_set_line_color(&style_line, lv_color_black());
	lv_style_set_line_rounded(&style_line, true);
	
	// Linha para dividir a parte da velocidade da parte da viagem
	static lv_point_t line_points[] = { {0, 20}, {240, 20} };
	lv_obj_t * line1;
	line1 = lv_line_create(screen);
	lv_line_set_points(line1, line_points, 2);     /*Set the points*/
	lv_obj_add_style(line1, &style_line, 0);
	lv_obj_center(line1);
	lv_obj_align(line1, LV_ALIGN_CENTER, 0, -53);
	
	// Linha vertical de todas as caixas
	static lv_point_t line_boxes_points[] = { {0, 110}, {0, 240} };
	lv_obj_t *line_boxes;
	line_boxes = lv_line_create(screen);
	lv_line_set_points(line_boxes, line_boxes_points, 2);     /*Set the points*/
	lv_obj_add_style(line_boxes, &style_line, 0);
	lv_obj_center(line_boxes);
	
	// Linha horizontal de cima da dist�ncia
	static lv_point_t line_dist_points[] = { {120, 0}, {240, 0} };
	lv_obj_t *line_dist;
	line_dist = lv_line_create(screen);
	lv_line_set_points(line_dist, line_dist_points, 2);     /*Set the points*/
	lv_obj_add_style(line_dist, &style_line, 0);
	lv_obj_center(line_dist);
	lv_obj_align(line_dist, LV_ALIGN_CENTER, 0, -10);
	
	// Linha horizontal de cima da vel_media
	static lv_point_t line_vel_m_points[] = { {120, 62}, {240, 62} };
	lv_obj_t *line_vel_med = lv_line_create(screen);
	lv_line_set_points(line_vel_med, line_vel_m_points, 2);
	lv_obj_add_style(line_vel_med, &style_line, 0);
	lv_obj_center(line_vel_med);
	
}