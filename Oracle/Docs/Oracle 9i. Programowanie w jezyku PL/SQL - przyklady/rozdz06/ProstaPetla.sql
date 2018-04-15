REM ProstaPetla.sql
REM Rozdzia³ 6., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok demonstruje prost¹ pêtlê pobierania.

DECLARE
  -- Zadeklarowanie zmiennych do przechowywania danych dotycz¹cych studentów. 
  -- studiuj¹cych przedmiot Historia.
  z_StudentID   studenci.id%TYPE;
  z_Imie        studenci.imie%TYPE;
  z_Nazwisko    studenci.nazwisko%TYPE;

  -- Kursor do pobrania danych dotycz¹cych studentów studiuj¹cych 
  -- przedmiot Historia. 
  CURSOR k_StudenciHistorii IS
    SELECT id, imie, nazwisko
      FROM studenci
      WHERE specjalnosc = 'Historia';
BEGIN
  -- Otwarcie kursora i zainicjowanie zbioru wynikowego 
  OPEN k_StudenciHistorii;
  LOOP
    -- Pobranie danych nastêpnego studenta
    FETCH k_StudenciHistorii INTO z_StudentID, z_Imie, z_Nazwisko;

    -- Wyjœcie z pêtli kiedy nie ma wiêcej wierszy do pobrania.
    EXIT WHEN k_StudenciHistorii%NOTFOUND;

    -- Przetwarzanie pobranych wierszy. W tym przypadku zapisanie 
    -- ka¿dego studenta na kurs 301 wydzia³u Historii, wstawiaj¹c dane 
    -- studentów do tabeli zarejestrowani_studenci. Dodatkowo, wprowadzenie 
    -- imion i nazwisk do tabeli tabela_tymcz.
    INSERT INTO zarejestrowani_studenci(student_id, wydzial, kurs)
      VALUES (z_StudentID, 'HIS', 301);

    INSERT INTO tabela_tymcz (kol_num, kol_znak)
      VALUES (z_StudentID, z_Imie || ' ' || z_Nazwisko);

  END LOOP;

  -- Zwolnienie zasobów wykorzystywanych przez kursor
  CLOSE k_StudenciHistorii;
END;
/
