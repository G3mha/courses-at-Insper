#include <sodium.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdlib.h>
#include "key.h"

#define NAME_EXTRA 20
#define PUBLIC_EXTENSION ".public"
#define PRIVATE_EXTENSION ".private"

typedef struct s_key
{
    unsigned char bytes_key[crypto_sign_SECRETKEYBYTES];
    char type;
} t_key;

t_key *alloc_key()
{
    t_key *key = malloc(sizeof(t_key));
    for (int i = 0; i < crypto_sign_SECRETKEYBYTES; i++)
    {
        key->bytes_key[i] = 0;
    }
    return key;
}
void init_keyring_env()
{
    if (sodium_init() < 0)
    {
        fprintf(stderr, "Error: libsodium initialization failed!\n");
        exit(EXIT_FAILURE);
    }
}

void set_type(t_key *key, char type)
{
    if (type != TYPE_PUBLIC_KEY && type != TYPE_PRIVATE_KEY)
    {
        fprintf(stderr, "Error: invalid %c type!\n", type);
        exit(EXIT_FAILURE);
    }
    key->type = type;
}

int create_keypair(t_key *public_key, t_key *private_key)
{
    int res = crypto_sign_keypair(get_key(public_key), get_key(private_key));
    if (res < 0)
    {
        fprintf(stderr, "Error: key pair generation failed!\n");
        exit(EXIT_FAILURE);
    }
    set_type(public_key, TYPE_PUBLIC_KEY);
    set_type(private_key, TYPE_PRIVATE_KEY);
    return res;
}

unsigned char *get_key(t_key *key)
{
    return key->bytes_key;
}

int get_key_size(t_key *key)
{
    if (key->type == TYPE_PUBLIC_KEY)
    {
        return crypto_sign_PUBLICKEYBYTES;
    }
    else
    {
        return crypto_sign_SECRETKEYBYTES;
    }
}

int get_hex_size(t_key *key)
{
    if (key->type == TYPE_PUBLIC_KEY)
    {
        return PUBLIC_KEY_HEX_SIZE;
    }
    else
    {
        return PRIVATE_KEY_HEX_SIZE;
    }
}

unsigned char *bytes_to_hex(unsigned char *bytes, int n)
{
    unsigned char *hex = malloc(n * 2 + 1);
    for (size_t i = 0; i < n; i++)
    {
        sprintf((char *)&hex[2 * i], "%02X", bytes[i]);
    }

    hex[n * 2] = '\0';
    return hex;
}

unsigned char *key_to_hex(t_key *key)
{
    // int key_hex_size = get_hex_size(key);
    unsigned char *bytes_key = get_key(key);

    int n = get_key_size(key);
    return bytes_to_hex(bytes_key, n);
}

int get_signature_size()
{
    return crypto_sign_BYTES;
}

unsigned char *signature_to_hex(unsigned char *signature)
{
    int n = get_signature_size();
    return bytes_to_hex(signature, n);
}

t_key *hex_to_key(unsigned char *hex, char type)
{
    t_key *key = alloc_key();
    if (type == TYPE_PRIVATE_KEY)
    {
        set_type(key, TYPE_PRIVATE_KEY);
    }
    else if (type == TYPE_PUBLIC_KEY)
    {
        set_type(key, TYPE_PUBLIC_KEY);
    }
    else
    {
        fprintf(stderr, "Error: invalid %c type!\n", type);
        exit(EXIT_FAILURE);
    }

    for (size_t i = 0; i < get_key_size(key); i++)
    {
        sscanf((char *)&hex[2 * i], "%2hhx", &key->bytes_key[i]);
    }

    return key;
}

char *get_correct_name(char *name, char type)
{
    char *new_name = malloc(sizeof(char) * strlen(name) + NAME_EXTRA);
    new_name = strcpy(new_name, name);
    if (type == TYPE_PUBLIC_KEY) // public key
    {
        new_name = strcat(new_name, PUBLIC_EXTENSION);
    }
    else // sign key (private)
    {
        new_name = strcat(new_name, PRIVATE_EXTENSION);
    }
    return new_name;
}
void save_key(t_key *key, char *name, char type)
{
    char *new_name = get_correct_name(name, type);
    int key_hex_size = get_hex_size(key);
    unsigned char *hex = key_to_hex(key);
    int dest = open(new_name, O_WRONLY | O_CREAT, 0700);
    int qtde = write(dest, hex, key_hex_size - 1);
    if (qtde != key_hex_size - 1)
    {
        fprintf(stderr, "Error: save key write error!\n");
        exit(EXIT_FAILURE);
    }
    char buf = '\n';
    qtde = write(dest, &buf, 1);
    if (qtde != 1)
    {
        fprintf(stderr, "Error: save key \\n write error!\n");
        exit(EXIT_FAILURE);
    }

    close(dest);
    free(new_name);
    free(hex);
}

void save_public_key(t_key *key, char *name)
{
    save_key(key, name, TYPE_PUBLIC_KEY); // public key
}

void save_private_key(t_key *key, char *name)
{
    save_key(key, name, TYPE_PRIVATE_KEY); // sign key (private)
}

t_key *load_key(char *name, char type)
{
    char *new_name = get_correct_name(name, type);
    int key_hex_size = 0;
    if (type == TYPE_PUBLIC_KEY) // public key
    {
        key_hex_size = crypto_sign_PUBLICKEYBYTES * 2 + 1;
    }
    else // sign key (private)
    {
        key_hex_size = crypto_sign_SECRETKEYBYTES * 2 + 1;
    }
    unsigned char *hex = malloc(key_hex_size);
    int source = open(new_name, O_RDONLY);
    int bytes_read = read(source, hex, key_hex_size - 1);

    if (bytes_read != key_hex_size - 1)
    {
        fprintf(stderr, "ERROR: read fewer bytes than necessary in %s!\n", new_name);
        exit(EXIT_FAILURE);
    }
    t_key *key = hex_to_key(hex, type);
    close(source);
    free(new_name);
    free(hex);

    return key;
}

t_key *load_public_key(char *name)
{
    return load_key(name, TYPE_PUBLIC_KEY); // public key
}

t_key *load_private_key(char *name)
{
    return load_key(name, TYPE_PRIVATE_KEY); // sign key (private)
}

void create_wallet(char *name)
/*
 * Generate random public and private keys and saves then
 * into two files: <name>.public and <name>.rivate
 */
{
    t_key *public_key = alloc_key();
    t_key *private_key = alloc_key();

    // Generate a key pair
    create_keypair(public_key, private_key);

    unsigned char *pk_hex = key_to_hex(public_key);
    unsigned char *ps_hex = key_to_hex(private_key);

    printf("PUBLIC KEY..: %s\n", pk_hex);
    printf("SIGN KEY.....: %s\n", ps_hex);

    save_private_key(private_key, name);
    save_public_key(public_key, name);

    free(private_key);
    free(public_key);
    free(pk_hex);
    free(ps_hex);

    return;
}