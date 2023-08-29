// sudo apt-get install libsodium-dev
// sudo apt-get install libjansson-dev
// gcc -g -Og inspercoin.c lib/key/key.c lib/coin/coin.c -o ic -lsodium -lcurl -ljansson -Wno-discarded-qualifiers

#include <sodium.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>  //open
#include <jansson.h>
#include <curl/curl.h>
#include "lib/key/key.h"
#include "lib/coin/coin.h"
#include <sys/types.h>
#include <sys/wait.h>

char *get_url(void)
{
    int file = open("config.ic", O_RDONLY);

    int i = 0;
    int bytes;
    char each_char;
    char label_found = 0;
    char write_value = 0;
    char *url = malloc(100 * sizeof(char));
    while (1) {
        bytes = read(file, &each_char, 1);
        if (bytes == 0 || bytes == -1) {
            break;
        }
        if (each_char == 'I') {
            label_found = 1;
            continue;
        }
        if (label_found) {
            if (write_value) {
                if (each_char == '\n') {
                    write_value = 0;
                    label_found = 0;
                    continue;
                }
                url[i] = each_char;
                i++;
            }
            if (each_char == '=') {
                write_value = 1;
                continue;
            }
        }
    }
    url[i++] = '\0';
    realloc(url, strlen(url) + 1);
    close(file);
    return url;
}

char *get_default_wallet(void)
{
    int file = open("config.ic", O_RDONLY);

    int i = 0;
    int bytes;
    char each_char;
    char label_found = 0;
    char write_value = 0;
    char *default_wallet = malloc(100 * sizeof(char));
    while (1) {
        bytes = read(file, &each_char, 1);
        if (bytes == 0 || bytes == -1) {
            break;
        }
        if (each_char == 'D') {
            label_found = 1;
            continue;
        }
        if (label_found) {
            if (write_value) {
                if (each_char == '\n') {
                    write_value = 0;
                    label_found = 0;
                    continue;
                }
                default_wallet[i] = each_char;
                i++;
            }
            if (each_char == '=') {
                write_value = 1;
                continue;
            }
        }
    }
    default_wallet[i++] = '\0';
    realloc(default_wallet, strlen(default_wallet) + 1);
    close(file);
    return default_wallet;
}

