#ifndef CHAIN_FUNCTION
#error CHAIN_FUNCTION not defined
#endif
#ifndef CHAIN_LIB
#error CHAIN_LIB not defined
#endif

#include CHAIN_LIB
#include <HsFFI.h>

void crystal_init(void);

int main(int argc, char** argv){
    hs_init(&argc, &argv);
    crystal_init();

    CHAIN_FUNCTION();

    hs_exit();

    return 0;
}