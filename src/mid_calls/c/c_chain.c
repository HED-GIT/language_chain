#include "c_chain.h"

#include "c_call.h"
#include "cpp_call.h"
#include "rust_call.h"
#include "go_call.h"
#include "d_call.h"
#include "zig_call.h"
#include "nim_call.h"
#include "oc_call.h"
#include "swift_call.h"

void start_c_chain(){
    call_c("c called by c");
    call_cpp("c++ called by c");
    call_rust("rust called by c");
    call_go("go called by c");
    call_d("d called by c");
    call_zig("zig called by c");
    call_nim("nim called by c");
    call_oc("oc called by c");
    call_swift("swift called by c");
}