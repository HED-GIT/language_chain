#ifdef __cplusplus
    #define EXTERNC extern "C"
#else
    #define EXTERNC
#endif

EXTERNC void start_ada_chain();
EXTERNC void _init();

#undef EXTERNC