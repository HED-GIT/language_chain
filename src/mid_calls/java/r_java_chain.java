package at.hed.foobar;

import org.graalvm.nativeimage.IsolateThread;
import org.graalvm.nativeimage.c.function.CEntryPoint;
import org.graalvm.nativeimage.c.function.CFunction;
import org.graalvm.nativeimage.c.type.CCharPointer;
import org.graalvm.nativeimage.c.type.CTypeConversion;

public class r_java_chain
{

    @CFunction(value = "call_ada")
    static native void call_ada(CCharPointer c);

    @CFunction(value = "call_c")
    static native void call_c(CCharPointer c);

    @CFunction(value = "call_cpp")
    static native void call_cpp(CCharPointer c);

    @CFunction(value = "call_cobol")
    static native void call_cobol(CCharPointer c);

    @CFunction(value = "call_d")
    static native void call_d(CCharPointer c);

    @CFunction(value = "call_fortran")
    static native void call_fortran(CCharPointer c);

    @CFunction(value = "call_go")
    static native void call_go(CCharPointer c);

    @CFunction(value = "call_haskell")
    static native void call_haskell(CCharPointer c);

    @CFunction(value = "call_java")
    static native void call_java(CCharPointer c);

    @CFunction(value = "call_nim")
    static native void call_nim(CCharPointer c);

    @CFunction(value = "call_oc")
    static native void call_oc(CCharPointer c);

    @CFunction(value = "call_odin")
    static native void call_odin(CCharPointer c);

    @CFunction(value = "call_pascal")
    static native void call_pascal(CCharPointer c);

    @CFunction(value = "call_rust")
    static native void call_rust(CCharPointer c);

    @CFunction(value = "call_swift")
    static native void call_swift(CCharPointer c);

    @CFunction(value = "call_zig")
    static native void call_zig(CCharPointer c);


    @CFunction(value = "adastring")
    static native CCharPointer adastring();

    @CFunction(value = "cstring")
    static native CCharPointer cstring();

    @CFunction(value = "cppstring")
    static native CCharPointer cppstring();

    @CFunction(value = "cobolstring")
    static native CCharPointer cobolstring();

    @CFunction(value = "dstring")
    static native CCharPointer dstring();

    @CFunction(value = "fortranstring")
    static native CCharPointer fortranstring();

    @CFunction(value = "gostring")
    static native CCharPointer gostring();

    @CFunction(value = "haskellstring")
    static native CCharPointer haskellstring();

    @CFunction(value = "javastring")
    static native CCharPointer javastring();

    @CFunction(value = "nimstring")
    static native CCharPointer nimstring();

    @CFunction(value = "ocstring")
    static native CCharPointer ocstring();

    @CFunction(value = "odinstring")
    static native CCharPointer odinstring();

    @CFunction(value = "pascalstring")
    static native CCharPointer pascalstring();

    @CFunction(value = "ruststring")
    static native CCharPointer ruststring();

    @CFunction(value = "swiftstring")
    static native CCharPointer swiftstring();

    @CFunction(value = "zigstring")
    static native CCharPointer zigstring();

    @CEntryPoint(name = "r_start_java_chain")
    public static void r_start_java_chain(IsolateThread isolateThread) {

        call_ada(adastring());
        call_c(cstring());
        call_cpp(cppstring());
        call_cobol(cobolstring());
        call_d(dstring());
        call_fortran(fortranstring());
        call_go(gostring());
        call_haskell(haskellstring());
        call_java(javastring());
        call_nim(nimstring());
        call_oc(ocstring());
        call_odin(odinstring());
        call_pascal(pascalstring());
        call_rust(ruststring());
        call_swift(swiftstring());
        call_zig(zigstring());
    }
}
