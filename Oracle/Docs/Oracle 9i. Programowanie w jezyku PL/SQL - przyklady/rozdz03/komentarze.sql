REM komentarze.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten przyk�ad demonstruje poprawne i niepoprawne komentarze.

DECLARE
  z_Wydzial    CHAR(3);
  z_Kurs       NUMBER;
BEGIN
  INSERT INTO grupy (wydzial, kurs)
    VALUES (z_Wydzial, z_Kurs);
END;
/

DECLARE
  z_Wydzial  CHAR(3);  -- Zmienna do obs�ugi 3-znakowego kodu wydzia�u
  z_Kurs     NUMBER;   -- Zmienna do obs�ugi numeru kursu 
BEGIN
  /* Wprowad� kurs identyfikowany przez z_Wydzial i z_Kurs
  do tabeli grupy w bazie danych. */
  INSERT INTO grupy (wydzial, kurs)
    VALUES (z_Wydzial, z_Kurs);
END;
/

DECLARE
  z_Wydzial    CHAR(3);  /* Zmienna do obs�ugi 3-znakowego kodu wydzia�u */
  z_Kurs       NUMBER;  /* Zmienna do obs�ugi numeru kursu */
BEGIN
  /* Wprowad� kurs identyfikowany przez z_Wydzial i z_Kurs
     do tabeli grupy w bazie danych. */
  INSERT INTO grupy (wydzial, kurs)
    VALUES (z_Wydzial, z_Kurs);
END;
/

BEGIN
  /* Jeste�my teraz wewn�trz komentarza. Gdyby�my rozpocz�li nast�pny 
     komentarz taki jak /* ten */, by�oby to niedozwolone. */
  NULL;
END;
/
