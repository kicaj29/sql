REM null.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje NULL jako instrukcj�.

DECLARE
  z_ZmTymcz NUMBER := 7;
BEGIN
  IF z_ZmTymcz < 5 THEN
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('Za ma�a');
  ELSIF z_ZmTymcz < 10 THEN
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('W porz�dku');
  ELSE
    NULL;  -- Nie wykonuj �adnych operacji
  END IF;
END;
/

