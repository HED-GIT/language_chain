lib Call
    fun call_ada(text: UInt8*) : Void
    fun call_c(text: UInt8*) : Void
    fun call_cpp(text: UInt8*) : Void
    fun call_cobol(text: UInt8*) : Void
    fun call_crystal(text: UInt8*) : Void
    fun call_d(text: UInt8*) : Void
    fun call_fortran(text: UInt8*) : Void
    fun call_go(text: UInt8*) : Void
    fun call_haskell(text: UInt8*) : Void
    fun call_java(text: UInt8*) : Void
    fun call_kotlin(text: UInt8*) : Void
    fun call_nim(text: UInt8*) : Void
    fun call_oc(text: UInt8*) : Void
    fun call_odin(text: UInt8*) : Void
    fun call_pascal(text: UInt8*) : Void
    fun call_rust(text: UInt8*) : Void
    fun call_swift(text: UInt8*) : Void
    fun call_zig(text: UInt8*) : Void
end

fun log = start_crystal_chain(): Void
    Call.call_ada("ada called by crystal".to_unsafe);
    Call.call_c("c called by crystal".to_unsafe);
    Call.call_cpp("cpp called by crystal".to_unsafe);
    Call.call_cobol("cobol called by crystal".to_unsafe);
    Call.call_crystal("crystal called by crystal".to_unsafe);
    Call.call_d("d called by crystal".to_unsafe);
    Call.call_fortran("fortran called by crystal".to_unsafe);
    Call.call_go("go called by crystal".to_unsafe);
    Call.call_haskell("haskell called by crystal".to_unsafe);
    Call.call_java("java called by crystal".to_unsafe);
    Call.call_kotlin("kotlin called by crystal".to_unsafe);
    Call.call_nim("nim called by crystal".to_unsafe);
    Call.call_oc("oc called by crystal".to_unsafe);
    Call.call_odin("odin called by crystal".to_unsafe);
    Call.call_pascal("pascal called by crystal".to_unsafe);
    Call.call_rust("rust called by crystal".to_unsafe);
    Call.call_swift("swift called by crystal".to_unsafe);
    Call.call_zig("zig called by crystal".to_unsafe);
end
