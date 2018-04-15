REM Mutujace.sql
REM Rozdzia� 11., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt pokazuje w jaki spos�b unikn�� b��du tabeli mutuj�cej.

CREATE OR REPLACE PACKAGE DaneStudenta AS
  TYPE t_Specjalnosci IS TABLE OF studenci.specjalnosc%TYPE
    INDEX BY BINARY_INTEGER;
  TYPE t_ID IS TABLE OF studenci.ID%TYPE
    INDEX BY BINARY_INTEGER;

  z_SpecjalnosciStudentow t_Specjalnosci;
  z_IDStudentow    t_ID;
  z_LiczbaZapisow  BINARY_INTEGER := 0;
END DaneStudenta;
/

PROMPT Wyzwalacz WOgraniczSpec...

CREATE OR REPLACE TRIGGER WOgraniczSpec
  BEFORE INSERT OR UPDATE OF specjalnosc ON studenci
  FOR EACH ROW
BEGIN
  /* Zarejestrowanie nowych danych w pakiecie DaneStudenta. Nie dokonuje si� zmian
     w tabeli studenci w celu unikni�cia b��du ORA-4091. */
  DaneStudenta.z_LiczbaZapisow := DaneStudenta.z_LiczbaZapisow + 1;
  DaneStudenta.z_SpecjalnosciStudentow(DaneStudenta.z_LiczbaZapisow) :=
    :new.specjalnosc;
  DaneStudenta.z_IDStudentow(DaneStudenta.z_LiczbaZapisow) := :new.id;
END WOgraniczSpec;
/

PROMPT Wyzwalacz IOgraniczSpec...

CREATE OR REPLACE TRIGGER IOgraniczSpec
  AFTER INSERT OR UPDATE OF specjalnosc ON studenci
DECLARE
  z_Maks_l_Studentow   CONSTANT NUMBER := 5;
  z_Biez_l_Studentow   NUMBER;
  z_StudentID          studenci.ID%TYPE;
  z_Specjalnosc        studenci.specjalnosc%TYPE;
BEGIN
  /* P�tla dla ka�dego studenta, kt�rego dane wprowadzono do bazy lub je uaktualniono
     i sprawdzenie, czy nie przekroczono limitu. */
  FOR z_IndeksPetli IN 1..DaneStudenta.z_LiczbaZapisow LOOP
    z_StudentID := DaneStudenta.z_IDStudentow(z_IndeksPetli);
    z_Specjalnosc := DaneStudenta.z_SpecjalnosciStudentow(z_IndeksPetli);

    -- Okre�lenie bie��cej liczby student�w w tej specjalno�ci.
    SELECT COUNT(*)
      INTO z_Biez_l_Studentow
      FROM studenci
      WHERE specjalnosc = z_Specjalnosc;

    -- Je�eli nie ma miejsc - zg�oszenie b��du.
    IF z_Biez_l_Studentow > z_Maks_l_Studentow THEN
      RAISE_APPLICATION_ERROR(-20000,
        'Za du�o student�w w specjalno�ci ' || z_Specjalnosc ||
        ' z powodu studenta ' || z_StudentID);
    END IF;
  END LOOP;

  -- Wyzerowanie licznika tak, aby przy nast�pnym wykonaniu wykorzystywano nowe dane.
  DaneStudenta.z_LiczbaZapisow := 0;
END IOgraniczSpec;
/

UPDATE studenci
  SET specjalnosc = 'Historia'
  WHERE ID = 10003;

UPDATE studenci
  SET specjalnosc = 'Historia'
  WHERE ID = 10002;

UPDATE studenci
  SET specjalnosc = 'Historia'
  WHERE ID = 10009;
