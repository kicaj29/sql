REM execDowiazane.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok demonstruje zastosowanie klauzuli USING razem z instrukcj¹ EXECUTE
REM IMMEDIATE do obs³ugi zmiennych dowi¹zanych.


DECLARE
  z_CiagSQL  VARCHAR2(1000);
  z_BlokPLSQL VARCHAR2(1000);

  CURSOR k_SpecEkon IS
    SELECT *
      FROM studenci
      WHERE specjalnosc = 'Ekonomia';
BEGIN
  -- Wstawienie EKN 103 do tabeli grupy, za pomoc¹ ci¹gu znaków
  -- zawieraj¹cego instrukcjê SQL.
  z_CiagSQL :=
    'INSERT INTO GRUPY (wydzial, kurs, opis,
                          maks_l_studentow, biez_l_studentow,
                          liczba_zaliczen)
       VALUES (:wydz, :kurs, :opis, :maks_ls, :biez_ls, :licz_z)';

  -- Wykonanie instrukcji INSERT za pomoc¹ wartoœci litera³ów.
  EXECUTE IMMEDIATE z_CiagSQL USING
    'EKN', 103, 'Ekonomia 103', 10, 0, 3;

  -- Zarejestrowanie wszystkich studentów Ekonomii w nowej grupie.
  FOR z_StudentRek IN k_SpecEkon LOOP
    -- Mamy tu instrukcjê SQL w postaci litera³u, ale tak¿e zmienne PL/SQL
    -- w klauzuli USING.
    EXECUTE IMMEDIATE
        'INSERT INTO zarejestrowani_studenci
           (student_ID, wydzial, kurs, ocena)
         VALUES (:id, :wydz, :kurs, NULL)'
      USING z_StudentRek.ID, 'EKN', 103;

    -- Uaktualnienie liczby studentów w grupie za pomoc¹
    -- anonimowego bloku PL/SQL.
    z_BlokPLSQL :=
      'BEGIN
         UPDATE grupy SET biez_l_studentow = biez_l_studentow + 1
         WHERE wydzial = :d and kurs = :c;
       END;';

    EXECUTE IMMEDIATE z_BlokPLSQL USING 'EKN', 103;
  END LOOP;
END;
/

ROLLBACK;
