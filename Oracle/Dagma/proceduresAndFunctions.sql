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
