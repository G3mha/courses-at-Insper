#include <jansson.h>
#include <sodium.h>
#include <curl/curl.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include "coin.h"
#include "../key/key.h"
#include "coin.h"
#include <unistd.h> //sleep
#include <fcntl.h>  //open

#define MESSAGE_LEN 165
#define MESSAGE_LEN_BLOCK 1000
#define JSON_TEXT_MAX 65535
#define COIN_ARGS_SIZE 2000
#define COIN_AMOUNT_SIZE 2500
#define TIME_STR_SIZE 22

struct response
{
    char *memory;
    size_t size;
};

char *timestring()
{
    time_t current_time;
    struct tm *utc_time;
    char *time_string = malloc(sizeof(char) * TIME_STR_SIZE);

    // Get current UTC time
    current_time = time(NULL);
    utc_time = gmtime(&current_time);

    // Format time as string
    strftime(time_string, 25, "%Y%m%d%H%M%S", utc_time);
    printf("UTC 0 time: %s\n", time_string);
    return time_string;
}

char *format_amount(double amount)
{
    char *str = malloc(COIN_AMOUNT_SIZE);
    sprintf(str, "%011.5f", amount);
    return str;
}

void broadcast_transaction(char *date_transaction,
                           unsigned char *address_from,
                           unsigned char *address_to,
                           char *amount,
                           char *reward,
                           unsigned char *signature,
                           char *url)
{
    printf("URL 1: [%s]\n", url);
    CURL *curl;
    CURLcode res;

    curl = curl_easy_init();
    if (curl)
    {
        char *args = malloc(COIN_ARGS_SIZE * sizeof(char));

        printf("\n\nSS: [%s]\n\n", signature);
        sprintf(args, 
                "%sbroadcast/transaction?date_transaction=%s&address_from=%s&address_to=%s&amount=%s&reward=%s&signature=%s",
                url,
                date_transaction,
                address_from,
                address_to,
                amount,
                reward,
                signature);
        printf("URL 2: [%s]\n", args);
        curl_easy_setopt(curl, CURLOPT_URL, args);
        curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, "POST");

        // Perform the request and capture the response
        res = curl_easy_perform(curl);
        if (res != CURLE_OK)
        {
            free(args);
            fprintf(stderr, "curl_easy_perform() failed: %s\n",
                    curl_easy_strerror(res));
        }

        // Clean up
        curl_easy_cleanup(curl);
        free(args);
    }
}

unsigned char *construct_message(char *time_str, char *amount, unsigned char *address_from, unsigned char *address_to, char *reward)
{
    char *message = malloc(MESSAGE_LEN * sizeof(char));
    message[0] = '\0';
    strcat(message, time_str);
    strcat(message, amount);
    strcat(message, (char *)address_from);
    strcat(message, (char *)address_to);
    strcat(message, reward);
    message[MESSAGE_LEN - 1] = '\0';
    return (unsigned char *)message;
}

void send_money(char *amount, char *wallet, unsigned char *address_to, char *reward, char *url)
{
    printf("Wallet: [%s]\n", wallet);
    double d_amount = atof(amount);
    char *f_amount = format_amount(d_amount);

    double d_reward = atof(reward);
    char *f_reward = format_amount(d_reward);

    t_key *private_key = load_private_key(wallet);
    t_key *public_key = load_public_key(wallet);

    unsigned char *ps_hex = key_to_hex(private_key);
    unsigned char *pb_hex = key_to_hex(private_key);
    printf("PRIVADA: [%s]\n", ps_hex);
    printf("PUBLICA: [%s]\n", pb_hex);

    unsigned char *address_from = key_to_hex(public_key);

    unsigned char signature[crypto_sign_BYTES];

    char *date_transaction = timestring();

    unsigned char *message = construct_message(date_transaction, f_amount, address_from, address_to, f_reward);

    printf("MESSAGE [%s]\n", message);

    if (crypto_sign_detached(signature, NULL, message, MESSAGE_LEN - 1, get_key(private_key)) < 0)
    {
        fprintf(stderr, "Error: message signing failed!\n");
        exit(EXIT_FAILURE);
    }

    if (crypto_sign_verify_detached(signature, message, MESSAGE_LEN - 1, get_key(public_key)) != 0)
    {
        fprintf(stderr, "Error: ------> signature verification failed!\n");
        exit(EXIT_FAILURE);
    }

    unsigned char *sig_hex = signature_to_hex(signature);
    printf("SIG: [%s]\n------------------------------------------\n", sig_hex);
    printf("URL 3: [%s]\n", url);

    broadcast_transaction(date_transaction,
                          address_from,
                          (unsigned char *)address_to,
                          f_amount,
                          f_reward,
                          sig_hex,
                          url);
    free(f_amount);
    free(f_reward);
    free(address_from);
    free(message);
    free(date_transaction);
    free(sig_hex);
    free(ps_hex);
    free(pb_hex);
    free(private_key);
    free(public_key);
}

