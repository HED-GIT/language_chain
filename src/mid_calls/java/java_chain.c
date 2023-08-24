#include "r_java_chain.h"
#include <stddef.h>

void start_java_chain(){
    graal_isolatethread_t *isolate_thread = NULL;
    graal_create_isolate(NULL, NULL, &isolate_thread);

    r_start_java_chain(isolate_thread);

    graal_tear_down_isolate(isolate_thread);
}