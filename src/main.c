#include "c_chain.h"
#include "cpp_chain.h"
#include <stdio.h>

int main(int argc, char** argv){
    start_c_chain();
    fprintf(stdout, "------------------------------\n");
    start_cpp_chain();
    return 0;
}