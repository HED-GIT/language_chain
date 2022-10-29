package main

// #include "c_call.h"
// #include "cpp_call.h"
// #include "d_call.h"
// #include "go_call.h"
// #include "nim_call.h"
// #include "oc_call.h"
// #include "rust_call.h"
// #include "zig_call.h"
// #include <stdlib.h>
import "C" // has to be seperate from the others

import (
	"unsafe"
)

//export start_go_chain
func start_go_chain() {
	c := C.CString("c called by go");
	defer C.free(unsafe.Pointer(c));
	cpp := C.CString("c++ called by go");
	defer C.free(unsafe.Pointer(cpp));
	rust := C.CString("rust called by go");
	defer C.free(unsafe.Pointer(rust));
	_go := C.CString("go called by go");
	defer C.free(unsafe.Pointer(_go));
	d := C.CString("d called by go");
	defer C.free(unsafe.Pointer(d));
	zig := C.CString("zig called by go");
	defer C.free(unsafe.Pointer(zig));
	nim := C.CString("nim called by go");
	defer C.free(unsafe.Pointer(nim));
	oc := C.CString("oc called by go");
	defer C.free(unsafe.Pointer(oc));

	C.call_c(c);
    C.call_cpp(cpp);
    C.call_rust(rust);
    C.call_go(_go);
    C.call_d(d);
    C.call_zig(zig);
    C.call_nim(nim);
    C.call_oc(oc);
}

func main(){}