json_t *parse_transaction(char *json_text, size_t *n_transaction)
{
    json_t *root = json_loads(json_text, 0, NULL);
    if (!root)
    {
        fprintf(stderr, "error: on line %d: %s\n", __LINE__, "Failed to parse JSON");
        exit(EXIT_FAILURE);
    }

    *n_transaction = json_array_size(root);
    return root;
}

void get_transaction_info(json_t *json_array,
                          size_t i,
                          long *id_transaction,
                          char **date_transaction,
                          unsigned char **address_from,
                          unsigned char **address_to,
                          char **amount,
                          char **reward,
                          unsigned char **signature)
{
    json_t *transaction = json_array_get(json_array, i);
    *date_transaction = json_string_value(json_object_get(transaction, "date_transaction"));
    *address_from = json_string_value(json_object_get(transaction, "address_from"));
    *address_to = json_string_value(json_object_get(transaction, "address_to"));
    *amount = json_string_value(json_object_get(transaction, "amount"));
    *reward = json_string_value(json_object_get(transaction, "reward"));
    *signature = json_string_value(json_object_get(transaction, "signature"));
    *id_transaction = json_integer_value(json_object_get(transaction, "id_transaction"));

    printf("Transaction %zu:\n", i + 1);
    printf("\tFrom: %s\n", *address_from);
    printf("\tTo: %s\n", *address_to);
    printf("\tAmount: %s\n", *amount);
    printf("\tReward: %s\n", *reward);

    // json_decref(root);
}

// https://everything.curl.dev/libcurl/callbacks/write
static size_t
write_callback(void *contents, size_t size, size_t nmemb, void *userp)
{
    size_t realsize = size * nmemb;
    struct response *mem = (struct response *)userp;

    char *ptr = realloc(mem->memory, mem->size + realsize + 1);
    if (!ptr)
    {
        /* out of memory! */
        printf("not enough memory (realloc returned NULL)\n");
        exit(EXIT_FAILURE);
    }

    mem->memory = ptr;
    memcpy(&(mem->memory[mem->size]), contents, realsize);
    mem->size += realsize;
    mem->memory[mem->size] = 0;

    return realsize;
}

char *get_transaction(char *url)
{
    printf("URL 4: [%s]\n", url);

    CURL *curl;
    CURLcode res;
    struct response chunk = {.memory = malloc(0),
                             .size = 0};

    curl = curl_easy_init();

    if (curl)
    {
        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)&chunk);

        res = curl_easy_perform(curl);

        if (res != CURLE_OK)
        {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
            exit(EXIT_FAILURE);
        }

        curl_easy_cleanup(curl);
    }

    return chunk.memory;
}

unsigned char *get_last_block_hash(char *url_raw)
{
    CURL *curl;
    CURLcode res;
    struct response chunk = {.memory = malloc(0),
                             .size = 0};
    char *url_final = malloc(COIN_ARGS_SIZE * sizeof(char));
    sprintf(url_final, "%sblockchain/1", url_raw);
    
    curl = curl_easy_init();
    if (curl){
        curl_easy_setopt(curl, CURLOPT_URL, url_final);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)&chunk);

        res = curl_easy_perform(curl);

        if (res != CURLE_OK)
        {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
            exit(EXIT_FAILURE);
        }

        curl_easy_cleanup(curl);
    }
    json_error_t error;
    json_t *root = json_loads(chunk.memory, 0, &error);
    json_t *block = json_array_get(root, 0);
    json_t *hash = json_object_get(block, "hash");
    char *hash_string = (char *) malloc(strlen(json_string_value(hash)));
    strcpy(hash_string, json_string_value(hash));
    json_decref(hash);
    json_decref(block);
    json_decref(root);
    free(url_final);
    return (unsigned char *) hash_string;
}


