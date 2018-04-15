REM DeklaracjeWyprzedzajace.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje deklaracje wyprzedzaj¹ce.

set serveroutput on

DECLARE
  z_WartTymcz BINARY_INTEGER := 5;

  -- Deklaracja wyprzedzaj¹ca procedury B.
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