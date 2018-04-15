REM AutoTrans.sql
REM Rozdzia� 4., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL

CREATE OR REPLACE PROCEDURE Autonomiczna AS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  INSERT INTO tabela_tymcz VALUES (-10, 'Pozdrowienia od transakcji autonomicznej!');
  COMMIT;
END Autonomiczna;
/


BEGIN
  -- Wstawienie wierszy do tabeli tabela_tymcz z transakcji macierzystej
  INSERT INTO tabela_tymcz VALUES (-10, 'Pozdrowienia od transakcji macierzystej!');
  
  -- Wywo�anie transakcji autonomicznej, kt�ra b�dzie niezale�na od 
  -- tej transakcji.
  Autonomiczna;
  
  -- Nawet je�eli wycofamy transakcj� macierzyst�, to instrukcja INSERT 
  -- wykonywana przez transakcj� autonomiczn� b�dzie zatwierdzona.
  ROLLBACK;
END;
/

SELECT * FROM tabela_tymcz WHERE kol_num = -10;
/
