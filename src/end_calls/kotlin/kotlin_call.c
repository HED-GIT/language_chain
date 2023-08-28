#include "r_kotlin_call.h"

void call_kotlin(const char* t){
    r_kotlin_call_symbols()->kotlin.root.r_call_kotlin(t);
}