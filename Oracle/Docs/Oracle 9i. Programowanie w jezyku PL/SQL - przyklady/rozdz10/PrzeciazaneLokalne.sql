REM PrzeciazaneLokalne.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok zawiera przeci¹¿ane procedury lokalne.

set serveroutput on

DECLARE
  -- Dwie przeci¹¿one procedury lokalne
  PROCEDURE ProcLokalna(p_Parametr1 IN NUMBER) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Wewn¹trz wersji 1, p_Parametr1 = ' ||
                         p_Parametr1);
  END ProcLokalna;

  PROCEDURE ProcLokalna(p_Parametr1 IN VARCHAR2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Wewn¹trz wersji 2, p_Parametr1 = ' ||
                         p_Parametr1);
  END ProcLokalna;
BEGIN
  -- Wywo³anie wersji 1
  ProcLokalna(12345);

  -- oraz wersji 2
  ProcLokalna('abcdef');
END;
/