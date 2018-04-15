REM WstawTymcz.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Tej funkcji nie mo¿na wywo³aæ z poziomu instrukcji SQL.

CREATE OR REPLACE FUNCTION WstawTymcz(
  p_Num IN tabela_tymcz.kol_num%TYPE,
  p_Znak IN tabela_tymcz.kol_znak%type)
  RETURN NUMBER AS
BEGIN
  INSERT INTO tabela_tymcz (kol_num, kol_znak)
    VALUES (p_Num, p_Znak);
  RETURN 0;
END WstawTymcz;
/

REM Niepoprawne zapytanie
SELECT WstawTymcz(1, 'Witajcie')
  FROM dual;
