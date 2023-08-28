#pragma once

#ifdef __cplusplus
    #define EXTERNC extern "C"
#else
    #define EXTERNC
#endif

EXTERNC void call_zig(const char* c);

#undef EXTERNC