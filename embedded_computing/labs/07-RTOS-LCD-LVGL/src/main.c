/************************************************************************/
/* includes                                                             */
/************************************************************************/

#include <asf.h>
#include <string.h>
#include "ili9341.h"
#include "lvgl.h"
#include "touch/touch.h"

/************************************************************************/
/* Constants                                                           */
/************************************************************************/
typedef struct  {
  uint32_t year;
  uint32_t month;
  uint32_t day;
  uint32_t week;
  uint32_t hour;
  uint32_t minute;
  uint32_t second;
} calendar;
volatile static lv_obj_t * btnPower;
volatile static lv_obj_t * btnMenu;
volatile static lv_obj_t * btnClk;
volatile static lv_obj_t * btnUp;
volatile static lv_obj_t * btnDown;
volatile static lv_obj_t * labelBtnPower;
volatile static lv_obj_t * labelBtnMenu;
volatile static lv_obj_t * labelBtnClk;
volatile static lv_obj_t * labelBtnUp;
volatile static lv_obj_t * labelBtnDown;
volatile static lv_obj_t * labelFloor;
volatile static lv_obj_t * labelFloorDecimal;
volatile static lv_obj_t * labelSetValue;
volatile static lv_obj_t * labelClock;
volatile int    flag_pisca = 0;
volatile int    flag_on = 1;
/************************************************************************/
/* LCD / LVGL                                                           */
/************************************************************************/
LV_FONT_DECLARE(dseg30);
LV_FONT_DECLARE(dseg50);
LV_FONT_DECLARE(dseg70);

#define LV_HOR_RES_MAX          (320)
#define LV_VER_RES_MAX          (240)

/*A static or global variable to store the buffers*/
static lv_disp_draw_buf_t disp_buf;

/*Static or global buffer(s). The second buffer is optional*/
static lv_color_t buf_1[LV_HOR_RES_MAX * LV_VER_RES_MAX];
static lv_disp_drv_t disp_drv;          /*A variable to hold the drivers. Must be static or global.*/
static lv_indev_drv_t indev_drv;

/************************************************************************/
/* RTOS                                                                 */
/************************************************************************/

#define TASK_LCD_STACK_SIZE                (1024*6/sizeof(portSTACK_TYPE))
#define TASK_LCD_STACK_PRIORITY            (tskIDLE_PRIORITY)

#define TASK_CLOCK_STACK_SIZE                (1024*6/sizeof(portSTACK_TYPE))
#define TASK_CLOCK_STACK_PRIORITY            (tskIDLE_PRIORITY)

extern void vApplicationStackOverflowHook(xTaskHandle *pxTask,  signed char *pcTaskName);
extern void vApplicationIdleHook(void);
extern void vApplicationTickHook(void);
extern void vApplicationMallocFailedHook(void);
extern void xPortSysTickHandler(void);

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
/* lvgl                                                                 */
/************************************************************************/

static void power_handler(lv_event_t * e) {
	lv_event_code_t code = lv_event_get_code(e);

	if (code == LV_EVENT_CLICKED) {
		flag_on = !flag_on;
		if (flag_on) {
    		lv_label_set_text(labelBtnPower, "[  " LV_SYMBOL_POWER "  ");
			lv_obj_set_width(btnMenu, 60);  lv_obj_set_height(btnMenu, 60);
			lv_obj_set_width(btnClk, 60);  lv_obj_set_height(btnClk, 60);
			lv_obj_set_width(btnDown, 60);  lv_obj_set_height(btnDown, 60);
			lv_obj_set_width(btnUp, 60);  lv_obj_set_height(btnUp, 60);
			lv_label_set_text_fmt(labelFloor, "%02d", 23);
			lv_label_set_text_fmt(labelFloorDecimal, ".%d", 4);
			lv_label_set_text_fmt(labelSetValue, "%02d", 22);
			uint32_t init_hour, init_min, init_sec;
			rtc_get_time(RTC, &init_hour, &init_min, &init_sec);
			lv_label_set_text_fmt(labelClock, "%02d:%02d", init_hour, init_min);
		} else {
			lv_label_set_text(labelBtnPower, "[  " LV_SYMBOL_POWER "  ]");
			lv_obj_set_width(btnMenu, 0);  lv_obj_set_height(btnMenu, 0);
			lv_obj_set_width(btnClk, 0);  lv_obj_set_height(btnClk, 0);
			lv_obj_set_width(btnDown, 0);  lv_obj_set_height(btnDown, 0);
			lv_obj_set_width(btnUp, 0);  lv_obj_set_height(btnUp, 0);
    		lv_label_set_text_fmt(labelFloor, "");
			lv_label_set_text_fmt(labelFloorDecimal, "");
			lv_label_set_text_fmt(labelSetValue, "");
			lv_label_set_text_fmt(labelClock, "");
		}
	}
	else if(code == LV_EVENT_VALUE_CHANGED) {
		LV_LOG_USER("Toggled");
	}
}

