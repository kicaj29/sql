REM NiejawnyFOR.sql
REM Rozdzia� 6., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok demonstruje niejawn� instrukcj� FOR.

BEGIN
  -- Rozpocz�cie p�tli. Niejawne wykonanie instrukcji OPEN.
  FOR z_DaneStudenta IN (SELECT id, imie, nazwisko
                          FROM studenci
                          WHERE specjalnosc = 'Historia') LOOP
    -- Niejawne wykonanie instrukcji FETCH  i sprawdzenie atrybutu %NOTFOUND

    -- Przetwarzanie pobranych wierszy, w tym przypadku zapisanie ka�dego
    -- studenta na kurs 301 wydzia�u Historii poprzez wprowadzenie ich do 
    -- tabeli zarejestrowani_studenci. Dodatkowo zapisanie imion i nazwisk
    -- student�w do tabeli tabela_tymcz.
    INSERT INTO zarejestrowani_studenci (student_id, wydzial, kurs)
      VALUES (z_DaneStudenta.ID, 'HIS', 301);

    INSERT INTO tabela_tymcz (kol_num, kol_znak)
      VALUES (z_DaneStudenta.ID,
              z_DaneStudenta.imie || ' ' || z_DaneStudenta.nazwisko);
  END LOOP;
  -- Teraz, po zako�czeniu p�tli niejawnie wykonywana jest instrukcja CLOSE.
END;
/
