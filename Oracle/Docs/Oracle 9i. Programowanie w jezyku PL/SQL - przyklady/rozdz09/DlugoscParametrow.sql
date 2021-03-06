REM DlugoscParametrow.sql 
REM Rozdział 9., Scott Urman - Oracle9i Programowanie w języku PL/SQL
REM Ten skrypt demonstruje prawidłowe i nieprawidłowe parametry formalne
REM ograniczone przez długość.

PROMPT Nierawidłowe wywołanie procedury DlugoscParametrow (parametry ograniczone
PROMPT w deklaracji)...
SET echo on

CREATE OR REPLACE PROCEDURE DlugoscParametrow (
  p_Parametr1 IN OUT VARCHAR2(10),
  p_Parametr2 IN OUT NUMBER(3,1)) AS
BEGIN
  p_Parametr1 := 'abcdefghijklm';
  p_Parametr2 := 12.3;
END DlugoscParametrow;
/

SET echo off

PROMPT Prawidłowe wywołanie procedury DlugoscParametrow...
SET echo on

CREATE OR REPLACE PROCEDURE DlugoscParametrow (
  p_Parametr1 IN OUT VARCHAR2,
  p_Parametr2 IN OUT NUMBER) AS
BEGIN
  p_Parametr1 := 'abcdefghijklmno';
  p_Parametr2 := 12.3;
END DlugoscParametrow;
/

SET echo off
PROMPT Prawidłowe wywołanie procedury DlugoscParametrow...
SET echo on

DECLARE
  z_Zmienna1 VARCHAR2(40);
  z_Zmienna2 NUMBER(7,3);
BEGIN
  DlugoscParametrow(z_Zmienna1, z_Zmienna2);
END;
/

SET echo off
PROMPT Nieprawidłowe wywołanie procedury DlugoscParametrow (ORA-6502)...
SET echo on

DECLARE
  z_Zmienna1 VARCHAR2(10);
  z_Zmienna2 NUMBER(7,3);
BEGIN
  DlugoscParametrow(z_Zmienna1, z_Zmienna2);
END;
/

SET echo off
PROMPT Wywołanie procedury DlugoscParametrow z wykorzystaniem atrybutu %TYPE dla parametrów...
SET echo on

CREATE OR REPLACE PROCEDURE DlugoscParametrow (
  p_Parametr1 IN OUT VARCHAR2,
  p_Parametr2 IN OUT studenci.biezace_zaliczenia%TYPE) AS
BEGIN
  p_Parametr2 := 12345;
END DlugoscParametrow;
/

SET echo off
PROMPT Niepoprawne wywołanie procedury DlugoscParametrow (ORA-6502)...
SET echo on

DECLARE
   z_Zmienna1 VARCHAR2(1); 
   -- zadeklarowanie zmiennej z_Zmienna2 bez ograniczeń
    z_Zmienna2 NUMBER;  
  BEGIN
    -- Mimo ze parametr aktualny ma miejsce dla 12345, uwzględniane
    -- jest ograniczenie dla parametru formalnego i wywołanie tej 
    -- procedury spowoduje wystąpienie błędu ORA-6502.
    DlugoscParametrow(z_Zmienna1, z_Zmienna2);
END;
/