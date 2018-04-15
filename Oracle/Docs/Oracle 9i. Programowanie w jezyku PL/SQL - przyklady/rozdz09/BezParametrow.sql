REM BezParametrow.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt prezentuje sk³adowane podprogramy bez parametrów.

set serveroutput on

CREATE OR REPLACE PROCEDURE BezParametrowP AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Brak parametrów!');
END BezParametrowP;

CREATE OR REPLACE FUNCTION BezParametrowF
  RETURN DATE AS
BEGIN
  RETURN SYSDATE;
END BezParametrowF;

BEGIN
  BezParametrowP;
  DBMS_OUTPUT.PUT_LINE('Wywo³anie funkcji BezParametrowF  ' ||
    TO_CHAR(BezParametrowF, 'DD-MON-YYYY'));
END;
/
