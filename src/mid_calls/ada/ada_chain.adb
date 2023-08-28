with ada_chain;
with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package body ada_chain is

    procedure start_ada_chain is 

        procedure call_ada(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_c(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_cpp(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_cobol(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_d(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_fortran(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_go(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_haskell(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_java(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_kotlin(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_nim(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_oc(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_odin(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_pascal(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_rust(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_swift(a: chars_ptr) with
            Import => True,
            Convention => C;
        procedure call_zig(a: chars_ptr) with
            Import => True,
            Convention => C;

    adastring : constant chars_ptr := New_String ("ada called by ada");
    cstring : constant chars_ptr := New_String ("c called by ada");
    cppstring : constant chars_ptr := New_String ("c++ called by ada");
    cobolstring : constant chars_ptr := New_String ("cobol called by ada");
    dstring : constant chars_ptr := New_String ("d called by ada");
    fortranstring : constant chars_ptr := New_String ("fortran called by ada");
    gostring : constant chars_ptr := New_String ("go called by ada");
    haskellstring : constant chars_ptr := New_String ("haskell called by ada");
    javastring : constant chars_ptr := New_String ("java called by ada");
    kotlinstring : constant chars_ptr := New_String ("kotlin called by ada");
    nimstring : constant chars_ptr := New_String ("nim called by ada");
    ocstring : constant chars_ptr := New_String ("oc called by ada");
    odinstring : constant chars_ptr := New_String ("odin called by ada");
    pascalstring : constant chars_ptr := New_String ("pascal called by ada");
    ruststring : constant chars_ptr := New_String ("rust called by ada");
    swiftstring : constant chars_ptr := New_String ("swift called by ada");
    zigstring : constant chars_ptr := New_String ("zig called by ada");

    begin
        call_ada(adastring);
        call_c(cstring);
        call_cpp(cppstring);
        call_cobol(cobolstring);
        call_d(dstring);
        call_fortran(fortranstring);
        call_go(gostring);
        call_haskell(haskellstring);
        call_java(javastring);
        call_kotlin(kotlinstring);
        call_nim(nimstring);
        call_oc(ocstring);
        call_odin(odinstring);
        call_pascal(pascalstring);
        call_rust(ruststring);
        call_swift(swiftstring);
        call_zig(zigstring);
    end start_ada_chain;
end ada_chain;