import kotlinx.cinterop.*
import platform.posix.*
import ada_call.call_ada
import c_call.call_c
import cpp_call.call_cpp
import cobol_call.call_cobol
import d_call.call_d
import fortran_call.call_fortran
import go_call.call_go
import haskell_call.call_haskell
import java_call.call_java
import kotlin_call.call_kotlin
import nim_call.call_nim
import oc_call.call_oc
import odin_call.call_odin
import pascal_call.call_pascal
import rust_call.call_rust
import swift_call.call_swift
import zig_call.call_zig

fun r_start_kotlin_chain(){
    call_ada("ada called by kotlin")
    call_c("c called by kotlin")
    call_cpp("cpp called by kotlin")
    call_cobol("cobol called by kotlin")
    call_d("d called by kotlin")
    call_fortran("fortran called by kotlin")
    call_go("go called by kotlin".cstr) 
    memScoped {
        call_haskell("haskell called by kotlin".cstr.getPointer(this))
    }
    call_java("java called by kotlin")
    call_kotlin("kotlin called by kotlin")
    memScoped {
        call_nim("nim called by kotlin".cstr.getPointer(this))
    }
    call_oc("oc called by kotlin")
    call_odin("odin called by kotlin")
    call_pascal("pascal called by kotlin")
    call_rust("rust called by kotlin")
    call_swift("swift called by kotlin")
    call_zig("zig called by kotlin")
}