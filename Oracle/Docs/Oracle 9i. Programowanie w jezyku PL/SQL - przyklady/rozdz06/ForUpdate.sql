REM ForUpdate.sql
REM Rozdzia� 6., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje kursor zawieraj�cy klauzul� FOR UPDATE.

DECLARE
  -- Liczba zalicze� dodawana do sumy zalicze� dla ka�dego studenta 
  z_LiczbaZaliczen  grupy.liczba_zaliczen%TYPE;

  -- Ten kursor wybierze tylko tych student�w, kt�rzy s� aktualnie 
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
  -- Ustawienie p�tli pobierania kursora.
  FOR z_DaneStudenta IN k_ZarejestrowaniStudenci LOOP
  -- Okre�lenie liczb� zalicze� dla wydzia�u Historia, kurs 101.
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

  -- Zatwierdzenie  dzia�a� i zwolnienie blokad.
  COMMIT;
END;
/
