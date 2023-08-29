#ifndef CALL_FUNCTION
#error CALL_FUNCTION not defined
#endif
#ifndef CALL_LIB
#error CALL_LIB not defined
#endif

#include CALL_LIB
#include <HsFFI.h>

int main(int argc, char** argv){
    hs_init(&argc, &argv);

    CALL_FUNCTION("this is a test string");

    hs_exit();

    return 0;
}