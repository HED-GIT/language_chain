import std.stdio;
import std.string;


extern (C) void call_d(const char* x){
    writefln("%s", fromStringz(x));
}