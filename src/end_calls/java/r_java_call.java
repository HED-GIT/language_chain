package at.hed.foobar;

import org.graalvm.nativeimage.IsolateThread;
import org.graalvm.nativeimage.c.function.CEntryPoint;
import org.graalvm.nativeimage.c.type.CCharPointer;
import org.graalvm.nativeimage.c.type.CTypeConversion;

public class r_java_call
{
    @CEntryPoint(name = "r_call_java")
    public static void r_call_java( IsolateThread isolateThread, CCharPointer text) {
        System.out.println(CTypeConversion.toJavaString(text));
    }
}