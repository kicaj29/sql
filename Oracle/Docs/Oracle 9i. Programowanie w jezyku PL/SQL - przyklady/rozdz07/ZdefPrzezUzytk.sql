REM ZdefPrzezUzytk.sql
REM Rozdzia� 7., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten przyk�ad pokazuje wyj�tki zdefiniowane przez u�ytkownika.

DECLARE
-- Wyj�tek do wskazania b��du
  w_ZbytDuzoStudentow EXCEPTION;
-- Bie��ca liczba student�w zarejestrowanych na kurs HIS-101
  z_Biez_L_Studentow  NUMBER(3);     
-- Maksymalna liczba dopuszczonych student�w na kurs HIS-101
  z_Maks_L_Studentow  NUMBER(3);          
BEGIN
 /* Znajd� bie��c� liczb� student�w zarejestrowanych
         oraz maksymaln� liczb� dopuszczonych student�w. */
  SELECT biez_l_studentow, maks_l_studentow 
    INTO z_Biez_L_Studentow, z_Maks_L_Studentow
    FROM grupy
    WHERE wydzial = 'HIS' AND kurs = 101;
     /* Sprawd� liczb� student�w na tych zaj�ciach. */
  IF z_Biez_L_Studentow > z_Maks_L_Studentow THEN
     /* Za du�o student�w zarejestrowanych - zg�oszenie wyj�tku. */
    RAISE w_ZbytDuzoStudentow;
  END IF;
END;
/

DECLARE
-- Wyj�tek do wskazania b��du
  w_ZbytDuzoStudentow EXCEPTION;
-- Bie��ca liczba student�w zarejestrowanych na kurs HIS-101
  z_Biez_L_Studentow  NUMBER(3);     
-- Maksymalna liczba dopuszczonych student�w na kurs HIS-101
  z_Maks_L_Studentow  NUMBER(3);          
BEGIN
 /* Znajd� bie��c� liczb� student�w zarejestrowanych
         oraz maksymaln� liczb� dopuszczonych student�w. */
  SELECT biez_l_studentow, maks_l_studentow 
    INTO z_Biez_L_Studentow, z_Maks_L_Studentow
    FROM grupy
    WHERE wydzial = 'HIS' AND kurs = 101;
     /* Sprawd� liczb� student�w na tych zaj�ciach. */
  IF z_Biez_L_Studentow > z_Maks_L_Studentow THEN
     /* Za du�o student�w zarejestrowanych - zg�oszenie wyj�tku. */
    RAISE w_ZbytDuzoStudentow;
  END IF;
EXCEPTION
  WHEN w_ZbytDuzoStudentow THEN
     /* Program obs�ugi wykonywany jest, je�li na kurs 101 wydzia�u     
        Historia (HIS-101) zarejestrowano za du�o student�w. 
        Wprowadzimy zapis dziennika wyja�niaj�cy  
        przyczyn� b��du. */
  INSERT INTO dziennik_bledow(informacja) VALUES ('Na kursie 101 z Historii 
     jest ' || z_Biez_L_Studentow || 'student�w: maksymaln� dozwolon� 
     liczb� jest ' || z_Maks_L_Studentow);
END;
/

DECLARE
-- Wyj�tek do wskazania b��du
  w_ZbytDuzoStudentow EXCEPTION;
-- Bie��ca liczba student�w zarejestrowanych na kurs HIS-101
  z_Biez_L_Studentow  NUMBER(3);     
-- Maksymalna liczba dopuszczonych student�w na kurs HIS-101
  z_Maks_L_Studentow  NUMBER(3);          
BEGIN
 /* Znajd� bie��c� liczb� student�w zarejestrowanych
         oraz maksymaln� liczb� dopuszczonych student�w. */
  SELECT biez_l_studentow, maks_l_studentow 
    INTO z_Biez_L_Studentow, z_Maks_L_Studentow
    FROM grupy
    WHERE wydzial = 'HIS' AND kurs = 101;
     /* Sprawd� liczb� student�w na tych zaj�ciach. */
  IF z_Biez_L_Studentow > z_Maks_L_Studentow THEN
     /* Za du�o student�w zarejestrowanych - zg�oszenie wyj�tku. */
    RAISE w_ZbytDuzoStudentow;
  END IF;
EXCEPTION
  WHEN w_ZbytDuzoStudentow THEN
     /* Program obs�ugi wykonywany jest, je�li na kurs 101 wydzia�u     
        Historia (HIS-101) zarejestrowano za du�o student�w. 
        Wprowadzimy zapis dziennika wyja�niaj�cy  
        przyczyn� b��du. */
  INSERT INTO dziennik_bledow(informacja) VALUES ('Na kursie 101 z Historii 
     jest ' || z_Biez_L_Studentow || 'student�w: maksymaln� dozwolon� 
     liczb� jest ' || z_Maks_L_Studentow);
   WHEN OTHERS THEN
       /* Program obs�ugi, wykonywany dla wszystkich innych b��d�w. */
   INSERT INTO dziennik_bledow (informacja) VALUES ('Wyst�pi� inny b��d');
END; 
/

DECLARE
-- Wyj�tek do wskazania b��du
  w_ZbytDuzoStudentow EXCEPTION;
-- Bie��ca liczba student�w zarejestrowanych na kurs HIS-101
  z_Biez_L_Studentow  NUMBER(3);     
-- Maksymalna liczba dopuszczonych student�w na kurs HIS-101
  z_Maks_L_Studentow  NUMBER(3);
  z_KodBledu dziennik_bledow.kod%TYPE;
  z_KomunikatBledu dziennik_bledow.komunikat%TYPE;          
BEGIN
 /* Znajd� bie��c� liczb� student�w zarejestrowanych
         oraz maksymaln� liczb� dopuszczonych student�w. */
  SELECT biez_l_studentow, maks_l_studentow 
    INTO z_Biez_L_Studentow, z_Maks_L_Studentow
    FROM grupy
    WHERE wydzial = 'HIS' AND kurs = 101;
     /* Sprawd� liczb� student�w na tych zaj�ciach. */
  IF z_Biez_L_Studentow > z_Maks_L_Studentow THEN
     /* Za du�o student�w zarejestrowanych - zg�oszenie wyj�tku. */
    RAISE w_ZbytDuzoStudentow;
  END IF;
EXCEPTION
  WHEN w_ZbytDuzoStudentow THEN
     /* Program obs�ugi wykonywany jest, je�li na kurs 101 wydzia�u     
        Historia (HIS-101) zarejestrowano za du�o student�w. 
        Wprowadzimy zapis dziennika wyja�niaj�cy  
        przyczyn� b��du. */
  INSERT INTO dziennik_bledow(informacja) VALUES ('Na kursie 101 z Historii 
     jest ' || z_Biez_L_Studentow || 'student�w: maksymaln� dozwolon� 
     liczb� jest ' || z_Maks_L_Studentow);
   WHEN OTHERS THEN
    /* Program obs�ugi wykonywany dla wszystkich pozosta�ych b��d�w. */
    z_KodBledu := SQLCODE;
    z_KomunikatBledu := SUBSTR(SQLERRM, 1, 200);  
-- Zwr��my uwag� na zastosowanie w tym miejscu funkcji SUBSTR.
    INSERT INTO dziennik_bledow (kod, komunikat, informacja) VALUES
      (z_KodBledu, z_KomunikatBledu, 'Wyst�pi� b��d Oracle');
END;
/