proc call_c(x: cstring) {.importc.}
proc call_cpp(x: cstring) {.importc.}
proc call_d(x: cstring) {.importc.}
proc call_go(x: cstring) {.importc.}
proc call_nim(x: cstring) {.importc.}
proc call_oc(x: cstring) {.importc.}
proc call_rust(x: cstring) {.importc.}
proc call_zig(x: cstring) {.importc.}
proc call_swift(x: cstring) {.importc.}
proc call_pascal(x: cstring) {.importc.}
proc call_fortran(x: cstring) {.importc.}
proc call_ada(x: cstring) {.importc.}


proc start_nim_chain() {.exportc, dynlib.} =
    call_c("c called by nim");
    call_cpp("c++ called by nim");
    call_rust("rust called by nim");
    call_go("go called by nim");
    call_d("d called by nim");
    call_zig("zig called by nim");
    call_nim("nim called by nim");
    call_oc("oc called by nim");
    call_swift("swift called by nim");
    call_pascal("pascal called by nim");
    call_fortran("fortran called by nim");
    call_ada("ada called by nim");
