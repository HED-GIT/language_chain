with Text_IO; use Text_IO;
with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package ada_call is

    procedure call_ada(a: chars_ptr) with
		Export => True,
		Convention => C,
		External_Name => "call_ada";
end ada_call;