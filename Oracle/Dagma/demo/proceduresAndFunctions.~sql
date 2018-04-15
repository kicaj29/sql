create or replace procedure InkrementujWiek is
begin
       update pracownicy p set p.wiek = p.wiek + 1;
end;
/

create or replace procedure InkrementujWiekPracownika(v_id pracownicy.id%type) is
begin
       update pracownicy p set p.wiek = p.wiek + 1 where p.id = v_id;
end;
/



create or replace function PobierzPracownika
  (v_id pracownicy.id%type) return varchar2 is
  v_nazwisko pracownicy.nazwisko%type;
begin
  select nazwisko
  into v_nazwisko
  from pracownicy
  where id = v_id;
  return v_nazwisko;
end PobierzPracownika;
/
