REM wywolaniaBiblioteka.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten plik zawiera przyk³ady wywo³añ procedur pakietu Biblioteka.

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
  -- Wypo¿yczenie lektury obowi¹zkowej dla wszystkich studentów kursu HIS 101:
 
  -- Pobranie lektury obowi¹zkowej dla kursu HIS 101
  SELECT lektury_obowiazkowe
     INTO z_LekturaObowiazkowa
     FROM grupy_materialy
     WHERE wydzial = 'HIS'
     AND kurs = 101;
 
  -- Pêtla dla studentów kursu Historia 101
  FOR z_Rek IN k_StudenciHistoria101 LOOP
    -- pêtla dla listy lektury obowi¹zkowej
    FOR z_Indeks IN 1..z_LekturaObowiazkowa.COUNT LOOP
    -- wypo¿yczenie ksi¹¿ki!
       Biblioteka.Wypozyczenie(z_LekturaObowiazkowa(z_Indeks),
                      z_Rek.student_ID);
    END LOOP;
 END LOOP;
 
   -- Wyœwietlenie studentów, którzy wypo¿yczyli ksi¹¿kê
   Biblioteka.WyswietlWypozyczone(2001);
 
   -- Zwrot ksi¹¿ek przez kilku studentów
   Biblioteka.Zwrot(2001, 10001);
   Biblioteka.Zwrot(2001, 10002);
   Biblioteka.Zwrot(2001, 10003);

   -- Ponowne wyœwietlenie studentów, którzy wypo¿yczyli ksi¹¿kê.
   Biblioteka.WyswietlWypozyczone(2001);
END;
/
