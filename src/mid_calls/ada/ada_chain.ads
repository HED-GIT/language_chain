with Interfaces.C; use Interfaces.C;

package ada_chain is
	procedure start_ada_chain with
		Export => True,
		Convention => C,
		External_Name => "start_ada_chain";
end ada_chain;