#ifndef CALL_FUNCTION
#error CALL_FUNCTION not defined
#endif
#ifndef CALL_LIB
#error CALL_LIB not defined
#endif

#include CALL_LIB
#include <HsFFI.h>

void init_julia(int argc, char *argv[]);
void shutdown_julia(int retcode);

void crystal_init(void);

int main(int argc, char** argv){
    hs_init(&argc, &argv);
    init_julia(argc, argv);
    crystal_init();

    CALL_FUNCTION("this is a test string");

    hs_exit();
    shutdown_julia(1);

    return 0;
}