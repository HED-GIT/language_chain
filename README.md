# language_chain

a test program where different languages call each other

## languages

- ada
- c
- c++
- cobol
- crystal
- d
- fortran
- go
- haskell
- java
- julia
- kotlin
- nim
- objective-c
- odin
- pascal
- rust
- swift
- zig

## dependencies

- cbindgen
- crystal
- dmd
- fpc
- gcc
- gcc-ada
- gcc-fortran
- gcc-objc
- ghc 9.0.2
- gnucobol
- go
- julia
- kotlin-native
- make
- native-image
- nim
- odin
- rustup
- rust-bindgen
- swift
- zig

or

- docker
- (docker-compose)

## todos

- rust_chain not using generated .rs files for nim
- nim_call should use native print instead of prints from c
- something acts weird in docker (fortran doesn't seem to be the problem), okay fortran is the problem
- haskell has to be initialized, find a way to remove it
- main not using haskell_chain.h and rust_chain.h
- make go use haskell header file
- make java not use strings that are defined in c code

## possible future languages

- julia
- scala (using java and graalvm)
- groovy (using java and graalvm)
