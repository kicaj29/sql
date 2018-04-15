REM komentarze.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten przyk³ad demonstruje poprawne i niepoprawne komentarze.

DECLARE
  z_Wydzial    CHAR(3);
  z_Kurs       NUMBER;
BEGIN
  INSERT INTO grupy (wydzial, kurs)
    VALUES (z_Wydzial, z_Kurs);
END;
/

DECLARE
  z_Wydzial  CHAR(3);  -- Zmienna do obs³ugi 3-znakowego kodu wydzia³u
  z_Kurs     NUMBER;   -- Zmienna do obs³ugi numeru kursu 
BEGIN
  /* WprowadŸ kurs identyfikowany przez z_Wydzial i z_Kurs
  do tabeli grupy w bazie danych. */
  INSERT INTO grupy (wydzial, kurs)
    VALUES (z_Wydzial, z_Kurs);
END;
/

DECLARE
  z_Wydzial    CHAR(3);  /* Zmienna do obs³ugi 3-znakowego kodu wydzia³u */
  z_Kurs       NUMBER;  /* Zmienna do obs³ugi numeru kursu */
BEGIN
  /* WprowadŸ kurs identyfikowany przez z_Wydzial i z_Kurs
     do tabeli grupy w bazie danych. */
  INSERT INTO grupy (wydzial, kurs)
    VALUES (z_Wydzial, z_Kurs);
END;
/

BEGIN
  /* Jesteœmy teraz wewn¹trz komentarza. Gdybyœmy rozpoczêli nastêpny 
     komentarz taki jak /* ten */, by³oby to niedozwolone. */
  NULL;
END;
/
