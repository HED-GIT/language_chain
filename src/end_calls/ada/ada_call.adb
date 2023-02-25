with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Text_IO; use Text_IO;

package body ada_call is

    procedure call_ada(a: chars_ptr) is 
        s : String := Value (a);
    begin
        Put_Line(s);
    end call_ada;
end ada_call;