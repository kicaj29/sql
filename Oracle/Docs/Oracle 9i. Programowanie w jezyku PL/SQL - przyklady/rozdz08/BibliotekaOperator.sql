REM BibliotekaOperator.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM W teja wersji pakietu Biblioteka wykorzystano operator TABLE
REM w celu wykonywania dzia�a� z indywidualnymi elementami tabel zagnie�d�onych.

CREATE OR REPLACE PACKAGE Biblioteka AS
  -- Wy�wietlenie listy student�w, kt�rzy wypo�yczyli okre�lon� ksi��k�.
  PROCEDURE WyswietlWypozyczone(
    p_NumerKatalogowy IN katalog_bibl.Numer_katalogowy%TYPE);

  -- Wypo�yczenie ksi��ki o Numerze katalogowym p_NumerKatalogowy studentowi 
  -- o identyfikatorze p_StudentID.
  PROCEDURE Wypozyczenie(
    p_NumerKatalogowy IN katalog_bibl.Numer_katalogowy%TYPE,
    p_StudentID IN NUMBER);
                     
  -- Zwrot ksi��ki o Numerze p_NumerKatalogowy przez studenta
  -- o identyfikatorze p_StudentID.
  PROCEDURE Zwrot(
    p_NumerKatalogowy IN katalog_bibl.Numer_katalogowy%TYPE,
    p_StudentID IN NUMBER);
END Biblioteka;
/


CREATE OR REPLACE PACKAGE BODY Biblioteka AS
-- Wy�wietlenie listy student�w, kt�rzy wypo�yczyli okre�lon� ksi��k�.

