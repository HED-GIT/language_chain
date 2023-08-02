IDENTIFICATION DIVISION.
PROGRAM-ID. call_cobol.

ENVIRONMENT DIVISION.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 msg-length pic 99.

Linkage section.
01 msg pic X(30).

PROCEDURE DIVISION using msg.
    compute msg-length = 0
    inspect msg tallying msg-length for characters before initial x'00'
    display msg(1:msg-length).
