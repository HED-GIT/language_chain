library pascal_chain;

procedure call_ada (str: PChar); external;
procedure call_c (str: PChar); external;
procedure call_cpp (str: PChar); external;
procedure call_cobol (str: PChar); external;
procedure call_d (str: PChar); external;
procedure call_fortran (str: PChar); external;
procedure call_go (str: PChar); external;
procedure call_nim (str: PChar); external;
procedure call_oc (str: PChar); external;
procedure call_odin (str: PChar); external;
procedure call_pascal (str: PChar); external;
procedure call_rust (str: PChar); external;
procedure call_swift (str: PChar); external;
procedure call_zig (str: PChar); external;

procedure start_pascal_chain() cdecl;
begin
    call_ada('ada called by pascal');
    call_c('c called by pascal');
    call_cpp('c++ called by pascal');
    call_cobol('cobol called by pascal');
    call_d('d called by pascal');
    call_fortran('fortran called by pascal');
    call_go('go called by pascal');
    call_nim('nim called by pascal');
    call_oc('oc called by pascal');
    call_odin('odin called by pascal');
    call_pascal('pascal called by pascal');
    call_rust('rust called by pascal');
    call_swift('swift called by pascal');
    call_zig('zig called by pascal');
end;

exports
    start_pascal_chain;
end.
