REM AutoSavePoints.sql
REM Rozdzia� 4., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL

CREATE OR REPLACE PROCEDURE AutoProc AS
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   ROLLBACK TO SAVEPOINT A;
END AutoProc;
/

BEGIN
   SAVEPOINT A;
   INSERT INTO tabela_tymcz (kol_znak)
     VALUES  ('Punkt zachowania A!');
   -- Chocia� A jest poprawnym punktem zachowania wewn�trz transakcji
   -- macierzystej, to jednak nie jest poprawny w transakcji autonomicznej.
   -- Spowoduje to powstanie b��du.
   AutoProc;
END;
/

