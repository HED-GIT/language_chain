#include "c_call.h"

#include <stdio.h>

void call_c(const char* x){
    fprintf(stdout, "%s\n", x);
}

char* adastring(){
    return "ada called by java";
}

char* cstring(){
    return "c called by java";
}

char* cppstring(){
    return "cpp called by java";
}

char* cobolstring(){
    return "cobol called by java";
}

char* crystalstring(){
    return "crystal called by java";
}

char* dstring(){
    return "d called by java";
}

char* fortranstring(){
    return "fortran called by java";
}

char* gostring(){
    return "go called by java";
}

char* haskellstring(){
    return "haskell called by java";
}

char* javastring(){
    return "java called by java";
}

char* kotlinstring(){
    return "kotlin called by java";
}

char* nimstring(){
    return "nim called by java";
}

char* ocstring(){
    return "oc called by java";
}

char* odinstring(){
    return "odin called by java";
}

char* pascalstring(){
    return "pascal called by java";
}

char* ruststring(){
    return "rust called by java";
}

char* swiftstring(){
    return "swift called by java";
}

char* zigstring(){
    return "zig called by java";
}