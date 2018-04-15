REM KaskadaZSInsert.sql
REM Rozdzia� 11., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten wyzwalacz powoduje kaskadowe operacje INSERT do tabel
REM grupy i studenci po wykonaniu operacji INSERT do tabeli zarejestrowani_studenci.

CREATE OR REPLACE TRIGGER KaskadaZSInsert
  /* Utrzymuje w synchronizacji tabele zarejestrowani_studenci, 
     studenci i grupy. */
  BEFORE INSERT ON zarejestrowani_studenci
  FOR EACH ROW
DECLARE
  z_Zaliczenia grupy.liczba_zaliczen%TYPE;
BEGIN
  -- Sprawdzenie liczby zalicze� dla tej grupy.
  SELECT liczba_zaliczen
    INTO z_Zaliczenia
    FROM grupy
    WHERE wydzial = :new.wydzial
    AND kurs = :new.kurs;

  -- Modyfikacja bie��cych zalicze� dla tego studenta.
  UPDATE studenci
    SET biezace_zaliczenia = biezace_zaliczenia + z_Zaliczenia
    WHERE ID = :new.student_id;

  -- Dodaj jeden do liczby student�w w grupie.
  UPDATE grupy
    SET biez_l_studentow = biez_l_studentow + 1
    WHERE wydzial = :new.wydzial
    AND kurs = :new.kurs;
END KaskadaZSInsert;
/