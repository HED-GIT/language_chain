#![allow(non_camel_case_types)]

// include!("../../../build/headers/c_call.rs");
// include!("../../../build/headers/cpp_call.rs");
// include!("../../../build/headers/d_call.rs");
// include!("../../../build/headers/go_call.rs");
// include!("../../../build/headers/nim_call.rs");
// include!("../../../build/headers/oc_call.rs");
// include!("../../../build/headers/rust_call.rs");
// include!("../../../build/headers/zig_call.rs");

use std::ffi::CString;

extern "C" {
    fn call_nim(x: *const ::std::os::raw::c_char);
    fn call_rust(x: *const ::std::os::raw::c_char);
    fn call_c(x: *const ::std::os::raw::c_char);
    fn call_cpp(x: *const ::std::os::raw::c_char);
    fn call_d(x: *const ::std::os::raw::c_char);
    fn call_go(x: *const ::std::os::raw::c_char);
    fn call_oc(x: *const ::std::os::raw::c_char);
    fn call_zig(x: *const ::std::os::raw::c_char);
}

#[no_mangle]
pub extern fn start_rust_chain(){
    unsafe {
        let c = CString::new("c called by rust").unwrap();
        call_c(c.as_ptr());
        let cpp = CString::new("c++ called by rust").unwrap();
        call_cpp(cpp.as_ptr());
        let rust = CString::new("rust called by rust").unwrap();
        call_rust(rust.as_ptr() as *mut i8);
        let go = CString::new("go called by rust").unwrap();
        call_go(go.as_ptr() as *mut i8);
        let d = CString::new("d called by rust").unwrap();
        call_d(d.as_ptr());
        let zig = CString::new("zig called by rust").unwrap();
        call_zig(zig.as_ptr() as *mut i8);
        let nim = CString::new("nim called by rust").unwrap();
        call_nim(nim.as_ptr() as *mut i8);
        let oc = CString::new("oc called by rust").unwrap();
        call_oc(oc.as_ptr() as *mut i8);
    }
}