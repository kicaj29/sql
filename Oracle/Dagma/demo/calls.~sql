--InkrementujWiek
begin
  InkrementujWiek();
end;

begin
  InkrementujWiekPracownika(2);
end;

--procedury nie mo¿emy wywo³aæ z zapytania SQL
begin
  select InkrementujWiekPracownika(2) from dual;
end;

--PobierzPracownika
DECLARE
  V_ID_tmp NUMBER;
  v_Return VARCHAR2(200);
BEGIN
  V_ID_tmp := 2;
  v_Return := POBIERZPRACOWNIKA(V_ID => V_ID_tmp);
  DBMS_OUTPUT.PUT_LINE('v_Return = ' || v_Return);
END;

declare
  v_kwota varchar2(200);
  v_nazwisko varchar2(200);
begin
  select sum(pw.brutto), POBIERZPRACOWNIKA(pw.pracownik_id)
  into v_kwota, v_nazwisko
  from pracownicy_wyplaty pw 
  where pw.pracownik_id = 1
  group by pw.pracownik_id;
  dbms_output.PUT_LINE('Nazwisko: ' || v_nazwisko || ' Brutto: ' || v_kwota);
end;