int main(int argc, char *argv[])
{
    init_keyring_env();

    char *url = get_url();
    char *default_wallet = get_default_wallet();
    printf("url: %s\n", url);
    printf("default_wallet: %s\n", default_wallet);

    if (argc == 4 &&
        strcmp(argv[1], "criar") == 0 &&
        strcmp(argv[2], "carteira") == 0)
    {
        create_wallet(argv[3]);
        return 0;
    }
    else if (argc == 12 &&
             strcmp(argv[1], "enviar") == 0 &&
             strcmp(argv[3], "da") == 0 &&
             strcmp(argv[4], "carteira") == 0 &&
             strcmp(argv[6], "para") == 0 &&
             strcmp(argv[7], "endereco") == 0 &&
             strcmp(argv[9], "com") == 0 &&
             strcmp(argv[10], "recompensa") == 0)
    {
        // ENVIAR GRANA
        // ./inspercoin enviar 0.01 da carteira rico para endereco 4B904AEACACD702908BF822AB1A0FBF0A571C3B2E38C22DD5D67DBC15993D1A7 com recompensa 0.001
        send_money(argv[2], argv[5], (unsigned char *)argv[8], argv[11], url);
    }
    else if (argc == 9 &&
             strcmp(argv[1], "enviar") == 0 &&
             strcmp(argv[3], "para") == 0 &&
             strcmp(argv[4], "endereco") == 0 &&
             strcmp(argv[6], "com") == 0 &&
             strcmp(argv[7], "recompensa") == 0)
    {
        // ENVIAR GRANA de default wallet
        // ./inspercoin enviar <valor> para endereco <chave_publica_destino> com recompensa <valor_recompensa>
        // ./0          1      2       3    4        5                       6   7          8
        printf("default_wallet: %s\n", default_wallet);
        send_money(argv[2], default_wallet, (unsigned char *)argv[5], argv[8], url);
    }
    else if (argc == 3 &&
             strcmp(argv[1], "minerar") == 0 &&
             strcmp(argv[2], "transacao") == 0)
    {
        // ./inspercoin minerar transacao
        mine_transaction(url, default_wallet);
    }
    else if (argc == 6 &&
             strcmp(argv[1], "minerar") == 0 &&
             strcmp(argv[2], "transacao") == 0 &&
             strcmp(argv[3], "na") == 0 &&
             strcmp(argv[4], "carteira") == 0)
    {
        // ./inspercoin minerar transacao na carteira <carteira>
        mine_transaction(url, argv[5]);
    }
    else if (argc == 4 &&
             strcmp(argv[1], "minerar") == 0 &&
             strcmp(argv[3], "transacoes") == 0)
    {
        // ./inspercoin minerar <qtde> transacoes
        //   0          1      2      3
        int qtde = atoi(argv[2]);
        for (int i = 0; i < qtde; i++) 
        {
            pid_t pid = fork();
            if (pid == 0)
            {
                mine_transaction(url, default_wallet);
                return 0;
            }
        }
        int status;
        for (int i = 0; i < qtde; i++) 
        {
            waitpid(-1, &status, 0);
        }
    }
    else if (argc == 8 &&
             strcmp(argv[1], "verificar") == 0)
    { // VERIFICAR SE TRANSACAO É VÁLIDA
        // ./inspercoin verificar 20230427003846 E9AE8BF0871DB8F50E58DEF4C2D230B31B72155D97978A486FC6469053BAD23A E9AE8BF0871DB8F50E58DEF4C2D230B31B72155D97978A486FC6469053BAD23A 99999.00000 00000.00000 B28D62649379673982702C10EB1C1735C28FEBF9B871DE9FBB4EBD05CB47A17C5AF521355FB4FCCDE77BE6E289EF8CDBAF483037A86CEB4C8268397BDA07110B
        // ./inspercoin verificar <data> <origem> <destino> <valor> <recompensa> <assinatura>
        return validate_transaction(argv[2],
                                    argv[5],
                                    (unsigned char *)argv[3],
                                    (unsigned char *)argv[4],
                                    argv[6],
                                    (unsigned char *)argv[7]);
    }
    else if (argc == 11 &&
             strcmp(argv[1], "verificar") == 0) // corrigir para validar hash
    {
        // verificar se bloco é válido
        // ./inspercoin verificar 20230427003846 E9AE8BF0871DB8F50E58DEF4C2D230B31B72155D97978A486FC6469053BAD23A E9AE8BF0871DB8F50E58DEF4C2D230B31B72155D97978A486FC6469053BAD23A 99999.00000 00000.00000 B28D62649379673982702C10EB1C1735C28FEBF9B871DE9FBB4EBD05CB47A17C5AF521355FB4FCCDE77BE6E289EF8CDBAF483037A86CEB4C8268397BDA07110B  00000000000000149984 00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 00000E1DA0299B730000000000000000000000000000000000000000000000000000000000000000910000000000000030303030304531444130323939423733
        // ./inspercoin verificar <data> <origem> <destino> <valor> <recompensa> <assinatura_transacao> <nonce> <previous_hash> <hash_block>
        return validate_block(argv[2],
                              argv[5],
                              (unsigned char *)argv[3],
                              (unsigned char *)argv[4],
                              argv[6],
                              (unsigned char *)argv[7],
                              argv[8],
                              (unsigned char *)argv[9],
                              (unsigned char *)argv[10]);
    }
    else
    {
        // Precisa corrigir e melhorar isto!
        printf("USAGE:\n");
        printf("./inspercoin criar carteira <name_carteira>\n");
        printf("./inspercoin enviar <valor> da carteira <carteira> para endereco <endereco>\n");
        printf("./inspercoin enviar <valor> para endereco <endereco>\n");
        printf("./inspercoin minerar transacao\n");
        printf("./inspercoin minerar transacao na carteira <carteira>\n");
        printf("./inspercoin minerar <qtde> transacoes\n");
        printf("./inspercoin minerar <qtde_t> transacoes em <qtde_t> processos\n");
    }

    free(url);
    free(default_wallet);
    return 0;
}