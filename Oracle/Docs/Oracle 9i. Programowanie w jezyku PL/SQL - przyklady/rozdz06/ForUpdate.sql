REM ForUpdate.sql
REM Rozdzia³ 6., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje kursor zawieraj¹cy klauzulê FOR UPDATE.

DECLARE
  -- Liczba zaliczeñ dodawana do sumy zaliczeñ dla ka¿dego studenta 
  z_LiczbaZaliczen  grupy.liczba_zaliczen%TYPE;

  -- Ten kursor wybierze tylko tych studentów, którzy s¹ aktualnie 
  -- zarejestrowani na wydziale Historia, kurs 101.   
  CURSOR k_ZarejestrowaniStudenci IS
    SELECT *
      FROM studenci
      WHERE id IN (SELECT student_id
                     FROM zarejestrowani_studenci
                     WHERE wydzial= 'HIS'
                     AND kurs = 101)
      FOR UPDATE OF biezace_zaliczenia;

BEGIN
  -- Ustawienie pêtli pobierania kursora.
  FOR z_DaneStudenta IN k_ZarejestrowaniStudenci LOOP
  -- Okreœlenie liczbê zaliczeñ dla wydzia³u Historia, kurs 101.
  SELECT liczba_zaliczen
    INTO z_LiczbaZaliczen
    FROM grupy
    WHERE wydzial = 'HIS'
    AND kurs = 101;

  -- Uaktualnienie wiersza pobranego z kursora.
  UPDATE studenci
    SET biezace_zaliczenia = biezace_zaliczenia + z_LiczbaZaliczen
    WHERE CURRENT OF k_ZarejestrowaniStudenci;
  END LOOP;

  -- Zatwierdzenie  dzia³añ i zwolnienie blokad.
  COMMIT;
END;
/
