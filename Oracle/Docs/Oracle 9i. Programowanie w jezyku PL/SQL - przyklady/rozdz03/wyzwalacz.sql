REM wyzwalacz.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM To jest przyk³ad wyzwalacza w bazie danych.

CREATE OR REPLACE TRIGGER TylkoDodatnie
  BEFORE INSERT OR UPDATE OF kol_num
  ON tabela_tymcz
  FOR EACH ROW
BEGIN
  IF :new.kol_num < 0 THEN
    RAISE_APPLICATION_ERROR(-20100, 'Proszê wstawiæ wartoœæ dodatni¹');
  END IF;
END TylkoDodatnie;
/

-- Wykonanie tej instrukcji INSERT powiedzie siê, poniewa¿ wprowadzana wartoœæ jest dodatnia
INSERT INTO tabela_tymcz(kol_num, kol_znak)
  VALUES (1, 'To jest wiersz 1');

-- To dzia³anie nie powiedzie siê, poniewa¿ wprowadzana wartoœæ jest ujemna
INSERT INTO tabela_tymcz(kol_num, kol_znak)
  VALUES (-1, 'To jest wiersz -1');
  
ROLLBACK;
