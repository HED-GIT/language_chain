proc printf(formatstr: cstring) {.importc: "printf", varargs, header: "<stdio.h>".}

proc call_nim(x: cstring) {.exportc, dynlib.} =
    printf("%s\n", x) # todo find a way to not use c functions here
