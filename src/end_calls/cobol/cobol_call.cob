IDENTIFICATION DIVISION.
PROGRAM-ID. call_cobol.

ENVIRONMENT DIVISION.

DATA DIVISION.
WORKING-STORAGE SECTION.

Linkage section.
01 msg pic X(30).


PROCEDURE DIVISION using msg.
    display msg.

    