static void menu_handler(lv_event_t * e) {
	lv_event_code_t code = lv_event_get_code(e);

	if(code == LV_EVENT_CLICKED) {
		LV_LOG_USER("Clicked");
	}
	else if(code == LV_EVENT_VALUE_CHANGED) {
		LV_LOG_USER("Toggled");
	}
}

static void clk_handler(lv_event_t * e) {
	lv_event_code_t code = lv_event_get_code(e);

	if(code == LV_EVENT_CLICKED) {
		LV_LOG_USER("Clicked");
	}
	else if(code == LV_EVENT_VALUE_CHANGED) {
		LV_LOG_USER("Toggled");
	}
}

static void up_handler(lv_event_t * e) {
    lv_event_code_t code = lv_event_get_code(e);
    char *c;
    int temp;
    if(code == LV_EVENT_CLICKED) {
        c = lv_label_get_text(labelSetValue);
        temp = atoi(c);
        lv_label_set_text_fmt(labelSetValue, "%02d", temp + 1);
    }
}

static void down_handler(lv_event_t * e) {
    lv_event_code_t code = lv_event_get_code(e);
    char *c;
    int temp;
    if(code == LV_EVENT_CLICKED) {
        c = lv_label_get_text(labelSetValue);
        temp = atoi(c);
        lv_label_set_text_fmt(labelSetValue, "%02d", temp - 1);
    }
}

void lv_termostato(void) {
    static lv_style_t style;
    lv_style_init(&style);
    lv_style_set_bg_color(&style, lv_color_black());
    lv_style_set_border_color(&style, lv_color_white());
    // lv_style_set_border_width(&style, 5);

	btnPower = lv_btn_create(lv_scr_act());
	lv_obj_add_event_cb(btnPower, power_handler, LV_EVENT_ALL, NULL);
	lv_obj_align(btnPower, LV_ALIGN_BOTTOM_LEFT, 0, 0);
	lv_obj_add_style(btnPower, &style, 0);
    lv_obj_set_width(btnPower, 60);  lv_obj_set_height(btnPower, 60);
	labelBtnPower = lv_label_create(btnPower);
	lv_label_set_text(labelBtnPower, "[  " LV_SYMBOL_POWER "  ");
	lv_obj_center(labelBtnPower);

	btnMenu = lv_btn_create(lv_scr_act());
	lv_obj_add_event_cb(btnMenu, menu_handler, LV_EVENT_ALL, NULL);
	lv_obj_align(btnMenu, LV_ALIGN_BOTTOM_LEFT, 60, 0);
	lv_obj_add_style(btnMenu, &style, 0);
    lv_obj_set_width(btnMenu, 60);  lv_obj_set_height(btnMenu, 60);
	labelBtnMenu = lv_label_create(btnMenu);
	lv_label_set_text(labelBtnMenu, "|  M  |");
	lv_obj_center(labelBtnMenu);

	btnClk = lv_btn_create(lv_scr_act());
	lv_obj_add_event_cb(btnClk, clk_handler, LV_EVENT_ALL, NULL);
	lv_obj_align(btnClk, LV_ALIGN_BOTTOM_LEFT, 120, 0);
	lv_obj_add_style(btnClk, &style, 0);
    lv_obj_set_width(btnClk, 60);  lv_obj_set_height(btnClk, 60);
	labelBtnClk = lv_label_create(btnClk);
	lv_label_set_text(labelBtnClk, "  " LV_SYMBOL_REFRESH "  ]");
	lv_obj_center(labelBtnClk);

	btnDown = lv_btn_create(lv_scr_act());
	lv_obj_add_event_cb(btnDown, down_handler, LV_EVENT_ALL, NULL);
	lv_obj_align(btnDown, LV_ALIGN_BOTTOM_RIGHT, -10, 0);
	lv_obj_add_style(btnDown, &style, 0);
    lv_obj_set_width(btnDown, 60);  lv_obj_set_height(btnDown, 60);
	labelBtnDown = lv_label_create(btnDown);
	lv_label_set_text(labelBtnDown, "  |  " LV_SYMBOL_DOWN "  ] ");
	lv_obj_center(labelBtnDown);

	btnUp = lv_btn_create(lv_scr_act());
	lv_obj_add_event_cb(btnUp, up_handler, LV_EVENT_ALL, NULL);
	lv_obj_align(btnUp, LV_ALIGN_BOTTOM_RIGHT, -70, 0);
	lv_obj_add_style(btnUp, &style, 0);
    lv_obj_set_width(btnUp, 60);  lv_obj_set_height(btnUp, 60);
	labelBtnUp = lv_label_create(btnUp);
	lv_label_set_text(labelBtnUp, "[  " LV_SYMBOL_UP);
	lv_obj_center(labelBtnUp);

	labelFloor = lv_label_create(lv_scr_act());
    lv_obj_align(labelFloor, LV_ALIGN_LEFT_MID, 35, -30);
    lv_obj_set_style_text_font(labelFloor, &dseg70, LV_STATE_DEFAULT);
    lv_obj_set_style_text_color(labelFloor, lv_color_white(), LV_STATE_DEFAULT);
    lv_label_set_text_fmt(labelFloor, "%02d", 23);

	labelFloorDecimal = lv_label_create(lv_scr_act());
    lv_obj_align_to(labelFloorDecimal, labelFloor, LV_ALIGN_BOTTOM_RIGHT, 60, -22);
    lv_obj_set_style_text_font(labelFloorDecimal, &dseg50, LV_STATE_DEFAULT);
    lv_obj_set_style_text_color(labelFloorDecimal, lv_color_white(), LV_STATE_DEFAULT);
    lv_label_set_text_fmt(labelFloorDecimal, ".%d", 4);

	labelSetValue = lv_label_create(lv_scr_act());
    lv_obj_align(labelSetValue, LV_ALIGN_RIGHT_MID, -10, -40);
    lv_obj_set_style_text_font(labelSetValue, &dseg50, LV_STATE_DEFAULT);
    lv_obj_set_style_text_color(labelSetValue, lv_color_white(), LV_STATE_DEFAULT);
    lv_label_set_text_fmt(labelSetValue, "%02d", 22);
	
	labelClock = lv_label_create(lv_scr_act());
    lv_obj_align(labelClock, LV_ALIGN_RIGHT_MID, -10, -100);
    lv_obj_set_style_text_font(labelClock, &dseg30, LV_STATE_DEFAULT);
    lv_obj_set_style_text_color(labelClock, lv_color_white(), LV_STATE_DEFAULT);
	uint32_t init_hour, init_min, init_sec;
	rtc_get_time(RTC, &init_hour, &init_min, &init_sec);
    lv_label_set_text_fmt(labelClock, "%02d:%02d", init_hour, init_min);
}

