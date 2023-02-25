#include "c_chain.h"
#include "cpp_chain.h"
#include "d_chain.h"
#include "go_chain.h"
#include "nim_chain.h"
#include "oc_chain.h"
// #include "rust_chain.h"
#include "zig_chain.h"
#include "swift_chain.h"
#include "pascal_chain.h"
#include "ada_chain.h"
#include "fortran_chain.h"
#include <stdio.h>

void start_rust_chain(void);

int main(int argc, char **argv)
{
    start_c_chain();
    fprintf(stdout, "------------------------------\n");
    start_cpp_chain();
    fprintf(stdout, "------------------------------\n");
    start_d_chain();
    fprintf(stdout, "------------------------------\n");
    start_go_chain();
    fprintf(stdout, "------------------------------\n");
    start_nim_chain();
    fprintf(stdout, "------------------------------\n");
    start_oc_chain();
    fprintf(stdout, "------------------------------\n");
    start_rust_chain();
    fprintf(stdout, "------------------------------\n");
    start_zig_chain();
    fprintf(stdout, "------------------------------\n");
    start_swift_chain();
    fprintf(stdout, "------------------------------\n");
    start_pascal_chain();
    fprintf(stdout, "------------------------------\n");
    start_fortran_chain();
    fprintf(stdout, "------------------------------\n");
    _init();
    _ada_start_ada_chain();
    return 0;
}