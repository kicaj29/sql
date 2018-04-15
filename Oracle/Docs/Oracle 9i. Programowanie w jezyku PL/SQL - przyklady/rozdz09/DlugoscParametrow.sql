REM DlugoscParametrow.sql 
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt demonstruje prawid�owe i nieprawid�owe parametry formalne
REM ograniczone przez d�ugo��.

PROMPT Nierawid�owe wywo�anie procedury DlugoscParametrow (parametry ograniczone
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

PROMPT Prawid�owe wywo�anie procedury DlugoscParametrow...
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
PROMPT Prawid�owe wywo�anie procedury DlugoscParametrow...
SET echo on

DECLARE
  z_Zmienna1 VARCHAR2(40);
  z_Zmienna2 NUMBER(7,3);
BEGIN
  DlugoscParametrow(z_Zmienna1, z_Zmienna2);
END;
/

SET echo off
PROMPT Nieprawid�owe wywo�anie procedury DlugoscParametrow (ORA-6502)...
SET echo on

DECLARE
  z_Zmienna1 VARCHAR2(10);
  z_Zmienna2 NUMBER(7,3);
BEGIN
  DlugoscParametrow(z_Zmienna1, z_Zmienna2);
END;
/

SET echo off
PROMPT Wywo�anie procedury DlugoscParametrow z wykorzystaniem atrybutu %TYPE dla parametr�w...
SET echo on

CREATE OR REPLACE PROCEDURE DlugoscParametrow (
  p_Parametr1 IN OUT VARCHAR2,
  p_Parametr2 IN OUT studenci.biezace_zaliczenia%TYPE) AS
BEGIN
  p_Parametr2 := 12345;
END DlugoscParametrow;
/

SET echo off
PROMPT Niepoprawne wywo�anie procedury DlugoscParametrow (ORA-6502)...
SET echo on

DECLARE
   z_Zmienna1 VARCHAR2(1); 
   -- zadeklarowanie zmiennej z_Zmienna2 bez ogranicze�
    z_Zmienna2 NUMBER;  
  BEGIN
    -- Mimo ze parametr aktualny ma miejsce dla 12345, uwzgl�dniane
    -- jest ograniczenie dla parametru formalnego i wywo�anie tej 
    -- procedury spowoduje wyst�pienie b��du ORA-6502.
    DlugoscParametrow(z_Zmienna1, z_Zmienna2);
END;
/