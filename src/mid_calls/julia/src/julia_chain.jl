module julia_chain

export start_julia_chain

Base.@ccallable function start_julia_chain()::Cvoid
end
    @ccall "./build/libs/libada_call.so".call_ada("ada called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libc_call.so".call_c("c called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libcpp_call.so".call_cpp("cpp called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libcobol_call.so".call_cobol("cobol called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libcrystal_call.so".call_crystal("crystal called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libd_call.so".call_d("d called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libfortran_call.so".call_fortran("fortran called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libgo_call.so".call_go("go called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libhaskell_call.so".call_haskell("haskell called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libjava_call.so".call_java("java called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libjulia_call.so".call_julia("julia called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libkotlin_call.so".call_kotlin("kortlin called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libnim_call.so".call_nim("nim called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/liboc_call.so".call_oc("oc called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libodin_call.so".call_odin("odin called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libpascal_call.so".call_pascal("pascal called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/librust_call.so".call_rust("rust called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libswift_call.so".call_swift("swift called by julia"::Cstring)::Cvoid
    @ccall "./build/libs/libzig_call.so".call_zig("zig called by julia"::Cstring)::Cvoid
end