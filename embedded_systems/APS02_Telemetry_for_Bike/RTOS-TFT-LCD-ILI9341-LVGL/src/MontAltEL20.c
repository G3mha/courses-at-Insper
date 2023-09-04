/*******************************************************************************
 * Size: 20 px
 * Bpp: 1
 * Opts: 
 ******************************************************************************/
#define LV_LVGL_H_INCLUDE_SIMPLE 
#ifdef LV_LVGL_H_INCLUDE_SIMPLE
#include "lvgl.h"
#else
#include "lvgl/lvgl.h"
#endif

#ifndef MONTALTEL20
#define MONTALTEL20 1
#endif

#if MONTALTEL20

/*-----------------
 *    BITMAPS
 *----------------*/

/*Store the image of the glyphs*/
static LV_ATTRIBUTE_LARGE_CONST const uint8_t glyph_bitmap[] = {
    /* U+0020 " " */
    0x0,

    /* U+002C "," */
    0xea,

    /* U+002E "." */
    0xc0,

    /* U+002F "/" */
    0x2, 0x8, 0x10, 0x20, 0x81, 0x2, 0x8, 0x10,
    0x20, 0x81, 0x2, 0x8, 0x10, 0x20, 0x81, 0x2,
    0x4, 0x0,

    /* U+0030 "0" */
    0x1f, 0x6, 0x31, 0x1, 0x20, 0x28, 0x3, 0x0,
    0x60, 0xc, 0x1, 0x80, 0x30, 0x6, 0x0, 0xa0,
    0x24, 0x4, 0x63, 0x7, 0xc0,

    /* U+0031 "1" */
    0xf8, 0x42, 0x10, 0x84, 0x21, 0x8, 0x42, 0x10,
    0x84, 0x20,

    /* U+0032 "2" */
    0x3e, 0x30, 0x40, 0x8, 0x2, 0x0, 0x80, 0x20,
    0x10, 0x8, 0x4, 0x2, 0x1, 0x0, 0x80, 0x20,
    0x10, 0xf, 0xfc,

    /* U+0033 "3" */
    0x7f, 0x80, 0x20, 0x10, 0x8, 0x2, 0x1, 0x0,
    0x80, 0x3c, 0x1, 0x80, 0x10, 0x4, 0x1, 0x80,
    0x50, 0x61, 0xf0,

    /* U+0034 "4" */
    0x1, 0x0, 0x10, 0x2, 0x0, 0x40, 0x8, 0x1,
    0x0, 0x10, 0x82, 0x8, 0x40, 0x88, 0x8, 0xff,
    0xf0, 0x8, 0x0, 0x80, 0x8, 0x0, 0x80,

    /* U+0035 "5" */
    0x3f, 0x90, 0x4, 0x1, 0x0, 0x40, 0x10, 0x7,
    0xe0, 0x6, 0x0, 0xc0, 0x10, 0x4, 0x1, 0x80,
    0xd0, 0x61, 0xf0,

    /* U+0036 "6" */
    0x1f, 0xc, 0x24, 0x1, 0x0, 0x80, 0x20, 0x9,
    0xf2, 0x86, 0xc0, 0xf0, 0x1c, 0x5, 0x1, 0x40,
    0xc8, 0x61, 0xf0,

    /* U+0037 "7" */
    0xff, 0xe0, 0x18, 0xa, 0x2, 0x1, 0x0, 0x40,
    0x10, 0x8, 0x2, 0x1, 0x0, 0x40, 0x20, 0x8,
    0x2, 0x1, 0x0,

    /* U+0038 "8" */
    0x3f, 0xc, 0x32, 0x1, 0x40, 0x28, 0x5, 0x0,
    0x98, 0x60, 0xf0, 0x61, 0xd0, 0xe, 0x0, 0xc0,
    0x18, 0x6, 0xc1, 0x8f, 0xc0,

    /* U+0039 "9" */
    0x3e, 0x18, 0x4c, 0xa, 0x2, 0x80, 0xe0, 0x3c,
    0x15, 0x85, 0x3e, 0x40, 0x10, 0x4, 0x2, 0x0,
    0x90, 0xc3, 0xe0,

    /* U+003A ":" */
    0xc0, 0x0, 0xc,

    /* U+0041 "A" */
    0x1f, 0x4, 0x11, 0x1, 0x40, 0x18, 0x3, 0x0,
    0x60, 0xc, 0x1, 0x80, 0x3f, 0xfe, 0x0, 0xc0,
    0x18, 0x3, 0x0, 0x60, 0x8,

    /* U+0043 "C" */
    0x7, 0xc1, 0x83, 0x20, 0x4, 0x0, 0x40, 0x8,
    0x0, 0x80, 0x8, 0x0, 0x80, 0x8, 0x0, 0x40,
    0x4, 0x0, 0x20, 0x1, 0x83, 0x7, 0xc0,

    /* U+0044 "D" */
    0xff, 0x4, 0x6, 0x20, 0x9, 0x0, 0x28, 0x1,
    0x40, 0x6, 0x0, 0x30, 0x1, 0x80, 0xc, 0x0,
    0x60, 0x5, 0x0, 0x28, 0x2, 0x40, 0x63, 0xfc,
    0x0,

    /* U+0048 "H" */
    0x80, 0x30, 0x6, 0x0, 0xc0, 0x18, 0x3, 0x0,
    0x60, 0xf, 0xff, 0x80, 0x30, 0x6, 0x0, 0xc0,
    0x18, 0x3, 0x0, 0x60, 0x8,

    /* U+004D "M" */
    0x9e, 0xf, 0x94, 0x32, 0x1b, 0x2, 0x81, 0x40,
    0x20, 0x18, 0x4, 0x3, 0x0, 0x80, 0x60, 0x10,
    0xc, 0x2, 0x1, 0x80, 0x40, 0x30, 0x8, 0x6,
    0x1, 0x0, 0xc0, 0x20, 0x18, 0x4, 0x3, 0x0,
    0x80, 0x60, 0x10, 0x8,

    /* U+0050 "P" */
    0xff, 0x10, 0x1a, 0x1, 0x40, 0x18, 0x3, 0x0,
    0x60, 0xc, 0x2, 0x80, 0xdf, 0xe2, 0x0, 0x40,
    0x8, 0x1, 0x0, 0x20, 0x0,

    /* U+0053 "S" */
    0x3e, 0x18, 0x6c, 0x2, 0x0, 0x80, 0x20, 0x6,
    0x0, 0x70, 0x3, 0x0, 0x20, 0x4, 0x1, 0x0,
    0xf0, 0x63, 0xf0,

    /* U+0056 "V" */
    0x80, 0xa, 0x0, 0x50, 0x4, 0x80, 0x22, 0x1,
    0x10, 0x10, 0x40, 0x82, 0x8, 0x10, 0x40, 0x44,
    0x2, 0x20, 0x9, 0x0, 0x50, 0x1, 0x80, 0x8,
    0x0,

    /* U+005B "[" */
    0xf2, 0x49, 0x24, 0x92, 0x49, 0x24, 0x93, 0x80,

    /* U+005D "]" */
    0xe4, 0x92, 0x49, 0x24, 0x92, 0x49, 0x27, 0x80,

    /* U+0061 "a" */
    0x1e, 0x58, 0x54, 0xe, 0x1, 0x80, 0x60, 0x18,
    0x6, 0x1, 0x40, 0xd8, 0x51, 0xe4,

    /* U+0063 "c" */
    0x1f, 0x10, 0x50, 0x10, 0x8, 0x4, 0x2, 0x1,
    0x0, 0x40, 0x10, 0x47, 0xc0,

    /* U+0064 "d" */
    0x0, 0x40, 0x10, 0x4, 0x1, 0x1e, 0x58, 0x54,
    0xe, 0x1, 0x80, 0x60, 0x18, 0x6, 0x1, 0x40,
    0xd8, 0x51, 0xe4,

    /* U+0065 "e" */
    0x1e, 0x18, 0x44, 0xa, 0x2, 0x80, 0xa3, 0xcf,
    0x2, 0x0, 0x40, 0x18, 0x61, 0xe0,

    /* U+0067 "g" */
    0x1e, 0x58, 0x54, 0xe, 0x1, 0x80, 0x60, 0x18,
    0x6, 0x1, 0x40, 0xd8, 0x51, 0xe4, 0x1, 0x0,
    0xd8, 0x61, 0xf0,

    /* U+0068 "h" */
    0x80, 0x40, 0x20, 0x10, 0x9, 0xe5, 0xb, 0x7,
    0x1, 0x80, 0xc0, 0x60, 0x30, 0x18, 0xc, 0x6,
    0x2,

    /* U+0069 "i" */
    0x8f, 0xfe,

    /* U+006B "k" */
    0x80, 0x40, 0x20, 0x10, 0x8, 0x14, 0x12, 0x11,
    0x10, 0x98, 0x54, 0x31, 0x10, 0x48, 0x14, 0xa,
    0x2,

    /* U+006C "l" */
    0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x8c, 0x70,

    /* U+006D "m" */
    0x9e, 0x1e, 0x50, 0x90, 0xb0, 0x70, 0x70, 0x10,
    0x18, 0x8, 0xc, 0x4, 0x6, 0x2, 0x3, 0x1,
    0x1, 0x80, 0x80, 0xc0, 0x40, 0x60, 0x20, 0x20,

    /* U+006F "o" */
    0x1e, 0x18, 0x64, 0xa, 0x1, 0x80, 0x60, 0x18,
    0x6, 0x1, 0x40, 0x98, 0x61, 0xe0,

    /* U+0070 "p" */
    0x9e, 0x28, 0x6c, 0xa, 0x1, 0x80, 0x60, 0x18,
    0x6, 0x1, 0xc0, 0xa8, 0x69, 0xe2, 0x0, 0x80,
    0x20, 0x8, 0x0,

    /* U+0072 "r" */
    0x9d, 0x31, 0x8, 0x42, 0x10, 0x84, 0x20,

    /* U+0073 "s" */
    0x7c, 0xc2, 0x80, 0x80, 0x40, 0x38, 0x6, 0x1,
    0x1, 0x83, 0x7e,

    /* U+0074 "t" */
    0x84, 0x21, 0xe8, 0x42, 0x10, 0x84, 0x21, 0xc,
    0x3c,

    /* U+0075 "u" */
    0x80, 0xc0, 0x60, 0x30, 0x18, 0xc, 0x6, 0x3,
    0x1, 0x81, 0xa1, 0x4f, 0x20,

    /* U+00E1 "á" */
    0x2, 0x1, 0x0, 0x0, 0x0, 0x1e, 0x58, 0x54,
    0xe, 0x1, 0x80, 0x60, 0x18, 0x6, 0x1, 0x40,
    0xd8, 0x51, 0xe4,

    /* U+00E9 "é" */
    0x2, 0x1, 0x0, 0x0, 0x0, 0x1e, 0x18, 0x44,
    0xa, 0x2, 0x80, 0xa3, 0xcf, 0x2, 0x0, 0x40,
    0x18, 0x61, 0xe0
};


