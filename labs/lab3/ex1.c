#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char** argv) {
    int var_14 = 10;
    int var_10 = atoi(argv[1]);
    
    while (var_14 > 0) {
        var_10 += var_14;
        for (int i = 0; i <= 4; i++)
            var_10 -= i;
        var_14--;
    } 

    if (argc != 2 || var_10 != 522) {
        printf("Invalid Input");
        return 1;
    } else {
        printf("You go the correct key");
    }


    return 0;
}
