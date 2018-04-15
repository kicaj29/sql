REM TrwaloscPakietu2.sql
REM Rozdzia� 10., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten pakiet jest przeznaczony do seryjnego wykorzystywania.

CREATE OR REPLACE PACKAGE TrwaloscPakietu AS
   PRAGMA SERIALLY_REUSABLE;
  -- Typ s�u��cy do zapisania tablicy identyfikator�w student�w.
  TYPE t_TabelaStudentow IS TABLE OF studenci.ID%TYPE
    INDEX BY BINARY_INTEGER;
  -- Maksymalna liczba wierszy, kt�ra b�dzie zwr�cona za ka�dym razem.
  z_Maks_L_Wierszy NUMBER := 5;

  -- Procedura zwraca do z_Maks_L_Wierszy identyfikator�w student�w.
  PROCEDURE CzytajStudentow(p_TabelaStud OUT t_TabelaStudentow,
                         p_LiczWierszy   OUT NUMBER);

END TrwaloscPakietu;
/

CREATE OR REPLACE PACKAGE BODY TrwaloscPakietu AS
   PRAGMA SERIALLY_REUSABLE;

  -- Zapytanie do tabeli studenci.  Pomimo tego, �e jest ono globalne w stosunku do 
  -- tre�ci pakietu, b�dzie zresetowane po ka�dym odwo�aniu do bazy danych, poniewa� 
  -- pakiet ten zosta� teraz oznaczony do seryjnego wykorzystania.

  CURSOR KursorStudentow IS
    SELECT ID
      FROM studenci
      ORDER BY nazwisko;

  PROCEDURE CzytajStudentow(p_TabelaStud OUT t_TabelaStudentow,
                         p_LiczWierszy   OUT NUMBER) IS
    z_Wykonano BOOLEAN := FALSE;
    z_LiczWierszy NUMBER := 1;
  BEGIN
    IF NOT KursorStudentow%ISOPEN THEN
      -- Najpierw otwarcie kursora
      OPEN KursorStudentow;
    END IF;

    -- Kursor jest otwarty, zatem mo�na pobra� wiersze w liczbie do z_Maks_L_Wierszy
    WHILE NOT z_Wykonano LOOP
      FETCH KursorStudentow INTO p_TabelaStud(z_LiczWierszy);
      IF KursorStudentow%NOTFOUND THEN
        -- Nie ma wi�cej danych, zatem zako�czymy.
        CLOSE KursorStudentow;
        z_Wykonano := TRUE;
      ELSE
        z_LiczWierszy := z_LiczWierszy + 1;
        IF z_Liczwierszy > z_Maks_L_Wierszy THEN
          z_Wykonano := TRUE;
        END IF;
      END IF;
    END LOOP;

    -- Zwr�cenie rzeczywistej liczby pobranych wierszy.
    p_LiczWierszy := z_LiczWierszy - 1;

  END CzytajStudentow;
END TrwaloscPakietu;
/