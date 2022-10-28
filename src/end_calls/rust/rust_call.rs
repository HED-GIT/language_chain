use std::ffi::CStr;
use std::os::raw::c_char;

#[no_mangle]
pub extern fn call_rust(x: *const c_char){
    unsafe {
        println!("{}",CStr::from_ptr(x).to_str().unwrap());
    }
}