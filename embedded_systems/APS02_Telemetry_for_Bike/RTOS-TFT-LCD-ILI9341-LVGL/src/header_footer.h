/*
 * header_footer.h
 *
 * Created: 18/05/2023 11:10:59
 *  Author: guifl
 */ 


#ifndef HEADER_FOOTER_H_
#define HEADER_FOOTER_H_

#include "lvgl.h"

void create_header(lv_obj_t * screen, const lv_img_dsc_t *logo, const lv_font_t *MontAltEL20, lv_obj_t **labelClockHeader);
void create_footer(lv_obj_t * screen, int screen_number);

extern void settings_handler(lv_event_t *e);

lv_obj_t *labelClockHeader;
static lv_obj_t *labelSettings;

#endif /* HEADER_FOOTER_H_ */