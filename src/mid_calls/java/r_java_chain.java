package at.hed.foobar;

import org.graalvm.nativeimage.IsolateThread;
import org.graalvm.nativeimage.c.function.CEntryPoint;
import org.graalvm.nativeimage.c.function.CFunction;
import org.graalvm.nativeimage.c.type.CCharPointer;
import org.graalvm.nativeimage.c.type.CTypeConversion;

public class r_java_chain
{
    @CFunction("call_c")
    static native void call_c(CCharPointer text);

    @CEntryPoint(name = "r_start_java_chain")
    public static void r_start_java_chain( IsolateThread isolateThread) {
        //call_c(CTypeConversion.toCString("c called by java").get());
    }
}