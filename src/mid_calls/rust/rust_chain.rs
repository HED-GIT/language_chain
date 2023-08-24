#![allow(non_camel_case_types)]

include!("../../../build/rust/ada_call.rs");
include!("../../../build/rust/c_call.rs");
include!("../../../build/rust/cpp_call.rs");
include!("../../../build/rust/cobol_call.rs");
include!("../../../build/rust/d_call.rs");
include!("../../../build/rust/fortran_call.rs");
include!("../../../build/rust/go_call.rs");
include!("../../../build/rust/haskell_call.rs");
include!("../../../build/rust/java_call.rs");
//include!("../../../build/rust/nim_call.rs");
include!("../../../build/rust/oc_call.rs");
include!("../../../build/rust/odin_call.rs");
include!("../../../build/rust/pascal_call.rs");
include!("../../../build/rust/swift_call.rs");
include!("../../../build/rust/zig_call.rs");

include!("../../../src/end_calls/rust/rust_call.rs");

use std::ffi::CString;
use std::ffi::c_void;

extern "C" {
    fn call_nim(x: *const ::std::os::raw::c_char);
}

#[no_mangle]
pub extern fn start_rust_chain(){
    unsafe {
        let ada = CString::new("ada called by rust").unwrap();
        call_ada(ada.as_ptr() as *mut i8);
        let c = CString::new("c called by rust").unwrap();
        call_c(c.as_ptr());
        let cpp = CString::new("c++ called by rust").unwrap();
        call_cpp(cpp.as_ptr());
        let cobol = CString::new("cobol called by rust").unwrap();
        call_cobol(cobol.as_ptr() as *mut i8);
        let d = CString::new("d called by rust").unwrap();
        call_d(d.as_ptr());
        let fortran = CString::new("fortran called by rust").unwrap();
        call_fortran(fortran.as_ptr() as *mut i8);
        let go = CString::new("go called by rust").unwrap();
        call_go(go.as_ptr() as *mut i8);
        let haskell = CString::new("haskell called by rust").unwrap();
        call_haskell(haskell.as_ptr() as *mut c_void);
        let java = CString::new("java called by rust").unwrap();
        call_java(java.as_ptr() as *mut c_void);
        let nim = CString::new("nim called by rust").unwrap();
        call_nim(nim.as_ptr() as *mut i8);
        let oc = CString::new("oc called by rust").unwrap();
        call_oc(oc.as_ptr() as *mut i8);
        let odin = CString::new("odin called by rust").unwrap();
        call_odin(odin.as_ptr() as *mut i8);
        let pascal = CString::new("pascal called by rust").unwrap();
        call_pascal(pascal.as_ptr() as *mut i8);
        let rust = CString::new("rust called by rust").unwrap();
        call_rust(rust.as_ptr() as *mut i8);
        let swift = CString::new("swift called by rust").unwrap();
        call_swift(swift.as_ptr() as *mut i8);
        let zig = CString::new("zig called by rust").unwrap();
        call_zig(zig.as_ptr() as *mut i8);
    }
}