int process_pixel(int level, int param) {
    int new_level;

    if (level < param) {
        new_level = 0;
    } else {
        new_level = 255;
    }

    return new_level;
}
