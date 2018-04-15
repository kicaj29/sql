REM ZdefPrzezUzytk.sql
REM Rozdzia³ 7., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten przyk³ad pokazuje wyj¹tki zdefiniowane przez u¿ytkownika.

DECLARE
-- Wyj¹tek do wskazania b³êdu
  w_ZbytDuzoStudentow EXCEPTION;
-- Bie¿¹ca liczba studentów zarejestrowanych na kurs HIS-101
  z_Biez_L_Studentow  NUMBER(3);     
-- Maksymalna liczba dopuszczonych studentów na kurs HIS-101
  z_Maks_L_Studentow  NUMBER(3);          
BEGIN
 /* ZnajdŸ bie¿¹c¹ liczbê studentów zarejestrowanych
         oraz maksymaln¹ liczbê dopuszczonych studentów. */
  SELECT biez_l_studentow, maks_l_studentow 
    INTO z_Biez_L_Studentow, z_Maks_L_Studentow
    FROM grupy
    WHERE wydzial = 'HIS' AND kurs = 101;
     /* SprawdŸ liczbê studentów na tych zajêciach. */
  IF z_Biez_L_Studentow > z_Maks_L_Studentow THEN
     /* Za du¿o studentów zarejestrowanych - zg³oszenie wyj¹tku. */
    RAISE w_ZbytDuzoStudentow;
  END IF;
END;
/

DECLARE
-- Wyj¹tek do wskazania b³êdu
  w_ZbytDuzoStudentow EXCEPTION;
-- Bie¿¹ca liczba studentów zarejestrowanych na kurs HIS-101
  z_Biez_L_Studentow  NUMBER(3);     
-- Maksymalna liczba dopuszczonych studentów na kurs HIS-101
  z_Maks_L_Studentow  NUMBER(3);          
BEGIN
 /* ZnajdŸ bie¿¹c¹ liczbê studentów zarejestrowanych
         oraz maksymaln¹ liczbê dopuszczonych studentów. */
  SELECT biez_l_studentow, maks_l_studentow 
    INTO z_Biez_L_Studentow, z_Maks_L_Studentow
    FROM grupy
    WHERE wydzial = 'HIS' AND kurs = 101;
     /* SprawdŸ liczbê studentów na tych zajêciach. */
  IF z_Biez_L_Studentow > z_Maks_L_Studentow THEN
     /* Za du¿o studentów zarejestrowanych - zg³oszenie wyj¹tku. */
    RAISE w_ZbytDuzoStudentow;
  END IF;
EXCEPTION
  WHEN w_ZbytDuzoStudentow THEN
     /* Program obs³ugi wykonywany jest, jeœli na kurs 101 wydzia³u     
        Historia (HIS-101) zarejestrowano za du¿o studentów. 
        Wprowadzimy zapis dziennika wyjaœniaj¹cy  
        przyczynê b³êdu. */
  INSERT INTO dziennik_bledow(informacja) VALUES ('Na kursie 101 z Historii 
     jest ' || z_Biez_L_Studentow || 'studentów: maksymaln¹ dozwolon¹ 
     liczb¹ jest ' || z_Maks_L_Studentow);
END;
/

DECLARE
-- Wyj¹tek do wskazania b³êdu
  w_ZbytDuzoStudentow EXCEPTION;
-- Bie¿¹ca liczba studentów zarejestrowanych na kurs HIS-101
  z_Biez_L_Studentow  NUMBER(3);     
-- Maksymalna liczba dopuszczonych studentów na kurs HIS-101
  z_Maks_L_Studentow  NUMBER(3);          
BEGIN
 /* ZnajdŸ bie¿¹c¹ liczbê studentów zarejestrowanych
         oraz maksymaln¹ liczbê dopuszczonych studentów. */
  SELECT biez_l_studentow, maks_l_studentow 
    INTO z_Biez_L_Studentow, z_Maks_L_Studentow
    FROM grupy
    WHERE wydzial = 'HIS' AND kurs = 101;
     /* SprawdŸ liczbê studentów na tych zajêciach. */
  IF z_Biez_L_Studentow > z_Maks_L_Studentow THEN
     /* Za du¿o studentów zarejestrowanych - zg³oszenie wyj¹tku. */
    RAISE w_ZbytDuzoStudentow;
  END IF;
EXCEPTION
  WHEN w_ZbytDuzoStudentow THEN
     /* Program obs³ugi wykonywany jest, jeœli na kurs 101 wydzia³u     
        Historia (HIS-101) zarejestrowano za du¿o studentów. 
        Wprowadzimy zapis dziennika wyjaœniaj¹cy  
        przyczynê b³êdu. */
  INSERT INTO dziennik_bledow(informacja) VALUES ('Na kursie 101 z Historii 
     jest ' || z_Biez_L_Studentow || 'studentów: maksymaln¹ dozwolon¹ 
     liczb¹ jest ' || z_Maks_L_Studentow);
   WHEN OTHERS THEN
       /* Program obs³ugi, wykonywany dla wszystkich innych b³êdów. */
   INSERT INTO dziennik_bledow (informacja) VALUES ('Wyst¹pi³ inny b³¹d');
END; 
/

DECLARE
-- Wyj¹tek do wskazania b³êdu
  w_ZbytDuzoStudentow EXCEPTION;
-- Bie¿¹ca liczba studentów zarejestrowanych na kurs HIS-101
  z_Biez_L_Studentow  NUMBER(3);     
-- Maksymalna liczba dopuszczonych studentów na kurs HIS-101
  z_Maks_L_Studentow  NUMBER(3);
  z_KodBledu dziennik_bledow.kod%TYPE;
  z_KomunikatBledu dziennik_bledow.komunikat%TYPE;          
BEGIN
 /* ZnajdŸ bie¿¹c¹ liczbê studentów zarejestrowanych
         oraz maksymaln¹ liczbê dopuszczonych studentów. */
  SELECT biez_l_studentow, maks_l_studentow 
    INTO z_Biez_L_Studentow, z_Maks_L_Studentow
    FROM grupy
    WHERE wydzial = 'HIS' AND kurs = 101;
     /* SprawdŸ liczbê studentów na tych zajêciach. */
  IF z_Biez_L_Studentow > z_Maks_L_Studentow THEN
     /* Za du¿o studentów zarejestrowanych - zg³oszenie wyj¹tku. */
    RAISE w_ZbytDuzoStudentow;
  END IF;
EXCEPTION
  WHEN w_ZbytDuzoStudentow THEN
     /* Program obs³ugi wykonywany jest, jeœli na kurs 101 wydzia³u     
        Historia (HIS-101) zarejestrowano za du¿o studentów. 
        Wprowadzimy zapis dziennika wyjaœniaj¹cy  
        przyczynê b³êdu. */
  INSERT INTO dziennik_bledow(informacja) VALUES ('Na kursie 101 z Historii 
     jest ' || z_Biez_L_Studentow || 'studentów: maksymaln¹ dozwolon¹ 
     liczb¹ jest ' || z_Maks_L_Studentow);
   WHEN OTHERS THEN
    /* Program obs³ugi wykonywany dla wszystkich pozosta³ych b³êdów. */
    z_KodBledu := SQLCODE;
    z_KomunikatBledu := SUBSTR(SQLERRM, 1, 200);  
-- Zwróæmy uwagê na zastosowanie w tym miejscu funkcji SUBSTR.
    INSERT INTO dziennik_bledow (kod, komunikat, informacja) VALUES
      (z_KodBledu, z_KomunikatBledu, 'Wyst¹pi³ b³¹d Oracle');
END;
/