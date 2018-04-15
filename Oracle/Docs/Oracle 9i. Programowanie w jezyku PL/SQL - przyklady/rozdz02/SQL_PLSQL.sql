REM SQL_PLSQL.sql
REM Rozdzia³ 2, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL

CREATE OR REPLACE PROCEDURE Procedura_Serwera AS
    BEGIN
      NULL;
    END Procedura_Serwera;
/

DECLARE
       z_RekordStudenta studenci%ROWTYPE;
       z_Licznik BINARY_INTEGER;
    BEGIN
      z_Licznik:=7;
  
      SELECT *
         INTO z_RekordStudenta
         FROM studenci
         WHERE id = 10001;
 
     Procedura_Serwera;
 
   END;
/

UPDATE grupy
      SET maks_l_studentow = 70
      WHERE wydzial = 'HIS'
      AND kurs = 101;

