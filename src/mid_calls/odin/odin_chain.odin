package odin_chain

import "core:runtime"

foreign import lib_ada "libada_call"
foreign import lib_c "libc_call"
foreign import lib_cpp "libcpp_call"
foreign import lib_cobol "libcobol_call"
foreign import lib_d "libd_call"
foreign import lib_fortran "libfortran_call"
foreign import lib_go "libgo_call"
foreign import lib_haskell "libhaskell_call"
foreign import lib_nim "libnim_call"
foreign import lib_oc "liboc_call"
foreign import lib_odin "libodin_call"
foreign import lib_pascal "libpascal_call"
foreign import lib_rust "librust_call"
foreign import lib_swift "libswift_call"
foreign import lib_zig "libzig_call"

foreign lib_ada {
    call_ada :: proc(x: cstring) ---
}
foreign lib_c {
    call_c :: proc(x: cstring) ---
}
foreign lib_cpp {
    call_cpp :: proc(x: cstring) ---
}
foreign lib_cobol {
    call_cobol :: proc(x: cstring) ---
}
foreign lib_d {
    call_d :: proc(x: cstring) ---
}
foreign lib_fortran {
    call_fortran :: proc(x: cstring) ---
}
foreign lib_go {
    call_go :: proc(x: cstring) ---
}
foreign lib_haskell {
    call_haskell :: proc(x: cstring) ---
}
foreign lib_nim {
    call_nim :: proc(x: cstring) ---
}
foreign lib_oc {
    call_oc :: proc(x: cstring) ---
}
foreign lib_odin {
    call_odin :: proc(x: cstring) ---
}
foreign lib_pascal {
    call_pascal :: proc(x: cstring) ---
}
foreign lib_rust {
    call_rust :: proc(x: cstring) ---
}
foreign lib_swift {
    call_swift :: proc(x: cstring) ---
}
foreign lib_zig {
    call_zig :: proc(x: cstring) ---
}

@export
start_odin_chain :: proc "c"() {
	context = runtime.default_context()
    call_ada("ada called by odin")
    call_c("c called by odin")
    call_cpp("cpp called by odin")
    call_cobol("cobol called by odin")
    call_d("d called by odin")
    call_fortran("fortran called by odin")
    call_go("go called by odin")
    call_haskell("haskell called by odin")
    call_nim("nim called by odin")
    call_oc("oc called by odin")
    call_odin("odin called by odin")
    call_pascal("pascal called by odin")
    call_rust("rust called by odin")
    call_swift("swift called by odin")
    call_zig("zig called by odin")
}
