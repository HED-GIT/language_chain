IDENTIFICATION DIVISION.
PROGRAM-ID. start_cobol_chain.

ENVIRONMENT DIVISION.

DATA DIVISION.
WORKING-STORAGE SECTION.

PROCEDURE DIVISION.
    CALL "call_ada" using z"ada called by cobol".
    CALL "call_c" using z"c called by cobol".
    CALL "call_cpp" using z"cpp called by cobol".
    CALL "call_cobol" using z"cobol called by cobol".
    CALL "call_crystal" using z"crystal called by cobol".
    CALL "call_d" using z"d called by cobol".
    CALL "call_fortran" using z"fortran called by cobol".
    CALL "call_go" using z"go called by cobol".
    CALL "call_haskell" using z"haskell called by cobol".
    CALL "call_java" using z"java called by cobol".
    CALL "call_kotlin" using z"kotlin called by cobol".
    CALL "call_nim" using z"nim called by cobol".
    CALL "call_oc" using z"oc called by cobol".
    CALL "call_odin" using z"odin called by cobol".
    CALL "call_pascal" using z"pascal called by cobol".
    CALL "call_rust" using z"rust called by cobol".
    CALL "call_swift" using z"swift called by cobol".
    CALL "call_zig" using z"zig called by cobol".
    goback.
