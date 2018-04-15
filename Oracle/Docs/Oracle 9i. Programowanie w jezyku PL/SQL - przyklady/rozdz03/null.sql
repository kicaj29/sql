REM null.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje NULL jako instrukcjê.

DECLARE
  z_ZmTymcz NUMBER := 7;
BEGIN
  IF z_ZmTymcz < 5 THEN
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('Za ma³a');
  ELSIF z_ZmTymcz < 10 THEN
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('W porz¹dku');
  ELSE
    NULL;  -- Nie wykonuj ¿adnych operacji
  END IF;
END;
/

