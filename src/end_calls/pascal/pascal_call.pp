library pascal_call;

procedure call_pascal(str: PChar) cdecl;
begin
    WriteLn(str);
    Flush(Output);
end;

exports
    call_pascal;
end.