unsigned char *construct_block_message(char *str_nouce, unsigned char *previous_hash, char *time_str, char *amount, unsigned char *address_from, unsigned char *address_to, char *reward)
{
    char *message = malloc(MESSAGE_LEN_BLOCK * sizeof(char));
    message[0] = '\0';
    strcat(message, (char *)str_nouce);
    strcat(message, (char *)previous_hash);
    strcat(message, time_str);
    strcat(message, amount);
    strcat(message, (char *)address_from);
    strcat(message, (char *)address_to);
    strcat(message, reward);
    message[strlen(message)] = '\0';
    return (unsigned char *)message;
}

unsigned char *get_block_hash(long nonce, unsigned char *previous_hash, char *time_str, char *amount, unsigned char *address_from, unsigned char *address_to, char *reward)
{
    char *str_nouce = malloc(30);
    // printf("%ld\n", nonce); // Faz print do nonce
    sprintf(str_nouce, "%020ld", nonce);
    unsigned char *message = construct_block_message(str_nouce, previous_hash, time_str, amount, address_from, address_to, reward);
    unsigned char *hash = malloc(crypto_sign_BYTES);
    crypto_generichash(hash, crypto_sign_BYTES, (const unsigned char *)message, strlen((char *)message), NULL, 0);
    unsigned char *hex_hash = signature_to_hex(hash);
    free(message);
    free(hash);
    free(str_nouce);
    return hex_hash;
}

void mine_transaction(char *url_raw, char *wallet)
{
    char *url2 = malloc(COIN_ARGS_SIZE * sizeof(char));
    sprintf(url2, "%stransactions", url_raw);
    char *json_text = get_transaction(url2);
    // printf("\njson_text: %s\n\n", json_text); // Json text, descomente se quiser ver

    size_t n_transactions;
    json_t *json_array = parse_transaction(json_text, &n_transactions);
    // printf("NT %d\n", n_transactions); // qtde transações retornadas, descomente se quiser ver

    long id_transaction;
    char *date_transaction;
    t_key *public_key = load_public_key(wallet);
    unsigned char *miner_address = key_to_hex(public_key);
    unsigned char *address_from;
    unsigned char *address_to;
    char *amount;

    char *reward;
    unsigned char *signature;
    char flag_valid = 0;
    for (int i = 0; i < n_transactions; i++)
    {
        get_transaction_info(json_array,
                             i,
                             &id_transaction,
                             &date_transaction,
                             &address_from,
                             &address_to,
                             &amount,
                             &reward,
                             &signature);
        // faz get do balance da address_from
        sprintf(url2, "%sbalance/%s", url_raw, address_from);
        printf("URL: %s\n", url2);
        char *json_text = get_transaction(url2);
        json_t *root = json_loads(json_text, 0, NULL);
        json_t *balance_json = json_array_get(root, 0);
        double balance = atof(json_string_value(json_object_get(balance_json, "balance")));
        double amount_double = atof(amount);
        double reward_double = atof(reward);
        if (balance >= (amount_double + reward_double))
        {
            printf("Balance suficiente!\n");
            flag_valid = 1;
            break;
        }
        printf("Balance insuficiente!\n");
    }
    if (!flag_valid)
    {
        free(date_transaction);
        free(address_from);
        free(address_to);
        free(amount);
        free(reward);
        free(signature);
        printf("Não tem transação válida!\n");
        return;
    }
    printf("Tem transação válida!\n");
    long nonce = 0;
    unsigned char *hash;
    int diffic = 5; // Você vai precisar alterar aqui para pegar a dificuldade pela API!
    int go_on = 1;
    unsigned char *previous_hash = get_last_block_hash(url_raw);
    while (go_on)
    {
        hash = get_block_hash(nonce, previous_hash, date_transaction, amount, address_from, address_to, reward);

        go_on = 0;
        for (int i = 0; i < diffic; i++) // diffic primeiros elementos precisam ser '0'
        {
            if (hash[i] != '0')
            {
                go_on = 1;
                free(hash);
                break;
            }
        }
        nonce += 1;
    }
    nonce -= 1;

    printf("Minerou %ld\n%s\n", nonce, hash);

    printf("address_fromXXXXXXXXX: %s\n", address_from);
    broadcast_block(hash,
                    previous_hash,
                    miner_address,
                    id_transaction,
                    nonce,
                    url_raw);

    free(json_text);
    free(json_array);
    // free(previous_hash);
    free(amount);
    free(date_transaction);
    free(address_from);
    free(address_to);
    free(public_key);
}

