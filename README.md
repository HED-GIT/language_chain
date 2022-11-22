# c_all_lib_call

a c program that should call libraries written in different languages which then again call a c library

## languages

- c
- c++
- d
- nim
- zig
- go
- rust
- swift

## todos

- rust_chain not using generated .rs files
- nim_call prints using standard c function instead of some nim print
- c++ uses defined call_nim outside of header file (generated header does not include extern C)
- use dmd -HC flags to generate headers for d code