/*---------------------
 *  GLYPH DESCRIPTION
 *--------------------*/

static const lv_font_fmt_txt_glyph_dsc_t glyph_dsc[] = {
    {.bitmap_index = 0, .adv_w = 0, .box_w = 0, .box_h = 0, .ofs_x = 0, .ofs_y = 0} /* id = 0 reserved */,
    {.bitmap_index = 0, .adv_w = 81, .box_w = 1, .box_h = 1, .ofs_x = 0, .ofs_y = 0},
    {.bitmap_index = 1, .adv_w = 61, .box_w = 2, .box_h = 4, .ofs_x = 1, .ofs_y = -3},
    {.bitmap_index = 2, .adv_w = 61, .box_w = 2, .box_h = 1, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 3, .adv_w = 99, .box_w = 7, .box_h = 20, .ofs_x = 0, .ofs_y = -2},
    {.bitmap_index = 21, .adv_w = 210, .box_w = 11, .box_h = 15, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 42, .adv_w = 111, .box_w = 5, .box_h = 15, .ofs_x = 0, .ofs_y = 0},
    {.bitmap_index = 52, .adv_w = 179, .box_w = 10, .box_h = 15, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 71, .adv_w = 177, .box_w = 10, .box_h = 15, .ofs_x = 0, .ofs_y = 0},
    {.bitmap_index = 90, .adv_w = 207, .box_w = 12, .box_h = 15, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 113, .adv_w = 177, .box_w = 10, .box_h = 15, .ofs_x = 0, .ofs_y = 0},
    {.bitmap_index = 132, .adv_w = 191, .box_w = 10, .box_h = 15, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 151, .adv_w = 184, .box_w = 10, .box_h = 15, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 170, .adv_w = 201, .box_w = 11, .box_h = 15, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 191, .adv_w = 191, .box_w = 10, .box_h = 15, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 210, .adv_w = 61, .box_w = 2, .box_h = 11, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 213, .adv_w = 257, .box_w = 11, .box_h = 15, .ofs_x = 2, .ofs_y = 0},
    {.bitmap_index = 234, .adv_w = 228, .box_w = 12, .box_h = 15, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 257, .adv_w = 264, .box_w = 13, .box_h = 15, .ofs_x = 3, .ofs_y = 0},
    {.bitmap_index = 282, .adv_w = 261, .box_w = 11, .box_h = 15, .ofs_x = 3, .ofs_y = 0},
    {.bitmap_index = 303, .adv_w = 392, .box_w = 19, .box_h = 15, .ofs_x = 3, .ofs_y = 0},
    {.bitmap_index = 339, .adv_w = 228, .box_w = 11, .box_h = 15, .ofs_x = 3, .ofs_y = 0},
    {.bitmap_index = 360, .adv_w = 193, .box_w = 10, .box_h = 15, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 379, .adv_w = 217, .box_w = 13, .box_h = 15, .ofs_x = 0, .ofs_y = 0},
    {.bitmap_index = 404, .adv_w = 95, .box_w = 3, .box_h = 19, .ofs_x = 3, .ofs_y = -4},
    {.bitmap_index = 412, .adv_w = 95, .box_w = 3, .box_h = 19, .ofs_x = 1, .ofs_y = -4},
    {.bitmap_index = 420, .adv_w = 215, .box_w = 10, .box_h = 11, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 434, .adv_w = 176, .box_w = 9, .box_h = 11, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 447, .adv_w = 215, .box_w = 10, .box_h = 15, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 466, .adv_w = 189, .box_w = 10, .box_h = 11, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 480, .adv_w = 217, .box_w = 10, .box_h = 15, .ofs_x = 1, .ofs_y = -4},
    {.bitmap_index = 499, .adv_w = 214, .box_w = 9, .box_h = 15, .ofs_x = 2, .ofs_y = 0},
    {.bitmap_index = 516, .adv_w = 82, .box_w = 1, .box_h = 15, .ofs_x = 2, .ofs_y = 0},
    {.bitmap_index = 518, .adv_w = 185, .box_w = 9, .box_h = 15, .ofs_x = 2, .ofs_y = 0},
    {.bitmap_index = 535, .adv_w = 93, .box_w = 4, .box_h = 15, .ofs_x = 2, .ofs_y = 0},
    {.bitmap_index = 543, .adv_w = 341, .box_w = 17, .box_h = 11, .ofs_x = 2, .ofs_y = 0},
    {.bitmap_index = 567, .adv_w = 196, .box_w = 10, .box_h = 11, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 581, .adv_w = 215, .box_w = 10, .box_h = 15, .ofs_x = 2, .ofs_y = -4},
    {.bitmap_index = 600, .adv_w = 124, .box_w = 5, .box_h = 11, .ofs_x = 2, .ofs_y = 0},
    {.bitmap_index = 607, .adv_w = 150, .box_w = 8, .box_h = 11, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 618, .adv_w = 121, .box_w = 5, .box_h = 14, .ofs_x = 2, .ofs_y = 0},
    {.bitmap_index = 627, .adv_w = 213, .box_w = 9, .box_h = 11, .ofs_x = 2, .ofs_y = 0},
    {.bitmap_index = 640, .adv_w = 215, .box_w = 10, .box_h = 15, .ofs_x = 1, .ofs_y = 0},
    {.bitmap_index = 659, .adv_w = 189, .box_w = 10, .box_h = 15, .ofs_x = 1, .ofs_y = 0}
};

