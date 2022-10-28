#include "cpp_chain.hpp"

#include "c_call.h"
#include "cpp_call.h"
#include "rust_call.hpp"
#include "go_call.h"
#include "d_call.h"
#include "zig_call.h"
#include "nim_call.h"
#include "oc_call.h"

extern "C" void call_nim(const char*); // todo manage to move this to autogen header

void start_cpp_chain(){
    call_c((const char*)"c called by c++");
    call_cpp("c++ called by c++");
    call_rust((const char*)"rust called by c++");
    call_go((char*)"go called by c++");
    call_d((const char*)"d called by c++");
    call_zig((const char*)"zig called by c++");
    call_nim((const char*)"nim called by c++");
    call_oc((const char*)"oc called by c++");
}