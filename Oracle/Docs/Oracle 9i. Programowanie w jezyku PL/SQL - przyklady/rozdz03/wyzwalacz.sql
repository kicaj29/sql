REM wyzwalacz.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM To jest przyk�ad wyzwalacza w bazie danych.

CREATE OR REPLACE TRIGGER TylkoDodatnie
  BEFORE INSERT OR UPDATE OF kol_num
  ON tabela_tymcz
  FOR EACH ROW
BEGIN
  IF :new.kol_num < 0 THEN
    RAISE_APPLICATION_ERROR(-20100, 'Prosz� wstawi� warto�� dodatni�');
  END IF;
END TylkoDodatnie;
/

-- Wykonanie tej instrukcji INSERT powiedzie si�, poniewa� wprowadzana warto�� jest dodatnia
INSERT INTO tabela_tymcz(kol_num, kol_znak)
  VALUES (1, 'To jest wiersz 1');

-- To dzia�anie nie powiedzie si�, poniewa� wprowadzana warto�� jest ujemna
INSERT INTO tabela_tymcz(kol_num, kol_znak)
  VALUES (-1, 'To jest wiersz -1');
  
ROLLBACK;
