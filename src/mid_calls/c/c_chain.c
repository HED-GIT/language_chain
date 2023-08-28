#include "c_chain.h"

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

void start_c_chain(){
    call_ada("ada called by c");
    call_c("c called by c");
    call_cpp("c++ called by c");
    call_cobol("cobol called by c");
    call_d("d called by c");
    call_fortran("fortran called by c");
    call_go("go called by c");
    call_haskell("haskell called by c");
    call_java("java called by c");
    call_kotlin("kotlin called by c");
    call_nim("nim called by c");
    call_oc("oc called by c");
    call_odin("odin called by c");
    call_pascal("pascal called by c");
    call_rust("rust called by c");
    call_swift("swift called by c");
    call_zig("zig called by c");
}