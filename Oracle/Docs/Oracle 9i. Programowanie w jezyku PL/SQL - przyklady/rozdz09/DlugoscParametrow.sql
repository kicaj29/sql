REM DlugoscParametrow.sql 
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt demonstruje prawid³owe i nieprawid³owe parametry formalne
REM ograniczone przez d³ugoœæ.

PROMPT Nierawid³owe wywo³anie procedury DlugoscParametrow (parametry ograniczone
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

PROMPT Prawid³owe wywo³anie procedury DlugoscParametrow...
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
PROMPT Prawid³owe wywo³anie procedury DlugoscParametrow...
SET echo on

DECLARE
  z_Zmienna1 VARCHAR2(40);
  z_Zmienna2 NUMBER(7,3);
BEGIN
  DlugoscParametrow(z_Zmienna1, z_Zmienna2);
END;
/

SET echo off
PROMPT Nieprawid³owe wywo³anie procedury DlugoscParametrow (ORA-6502)...
SET echo on

DECLARE
  z_Zmienna1 VARCHAR2(10);
  z_Zmienna2 NUMBER(7,3);
BEGIN
  DlugoscParametrow(z_Zmienna1, z_Zmienna2);
END;
/

SET echo off
PROMPT Wywo³anie procedury DlugoscParametrow z wykorzystaniem atrybutu %TYPE dla parametrów...
SET echo on

CREATE OR REPLACE PROCEDURE DlugoscParametrow (
  p_Parametr1 IN OUT VARCHAR2,
  p_Parametr2 IN OUT studenci.biezace_zaliczenia%TYPE) AS
BEGIN
  p_Parametr2 := 12345;
END DlugoscParametrow;
/

SET echo off
PROMPT Niepoprawne wywo³anie procedury DlugoscParametrow (ORA-6502)...
SET echo on

DECLARE
   z_Zmienna1 VARCHAR2(1); 
   -- zadeklarowanie zmiennej z_Zmienna2 bez ograniczeñ
    z_Zmienna2 NUMBER;  
  BEGIN
    -- Mimo ze parametr aktualny ma miejsce dla 12345, uwzglêdniane
    -- jest ograniczenie dla parametru formalnego i wywo³anie tej 
    -- procedury spowoduje wyst¹pienie b³êdu ORA-6502.
    DlugoscParametrow(z_Zmienna1, z_Zmienna2);
END;
/