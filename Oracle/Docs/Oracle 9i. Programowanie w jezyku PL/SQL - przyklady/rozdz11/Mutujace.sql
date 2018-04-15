REM Mutujace.sql
REM Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt pokazuje w jaki sposób unikn¹æ b³êdu tabeli mutuj¹cej.

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
  /* Zarejestrowanie nowych danych w pakiecie DaneStudenta. Nie dokonuje siê zmian
     w tabeli studenci w celu unikniêcia b³êdu ORA-4091. */
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
  /* Pêtla dla ka¿dego studenta, którego dane wprowadzono do bazy lub je uaktualniono
     i sprawdzenie, czy nie przekroczono limitu. */
  FOR z_IndeksPetli IN 1..DaneStudenta.z_LiczbaZapisow LOOP
    z_StudentID := DaneStudenta.z_IDStudentow(z_IndeksPetli);
    z_Specjalnosc := DaneStudenta.z_SpecjalnosciStudentow(z_IndeksPetli);

    -- Okreœlenie bie¿¹cej liczby studentów w tej specjalnoœci.
    SELECT COUNT(*)
      INTO z_Biez_l_Studentow
      FROM studenci
      WHERE specjalnosc = z_Specjalnosc;

    -- Je¿eli nie ma miejsc - zg³oszenie b³êdu.
    IF z_Biez_l_Studentow > z_Maks_l_Studentow THEN
      RAISE_APPLICATION_ERROR(-20000,
        'Za du¿o studentów w specjalnoœci ' || z_Specjalnosc ||
        ' z powodu studenta ' || z_StudentID);
    END IF;
  END LOOP;

  -- Wyzerowanie licznika tak, aby przy nastêpnym wykonaniu wykorzystywano nowe dane.
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