/************************************************************************/
/* TASKS                                                                */
/************************************************************************/

static void task_lcd(void *pvParameters) {
	int px, py;

	lv_termostato();

	for (;;)  {
		lv_tick_inc(50);
		lv_task_handler();
		vTaskDelay(50);
	}
}

static void task_clock(void *pvParameters) {
	uint32_t past_hour, past_min, past_sec;
	uint32_t current_hour, current_min, current_sec;
	for (;;)  {
		if (flag_on) {
			rtc_get_time(RTC, &current_hour, &current_min, &current_sec);
			if (flag_pisca) {
				lv_label_set_text_fmt(labelClock, "%02d:%02d", current_hour, current_min);
			} else {
				lv_label_set_text_fmt(labelClock, "%02d %02d", current_hour, current_min);
			}
		}
		vTaskDelay(100);
	}
}

/************************************************************************/
/* configs                                                              */
/************************************************************************/

static void configure_lcd(void) {
	/**LCD pin configure on SPI*/
	pio_configure_pin(LCD_SPI_MISO_PIO, LCD_SPI_MISO_FLAGS);  //
	pio_configure_pin(LCD_SPI_MOSI_PIO, LCD_SPI_MOSI_FLAGS);
	pio_configure_pin(LCD_SPI_SPCK_PIO, LCD_SPI_SPCK_FLAGS);
	pio_configure_pin(LCD_SPI_NPCS_PIO, LCD_SPI_NPCS_FLAGS);
	pio_configure_pin(LCD_SPI_RESET_PIO, LCD_SPI_RESET_FLAGS);
	pio_configure_pin(LCD_SPI_CDS_PIO, LCD_SPI_CDS_FLAGS);
	
	ili9341_init();
	ili9341_backlight_on();
}

static void configure_console(void) {
	const usart_serial_options_t uart_serial_options = {
		.baudrate = USART_SERIAL_EXAMPLE_BAUDRATE,
		.charlength = USART_SERIAL_CHAR_LENGTH,
		.paritytype = USART_SERIAL_PARITY,
		.stopbits = USART_SERIAL_STOP_BIT,
	};

	/* Configure console UART. */
	stdio_serial_init(CONSOLE_UART, &uart_serial_options);

	/* Specify that stdout should not be buffered. */
	setbuf(stdout, NULL);
}

