const call_ada = @cImport({
    @cInclude("ada_call.h");
}).call_ada;
const call_c = @cImport({
    @cInclude("c_call.h");
}).call_c;
const call_cpp = @cImport({
    @cInclude("cpp_call.h");
}).call_cpp;
const call_cobol = @cImport({
    @cInclude("cobol_call.h");
}).call_cobol;
const call_d = @cImport({
    @cInclude("d_call.h");
}).call_d;
const call_fortran = @cImport({
    @cInclude("fortran_call.h");
}).call_fortran;
const call_go = @cImport({
    @cInclude("go_call.h");
}).call_go;
const call_nim = @cImport({
    @cInclude("nim_call.h");
}).call_nim;
const call_oc = @cImport({
    @cInclude("oc_call.h");
}).call_oc;
const call_pascal = @cImport({
    @cInclude("pascal_call.h");
}).call_pascal;
const call_rust = @cImport({
    @cInclude("rust_call.h");
}).call_rust;
const call_swift = @cImport({
    @cInclude("swift_call.h");
}).call_swift;
const call_zig = @cImport({
    @cInclude("zig_call.h");
}).call_zig;

pub export fn start_zig_chain() callconv(.C) void {
    var ada = "ada called by zig".*;
    call_ada(&ada);
    call_c("c called by zig");
    call_cpp("c++ called by zig");
    var cobol = "cobol called by zig".*;
    call_cobol(&cobol);
    call_d("d called by zig");
    var fortran = "fortran called by zig".*;
    call_fortran(&fortran);
    var go = "go called by zig".*;
    call_go(&go);
    var nim = "nim called by zig".*;
    call_nim(&nim);
    call_oc("oc called by zig");
    call_pascal("pascal called by zig");
    call_rust("rust called by zig");
    var swift = "swift called by zig".*;
    call_swift(&swift);
    call_zig("zig called by zig");

}