/*---------------------
 *  CHARACTER MAPPING
 *--------------------*/

static const uint16_t unicode_list_0[] = {
    0x0, 0xc, 0xe, 0xf, 0x10, 0x11, 0x12, 0x13,
    0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x21,
    0x23, 0x24, 0x28, 0x2d, 0x30, 0x33, 0x36, 0x3b,
    0x3d, 0x41, 0x43, 0x44, 0x45, 0x47, 0x48, 0x49,
    0x4b, 0x4c, 0x4d, 0x4f, 0x50, 0x52, 0x53, 0x54,
    0x55, 0xc1, 0xc9
};

/*Collect the unicode lists and glyph_id offsets*/
static const lv_font_fmt_txt_cmap_t cmaps[] =
{
    {
        .range_start = 32, .range_length = 202, .glyph_id_start = 1,
        .unicode_list = unicode_list_0, .glyph_id_ofs_list = NULL, .list_length = 43, .type = LV_FONT_FMT_TXT_CMAP_SPARSE_TINY
    }
};

/*-----------------
 *    KERNING
 *----------------*/


/*Map glyph_ids to kern left classes*/
static const uint8_t kern_left_class_mapping[] =
{
    0, 0, 1, 1, 2, 3, 0, 4,
    5, 6, 7, 8, 9, 10, 3, 11,
    12, 13, 14, 15, 16, 17, 18, 19,
    20, 0, 21, 22, 0, 23, 21, 24,
    21, 25, 26, 24, 27, 27, 28, 29,
    30, 21, 21, 23
};

