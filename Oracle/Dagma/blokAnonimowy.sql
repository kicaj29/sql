BEGIN
  DBMS_OUTPUT.PUT_LINE('ZACZYNAMY');
END;

DECLARE
  V_ID NUMBER;
  v_Return VARCHAR2(200);
BEGIN
  V_ID := 3;
  delete from pracownicy where id >= V_ID;
  insert into pracownicy (id, nazwisko, wiek) values (V_ID, 'testA', 22);
  V_ID := V_ID + 1;
  insert into pracownicy (id, nazwisko, wiek) values (V_ID, 'testB', 34);
  DBMS_OUTPUT.PUT_LINE('ZAKOÑCZONOE POMYŒLNIE');
END;

select * from pracownicy;
