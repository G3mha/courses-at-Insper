/*
 * header_footer.c
 *
 * Created: 18/05/2023 11:10:50
 *  Author: guifl
 */ 
#include "header_footer.h"


void create_header(lv_obj_t *screen, const lv_img_dsc_t *logo, const lv_font_t *MontAltEL20, lv_obj_t **labelClockHeader) {
	static lv_style_t clockStyle;
	lv_style_init(&clockStyle);
	lv_style_set_border_width(&clockStyle, 0);
	lv_style_set_text_color(&clockStyle, lv_color_black());
	// Label clock
	*labelClockHeader = lv_label_create(screen);
	lv_obj_align(*labelClockHeader, LV_ALIGN_TOP_RIGHT, -5, 5);
	lv_obj_add_style(*labelClockHeader, &clockStyle, 0);
	// 0123456789:., PesokgHr�rim/hclVatu
	lv_obj_set_style_text_font(*labelClockHeader, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text_fmt(*labelClockHeader, "%02d:%02d:02d", 14, 2, 10);
	// ------------------------ Logo ------------------------
	lv_obj_t * img = lv_img_create(screen);
	lv_img_set_src(img, logo);
	lv_obj_align(img, LV_ALIGN_TOP_LEFT, 3, 5);
	
	// Linha divisora
	static lv_style_t style_line;
	lv_style_init(&style_line);
	lv_style_set_line_width(&style_line, 2);
	lv_style_set_bg_color(&style_line, lv_color_white());
	lv_style_set_line_color(&style_line, lv_color_black());
	lv_style_set_line_rounded(&style_line, true);

	static lv_point_t line_points[] = { {0, 0}, {240, 0} };
	lv_obj_t * line1;
	line1 = lv_line_create(screen);
	lv_line_set_points(line1, line_points, 2);     /*Set the points*/
	lv_obj_add_style(line1, &style_line, 0);
	lv_obj_center(line1);
	lv_obj_align(line1, LV_ALIGN_TOP_MID, 0, 32);
}

void create_footer(lv_obj_t * screen, int screen_number) {
	
	// Linha divisora
	static lv_style_t style_line;
	lv_style_init(&style_line);
	lv_style_set_line_width(&style_line, 2);
	lv_style_set_line_color(&style_line, lv_color_black());
	lv_style_set_line_rounded(&style_line, true);
	
	static lv_point_t line_points[] = { {0, 240}, {240, 240} };
	lv_obj_t * line1;
	line1 = lv_line_create(screen);
	lv_line_set_points(line1, line_points, 2);     /*Set the points*/
	lv_obj_add_style(line1, &style_line, 0);
	lv_obj_center(line1);
	
	
	// -------------------- Engrenagem/Casa --------------------
	static lv_style_t style;
	lv_style_init(&style);
	lv_style_set_bg_color(&style, lv_color_white());
	lv_style_set_border_color(&style, lv_color_white());
	lv_style_set_border_width(&style, 0);
	lv_style_set_text_color(&style, lv_color_black());
	lv_style_set_outline_color(&style, lv_color_white());
	
	lv_obj_t *settings = lv_btn_create(screen);
	lv_obj_add_event_cb(settings, settings_handler, LV_EVENT_ALL, NULL);
	lv_obj_align(settings, LV_ALIGN_BOTTOM_RIGHT, -5, -5);
	lv_obj_set_style_text_font(settings, &lv_font_montserrat_24, LV_STATE_DEFAULT);
	lv_obj_add_style(settings, &style, 0);
	
	labelSettings = lv_label_create(settings);
	if (screen_number == 1) {
		lv_label_set_text(labelSettings, LV_SYMBOL_SETTINGS);
	} else {
		lv_label_set_text(labelSettings, LV_SYMBOL_HOME);
	}
	lv_obj_center(labelSettings);
}