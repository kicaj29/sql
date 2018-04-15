REM PrzeciazanieObiektow.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt ilustruje przeci¹¿anie podprogramów w pakietach
REM wykorzystuj¹cych typy obiektowe.


CREATE OR REPLACE TYPE t1 AS OBJECT (
  f NUMBER
);
/
show errors

CREATE OR REPLACE TYPE t2 AS OBJECT (
  f NUMBER
);
/
show errors

CREATE OR REPLACE PACKAGE Przeciazanie AS
  PROCEDURE Proc(p_Parametr1 IN t1);
  PROCEDURE Proc(p_Parametr1 IN t2);
END Przeciazanie;
/
show errors

CREATE OR REPLACE PACKAGE BODY Przeciazanie AS
  PROCEDURE Proc(p_Parametr1 IN t1) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Proc(t1): ' || p_Parametr1.f);
  END Proc;

  PROCEDURE Proc(p_Parametr1 IN t2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Proc(t2): ' || p_Parametr1.f);
  END Proc;
END Przeciazanie;
/
show errors

set serveroutput on

DECLARE
   z_Obiekt1 t1 := t1(1);
   z_Obiekt2 t2 := t2(2);
BEGIN
   Przeciazanie.Proc(z_Obiekt1);
   Przeciazanie.Proc(z_Obiekt2);
END;
/