void broadcast_block(
    unsigned char *hash,
    unsigned char *previous_hash,
    unsigned char *miner_address,
    long id_transaction,
    long nonce,
    char *url_raw)
{
    CURL *curl;
    CURLcode res;

    printf("URL: %s\n", url_raw);

    char *str_nouce = malloc(30);
    sprintf(str_nouce, "%020ld", nonce);

    curl = curl_easy_init();
    if (curl)
    {
        char *args = malloc(COIN_ARGS_SIZE * sizeof(char));
        printf("ID [%ld]\n", id_transaction);

        // Vai precisar alterar esta URL!
        sprintf(args, "%sbroadcast/block?hash_=%s&previous_hash=%s&miner_address=%s&id_transaction=%ld&nonce=%s",
                url_raw,
                hash,
                previous_hash,
                miner_address,
                id_transaction,
                str_nouce);

        printf("\n\nURL : [%s]\n\n", args);
        curl_easy_setopt(curl, CURLOPT_URL, args);
        curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, "POST");

        // Perform the request and capture the response
        res = curl_easy_perform(curl);

        if (res != CURLE_OK)
        {
            printf("4\n");
            fprintf(stderr, "curl_easy_perform() failed: %s\n",
                    curl_easy_strerror(res));
        }

        free(args);
        free(str_nouce);
        // Clean up
        curl_easy_cleanup(curl);
    }
    else
    {
        free(str_nouce);
    }
}

int validate_transaction(char *date_transaction,
                         char *amount,
                         unsigned char *address_from,
                         unsigned char *address_to,
                         char *reward,
                         unsigned char *signature)
{
    // Adaptação pq a assinatura tem o mesmo tamanho da chave primária
    t_key *sign = hex_to_key(signature, TYPE_PRIVATE_KEY);
    unsigned char *sig = get_key(sign);

    unsigned char *message = construct_message(date_transaction, amount, address_from, address_to, reward);

    t_key *pk = hex_to_key(address_from, TYPE_PUBLIC_KEY);

    if (crypto_sign_verify_detached(sig, message, MESSAGE_LEN - 1, get_key(pk)) != 0)
    {
        fprintf(stderr, "Error: signature verification failed!\n");
        free(sign);
        free(message);
        free(pk);
        return 0;
    }
    else
    {
        printf("Signature verified successfully!\n");
        free(sign);
        free(message);
        free(pk);
        return 1;
    }
}

int validate_block(char *date_transaction,
                   char *amount,
                   unsigned char *address_from,
                   unsigned char *address_to,
                   char *reward,
                   unsigned char *hash,
                   char *nonce,
                   unsigned char *previous_hash,
                   unsigned char *block_hash)
{
    if (!validate_transaction(date_transaction,
                              amount,
                              address_from,
                              address_to,
                              reward,
                              hash))
    {
        printf("Block verification failed. Validate transaction first.!\n");
        return 0;
    }

    unsigned char *ref_hash = get_block_hash(atol(nonce), previous_hash, date_transaction, amount, address_from, address_to, reward);

    for (int i = 0; i < PRIVATE_KEY_HEX_SIZE; i++)
    {
        if (block_hash[i] != ref_hash[i])
        {
            printf("Block verification failed!\n");
            return 0;
        }
    }

    printf("Block verified successfully!\n");
    return 1;
}