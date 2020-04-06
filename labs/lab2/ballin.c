// Type your code here, or load an example.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc, char** argv) {

    if (argc <= 0) {
        return 1;
    }

    int big_number = 8000;
    for(int i = 0; i < 5; i++) {
        big_number -= i;
        if (big_number % 2) {
            big_number += 10;
        }
    }

    if (big_number == atoi(*(argv + 1))) {
        printf("Password phrase: %d\r\n", big_number);
    }

    return 0;
}

