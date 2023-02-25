# c_all_lib_call

a c program that should call libraries written in different languages which then call librarys in all the other languages

## languages

- c
- c++
- d
- nim
- zig
- objective c
- go
- rust
- swift
- pascal
- fortran

## todos

- rust_chain not using generated .rs files
- nim_call should use native print instead of prints from c
- c++ uses defined call_nim outside of header file (generated header does not include extern C)
- use dmd -HC flags to generate headers for d code (as far as i know currently unsupported/only supported for c++headers)
- try to add ada
