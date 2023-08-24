#include "ada_chain.h"
#include "c_chain.h"
#include "cpp_chain.h"
#include "cobol_chain.h"
#include "d_chain.h"
#include "fortran_chain.h"
#include "go_chain.h"
//#include "haskell_chain.h"
#include "java_chain.h"
#include "nim_chain.h"
#include "oc_chain.h"
#include "odin_chain.h"
#include "pascal_chain.h"
//#include "rust_chain.h"
#include "swift_chain.h"
#include "zig_chain.h"
#include <stdio.h>

void start_rust_chain(void);
void start_haskell_chain(void);
void hs_init(int *argc, char **argv[]);
void hs_exit(void);

int main(int argc, char **argv)
{
    hs_init(&argc, &argv);

    start_ada_chain();
    fprintf(stdout, "------------------------------\n");
    start_c_chain();
    fprintf(stdout, "------------------------------\n");
    start_cpp_chain();
    fprintf(stdout, "------------------------------\n");
    start_cobol_chain();
    fprintf(stdout, "------------------------------\n");
    start_d_chain();
    fprintf(stdout, "------------------------------\n");
    start_fortran_chain();
    fprintf(stdout, "------------------------------\n");
    start_go_chain();
    fprintf(stdout, "------------------------------\n");
    start_haskell_chain();
    fprintf(stdout, "------------------------------\n");
    start_java_chain();
    fprintf(stdout, "------------------------------\n");
    start_nim_chain();
    fprintf(stdout, "------------------------------\n");
    start_oc_chain();
    fprintf(stdout, "------------------------------\n");
    start_odin_chain();
    fprintf(stdout, "------------------------------\n");
    start_pascal_chain();
    fprintf(stdout, "------------------------------\n");
    start_rust_chain();
    fprintf(stdout, "------------------------------\n");
    start_swift_chain();
    fprintf(stdout, "------------------------------\n");
    start_zig_chain();
    hs_exit();
    return 0;
}