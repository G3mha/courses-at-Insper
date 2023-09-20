#ifndef __INSPERCOIN_KEY_H__
#define __INSPERCOIN_KEY_H__

struct s_key;
typedef struct s_key t_key;

#define PUBLIC_KEY_HEX_SIZE crypto_sign_PUBLICKEYBYTES * 2 + 1
#define PRIVATE_KEY_HEX_SIZE crypto_sign_SECRETKEYBYTES * 2 + 1

#define TYPE_PUBLIC_KEY (char)'P'
#define TYPE_PRIVATE_KEY (char)'S'

void init_keyring_env();
int create_keypair(t_key *public_key, t_key *private_key);
unsigned char *get_key(t_key *key);
unsigned char *key_to_hex(t_key *key);
unsigned char *signature_to_hex(unsigned char *signature);
t_key *hex_to_key(unsigned char *hex, char type);
void save_public_key(t_key *key, char *name);
void save_private_key(t_key *key, char *name);
t_key *load_public_key(char *name);
t_key *load_private_key(char *name);
void create_wallet(char *name);

#endif