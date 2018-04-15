REM WyswietlObowiazkowe.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ta procedura ilustruje spos�b tworzenia zapyta� do sk�adowanych tablic varray.

CREATE OR REPLACE PROCEDURE WyswietlObowiazkowe(
  p_Wydzial IN grupy_materialy.Wydzial%TYPE,
  p_Kurs IN grupy_materialy.Kurs%TYPE) IS
  
  z_Ksiazki grupy_materialy.lektury_obowiazkowe%TYPE;
  z_Tytul ksiazki.tytul%TYPE;
BEGIN
  -- Pobranie ca�ej tablicy varray.
  SELECT lektury_obowiazkowe
    INTO z_Ksiazki
    FROM grupy_materialy
    WHERE Wydzial = p_Wydzial
    AND Kurs = p_Kurs;

  DBMS_OUTPUT.PUT('Lektury obowi�zkowe dla kursu ' || RTRIM(p_Wydzial));
  DBMS_OUTPUT.PUT_LINE(' ' || p_Kurs || ':');

  -- P�tla dla tabeli, wy�wietlenie ka�dego wiersza.
  FOR z_Indeks IN 1..z_Ksiazki.COUNT LOOP
    SELECT tytul
      INTO z_Tytul
      FROM ksiazki
      WHERE Numer_katalogowy = z_Ksiazki(z_Indeks);
    DBMS_OUTPUT.PUT_LINE(
      '  ' || z_Ksiazki(z_Indeks) || ': ' || z_Tytul);
  END LOOP;
END WyswietlObowiazkowe;
/

DECLARE
  CURSOR k_Kursy IS
    SELECT wydzial, kurs
    FROM grupy_materialy
    ORDER BY wydzial;
BEGIN
  FOR z_Rek IN k_Kursy LOOP
     WyswietlObowiazkowe(z_Rek.wydzial, z_Rek.kurs);
  END LOOP;
END;
/
