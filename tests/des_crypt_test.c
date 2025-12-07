#include <stdio.h>
#include <openssl/des.h>

int main() {
  char *pw;
  int i;
  printf("START\n");
  for(i=0;i<1000000;i++) {
    pw = DES_crypt("abcdef", "ab");
  }
  printf("DONE\n");
}

