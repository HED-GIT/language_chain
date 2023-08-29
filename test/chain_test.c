#ifndef CHAIN_FUNCTION
#error CHAIN_FUNCTION not defined
#endif
#ifndef CHAIN_LIB
#error CHAIN_LIB not defined
#endif

#include CHAIN_LIB
#include <HsFFI.h>

int main(int argc, char** argv){
    hs_init(&argc, &argv);

    CHAIN_FUNCTION();

    hs_exit();

    return 0;
}