REM DeklaracjeWyprzedzajace.sql
REM Rozdział 10., Scott Urman - Oracle9i Programowanie w języku PL/SQL
REM Ten blok ilustruje deklaracje wyprzedzające.

set serveroutput on

DECLARE
  z_WartTymcz BINARY_INTEGER := 5;

  -- Deklaracja wyprzedzająca procedury B.
  PROCEDURE B(p_Licznik IN OUT BINARY_INTEGER);

  PROCEDURE A(p_Licznik IN OUT BINARY_INTEGER) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('A(' || p_Licznik || ')');   
    IF p_Licznik > 0 THEN
      B(p_Licznik);
      p_Licznik := p_Licznik - 1;
    END IF;
  END A;

  PROCEDURE B(p_Licznik IN OUT BINARY_INTEGER) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('B(' || p_Licznik || ')');
    p_Licznik := p_Licznik - 1;
    A(p_Licznik);
  END B;
BEGIN
  B(z_WartTymcz);
END;
/