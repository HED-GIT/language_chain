extern (C) void call_c(const char* x);
extern (C) void call_d(const char* x);
extern (C) void call_cpp(const char* x);
extern (C) void call_go(const char* x);
extern (C) void call_nim(const char* x);
extern (C) void call_oc(const char* x);
extern (C) void call_rust(const char* x);
extern (C) void call_zig(const char* x);

extern (C) void start_d_chain(){
    call_c("c called by d");
    call_cpp("c++ called by d");
    call_rust("rust called by d");
    call_go("go called by d");
    call_d("d called by d");
    call_zig("zig called by d");
    call_nim("nim called by d");
    call_oc("oc called by d");
}