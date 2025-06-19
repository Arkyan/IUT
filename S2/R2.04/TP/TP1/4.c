//
// Created by didry on 04/02/2025.
//

#include <stdio.h>
int main(void) {
    char str[81] = "ABCDEF";
    char *p;

    p = str;
    *p = 'X';
    p++;
    *p = 'Y';
    *(p+2) = 'Z';

    printf("%s\n", str);
    printf("%s\n", &str[1]);

    printf("%s\n", p);
    printf("%s\n", p+1);
    printf("%s\n", p-1);
    printf("%d\n", p-str);

    return 0;
}

// L'affichage est :
// XYCZEF
// YCZEF
// YCZEF
// CZEF
// XYCZEF
// 1