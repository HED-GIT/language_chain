import Glibc

@_cdecl("call_swift")
public func call_swift(str: UnsafeMutablePointer<CChar>){
    print(String(cString: str))
    fflush(stdout)
}