void RTC_init(Rtc *rtc, uint32_t id_rtc, calendar t, uint32_t irq_type) {
	pmc_enable_periph_clk(ID_RTC);

	rtc_set_hour_mode(rtc, 0);

	rtc_set_date(rtc, t.year, t.month, t.day, t.week);
	rtc_set_time(rtc, t.hour, t.minute, t.second);

	NVIC_DisableIRQ(id_rtc);
	NVIC_ClearPendingIRQ(id_rtc);
	NVIC_SetPriority(id_rtc, 4);
	NVIC_EnableIRQ(id_rtc);

	rtc_enable_interrupt(rtc,  irq_type);
}

void RTC_Handler(void) {
    uint32_t ul_status = rtc_get_status(RTC);
	
    /* Second tick */
	if ((ul_status & RTC_SR_SEC) == RTC_SR_SEC) {
		flag_pisca = !flag_pisca;
	}

    rtc_clear_status(RTC, RTC_SCCR_SECCLR);
    rtc_clear_status(RTC, RTC_SCCR_ALRCLR);
    rtc_clear_status(RTC, RTC_SCCR_ACKCLR);
    rtc_clear_status(RTC, RTC_SCCR_TIMCLR);
    rtc_clear_status(RTC, RTC_SCCR_CALCLR);
    rtc_clear_status(RTC, RTC_SCCR_TDERRCLR);
}

/************************************************************************/
/* port lvgl                                                            */
/************************************************************************/
void my_flush_cb(lv_disp_drv_t * disp_drv, const lv_area_t * area, lv_color_t * color_p) {
	ili9341_set_top_left_limit(area->x1, area->y1);   ili9341_set_bottom_right_limit(area->x2, area->y2);
	ili9341_copy_pixels_to_screen(color_p,  (area->x2 + 1 - area->x1) * (area->y2 + 1 - area->y1));
	
	/* IMPORTANT!!!
	* Inform the graphics library that you are ready with the flushing*/
	lv_disp_flush_ready(disp_drv);
}

void my_input_read(lv_indev_drv_t * drv, lv_indev_data_t*data) {
	int px, py, pressed;
	
	if (readPoint(&px, &py))
		data->state = LV_INDEV_STATE_PRESSED;
	else
		data->state = LV_INDEV_STATE_RELEASED; 
	
	data->point.x = px;
	data->point.y = py;
}

void configure_lvgl(void) {
	lv_init();
	lv_disp_draw_buf_init(&disp_buf, buf_1, NULL, LV_HOR_RES_MAX * LV_VER_RES_MAX);
	
	lv_disp_drv_init(&disp_drv);            /*Basic initialization*/
	disp_drv.draw_buf = &disp_buf;          /*Set an initialized buffer*/
	disp_drv.flush_cb = my_flush_cb;        /*Set a flush callback to draw to the display*/
	disp_drv.hor_res = LV_HOR_RES_MAX;      /*Set the horizontal resolution in pixels*/
	disp_drv.ver_res = LV_VER_RES_MAX;      /*Set the vertical resolution in pixels*/

	lv_disp_t * disp;
	disp = lv_disp_drv_register(&disp_drv); /*Register the driver and save the created display objects*/
	
	/* Init input on LVGL */
	lv_indev_drv_init(&indev_drv);
	indev_drv.type = LV_INDEV_TYPE_POINTER;
	indev_drv.read_cb = my_input_read;
	lv_indev_t * my_indev = lv_indev_drv_register(&indev_drv);
}

/************************************************************************/
/* main                                                                 */
/************************************************************************/
int main(void) {
	/* board and sys init */
	board_init();
	sysclk_init();
	configure_console();

	/* LCd, touch and lvgl init*/
	configure_lcd();
	configure_touch();
	configure_lvgl();

	/* RTC */
	calendar rtc_initial = {2023, 5, 7, 18, 12, 56, 1};
	RTC_init(RTC, ID_RTC, rtc_initial, RTC_IER_SECEN);

	/* Create task to control oled */
	if (xTaskCreate(task_lcd, "LCD", TASK_LCD_STACK_SIZE, NULL, TASK_LCD_STACK_PRIORITY, NULL) != pdPASS) {
		printf("Failed to create lcd task\r\n");
	}
	
	if (xTaskCreate(task_clock, "clock", TASK_CLOCK_STACK_SIZE, NULL, TASK_CLOCK_STACK_PRIORITY, NULL) != pdPASS) {
		printf("Failed to create clock task\r\n");
	}

	/* Start the scheduler. */
	vTaskStartScheduler();

	while(1){ }
}
