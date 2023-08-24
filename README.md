# language_chain

a test program where different compiled languages call each other

## languages

- ada
- c
- c++
- cobol
- d
- fortran
- go
- haskell
- java
- nim
- objective-c
- odin
- pascal
- rust
- swift
- zig

## todos

- rust_chain not using generated .rs files for nim
- nim_call should use native print instead of prints from c
- something acts weird in docker (fortran doesn't seem to be the problem), okay fortran is the problem
- haskell has to be initialized, find a way to remove it
- main not using haskell_chain.h and rust_chain.h
- make go use haskell header file
