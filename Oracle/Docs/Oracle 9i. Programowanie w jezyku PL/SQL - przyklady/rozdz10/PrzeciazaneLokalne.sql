REM PrzeciazaneLokalne.sql
REM Rozdzia� 10., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok zawiera przeci��ane procedury lokalne.

set serveroutput on

DECLARE
  -- Dwie przeci��one procedury lokalne
  PROCEDURE ProcLokalna(p_Parametr1 IN NUMBER) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Wewn�trz wersji 1, p_Parametr1 = ' ||
                         p_Parametr1);
  END ProcLokalna;

  PROCEDURE ProcLokalna(p_Parametr1 IN VARCHAR2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Wewn�trz wersji 2, p_Parametr1 = ' ||
                         p_Parametr1);
  END ProcLokalna;
BEGIN
  -- Wywo�anie wersji 1
  ProcLokalna(12345);

  -- oraz wersji 2
  ProcLokalna('abcdef');
END;
/