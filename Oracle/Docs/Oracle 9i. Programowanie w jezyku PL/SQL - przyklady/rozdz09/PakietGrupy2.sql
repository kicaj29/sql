REM PakietGrupy2.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten pakiet zawiera dodatkow¹ procedurê w treœci pakietu.

CREATE OR REPLACE PACKAGE PakietGrupy AS
  -- Dodanie nowego studenta do okreœlonej grupy.
  PROCEDURE DodajStudenta(p_StudentID  IN studenci.id%TYPE,
                          p_Wydzial     IN grupy.wydzial%TYPE, 
                          p_Kurs        IN grupy.kurs%TYPE);

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

CREATE OR REPLACE PACKAGE BODY PakietGrupy AS
  -- Procedura narzêdziowa uaktualniaj¹ca tabele studenci i grupy, w celu
  -- uwzglêdnienia zmian.  Je¿eli parametr p_Dodano ma wartoœæ TRUE, wtedy tabele
  -- s¹ uaktualniane w zwi¹zku z dodaniem studenta do grupy.  Je¿eli ma wartoœæ FALSE,
  -- wówczas s¹ uaktualniane w celu uwzglêdnienia usuniêcia studenta.
  PROCEDURE UaktualnijTabStudenci_I_Grupy(
    p_Dodano    IN BOOLEAN,
    p_StudentID IN studenci.id%TYPE,
    p_Wydzial IN grupy.wydzial%TYPE,
    p_Kurs     IN grupy.kurs%TYPE) IS

    -- Liczba zaliczeñ dla wybranej grupy
    z_LiczbaZaliczen  grupy.liczba_zaliczen%TYPE;
  BEGIN
    -- Okreœlenie liczby zaliczeñ.
    SELECT liczba_zaliczen
      INTO z_LiczbaZaliczen
      FROM grupy
      WHERE wydzial = p_Wydzial
      AND kurs = p_Kurs;

    IF (p_Dodano) THEN
      -- Dodanie liczby zaliczeñ do obci¹¿enia studentów.
      UPDATE STUDENCI
        SET biezace_zaliczenia = biezace_zaliczenia + z_LiczbaZaliczen
        WHERE ID = p_StudentID;

      -- Zwiêkszenie wartoœci pola biez_l_studentow
      UPDATE grupy
        SET biez_l_studentow = biez_l_studentow + 1
        WHERE wydzial = p_Wydzial
        AND kurs = p_Kurs;
     ELSE
       -- Usuniêcie liczby zaliczeñ z_LiczbaZaliczen z obci¹¿enia studentów
       UPDATE STUDENCI
         SET biezace_zaliczenia = biezace_zaliczenia - z_LiczbaZaliczen
         WHERE ID = p_StudentID;

       -- Zmniejszenie wartoœci pola biez_l_studentow
       UPDATE grupy
         SET biez_l_studentow = biez_l_studentow - 1
         WHERE wydzial = p_Wydzial
         AND kurs = p_Kurs;
     END IF;
  END UaktualnijTabStudenci_I_Grupy;

  -- Dodanie nowego studenta do okreœlonej grupy.
  PROCEDURE DodajStudenta(p_StudentID  IN studenci.id%TYPE,
                          p_Wydzial     IN grupy.wydzial%TYPE, 
                          p_Kurs        IN grupy.kurs%TYPE)
 IS
  BEGIN
    INSERT INTO zarejestrowani_studenci (student_id, wydzial, kurs)
      VALUES (p_StudentID, p_Wydzial, p_Kurs);

    UaktualnijTabStudenci_I_Grupy(TRUE, p_StudentID, p_Wydzial,
                                   p_Kurs);
  END DodajStudenta;

  -- Usuniêcie studenta z wybranej grupy.
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

    UaktualnijTabStudenci_I_Grupy(FALSE, p_StudentID, p_Wydzial,
                                   p_Kurs);	

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
