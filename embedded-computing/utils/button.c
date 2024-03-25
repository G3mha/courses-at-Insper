/* *
 * Arquivo com inicialização de Botões
 *
 * Defines e configs de:
 *  - Botão embutido
 *  - Botão 1 da placa OLED1
 *  - Botão 2 da placa OLED1
 *  - Botão 3 da placa OLED1
 *  - Todos juntos
 *
 * OBS: o código só funciona quando na entrada EXT1
 * NÃO ESQUEÇA DE CHAMAR A FUNÇÃO NA MAIN
 */

/* --- --- --- --- --- --- --- --- --- --- --- --- --- */

// Em CONFIG DA PLACA

// Config do botão embutido
#define BUT_PIO PIOA
#define BUT_PIO_ID ID_PIOA
#define BUT_PIO_IDX 11
#define BUT_PIO_IDX_MASK (1u << BUT_PIO_IDX)
// Config do BUT1
#define BUT1_PIO PIOD
#define BUT1_PIO_ID ID_PIOD
#define BUT1_PIO_IDX 28
#define BUT1_PIO_IDX_MASK (1u << BUT1_PIO_IDX)
// Config do BUT2
#define BUT2_PIO PIOC
#define BUT2_PIO_ID ID_PIOC
#define BUT2_PIO_IDX 31
#define BUT2_PIO_IDX_MASK (1u << BUT2_PIO_IDX)
// Config do BUT3
#define BUT3_PIO PIOA
#define BUT3_PIO_ID ID_PIOA
#define BUT3_PIO_IDX 19
#define BUT3_PIO_IDX_MASK (1u << BUT3_PIO_IDX)

/* --- --- --- --- --- --- --- --- --- --- --- --- --- */

// EM PROTOTYPES
void init_but(Pio *pio, uint32_t id, uint32_t mask);

// EM INICIALIZAÇÕES
void init_but(Pio *pio, uint32_t id, uint32_t mask) {
    // Config do Botão
    pmc_enable_periph_clk(id);
    pio_set_input(pio, mask, PIO_DEFAULT);
    pio_pull_up(pio, mask, 1);
    pio_set_debounce_filter(pio, mask, 60);
}