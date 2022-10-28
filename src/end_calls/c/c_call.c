#include "c_call.h"

#include <stdio.h>

void call_c(const char* x){
    fprintf(stdout, "%s\n", x);
}