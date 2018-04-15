REM wywolaniaBiblioteka.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten plik zawiera przyk�ady wywo�a� procedur pakietu Biblioteka.

BEGIN
   Biblioteka.WyswietlWypozyczone(1000);
END;
/

DECLARE
   CURSOR k_StudenciHistoria101 IS
   SELECT student_ID
      FROM zarejestrowani_studenci
      WHERE wydzial = 'HIS'
      AND kurs = 101;
   z_LekturaObowiazkowa grupy_materialy.lektury_obowiazkowe%TYPE;
BEGIN
  -- Wypo�yczenie lektury obowi�zkowej dla wszystkich student�w kursu HIS 101:
 
  -- Pobranie lektury obowi�zkowej dla kursu HIS 101
  SELECT lektury_obowiazkowe
     INTO z_LekturaObowiazkowa
     FROM grupy_materialy
     WHERE wydzial = 'HIS'
     AND kurs = 101;
 
  -- P�tla dla student�w kursu Historia 101
  FOR z_Rek IN k_StudenciHistoria101 LOOP
    -- p�tla dla listy lektury obowi�zkowej
    FOR z_Indeks IN 1..z_LekturaObowiazkowa.COUNT LOOP
    -- wypo�yczenie ksi��ki!
       Biblioteka.Wypozyczenie(z_LekturaObowiazkowa(z_Indeks),
                      z_Rek.student_ID);
    END LOOP;
 END LOOP;
 
   -- Wy�wietlenie student�w, kt�rzy wypo�yczyli ksi��k�
   Biblioteka.WyswietlWypozyczone(2001);
 
   -- Zwrot ksi��ek przez kilku student�w
   Biblioteka.Zwrot(2001, 10001);
   Biblioteka.Zwrot(2001, 10002);
   Biblioteka.Zwrot(2001, 10003);

   -- Ponowne wy�wietlenie student�w, kt�rzy wypo�yczyli ksi��k�.
   Biblioteka.WyswietlWypozyczone(2001);
END;
/
