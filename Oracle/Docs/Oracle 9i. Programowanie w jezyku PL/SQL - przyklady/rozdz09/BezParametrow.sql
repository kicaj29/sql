REM BezParametrow.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt prezentuje sk�adowane podprogramy bez parametr�w.

set serveroutput on

CREATE OR REPLACE PROCEDURE BezParametrowP AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Brak parametr�w!');
END BezParametrowP;

CREATE OR REPLACE FUNCTION BezParametrowF
  RETURN DATE AS
BEGIN
  RETURN SYSDATE;
END BezParametrowF;

BEGIN
  BezParametrowP;
  DBMS_OUTPUT.PUT_LINE('Wywo�anie funkcji BezParametrowF  ' ||
    TO_CHAR(BezParametrowF, 'DD-MON-YYYY'));
END;
/
