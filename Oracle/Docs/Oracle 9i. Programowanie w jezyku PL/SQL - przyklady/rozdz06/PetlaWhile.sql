REM PetlaWhile.sql
REM Rozdzia� 6., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje p�tl� pobierania kursora WHILE.

DECLARE
  -- Kursor do pobrania danych dotycz�cych student�w studiuj�cych specjalno�� Historia. 
  CURSOR k_StudenciHistorii IS
    SELECT id, imie, nazwisko
      FROM studenci
      WHERE specjalnosc = 'Historia';

  -- Zadeklarowanie rekordu do przechowywania pobranych danych.
  z_DaneStudentow  k_StudenciHistorii%ROWTYPE;
BEGIN
  -- Otwarcie kursora i zainicjowanie zbioru wynikowego 
  OPEN k_StudenciHistorii;

  -- Pobierz pierwszy wiersz do wykonania p�tli WHILE 
  FETCH k_StudenciHistorii INTO z_DaneStudentow;
  -- Kontynuacja wykonywania p�tli do momentu, kiedy nie b�dzie wierszy do pobrania
  WHILE k_StudenciHistorii%FOUND LOOP
    -- Przetwarzanie pobranych wierszy. W tym przypadku zapisanie 
    -- ka�dego studenta na kurs 301 wydzia�u Historii, wstawiaj�c dane 
    -- student�w do tabeli zarejestrowani_studenci. Dodatkowo wprowadzenie 
    -- imion i nazwisk do tabeli tabela_tymcz.
    INSERT INTO zarejestrowani_studenci(student_id, wydzial, kurs)
      VALUES (z_DaneStudentow.id, 'HIS', 301);

    INSERT INTO tabela_tymcz (kol_num, kol_znak)
      VALUES (z_DaneStudentow.ID, 
              z_DaneStudentow.imie || ' ' || z_DaneStudentow.nazwisko);

    -- Pobranie nast�pnego wiersza. Przed dalszym wykonywaniem p�tli 
    -- b�dzie sprawdzony warunek atrybutu %FOUND. 
    FETCH k_StudenciHistorii INTO z_DaneStudentow;
  END LOOP;

  -- Zwolnienie zasob�w wykorzystywanych przez kursor
  CLOSE k_StudenciHistorii;
END;
/
