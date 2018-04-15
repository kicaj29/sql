REM commit.sql
REM Rozdzia� 6., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok powoduje wygenerowanie b�edu "ORA-1002: fetch out of sequence" ze wzgl�du na
REM wykonanie instrukcji COMMIT wewn�trz instrukcji SELECT..FOR UPDATE.

DECLARE
  -- Kursor do pobrania danych wszystkich student�w, jak r�wnie� 
  -- do zablokowania wierszy.
  CURSOR k_WszyscyStudenci IS
    SELECT *
      FROM studenci
      FOR UPDATE;

  -- Zmienna dla pobieranych danych.
  z_DaneStudenta  k_WszyscyStudenci%ROWTYPE;
BEGIN
  -- Otwarcie kursora. Za�o�enie blokad.
  OPEN k_WszyscyStudenci;

  -- Pobranie pierwszego rekordu.
  FETCH k_WszyscyStudenci INTO z_DaneStudenta;

  -- Wydanie instrukcji COMMIT. Spowoduje to zwolnienie blokad i uniewa�nienie kursora.
  COMMIT;

  -- Ta instrukcja FETCH spowoduje powstanie b��du ORA-1002.
  FETCH k_WszyscyStudenci INTO z_DaneStudenta;
END;
/

DECLARE
  -- Liczba zalicze� dodawana do ��cznej liczby zalicze� dla ka�dego studenta 
  z_LiczbaZaliczen  grupy.liczba_zaliczen%TYPE;

  -- Ten kursor wybierze tylko tych student�w, kt�rzy s� aktualnie 
  -- zarejestrowani na wydziale Historia, kurs 101.   
  CURSOR k_ZarejestrowaniStudenci IS
    SELECT *
      FROM studenci
      WHERE id IN (SELECT student_id
                     FROM zarejestrowani_studenci
                     WHERE wydzial= 'HIS'
                     AND kurs = 101);

BEGIN
  -- Ustawienie p�tli pobierania kursora.
  FOR z_DaneStudenta IN k_ZarejestrowaniStudenci LOOP
  -- Okre�lenie liczby zalicze� dla wydzia�u Historia, kurs 101.
  SELECT liczba_zaliczen
    INTO z_LiczbaZaliczen
    FROM grupy
    WHERE wydzial = 'HIS'
    AND kurs = 101;

  -- Uaktualnienie wierszy pobranych z kursora.
  UPDATE studenci
    SET biezace_zaliczenia = biezace_zaliczenia + z_LiczbaZaliczen
    WHERE id = z_DaneStudenta.id;

  -- Mo�na wykona� zatwierdzenie poleceniem COMMIT wewn�trz p�tli, 
  -- poniewa� kursor nie jest zadeklarowany z klauzula FOR UPDATE.
  COMMIT;
  END LOOP;
END;
/
