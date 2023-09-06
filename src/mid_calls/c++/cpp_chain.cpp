#include "cpp_chain.hpp"

#include "ada_call.h"
#include "c_call.h"
#include "cpp_call.h"
#include "cobol_call.h"
#include "crystal_call.h"
#include "d_call.h"
#include "fortran_call.h"
#include "go_call.h"
#include "haskell_call.h"
#include "java_call.h"
#include "julia_call.h"
#include "kotlin_call.h"
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
    call_ada("ada called by cpp");
    call_c("c called by cpp");
    call_cpp("cpp called by cpp");
    call_cobol("cobol called by cpp");
    call_crystal("crystal called by cpp");
    call_d("d called by cpp");
    call_fortran("fortran called by cpp");
    call_go((char*)"go called by cpp");
    call_haskell((char*)"haskell called by cpp");
    call_java("java called by cpp");
    call_julia("julia called by cpp");
    call_kotlin("kotlin called by cpp");
    call_nim((char*)"nim called by cpp");
    call_oc("oc called by cpp");
    call_odin("odin called by cpp");
    call_pascal("pascal called by cpp");
    call_rust("rust called by cpp");
    call_swift("swift called by cpp");
    call_zig("zig called by cpp");
}