REM Pseudorekordy.sql
REM Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten wyzwalacz pokazuje, ¿e :old oraz :new s¹ pseudorekordami.

set echo on

CREATE OR REPLACE TRIGGER UsunTymcz
  BEFORE DELETE ON tabela_tymcz
  FOR EACH ROW
DECLARE
  z_RekTymcz tabela_tymcz%ROWTYPE;
BEGIN
  /* To nie jest poprawne przypisanie poniewa¿ :old nie jest w³aœciwie
     rekordem. */
  z_RekTymcz := :old;

  /* Mo¿emy jednak uzyskaæ ten sam efekt przypisuj¹c wartoœci
    poszczególnych pól pojedynczo. */
  z_RekTymcz.kol_znak := :old.kol_znak;
  z_RekTymcz.kol_num := :old.kol_num;
END UsunTymcz;
/