/*Map glyph_ids to kern right classes*/
static const uint8_t kern_right_class_mapping[] =
{
    0, 0, 1, 1, 2, 3, 4, 5,
    6, 7, 8, 3, 9, 10, 11, 12,
    13, 14, 15, 15, 15, 15, 16, 17,
    18, 19, 20, 20, 20, 20, 20, 21,
    22, 21, 21, 23, 20, 23, 23, 24,
    21, 25, 20, 20
};

/*Kern values between classes*/
static const int8_t kern_class_values[] =
{
    0, 35, -3, -4, 3, 3, -6, 0,
    -4, 3, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, -32, -20, -6, 10, 0, 0, -22,
    0, 6, -7, 0, -5, 0, 0, 0,
    0, 0, 0, 10, 0, 0, 0, 0,
    0, 0, -3, -6, 0, 0, 0, -3,
    0, 0, -3, 0, 0, 0, 0, 0,
    0, 0, -8, 0, 0, 0, 0, 0,
    0, 0, 0, 3, 3, -2, 0, 0,
    0, -9, 0, -2, 0, 0, 0, 0,
    0, 0, 0, -3, 0, 0, -3, 0,
    0, 0, 0, -2, 0, 0, 0, 0,
    -2, -2, 0, -3, -4, 0, 0, 0,
    0, 0, 0, 0, -3, 0, 0, 0,
    0, 0, 0, 0, 0, 6, 9, 0,
    -8, -2, -6, 0, -2, -17, 3, -3,
    2, 0, 3, 0, -3, -16, 0, 0,
    4, 0, 0, 0, 0, 0, 0, 0,
    0, 0, -2, -2, 0, -2, -5, 0,
    0, 0, 0, 0, 0, 0, -2, 0,
    0, 0, 0, 0, 0, 0, 0, 3,
    3, 0, 0, 0, 0, 0, 0, -3,
    0, 0, 0, 0, 0, 0, 0, -3,
    0, 0, 3, 0, 0, 0, 0, 0,
    -17, -14, -6, 3, 0, -3, -21, -6,
    0, -6, 0, -6, -6, -6, 0, -3,
    2, 0, -3, -16, 0, -9, -9, -10,
    -9, 3, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, -5, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 13, 0, 0, 0, 0,
    0, 0, 3, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, -3, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, -6, 0, 0, 0, 0,
    0, 0, 0, 0, 5, 0, -8, 3,
    -3, -2, -12, -3, 0, -5, -3, -1,
    0, -5, 0, -2, -3, 0, 0, -8,
    0, 0, 0, -6, -6, -6, -6, 0,
    -3, -3, -3, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, -6, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, -3, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, -2, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    -10, -16, 0, 0, -2, -5, -10, -3,
    0, -2, 0, 0, -9, 0, -3, 0,
    -5, 0, -4, -4, 0, -9, -9, 0,
    0, 6, 0, 0, -3, 0, -3, 3,
    0, -3, 0, -3, -2, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, -11, -13, -8, 10, 0, 0,
    -23, -2, 3, -5, -2, -7, -6, -6,
    -5, -5, 0, 0, 7, -18, 0, -7,
    -11, -18, -10, 0, 10, 0, 4, 0,
    0, -4, 0, 6, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, -3,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, -7, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 6, 0, -3,
    -8, -3, -6, -9, 0, -6, -2, -3,
    2, -3, 0, 0, 0, -1, -3, -4,
    -3, -3, 0, 0, 0, 0, 0, 0,
    0, -9, -3, -6, 0, 0, -10, 0,
    -3, 0, 0, 0, 0, 0, -6, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, -8, -2, 0, 0, 0, -8,
    0, -6, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    3, 0, -3, 0, 4, 3, -10, 0,
    -3, -2, 3, 0, 0, 0, 0, 0,
    -4, -4, 0, -6, 0, -3, -3, -5,
    -3, 9, 12, 3, -6, 6, 3, 0,
    2, -5, 3, 0, 6, 0, 0, 0,
    0, 0, 0, 0, -3, 0, 0, 0,
    0, 0, -6, 0, 0, -9, -3, -8,
    0, 0, -9, 0, -3, 0, 0, 0,
    0, 0, -13, 0, 0, 0, 0, 0,
    0, 0, 0, -3, -13, 0, -6, 0,
    -3, -11, 0, 6, 0, 0, 0, -6,
    -9, -6, -7, -9, -7, -6, -4, -3,
    -3, -3, -2, 0, 0, 0, 0, -3,
    -3, -3, 0, 0, -9, 0, -2, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 3, 0, -6,
    -8, -3, 0, -12, -3, -9, -2, -6,
    0, 0, 0, 0, 0, 0, 0, 0,
    -6, 0, 0, 0, 0, 0
};


