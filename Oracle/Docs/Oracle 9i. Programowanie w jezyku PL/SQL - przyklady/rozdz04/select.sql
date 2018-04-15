REM select.sql
REM Rozdzia³ 4., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok zawiera przyk³ady 2 instrukcji SELECT.

DECLARE
  z_RekordStudenta  studenci%ROWTYPE;
  z_Wydzial         grupy.wydzial%TYPE;
  z_Kurs            grupy.kurs%TYPE;
BEGIN
  -- Pobierz jeden rekord z tabeli studenci i zachowaj w rekordzie 
  -- z_RekordStudenta. Nale¿y zwróciæ uwagê, ze klauzula WHERE 
  -- odpowiada tylko jednemu wierszowi tabeli. Nale¿y równie¿ zwróciæ 
  -- uwagê, ze zapytanie zwraca wszystkie pola w tabeli studenci 
  -- (poniewa¿ stosowany jest znak *). W ten sposób ³adowany rekord
  -- jest zdefiniowany jako studenci%ROWTYPE.
  SELECT *
    INTO z_RekordStudenta
    FROM studenci
    WHERE id = 10000;

  -- Pobierz dwa pola z tabeli grupy i zachowaj je w zmiennych 
  -- z_Wydzial oraz z_Kurs. Znowu zatem klauzula WHERE odpowiada
  -- tylko jednemu wierszowi tabeli.
  SELECT wydzial, kurs
    INTO z_Wydzial, z_Kurs
    FROM grupy
    WHERE pokoj_id = 20000;
END;
/
