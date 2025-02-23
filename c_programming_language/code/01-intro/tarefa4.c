int process_pixel(int level, int param) {
    int new_level;
    
    new_level = level + param;

    if (new_level > 255) {
        new_level = 255;
    } else {
        new_level = new_level;
    }

    return new_level;
}
