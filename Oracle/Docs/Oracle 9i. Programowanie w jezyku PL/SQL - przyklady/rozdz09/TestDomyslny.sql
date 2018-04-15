REM TestDomyslny.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt prezentuje ró¿ne sposoby wywo³ywania procedur
REM z parametrami domyœlnymi.

set serveroutput on

CREATE OR REPLACE PROCEDURE TestDomyslny (
  p_ParametrA NUMBER DEFAULT 10,
  p_ParametrB VARCHAR2 DEFAULT 'abcdef',
  p_ParametrC DATE DEFAULT sysdate) AS
BEGIN
     DBMS_OUTPUT.PUT_LINE(
        'A:  ' || p_ParametrA ||
        '  B:  ' || p_ParametrB ||
        '  C:  ' || TO_CHAR(p_ParametrC, 'DD-MON-YYYY'));
END TestDomyslny;
/

BEGIN 
    TestDomyslny (p_ParametrA => 7, p_ParametrC => '30-DEC-95');
END;
/

BEGIN
  -- Zastosowanie wartoœci domyœlnej zarówno dla parametru p_ParametrB,
  -- jak i dla p_ParameterC 
  TestDomyslny(7);
END;
/