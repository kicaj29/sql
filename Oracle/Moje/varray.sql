
create or replace procedure procVarray is
PRAGMA AUTONOMOUS_TRANSACTION;
  TYPE anTypeUmowaLiczba IS VARRAY(12) OF NUMBER(12,2);
  
  anUmowaLiczba anTypeUmowaLiczba := anTypeUmowaLiczba(1,2,3,4,5,6,7,8,9,10,11,12);
  nMiesiac NUMBER(2);
begin
  nMiesiac := 1;
  anUmowaLiczba(nMiesiac) := 11;
  if anUmowaLiczba(nMiesiac) = 11 then
    dbms_output.put_line('OK');
  end if;
  
  nMiesiac := 12;
  anUmowaLiczba(nMiesiac) := 1212;
  if anUmowaLiczba(nMiesiac) = 1212 then
    dbms_output.put_line('OK');
  end if;
  while (1 = 1) loop
    null;
  end loop;
commit;  
end;



