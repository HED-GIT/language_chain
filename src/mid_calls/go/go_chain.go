package main

// #include "ada_call.h"
// #include "c_call.h"
// #include "cpp_call.h"
// #include "cobol_call.h"
// #include "crystal_call.h"
// #include "d_call.h"
// #include "fortran_call.h"
// #include "go_call.h"
// void call_haskell(char*);
// #include "java_call.h"
// #include "kotlin_call.h"
// #include "nim_call.h"
// #include "oc_call.h"
// #include "odin_call.h"
// #include "pascal_call.h"
// #include "rust_call.h"
// #include "swift_call.h"
// #include "zig_call.h"
// #include <stdlib.h>
import "C" // has to be seperate from the others

import (
	"unsafe"
)

//export start_go_chain
func start_go_chain() {
	ada := C.CString("ada called by go")
	defer C.free(unsafe.Pointer(ada))
	c := C.CString("c called by go")
	defer C.free(unsafe.Pointer(c))
	cpp := C.CString("cpp called by go")
	defer C.free(unsafe.Pointer(cpp))
	cobol := C.CString("cobol called by go")
	defer C.free(unsafe.Pointer(cobol))
	crystal := C.CString("crystal called by go")
	defer C.free(unsafe.Pointer(crystal))
	d := C.CString("d called by go")
	defer C.free(unsafe.Pointer(d))
	fortran := C.CString("fortran called by go")
	defer C.free(unsafe.Pointer(fortran))
	_go := C.CString("go called by go")
	defer C.free(unsafe.Pointer(_go))
	haskell := C.CString("haskell called by go")
	defer C.free(unsafe.Pointer(haskell))
	java := C.CString("java called by go")
	defer C.free(unsafe.Pointer(java))
	kotlin := C.CString("kotlin called by go")
	defer C.free(unsafe.Pointer(kotlin))
	nim := C.CString("nim called by go")
	defer C.free(unsafe.Pointer(nim))
	oc := C.CString("oc called by go")
	defer C.free(unsafe.Pointer(oc))
	odin := C.CString("odin called by go")
	defer C.free(unsafe.Pointer(odin))
	pascal := C.CString("pascal called by go")
	defer C.free(unsafe.Pointer(pascal))
	rust := C.CString("rust called by go")
	defer C.free(unsafe.Pointer(rust))
	swift := C.CString("swift called by go")
	defer C.free(unsafe.Pointer(swift))
	zig := C.CString("zig called by go")
	defer C.free(unsafe.Pointer(zig))

	C.call_ada(ada)
	C.call_c(c)
	C.call_cpp(cpp)
	C.call_cobol(cobol)
	C.call_crystal(crystal)
	C.call_d(d)
	C.call_fortran(fortran)
	C.call_go(_go)
	C.call_haskell(haskell)
	C.call_java(java)
	C.call_kotlin(kotlin)
	C.call_nim(nim)
	C.call_oc(oc)
	C.call_odin(odin)
	C.call_pascal(pascal)
	C.call_rust(rust)
	C.call_swift(swift)
	C.call_zig(zig)
}

func main() {}
