REM Przeciazanie.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten pakiet zawiera przeci¹¿one podprogramy.

CREATE OR REPLACE PACKAGE PakietGrupy AS
  -- Dodanie nowego studenta do okreœlonej grupy.
  PROCEDURE DodajStudenta (p_StudentID IN studenci.id%TYPE, 
                           p_Wydzial    IN grupy.wydzial%TYPE,
                           p_Kurs       IN grupy.kurs%TYPE);
  
  -- Dodanie nowego studenta tak¿e przez podanie imienia i nazwiska 
  -- zamiast numeru identyfikatora ID.
  PROCEDURE DodajStudenta (p_Imie       IN studenci.imie%TYPE,
                           p_Nazwisko   IN studenci.nazwisko%TYPE, 
                           p_Wydzial    IN grupy.wydzial%TYPE,
                           p_Kurs       IN grupy.kurs%TYPE);

  -- Usuniêcie okreœlonego studenta z grupy.
  PROCEDURE UsunStudenta (p_StudentID IN studenci.id%TYPE,
                          p_Wydzial    IN grupy.wydzial%TYPE, 
                          p_Kurs       IN grupy.kurs%TYPE);

  -- Wyj¹tek zg³oszony przez procedurê UsunStudenta.
  w_StudentNiezarejestrowany EXCEPTION;

  -- Typ tabeli u¿ywanej do przechowywania danych o studencie.
  TYPE t_TabelaIDStudentow IS TABLE OF studenci.id%TYPE
    INDEX BY BINARY_INTEGER;

  -- Zwraca tabelê PL/SQL zawieraj¹c¹ studentów znajduj¹cych siê 
  -- aktualnie w okreœlonej grupie.
  PROCEDURE ListaGrupy(p_Wydzial         IN  grupy.wydzial%TYPE,
                       p_Kurs            IN  grupy.kurs%TYPE,
                       p_IDs             OUT t_TabelaIDStudentow,
                       p_LiczbaStudentow IN OUT BINARY_INTEGER);
END PakietGrupy;
/
show errors

CREATE OR REPLACE PACKAGE BODY PakietGrupy AS
  -- Dodanie nowego studenta do okreœlonej grupy.
  PROCEDURE DodajStudenta (p_StudentID IN studenci.id%TYPE, 
                           p_Wydzial    IN grupy.wydzial%TYPE,
                           p_Kurs       IN grupy.kurs%TYPE) IS
  BEGIN
  INSERT INTO zarejestrowani_studenci (student_id, wydzial, kurs)
    VALUES (p_StudentID, p_Wydzial, p_Kurs);
  COMMIT;
END DodajStudenta;

-- Dodanie nowego studenta przez podanie imienia i nazwiska zamiast identyfikatora ID.
PROCEDURE DodajStudenta (p_Imie       IN studenci.imie%TYPE,
                         p_Nazwisko   IN studenci.nazwisko%TYPE, 
                         p_Wydzial    IN grupy.wydzial%TYPE,
                         p_Kurs       IN grupy.kurs%TYPE) IS
  z_StudentID studenci.ID%TYPE;
BEGIN
  /* Najpierw konieczne jest uzyskanie identyfikatora ID z tabeli studenci. */
  SELECT ID
    INTO z_StudentID
    FROM studenci
    WHERE imie = p_Imie
    AND nazwisko = p_Nazwisko;
    -- Teraz mo¿na dodaæ studenta przez podanie identyfikatora ID.
    INSERT INTO zarejestrowani_studenci (student_id, wydzial, kurs)
      VALUES (z_StudentID, p_Wydzial, p_Kurs);
    COMMIT;
  END DodajStudenta;

  -- Usuwa studenta z okreœlonej grupy.
  PROCEDURE UsunStudenta(p_StudentID  IN studenci.id%TYPE,
                          p_Wydzial IN grupy.wydzial%TYPE,
                          p_Kurs     IN grupy.kurs%TYPE) IS
  BEGIN
    DELETE FROM zarejestrowani_studenci
      WHERE student_id = p_StudentID
      AND wydzial = p_Wydzial
      AND kurs = p_Kurs;

    -- Sprawdzenie, czy operacja DELETE powiod³a siê. Je¿eli 
    -- nie znaleziono wierszy do usuniêcia - zg³oszenie b³êdu.
    IF SQL%NOTFOUND THEN
      RAISE w_StudentNieZarejestrowany;
    END IF;
  END UsunStudenta;

  -- Zwraca tabelê PL/SQL zawieraj¹c¹ studentów 
  -- przypisanych do danej grupy.
  PROCEDURE ListaGrupy(p_Wydzial  IN  grupy.wydzial%TYPE,
                      p_Kurs      IN  grupy.kurs%TYPE,
                      p_IDs         OUT t_TabelaIDStudentow,
                      p_LiczbaStudentow IN OUT BINARY_INTEGER) IS

    z_StudentID  zarejestrowani_studenci.student_id%TYPE;

    -- Lokalny kursor w celu pobrania zarejestrowanych studentów.
    CURSOR k_ZarejestrowaniStudenci IS
      SELECT student_id
        FROM zarejestrowani_studenci
        WHERE wydzial = p_Wydzial
        AND kurs = p_Kurs;
  BEGIN
    /* Parametr p_LiczbaStudentow bêdzie indeksem tabeli. Rozpoczyna siê od
     * 0 i bêdzie zwiêkszany o 1 za ka¿dym wykonaniem pêtli pobierania.
     * Przy zakoñczeniu wykonywania pêtli bêdzie zawieraæ liczbê pobranych wierszy,
     * a zatem liczb¹ wierszy zwracanych w parametrze
     * p_IDs.
     */
    p_LiczbaStudentow := 0;

    OPEN k_ZarejestrowaniStudenci;
    LOOP
      FETCH k_ZarejestrowaniStudenci INTO z_StudentID;
      EXIT WHEN k_ZarejestrowaniStudenci%NOTFOUND;

      p_LiczbaStudentow := p_LiczbaStudentow + 1;
      p_IDs(p_LiczbaStudentow) := z_StudentID;
    END LOOP;
  END ListaGrupy;
END PakietGrupy;
/
show errors
