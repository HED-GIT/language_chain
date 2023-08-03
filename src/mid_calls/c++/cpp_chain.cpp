#include "cpp_chain.hpp"

#include "ada_call.h"
#include "c_call.h"
#include "cpp_call.h"
#include "cobol_call.h"
#include "d_call.h"
#include "fortran_call.h"
#include "go_call.h"
extern "C"{
#include "nim_call.h"
}
#include "oc_call.h"
#include "odin_call.h"
#include "pascal_call.h"
#include "rust_call.hpp"
#include "swift_call.h"
#include "zig_call.h"

void start_cpp_chain(){
    call_ada((char*)"ada called by c++");
    call_c("c called by c++");
    call_cpp("c++ called by c++");
    call_cobol((char*)"cobol called by c++");
    call_d("d called by c++");
    call_fortran((char*)"fortran called by c++");
    call_go((char*)"go called by c++");
    call_nim((char*)"nim called by c++");
    call_oc("oc called by c++");
    call_odin("odin called by c++");
    call_pascal("pascal called by c++");
    call_rust("rust called by c++");
    call_swift("swift called by c++");
    call_zig("zig called by c++");
}