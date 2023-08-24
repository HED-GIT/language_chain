#include "r_java_call.h"
#include <stddef.h>

void call_java(char* text){
    graal_isolatethread_t *isolate_thread = NULL;
    graal_create_isolate(NULL, NULL, &isolate_thread);

    r_call_java(isolate_thread,text);

    graal_tear_down_isolate(isolate_thread);
}