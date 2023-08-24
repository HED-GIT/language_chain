#include "ada_chain.h"
#include "java_chain.h"
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
    start_java_chain();
    fprintf(stdout, "------------------------------\n");
    start_zig_chain();

    hs_exit();
    return 0;
}