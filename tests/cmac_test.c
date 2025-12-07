#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <openssl/evp.h>
#include <openssl/pem.h>
#include <openssl/err.h>
#include <openssl/core_names.h>
#include <openssl/params.h>
#include <openssl/cmac.h>

static void hexdump(const char *label, const unsigned char *buf, size_t len) {
    printf("%s (%zu bytes): ", label, len);
    for (size_t i = 0; i < len; i++) printf("%02X", buf[i]);
    printf("\n");
}

char * getKey(int keySize)
{
    char* key = (char *)malloc(keySize * sizeof(char));
    
    for (int i = 0; i < keySize; i++)
    {
        key[i] = (char)rand();
    }
    return(key);

}


static void do_cmac(const EVP_CIPHER *cipher,
                    const unsigned char *key, size_t keylen,
                    const unsigned char *msg, size_t msglen,
                    unsigned char *tag, size_t *taglen /* in: requested, out: produced */) {

    size_t block = (size_t)EVP_CIPHER_block_size(cipher);

    if (*taglen == 0 || *taglen > block) {
        *taglen = block; // default to full block if invalid/zero
    }

    CMAC_CTX *ctx = CMAC_CTX_new();


    CMAC_Init(ctx, key, keylen, cipher, NULL);

	CMAC_Update(ctx, msg, msglen);


    unsigned char fulltag[EVP_MAX_BLOCK_LENGTH];
    size_t full_len = 0;
    CMAC_Final(ctx, fulltag, &full_len);

    CMAC_CTX_free(ctx);

    memcpy(tag, fulltag, *taglen);
}


int main(int argc, char** argv) {


    const char *msg = "hello";
    const char *name = "aes-128";
    const char *key_hex = NULL;
    const char *msg_text = NULL;
    const char *msg_hex = NULL;
    const char *file_path = NULL;
    const char *verify_hex = NULL;
    long taglen_opt = -1;
    int keysize=16;

    srand(time(NULL));


    if (argc > 1) msg =  argv[1];
    if (argc > 1) name =  argv[2];


const EVP_CIPHER *cipher=EVP_aes_128_cbc();
if (strcmp(name, "aes-128-cbc") == 0) { keysize=16; cipher= EVP_aes_128_cbc();}
if (strcmp(name, "aes-128-ecb") == 0) { keysize=16;cipher=  EVP_aes_128_ecb();}

if (strcmp(name, "camellia-128-cbc") == 0) { keysize=16;cipher=  EVP_camellia_128_cbc();}
if (strcmp(name, "camellia-128-ecb") == 0) { keysize=16;cipher=  EVP_camellia_128_ecb();}
if (strcmp(name, "aria-128-cbc") == 0) { keysize=16;cipher=  EVP_aria_128_cbc();}
if (strcmp(name, "aria-128-ecb") == 0) { keysize=16;cipher=  EVP_aria_128_ecb();}


if (strcmp(name, "aes-192-cbc") == 0) { keysize=24; cipher= EVP_aes_192_cbc();}
if (strcmp(name, "aes-192-ecb") == 0) { keysize=24;cipher=  EVP_aes_192_ecb();}
if (strcmp(name, "camellia-192-cbc") == 0) { keysize=24;cipher=  EVP_camellia_192_cbc();}
if (strcmp(name, "camellia-192-ecb") == 0) { keysize=24;cipher=  EVP_camellia_192_ecb();}
if (strcmp(name, "aria-192-cbc") == 0) { keysize=24;cipher=  EVP_aria_192_cbc();}
if (strcmp(name, "aria-192-ecb") == 0) { keysize=24;cipher=  EVP_aria_192_ecb();}
if (strcmp(name, "aes-256-cbc") == 0) { keysize=32; cipher= EVP_aes_256_cbc();}
if (strcmp(name, "aes-256-ecb") == 0) { keysize=32;cipher=  EVP_aes_256_ecb();}
if (strcmp(name, "camellia-256-cbc") == 0) { keysize=32;cipher=  EVP_camellia_256_cbc();}
if (strcmp(name, "camellia-256-ecb") == 0) { keysize=32;cipher=  EVP_camellia_256_ecb();}
if (strcmp(name, "aria-256-cbc") == 0) { keysize=32;cipher=  EVP_aria_256_cbc();}
if (strcmp(name, "aria-256-ecb") == 0) { keysize=32;cipher=  EVP_aria_256_ecb();}
if (strcmp(name, "sm4-cbc") == 0) { keysize=32;cipher=  EVP_sm4_cbc();}
if (strcmp(name, "sm4-ecb") == 0) { keysize=32;cipher=  EVP_sm4_ecb();}


size_t block = (size_t)EVP_CIPHER_block_size(cipher);
size_t taglen=block;
printf("Block size %ld\n",(long)block);

    unsigned char *key = getKey(keysize);

  unsigned char *tag = (unsigned char*)malloc(taglen);



    do_cmac(cipher, key, keysize, msg, strlen(msg), tag, &taglen);

    printf("Message: %s\n",msg);
    printf("Cipher: %s\n",name);

    hexdump("\nKey: ",key,keysize);

    hexdump("\nTag: ",tag,taglen);



    return EXIT_SUCCESS;
}