PROCEDURE WyswietlWypozyczone(
    p_NumerKatalogowy IN katalog_bibl.Numer_katalogowy%TYPE) IS
    
    z_ListaStudentow ListaStudentow;
    z_Student studenci%ROWTYPE;
    z_Ksiazka ksiazki%ROWTYPE;
    z_Znaleziono BOOLEAN := FALSE;

 CURSOR k_Wypozyczono IS
    SELECT column_value ID
       FROM TABLE(SELECT wypozyczono_dla 
                  FROM katalog_bibl
                  WHERE Numer_katalogowy = p_NumerKatalogowy);
 BEGIN
      
    SELECT *
      INTO z_Ksiazka
      FROM ksiazki
      WHERE Numer_katalogowy = p_NumerKatalogowy;
    
    DBMS_OUTPUT.PUT_LINE(
      'Studenci, kt�rzy wypo�yczyli ' || z_Ksiazka.Numer_katalogowy || ': ' ||
      z_Ksiazka.tytul || ': ');
    
    -- P�tla dla tabeli zagnie�d�onej i wy�wietlenie nazwisk student�w.
    FOR z_Rek IN k_Wypozyczono LOOP
        z_Znaleziono := TRUE;
        
        SELECT *
          INTO z_Student
          FROM studenci
          WHERE ID = z_Rek.ID;
        
        DBMS_OUTPUT.PUT_LINE('  ' || z_Student.imie || ' ' || 
                             z_Student.nazwisko);
      END LOOP;
    
     IF NOT z_Znaleziono THEN
      DBMS_OUTPUT.PUT_LINE('  Brak');
    END IF;
  END WyswietlWypozyczone;

 -- Wypo�yczenie ksi��ki o Numerze katalogowym p_NumerKatalogowy studentowi 
  -- o identyfikatorze p_StudentID.
  PROCEDURE Wypozyczenie(
    p_NumerKatalogowy IN katalog_bibl.Numer_katalogowy%TYPE,
    p_StudentID IN NUMBER) IS

    z_LiczbaEgz katalog_bibl.liczba_egz%TYPE;
    z_LiczbaWypozycz katalog_bibl.liczba_wypozycz%TYPE;
    z_Wypozyczono_dla katalog_bibl.wypozyczono_dla%TYPE;
  BEGIN
    -- Najpierw sprawdzimy, czy ksi��ka istnieje, a nast�pnie, czy jest jeszcze 
    -- dost�pny egzemplarz do wypo�yczenia.
    BEGIN
      SELECT liczba_egz, liczba_wypozycz, wypozyczono_dla
        INTO z_LiczbaEgz, z_LiczbaWypozycz, z_Wypozyczono_dla
        FROM katalog_bibl
        WHERE Numer_katalogowy = p_NumerKatalogowy
        FOR UPDATE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000,
          'W bibliotece nie ma ksi��ki o Numerze katalogowym ' ||
          p_NumerKatalogowy || '');
    END;
  
    IF z_LiczbaEgz = z_LiczbaWypozycz THEN
      RAISE_APPLICATION_ERROR(-20001,
        'Wszystkie egzemplarze ksi��ki o Numerze ' || p_NumerKatalogowy || 
        ' wypo�yczono');
    END IF;
  
    -- Przeszukiwanie listy, w celu sprawdzenia, czy student ju� wypo�yczy� t� ksi��k�.
    IF z_Wypozyczono_dla IS NOT NULL THEN
      FOR z_Licznik IN 1..z_Wypozyczono_dla.COUNT LOOP
        IF z_Wypozyczono_dla(z_Licznik) = p_StudentID THEN
          RAISE_APPLICATION_ERROR(-20002,
            'Student ' || p_StudentID || ' ju� wypo�yczy� t� ksi��k� ' ||
            p_NumerKatalogowy || '');
        END IF;
      END LOOP;
    END IF;
    
    -- Przygotowanie miejsca na li�cie
    IF z_Wypozyczono_dla IS NULL THEN
      z_Wypozyczono_dla := ListaStudentow(NULL);
    ELSE
      z_Wypozyczono_dla.EXTEND;
    END IF;
    
    -- Wypo�yczenie ksi��ki - dodanie jej do lity.
    z_Wypozyczono_dla(z_Wypozyczono_dla.COUNT) := p_StudentID;

    -- I umieszczenie jej z powrotem do bazy danych, dodaj�c 1 do liczba_wypozycz.
    UPDATE katalog_bibl
      SET wypozyczono_dla = z_Wypozyczono_dla,
          liczba_wypozycz = liczba_wypozycz + 1
      WHERE Numer_katalogowy = p_NumerKatalogowy;
  END Wypozyczenie;

  -- Zwrot ksi��ki o Numerze p_NumerKatalogowy przez studenta
  -- o identyfikatorze p_StudentID.
  PROCEDURE Zwrot(
    p_NumerKatalogowy IN katalog_bibl.Numer_katalogowy%TYPE,
    p_StudentID IN NUMBER) IS
    
    z_LiczbaEgz katalog_bibl.liczba_egz%TYPE;
    z_LiczbaWypozycz katalog_bibl.liczba_wypozycz%TYPE;
    z_Wypozyczono_dla katalog_bibl.wypozyczono_dla%TYPE;
    z_JuzWypozyczono BOOLEAN := FALSE;
  BEGIN
    -- Najpierw sprawdzenie, czy ksi��ka istnieje
    BEGIN
      SELECT liczba_egz, liczba_wypozycz, wypozyczono_dla
        INTO z_LiczbaEgz, z_LiczbaWypozycz, z_Wypozyczono_Dla
        FROM katalog_bibl
        WHERE Numer_katalogowy = p_NumerKatalogowy
        FOR UPDATE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000,
          'W bibliotece nie ma ksi��ki o Numerze katalogowym ' ||
          p_NumerKatalogowy || '');
    END;
    
    -- Przeszukiwanie listy w celu sprawdzenia, czy student j� 
    -- wypo�yczy�.
    IF z_Wypozyczono_Dla IS NOT NULL THEN
      FOR z_Licznik IN 1..z_Wypozyczono_Dla.COUNT LOOP
        IF z_Wypozyczono_Dla(z_Licznik) = p_StudentID THEN
          z_JuzWypozyczono := TRUE;
          -- Usuni�cie ksi��ki z listy.
          z_Wypozyczono_Dla.DELETE(z_Licznik);
        END IF;
      END LOOP;
    END IF;
    
    IF NOT z_JuzWypozyczono THEN
      RAISE_APPLICATION_ERROR(-20003,
        'Student ' || p_StudentID || ' nie wypo�ycza� ksi��ki o Numerze ' ||
        p_NumerKatalogowy || '');
    END IF;
    
    -- I umieszczenie jej z powrotem w bazie danych, zmniejszaj�c o 1 warto�� liczba_wypozycz.
    UPDATE katalog_bibl
      SET wypozyczono_dla = z_Wypozyczono_Dla,
          liczba_wypozycz = liczba_wypozycz - 1
      WHERE Numer_katalogowy = p_NumerKatalogowy;
  END Zwrot;
END Biblioteka;
/



