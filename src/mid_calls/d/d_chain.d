extern (C) void call_ada(const char* x);
extern (C) void call_c(const char* x);
extern (C) void call_cpp(const char* x);
extern (C) void call_cobol(const char* x);
extern (C) void call_d(const char* x);
extern (C) void call_fortran(const char* x);
extern (C) void call_go(const char* x);
extern (C) void call_haskell(const char* x);
extern (C) void call_java(const char* x);
extern (C) void call_kotlin(const char* x);
extern (C) void call_nim(const char* x);
extern (C) void call_oc(const char* x);
extern (C) void call_odin(const char* x);
extern (C) void call_pascal(const char* x);
extern (C) void call_rust(const char* x);
extern (C) void call_swift(const char* x);
extern (C) void call_zig(const char* x);

extern (C) void start_d_chain(){
    call_ada("ada called by d");
    call_c("c called by d");
    call_cpp("c++ called by d");
    call_cobol("cobol called by d");
    call_d("d called by d");
    call_fortran("fortran called by d");
    call_go("go called by d");
    call_haskell("haskell called by d");
    call_java("java called by d");
    call_kotlin("kotlin called by d");
    call_nim("nim called by d");
    call_oc("oc called by d");
    call_odin("oc called by d");
    call_pascal("pascal called by d");
    call_rust("rust called by d");
    call_swift("swift called by d");
    call_zig("zig called by d");
}