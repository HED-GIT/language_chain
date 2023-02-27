IDENTIFICATION DIVISION.
PROGRAM-ID. start_cobol_chain.

ENVIRONMENT DIVISION.

DATA DIVISION.
WORKING-STORAGE SECTION.

PROCEDURE DIVISION.
    CALL "call_c" using z"c called from cobol".
    CALL "call_cpp" using z"cpp called from cobol".
    CALL "call_rust" using z"rust called from cobol".
    CALL "call_go" using z"go called from cobol".
    CALL "call_d" using z"d called from cobol".
    CALL "call_zig" using z"zig called from cobol".
    CALL "call_nim" using z"nim called from cobol".
    CALL "call_oc" using z"oc called from cobol".
    CALL "call_swift" using z"swift called from cobol".
    CALL "call_pascal" using z"pascal called from cobol".
    CALL "call_fortran" using z"fortran called from cobol".
    CALL "call_ada" using z"ada called from cobol".
    CALL "call_cobol" using z"cobol called from cobol".
    goback.
