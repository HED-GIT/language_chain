import kotlinx.cinterop.*

fun r_call_kotlin(cString: CPointer<ByteVar>){
    println(cString.toKString());
}
