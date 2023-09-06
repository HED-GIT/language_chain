#ifndef CHAIN_FUNCTION
#error CHAIN_FUNCTION not defined
#endif
#ifndef CHAIN_LIB
#error CHAIN_LIB not defined
#endif

#include CHAIN_LIB
#include <HsFFI.h>

void crystal_init(void);
void init_julia(int argc, char *argv[]);
void shutdown_julia(int retcode);

int main(int argc, char** argv){
    hs_init(&argc, &argv);
    init_julia(argc, argv);
    crystal_init();

    CHAIN_FUNCTION();

    hs_exit();
    shutdown_julia(1);

    return 0;
}