#include "ada_call.h"
#include "c_call.h"
#include "cpp_call.h"
#include "cobol_call.h"
#include "d_call.h"
#include "fortran_call.h"
#include "go_call.h"
#include "haskell_call.h"
#include "java_call.h"
#include "kotlin_call.h"
#include "nim_call.h"
#include "oc_call.h"
#include "odin_call.h"
#include "pascal_call.h"
#include "rust_call.h"
#include "swift_call.h"
#include "zig_call.h"

void start_oc_chain(){
    call_ada("ada called by oc");
    call_c("c called by oc");
    call_cpp("c++ called by oc");
    call_cobol("cobol called by oc");
    call_d("d called by oc");
    call_fortran("fortran called by oc");
    call_go("go called by oc");
    call_haskell("haskell called by oc");
    call_java("java called by oc");
    call_kotlin("kotlin called by oc");
    call_nim("nim called by oc");
    call_oc("oc called by oc");
    call_odin("odin called by oc");
    call_pascal("pascal called by oc");
    call_rust("rust called by oc");
    call_swift("swift called by oc");
    call_zig("zig called by oc");
}