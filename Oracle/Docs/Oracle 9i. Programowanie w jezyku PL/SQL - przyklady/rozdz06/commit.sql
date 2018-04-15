REM commit.sql
REM Rozdzia³ 6., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok powoduje wygenerowanie b³edu "ORA-1002: fetch out of sequence" ze wzglêdu na
REM wykonanie instrukcji COMMIT wewn¹trz instrukcji SELECT..FOR UPDATE.

DECLARE
  -- Kursor do pobrania danych wszystkich studentów, jak równie¿ 
  -- do zablokowania wierszy.
  CURSOR k_WszyscyStudenci IS
    SELECT *
      FROM studenci
      FOR UPDATE;

  -- Zmienna dla pobieranych danych.
  z_DaneStudenta  k_WszyscyStudenci%ROWTYPE;
BEGIN
  -- Otwarcie kursora. Za³o¿enie blokad.
  OPEN k_WszyscyStudenci;

  -- Pobranie pierwszego rekordu.
  FETCH k_WszyscyStudenci INTO z_DaneStudenta;

  -- Wydanie instrukcji COMMIT. Spowoduje to zwolnienie blokad i uniewa¿nienie kursora.
  COMMIT;

  -- Ta instrukcja FETCH spowoduje powstanie b³êdu ORA-1002.
  FETCH k_WszyscyStudenci INTO z_DaneStudenta;
END;
/

DECLARE
  -- Liczba zaliczeñ dodawana do ³¹cznej liczby zaliczeñ dla ka¿dego studenta 
  z_LiczbaZaliczen  grupy.liczba_zaliczen%TYPE;

  -- Ten kursor wybierze tylko tych studentów, którzy s¹ aktualnie 
  -- zarejestrowani na wydziale Historia, kurs 101.   
  CURSOR k_ZarejestrowaniStudenci IS
    SELECT *
      FROM studenci
      WHERE id IN (SELECT student_id
                     FROM zarejestrowani_studenci
                     WHERE wydzial= 'HIS'
                     AND kurs = 101);

BEGIN
  -- Ustawienie pêtli pobierania kursora.
  FOR z_DaneStudenta IN k_ZarejestrowaniStudenci LOOP
  -- Okreœlenie liczby zaliczeñ dla wydzia³u Historia, kurs 101.
  SELECT liczba_zaliczen
    INTO z_LiczbaZaliczen
    FROM grupy
    WHERE wydzial = 'HIS'
    AND kurs = 101;

  -- Uaktualnienie wierszy pobranych z kursora.
  UPDATE studenci
    SET biezace_zaliczenia = biezace_zaliczenia + z_LiczbaZaliczen
    WHERE id = z_DaneStudenta.id;

  -- Mo¿na wykonaæ zatwierdzenie poleceniem COMMIT wewn¹trz pêtli, 
  -- poniewa¿ kursor nie jest zadeklarowany z klauzula FOR UPDATE.
  COMMIT;
  END LOOP;
END;
/
