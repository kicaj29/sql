REM Zarejestruj.sql
REM Rozdzia� 7., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ta procedura ilustruje zastosowanie funkcji RAISE_APPLICATION_ERROR.

CREATE OR REPLACE PROCEDURE Zarejestruj (

  /* Ta procedura rejestruje studenta identyfikowanego przez parametr 
     p_StudentID na zaj�ciach identyfikowanych przez parametry p_Wydzial 
     oraz p_Kurs. */

  p_StudentID IN studenci.id%TYPE,
  p_Wydzial IN grupy.wydzial%TYPE,
  p_Kurs IN grupy.kurs%TYPE) AS

  z_Biez_L_Studentow  grupy.biez_l_studentow%TYPE;
  z_Maks_L_Studentow  grupy.maks_l_studentow%TYPE;
  z_LiczZaliczen grupy.liczba_zaliczen%TYPE;
  z_Licznik NUMBER;

BEGIN
  /* Okre�lenie bie��cej liczby student�w zarejestrowanych oraz maksymalnej 
     liczby student�w mo�liwych do zarejestrowania. */
 BEGIN
  SELECT biez_l_studentow, maks_l_studentow, liczba_zaliczen
     INTO z_Biez_L_Studentow, z_Maks_L_Studentow, z_LiczZaliczen
     FROM grupy
     WHERE kurs = p_Kurs
     AND wydzial = p_Wydzial;

  /* Sprawdzenie, czy istnieje wolne miejsce dla dodatkowego studenta. */
  IF z_Biez_L_Studentow + 1 > z_Maks_L_Studentow THEN
     RAISE_APPLICATION_ERROR(-20000, 'Nie mo�na doda� wi�cej student�w na zaj�cia ' ||                
                             p_Wydzial || ' ' || p_Kurs);
  END IF;
  
  
EXCEPTION
   WHEN NO_DATA_FOUND THEN
     /* Informacja o zaj�ciach przekazana do tej procedury nie istnieje. */
     RAISE_APPLICATION_ERROR(-20001, p_Wydzial || ' ' || p_Kurs || ' nie istnieje!');
END;

/* Sprawdzenie, czy studenta nie zarejestrowano wcze�niej */
SELECT COUNT(*)
  INTO z_Licznik
  FROM zarejestrowani_studenci
  WHERE student_id = p_StudentID
  AND wydzial = p_Wydzial
  AND kurs = p_kurs;
IF z_Licznik = 1 THEN
  RAISE_APPLICATION_ERROR(-20002,
   'Student  ' || p_StudentID ||  'zosta� ju� zarejestrowany na ' || p_Wydzial || '  ' || p_Kurs);
END IF;

/* S� jeszcze miejsca i studenta nie zarejestrowano do tej pory na te zaj�cia.   
   Uaktualnienie w�a�ciwych tabel. */
INSERT INTO zarejestrowani_studenci(student_id, wydzial, kurs)
  VALUES (p_StudentID, p_Wydzial, p_Kurs);
UPDATE studenci
  SET biezace_zaliczenia = biezace_zaliczenia + z_LiczZaliczen
  WHERE ID = p_StudentID;
UPDATE grupy
  SET biez_l_studentow = biez_l_studentow + 1
  WHERE kurs = p_Kurs
  AND wydzial = p_Wydzial;
END Zarejestruj;

/

show errors

-- Ilustruje b��dy ORA-2001 oraz ORA-2002
 exec Zarejestruj(10000, 'INF', 999);
 exec Zarejestruj(10000, 'INF', 102);

--Zarejestrowanie 2 student�w na zaj�cia MUZ 410. Spowoduje to b��d ORA-2003
  exec Zarejestruj(10002, 'MUZ', 410);
  exec Zarejestruj(10005, 'MUZ', 410);

BEGIN
  RAISE NO_DATA_FOUND;
END;
/
