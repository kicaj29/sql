REM PakietGrupy2.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten pakiet zawiera dodatkow� procedur� w tre�ci pakietu.

CREATE OR REPLACE PACKAGE PakietGrupy AS
  -- Dodanie nowego studenta do okre�lonej grupy.
  PROCEDURE DodajStudenta(p_StudentID  IN studenci.id%TYPE,
                          p_Wydzial     IN grupy.wydzial%TYPE, 
                          p_Kurs        IN grupy.kurs%TYPE);

  -- Usuni�cie okre�lonego studenta z grupy.
  PROCEDURE UsunStudenta (p_StudentID IN studenci.id%TYPE,
                          p_Wydzial    IN grupy.wydzial%TYPE, 
                          p_Kurs       IN grupy.kurs%TYPE);

  -- Wyj�tek zg�oszony przez procedur� UsunStudenta.
  w_StudentNiezarejestrowany EXCEPTION;

  -- Typ tabeli u�ywanej do przechowywania danych o studencie.
  TYPE t_TabelaIDStudentow IS TABLE OF studenci.id%TYPE
    INDEX BY BINARY_INTEGER;

  -- Zwraca tabel� PL/SQL zawieraj�c� student�w znajduj�cych si� 
  -- aktualnie w okre�lonej grupie.
  PROCEDURE ListaGrupy(p_Wydzial         IN  grupy.wydzial%TYPE,
                       p_Kurs            IN  grupy.kurs%TYPE,
                       p_IDs             OUT t_TabelaIDStudentow,
                       p_LiczbaStudentow IN OUT BINARY_INTEGER);
END PakietGrupy;

/

CREATE OR REPLACE PACKAGE BODY PakietGrupy AS
  -- Procedura narz�dziowa uaktualniaj�ca tabele studenci i grupy, w celu
  -- uwzgl�dnienia zmian.  Je�eli parametr p_Dodano ma warto�� TRUE, wtedy tabele
  -- s� uaktualniane w zwi�zku z dodaniem studenta do grupy.  Je�eli ma warto�� FALSE,
  -- w�wczas s� uaktualniane w celu uwzgl�dnienia usuni�cia studenta.
  PROCEDURE UaktualnijTabStudenci_I_Grupy(
    p_Dodano    IN BOOLEAN,
    p_StudentID IN studenci.id%TYPE,
    p_Wydzial IN grupy.wydzial%TYPE,
    p_Kurs     IN grupy.kurs%TYPE) IS

    -- Liczba zalicze� dla wybranej grupy
    z_LiczbaZaliczen  grupy.liczba_zaliczen%TYPE;
  BEGIN
    -- Okre�lenie liczby zalicze�.
    SELECT liczba_zaliczen
      INTO z_LiczbaZaliczen
      FROM grupy
      WHERE wydzial = p_Wydzial
      AND kurs = p_Kurs;

    IF (p_Dodano) THEN
      -- Dodanie liczby zalicze� do obci��enia student�w.
      UPDATE STUDENCI
        SET biezace_zaliczenia = biezace_zaliczenia + z_LiczbaZaliczen
        WHERE ID = p_StudentID;

      -- Zwi�kszenie warto�ci pola biez_l_studentow
      UPDATE grupy
        SET biez_l_studentow = biez_l_studentow + 1
        WHERE wydzial = p_Wydzial
        AND kurs = p_Kurs;
     ELSE
       -- Usuni�cie liczby zalicze� z_LiczbaZaliczen z obci��enia student�w
       UPDATE STUDENCI
         SET biezace_zaliczenia = biezace_zaliczenia - z_LiczbaZaliczen
         WHERE ID = p_StudentID;

       -- Zmniejszenie warto�ci pola biez_l_studentow
       UPDATE grupy
         SET biez_l_studentow = biez_l_studentow - 1
         WHERE wydzial = p_Wydzial
         AND kurs = p_Kurs;
     END IF;
  END UaktualnijTabStudenci_I_Grupy;

  -- Dodanie nowego studenta do okre�lonej grupy.
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

  -- Usuni�cie studenta z wybranej grupy.
  PROCEDURE UsunStudenta(p_StudentID  IN studenci.id%TYPE,
                          p_Wydzial IN grupy.wydzial%TYPE,
                          p_Kurs     IN grupy.kurs%TYPE) IS
  BEGIN
    DELETE FROM zarejestrowani_studenci
      WHERE student_id = p_StudentID
      AND wydzial = p_Wydzial
      AND kurs = p_Kurs;

    -- Sprawdzenie, czy operacja DELETE powiod�a si�. Je�eli 
    -- nie znaleziono wierszy do usuni�cia - zg�oszenie b��du.
      IF SQL%NOTFOUND THEN
      RAISE w_StudentNieZarejestrowany;
    END IF;

    UaktualnijTabStudenci_I_Grupy(FALSE, p_StudentID, p_Wydzial,
                                   p_Kurs);	

  END UsunStudenta;

  -- Zwraca tabel� PL/SQL zawieraj�c� student�w 
  -- przypisanych do danej grupy.
  PROCEDURE ListaGrupy(p_Wydzial  IN  grupy.wydzial%TYPE,
                      p_Kurs      IN  grupy.kurs%TYPE,
                      p_IDs         OUT t_TabelaIDStudentow,
                      p_LiczbaStudentow IN OUT BINARY_INTEGER) IS

    z_StudentID  zarejestrowani_studenci.student_id%TYPE;

    -- Lokalny kursor w celu pobrania zarejestrowanych student�w.
    CURSOR k_ZarejestrowaniStudenci IS
      SELECT student_id
        FROM zarejestrowani_studenci
        WHERE wydzial = p_Wydzial
        AND kurs = p_Kurs;
  BEGIN
    /* Parametr p_LiczbaStudentow b�dzie indeksem tabeli. Rozpoczyna si� od
     * 0 i b�dzie zwi�kszany o 1 za ka�dym wykonaniem p�tli pobierania.
     * Przy zako�czeniu wykonywania p�tli b�dzie zawiera� liczb� pobranych wierszy,
     * a zatem liczb� wierszy zwracanych w parametrze
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
