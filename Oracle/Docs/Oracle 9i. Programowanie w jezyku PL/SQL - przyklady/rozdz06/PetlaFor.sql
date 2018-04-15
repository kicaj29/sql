REM PetlaFor.sql
REM Rozdzia� 6., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok demonstruje p�tl� FOR kursora.

DECLARE
  -- Kursor do pobrania danych dotycz�cych student�w studiuj�cych Histori�
  CURSOR k_StudenciHistorii IS
    SELECT id, imie, nazwisko
      FROM studenci
      WHERE specjalnosc = 'Historia';
BEGIN
  -- Rozpocz�cie wykonywania petli. Tutaj wykonana jest niejawna 
  -- instrukcja OPEN kursora k_StudenciHistorii.
  FOR z_DaneStudenta IN k_StudenciHistorii LOOP
    -- Tutaj wykonana jest niejawna instrukcja FETCH.
    -- Przetwarzanie pobranych wierszy. W tym przypadku zapisanie 
    -- ka�dego studenta na kurs 301 wydzia� Historii, wstawiaj�c dane 
    -- student�w do tabeli zarejestrowani_studenci. Dodatkowo wprowadzenie 
    -- imion i nazwisk do tabeli tabela_tymcz.
    INSERT INTO zarejestrowani_studenci(student_id, wydzial, kurs)
      VALUES (z_DaneStudenta.ID, 'HIS', 301);

    INSERT INTO tabela_tymcz (kol_num, kol_znak)
      VALUES (z_DaneStudenta.ID,
              z_DaneStudenta.imie || ' ' || z_DaneStudenta.nazwisko);

    -- Przed dalszym wykonywaniem p�tli b�dzie niejawnie sprawdzony 
    -- atrybut kursora k_StudenciHistorii%NOTFOUND.
  END LOOP;
  -- Teraz, kiedy dzia�anie p�tli jest zako�czone, wykonana b�dzie 
  -- niejawna instrukcja CLOSE kursora k_StudenciHistorii.
END;
/