/*Collect the kern class' data in one place*/
static const lv_font_fmt_txt_kern_classes_t kern_classes =
{
    .class_pair_values   = kern_class_values,
    .left_class_mapping  = kern_left_class_mapping,
    .right_class_mapping = kern_right_class_mapping,
    .left_class_cnt      = 30,
    .right_class_cnt     = 25,
};

/*--------------------
 *  ALL CUSTOM DATA
 *--------------------*/

#if LV_VERSION_CHECK(8, 0, 0)
/*Store all the custom data of the font*/
static  lv_font_fmt_txt_glyph_cache_t cache;
static const lv_font_fmt_txt_dsc_t font_dsc = {
#else
static lv_font_fmt_txt_dsc_t font_dsc = {
#endif
    .glyph_bitmap = glyph_bitmap,
    .glyph_dsc = glyph_dsc,
    .cmaps = cmaps,
    .kern_dsc = &kern_classes,
    .kern_scale = 16,
    .cmap_num = 1,
    .bpp = 1,
    .kern_classes = 1,
    .bitmap_format = 0,
#if LV_VERSION_CHECK(8, 0, 0)
    .cache = &cache
#endif
};


/*-----------------
 *  PUBLIC FONT
 *----------------*/

/*Initialize a public general font descriptor*/
#if LV_VERSION_CHECK(8, 0, 0)
const lv_font_t MontAltEL20 = {
#else
lv_font_t MontAltEL20 = {
#endif
    .get_glyph_dsc = lv_font_get_glyph_dsc_fmt_txt,    /*Function pointer to get glyph's data*/
    .get_glyph_bitmap = lv_font_get_bitmap_fmt_txt,    /*Function pointer to get glyph's bitmap*/
    .line_height = 22,          /*The maximum line height required by the font*/
    .base_line = 4,             /*Baseline measured from the bottom of the line*/
#if !(LVGL_VERSION_MAJOR == 6 && LVGL_VERSION_MINOR == 0)
    .subpx = LV_FONT_SUBPX_NONE,
#endif
#if LV_VERSION_CHECK(7, 4, 0) || LVGL_VERSION_MAJOR >= 8
    .underline_position = -1,
    .underline_thickness = 1,
#endif
    .dsc = &font_dsc           /*The custom font data. Will be accessed by `get_glyph_bitmap/dsc` */
};



#endif /*#if MONTALTEL20*/

