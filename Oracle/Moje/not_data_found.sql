declare
  -- Local variables here
  i varchar2(10);
begin
  i:=12;
  dbms_output.put_line('przed: '||i);
  begin
   select 1 into i from dual d where d.dummy='f';
  exception
   when no_data_found then
    i:=0;
  end;
  dbms_output.put_line('po: '||i);
end;