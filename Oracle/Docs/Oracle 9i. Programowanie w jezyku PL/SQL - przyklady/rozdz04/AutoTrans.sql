REM AutoTrans.sql
REM Rozdzia³ 4., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL

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
  
  -- Wywo³anie transakcji autonomicznej, która bêdzie niezale¿na od 
  -- tej transakcji.
  Autonomiczna;
  
  -- Nawet je¿eli wycofamy transakcjê macierzyst¹, to instrukcja INSERT 
  -- wykonywana przez transakcjê autonomiczn¹ bêdzie zatwierdzona.
  ROLLBACK;
END;
/

SELECT * FROM tabela_tymcz WHERE kol_num = -10;
/
