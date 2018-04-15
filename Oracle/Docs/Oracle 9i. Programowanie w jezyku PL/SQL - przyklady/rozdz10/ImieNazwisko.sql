REM ImieNazwisko.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Tê funkcjê mo¿na wywo³aæ z instrukcji SQL.

CREATE OR REPLACE FUNCTION ImieNazwisko (
  p_StudenciID  studenci.id%TYPE)
  RETURN VARCHAR2 IS

  z_Wynik  VARCHAR2(100);
BEGIN
  SELECT imie || ' ' || nazwisko
    INTO z_Wynik
    FROM studenci
    WHERE ID = p_StudenciID;

  RETURN z_Wynik;
END ImieNazwisko;
/

SELECT ID, ImieNazwisko (ID) "ImieNazwisko"
FROM studenci;

INSERT INTO tabela_tymcz (kol_znak)
     VALUES (ImieNazwisko(10010));

