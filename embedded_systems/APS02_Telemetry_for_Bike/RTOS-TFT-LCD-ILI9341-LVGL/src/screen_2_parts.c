/*
 * screen_2_parts.c
 *
 * Created: 15/05/2023 12:27:40
 *  Author: guifl
 */ 
#include "screen_2_parts.h"

static void aro_handler(lv_event_t * e)
{
    lv_event_code_t code = lv_event_get_code(e);
    lv_obj_t * obj = lv_event_get_target(e);
    if(code == LV_EVENT_VALUE_CHANGED) {
        char buf[32];
        lv_roller_get_selected_str(obj, buf, sizeof(buf));
        LV_LOG_USER("Aro: %s\n", buf);
		if (strlen(buf) != 0) {
			float aro = atof(buf);
			xQueueSend(xQueueAro, &aro, 0);
			uint16_t valor_zoom = 256 * (aro / 20.0);
			lv_img_set_zoom(img_wheel, valor_zoom);
		}
    }
}

void create_aro_section(lv_obj_t * screen, const lv_font_t *MontAltEL20, lv_img_dsc_t *img_rodalogo) {
	static lv_style_t textStyle;
	lv_style_init(&textStyle);
	lv_style_set_pad_all(&textStyle, 0);
	lv_style_set_text_color(&textStyle, lv_color_black());
	
	static lv_style_t rollerStyle;
	lv_style_init(&rollerStyle);
	lv_style_set_border_width(&rollerStyle, 1);
	lv_style_set_border_color(&rollerStyle, lv_color_black());
	lv_style_set_bg_color(&rollerStyle, lv_color_white());
	lv_style_set_pad_all(&rollerStyle, 0);
	lv_style_set_text_color(&rollerStyle, lv_color_black());
	
	labelAroText = lv_label_create(screen);
	lv_obj_align(labelAroText, LV_ALIGN_LEFT_MID, 15, -10);
	lv_obj_add_style(labelAroText, &textStyle, 0);
	lv_obj_set_style_text_font(labelAroText, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text(labelAroText, "Aro [pol]");
	
	// lv_aro_roller(screen);
	lv_obj_t *roller1 = lv_roller_create(screen);
	lv_roller_set_options(roller1,
		"20.0\n"
		"24.0\n"
		"26.0\n"
		"27.5\n"
		"29.0\n",
		LV_ROLLER_MODE_INFINITE);
	lv_roller_set_visible_row_count(roller1, 3);
	lv_obj_center(roller1);
	lv_obj_add_event_cb(roller1, aro_handler, LV_EVENT_ALL, NULL);
	lv_obj_set_style_bg_color(roller1, lv_color_black(), LV_PART_SELECTED);
	lv_obj_set_style_text_color(roller1, lv_color_white(), LV_PART_SELECTED);
	lv_obj_set_width(roller1, 100);
	lv_obj_add_style(roller1, &rollerStyle, 0);
	lv_obj_set_style_text_font(roller1, MontAltEL20, LV_STATE_DEFAULT);
	lv_obj_align_to(roller1, labelAroText, LV_ALIGN_OUT_BOTTOM_MID, 0, 10);
	
	
	// Roda do logo.
	img_wheel = lv_img_create(screen);
	lv_img_set_src(img_wheel, img_rodalogo);
	lv_obj_align(img_wheel, LV_ALIGN_TOP_LEFT, 28, 60);
	
}

void create_peso_section(lv_obj_t * screen, const lv_font_t *MontAltEL20, const lv_img_dsc_t *img_peso_) {
}

static void plus_h_event_cb(lv_event_t * e)
{
	lv_event_code_t code = lv_event_get_code(e);
	lv_obj_t * btn = lv_event_get_target(e);
	if(code == LV_EVENT_CLICKED) {
		uint32_t label_value = atoi(lv_label_get_text(labelHoraValue));
		label_value = (label_value + 1) % 24;
		horario_sett sett = {label_value, 'h'};
		xQueueSend(xQueueHorarioSett, &sett, 0);
	}
}

static void minus_h_event_cb(lv_event_t * e) {
	lv_event_code_t code = lv_event_get_code(e);
	
	if(code == LV_EVENT_CLICKED) {
		uint32_t label_value = atoi(lv_label_get_text(labelHoraValue));
		label_value = (label_value - 1) % 24;
		horario_sett sett = {label_value, 'h'};
		xQueueSend(xQueueHorarioSett, &sett, 0);
	}
}

static void plus_seg_event_cb(lv_event_t * e)
{
	lv_event_code_t code = lv_event_get_code(e);

	if(code == LV_EVENT_CLICKED) {
		LV_LOG_USER("Clicked");
		uint32_t label_value = atoi(lv_label_get_text(labelSegundoValue));
		label_value = (label_value + 1) % 60;
		horario_sett sett = {label_value, 's'};
	}
	else if(code == LV_EVENT_VALUE_CHANGED) {
		LV_LOG_USER("Toggled");
	}

}

static void minus_seg_event_cb(lv_event_t * e)
{
	lv_event_code_t code = lv_event_get_code(e);

	if(code == LV_EVENT_CLICKED) {
		LV_LOG_USER("Clicked");
		uint32_t label_value = atoi(lv_label_get_text(labelSegundoValue));
		label_value = (label_value - 1) % 60;
		horario_sett sett = {label_value, 's'};
		xQueueSend(xQueueHorarioSett, &sett, 0);
	}

}

static void minus_min_event_cb(lv_event_t * e)
{
	lv_event_code_t code = lv_event_get_code(e);

	if(code == LV_EVENT_CLICKED) {
		LV_LOG_USER("Clicked");
		uint32_t label_value = atoi(lv_label_get_text(labelMinValue));
		label_value = (label_value - 1) % 60;
		horario_sett sett = {label_value, 'm'};
		xQueueSend(xQueueHorarioSett, &sett, 0);
	}
	else if(code == LV_EVENT_VALUE_CHANGED) {
		LV_LOG_USER("Toggled");
	}

}

static void plus_min_event_cb(lv_event_t * e)
{
	lv_event_code_t code = lv_event_get_code(e);

	if(code == LV_EVENT_CLICKED) {
		LV_LOG_USER("Clicked");
		uint32_t label_value = atoi(lv_label_get_text(labelMinValue));
		label_value = (label_value + 1) % 60;
		horario_sett sett = {label_value, 'm'};
		xQueueSend(xQueueHorarioSett, &sett, 0);
	}
	else if(code == LV_EVENT_VALUE_CHANGED) {
		LV_LOG_USER("Toggled");
	}

}


void create_horario_section(lv_obj_t *screen, const lv_font_t *MontAltEL20, const lv_img_dsc_t *img_horario_) {
	static lv_style_t textStyle;
	lv_style_init(&textStyle);
	lv_style_set_border_width(&textStyle, 0);
	lv_style_set_text_color(&textStyle, lv_color_black());
	
	labelHorarioText = lv_label_create(screen);
	lv_obj_align(labelHorarioText, LV_ALIGN_TOP_RIGHT, -40, 40);
	lv_obj_add_style(labelHorarioText, &textStyle, 0);
	lv_obj_set_style_text_font(labelHorarioText, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text(labelHorarioText, "Horario");
	
	// Icone de horario
	img_horario = lv_img_create(screen);
	lv_img_set_src(img_horario, img_horario_);
	lv_obj_align_to(img_horario, labelHorarioText, LV_ALIGN_OUT_RIGHT_MID, 15, 0);
	
	labelHoraValue = lv_label_create(screen);
	lv_obj_align_to(labelHoraValue, labelHorarioText,  LV_ALIGN_OUT_BOTTOM_MID, 5, 20);
	lv_obj_add_style(labelHoraValue, &textStyle, 0);
	lv_obj_set_style_text_font(labelHoraValue, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text_fmt(labelHoraValue, "%d", 20);
	
	labelHoraText = lv_label_create(screen);
	lv_obj_align_to(labelHoraText, labelHoraValue, LV_ALIGN_OUT_RIGHT_MID, 2, -2);
	lv_obj_add_style(labelHoraText, &textStyle, 0);
	lv_obj_set_style_text_font(labelHoraText, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text(labelHoraText, "H");
	
	labelMinValue = lv_label_create(screen);
	lv_obj_align_to(labelMinValue, labelHoraValue, LV_ALIGN_OUT_BOTTOM_MID, 2, 10);
	lv_obj_add_style(labelMinValue, &textStyle, 0);
	lv_obj_set_style_text_font(labelMinValue, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text_fmt(labelMinValue, "%d", 20);
	
	labelMinText = lv_label_create(screen);
	lv_obj_align_to(labelMinText, labelMinValue, LV_ALIGN_OUT_RIGHT_MID, 2, -2);
	lv_obj_add_style(labelMinText, &textStyle, 0);
	lv_obj_set_style_text_font(labelMinText, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text(labelMinText, "M");
	
	labelSegundoValue = lv_label_create(screen);
	lv_obj_align_to(labelSegundoValue, labelMinValue, LV_ALIGN_OUT_BOTTOM_MID, 0, 10);
	lv_obj_add_style(labelSegundoValue, &textStyle, 0);
	lv_obj_set_style_text_font(labelSegundoValue, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text_fmt(labelSegundoValue, "%d", 20);
	
	labelSegundoText = lv_label_create(screen);
	lv_obj_align_to(labelSegundoText, labelSegundoValue, LV_ALIGN_OUT_RIGHT_MID, 2, -2);
	lv_obj_add_style(labelSegundoText, &textStyle, 0);
	lv_obj_set_style_text_font(labelSegundoText, MontAltEL20, LV_STATE_DEFAULT);
	lv_label_set_text(labelSegundoText, "S");
	
	// --------------------------- Botoes do lado ---------------------------
	static lv_style_t style_def;
	lv_style_init(&style_def);
	lv_style_set_bg_color(&style_def, lv_color_black());
	lv_style_set_text_color(&style_def, lv_color_white());

	static lv_style_t style_pr;
	lv_style_init(&style_pr);
	lv_style_set_img_recolor_opa(&style_pr, LV_OPA_30);
	lv_style_set_img_recolor(&style_pr, lv_color_black());
	
	lv_obj_t *minus = lv_btn_create(screen);     
	lv_obj_align_to(minus, labelHoraValue, LV_ALIGN_OUT_LEFT_MID, -2, 0);
	lv_obj_set_size(minus, 20, 20);             
	lv_obj_add_style(minus, &style_def, 0);     
	lv_obj_add_event_cb(minus, minus_h_event_cb, LV_EVENT_ALL, NULL);           

	lv_obj_t *label1 = lv_label_create(minus);          
	lv_label_set_text(label1, "-");                     
	lv_obj_center(label1);
	
	lv_obj_t * plus = lv_btn_create(screen);    
	lv_obj_align_to(plus, labelHoraText, LV_ALIGN_OUT_RIGHT_MID, 10, -5);
	lv_obj_set_size(plus, 20, 20);         
	lv_obj_add_style(plus, &style_def, 0);
	lv_obj_add_event_cb(plus, plus_h_event_cb, LV_EVENT_ALL, NULL);           

	lv_obj_t *label2 = lv_label_create(plus); 
	lv_label_set_text(label2, "+");                     
	lv_obj_center(label2);
	
	// Para os minutos
	lv_obj_t * minus_min = lv_btn_create(screen);     /*Add a button the current screen*/
	lv_obj_align_to(minus_min, labelMinValue, LV_ALIGN_OUT_LEFT_MID, -2, 0);
	lv_obj_set_size(minus_min, 20, 20);                          /*Set its size*/
	lv_obj_add_style(minus_min, &style_def, 0);
	lv_obj_add_event_cb(minus_min, minus_min_event_cb, LV_EVENT_ALL, NULL);           /*Assign a callback to the button*/

	lv_obj_t * label1_min = lv_label_create(minus_min);          /*Add a label to the button*/
	lv_label_set_text(label1_min, "-");                     /*Set the labels text*/
	lv_obj_center(label1_min);
	
	lv_obj_t * plus_min = lv_btn_create(screen);     /*Add a button the current screen*/
	lv_obj_align_to(plus_min, labelMinText, LV_ALIGN_OUT_RIGHT_MID, 2, -5);
	lv_obj_set_size(plus_min, 20, 20);                          /*Set its size*/
	lv_obj_add_style(plus_min, &style_def, 0);
	lv_obj_add_event_cb(plus_min, plus_min_event_cb, LV_EVENT_ALL, NULL);           /*Assign a callback to the button*/

	lv_obj_t * label2_min = lv_label_create(plus_min);          /*Add a label to the button*/
	lv_label_set_text(label2_min, "+");                     /*Set the labels text*/
	lv_obj_center(label2_min);
	
	// Para o segundo
	lv_obj_t * minus_seg = lv_btn_create(screen);     /*Add a button the current screen*/
	lv_obj_align_to(minus_seg, labelSegundoValue, LV_ALIGN_OUT_LEFT_MID, -2, 0);
	lv_obj_set_size(minus_seg, 20, 20);                          /*Set its size*/
	lv_obj_add_style(minus_seg, &style_def, 0);
	lv_obj_add_event_cb(minus_seg, minus_seg_event_cb, LV_EVENT_ALL, NULL);           /*Assign a callback to the button*/

	lv_obj_t * label1_seg = lv_label_create(minus_seg);          /*Add a label to the button*/
	lv_label_set_text(label1_seg, "-");                     /*Set the labels text*/
	lv_obj_center(label1_seg);
	
	lv_obj_t * plus_seg = lv_btn_create(screen);     /*Add a button the current screen*/
	lv_obj_align_to(plus_seg, labelSegundoText, LV_ALIGN_OUT_RIGHT_MID, 16,-5);
	lv_obj_set_size(plus_seg, 20, 20);                          /*Set its size*/
	lv_obj_add_style(plus_seg, &style_def, 0);
	lv_obj_add_event_cb(plus_seg, plus_seg_event_cb, LV_EVENT_ALL, NULL);           /*Assign a callback to the button*/

	lv_obj_t * label2_seg = lv_label_create(plus_seg);          /*Add a label to the button*/
	lv_label_set_text(label2_seg, "+");                     /*Set the labels text*/
	lv_obj_center(label2_seg);
	
	
	
	// --------------------------- Linhas de divisao ---------------------------
	static lv_style_t style_line;
	lv_style_init(&style_line);
	lv_style_set_line_width(&style_line, 2);
	lv_style_set_bg_color(&style_line, lv_color_white());
	lv_style_set_line_color(&style_line, lv_color_black());
	lv_style_set_line_rounded(&style_line, true);
	
	// Linha vertical de todas as caixas
	static lv_point_t line_boxes_points[] = { {0, 0}, {0, 245} };
	lv_obj_t *line_boxes;
	line_boxes = lv_line_create(screen);
	lv_line_set_points(line_boxes, line_boxes_points, 2);     /*Set the points*/
	lv_obj_add_style(line_boxes, &style_line, 0);
	lv_obj_center(line_boxes);
	lv_obj_align(line_boxes, LV_ALIGN_CENTER, 2, -5);
	
}