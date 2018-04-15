REM Pseudorekordy.sql
REM Rozdzia� 11., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten wyzwalacz pokazuje, �e :old oraz :new s� pseudorekordami.

set echo on

CREATE OR REPLACE TRIGGER UsunTymcz
  BEFORE DELETE ON tabela_tymcz
  FOR EACH ROW
DECLARE
  z_RekTymcz tabela_tymcz%ROWTYPE;
BEGIN
  /* To nie jest poprawne przypisanie poniewa� :old nie jest w�a�ciwie
     rekordem. */
  z_RekTymcz := :old;

  /* Mo�emy jednak uzyska� ten sam efekt przypisuj�c warto�ci
    poszczeg�lnych p�l pojedynczo. */
  z_RekTymcz.kol_znak := :old.kol_znak;
  z_RekTymcz.kol_num := :old.kol_num;
END UsunTymcz;
/


