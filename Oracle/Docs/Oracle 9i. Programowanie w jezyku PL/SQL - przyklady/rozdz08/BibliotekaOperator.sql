REM BibliotekaOperator.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM W teja wersji pakietu Biblioteka wykorzystano operator TABLE
REM w celu wykonywania dzia³añ z indywidualnymi elementami tabel zagnie¿d¿onych.

CREATE OR REPLACE PACKAGE Biblioteka AS
  -- Wyœwietlenie listy studentów, którzy wypo¿yczyli okreœlon¹ ksi¹¿kê.
  PROCEDURE WyswietlWypozyczone(
    p_NumerKatalogowy IN katalog_bibl.Numer_katalogowy%TYPE);

  -- Wypo¿yczenie ksi¹¿ki o Numerze katalogowym p_NumerKatalogowy studentowi 
  -- o identyfikatorze p_StudentID.
  PROCEDURE Wypozyczenie(
    p_NumerKatalogowy IN katalog_bibl.Numer_katalogowy%TYPE,
    p_StudentID IN NUMBER);
                     
  -- Zwrot ksi¹¿ki o Numerze p_NumerKatalogowy przez studenta
  -- o identyfikatorze p_StudentID.
  PROCEDURE Zwrot(
    p_NumerKatalogowy IN katalog_bibl.Numer_katalogowy%TYPE,
    p_StudentID IN NUMBER);
END Biblioteka;
/


CREATE OR REPLACE PACKAGE BODY Biblioteka AS
-- Wyœwietlenie listy studentów, którzy wypo¿yczyli okreœlon¹ ksi¹¿kê.

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
      'Studenci, którzy wypo¿yczyli ' || z_Ksiazka.Numer_katalogowy || ': ' ||
      z_Ksiazka.tytul || ': ');
    
    -- Pêtla dla tabeli zagnie¿d¿onej i wyœwietlenie nazwisk studentów.
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

 -- Wypo¿yczenie ksi¹¿ki o Numerze katalogowym p_NumerKatalogowy studentowi 
  -- o identyfikatorze p_StudentID.
  PROCEDURE Wypozyczenie(
    p_NumerKatalogowy IN katalog_bibl.Numer_katalogowy%TYPE,
    p_StudentID IN NUMBER) IS

    z_LiczbaEgz katalog_bibl.liczba_egz%TYPE;
    z_LiczbaWypozycz katalog_bibl.liczba_wypozycz%TYPE;
    z_Wypozyczono_dla katalog_bibl.wypozyczono_dla%TYPE;
  BEGIN
    -- Najpierw sprawdzimy, czy ksi¹¿ka istnieje, a nastêpnie, czy jest jeszcze 
    -- dostêpny egzemplarz do wypo¿yczenia.
    BEGIN
      SELECT liczba_egz, liczba_wypozycz, wypozyczono_dla
        INTO z_LiczbaEgz, z_LiczbaWypozycz, z_Wypozyczono_dla
        FROM katalog_bibl
        WHERE Numer_katalogowy = p_NumerKatalogowy
        FOR UPDATE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000,
          'W bibliotece nie ma ksi¹¿ki o Numerze katalogowym ' ||
          p_NumerKatalogowy || '');
    END;
  
    IF z_LiczbaEgz = z_LiczbaWypozycz THEN
      RAISE_APPLICATION_ERROR(-20001,
        'Wszystkie egzemplarze ksi¹¿ki o Numerze ' || p_NumerKatalogowy || 
        ' wypo¿yczono');
    END IF;
  
    -- Przeszukiwanie listy, w celu sprawdzenia, czy student ju¿ wypo¿yczy³ tê ksi¹¿kê.
    IF z_Wypozyczono_dla IS NOT NULL THEN
      FOR z_Licznik IN 1..z_Wypozyczono_dla.COUNT LOOP
        IF z_Wypozyczono_dla(z_Licznik) = p_StudentID THEN
          RAISE_APPLICATION_ERROR(-20002,
            'Student ' || p_StudentID || ' ju¿ wypo¿yczy³ tê ksi¹¿kê ' ||
            p_NumerKatalogowy || '');
        END IF;
      END LOOP;
    END IF;
    
    -- Przygotowanie miejsca na liœcie
    IF z_Wypozyczono_dla IS NULL THEN
      z_Wypozyczono_dla := ListaStudentow(NULL);
    ELSE
      z_Wypozyczono_dla.EXTEND;
    END IF;
    
    -- Wypo¿yczenie ksi¹¿ki - dodanie jej do lity.
    z_Wypozyczono_dla(z_Wypozyczono_dla.COUNT) := p_StudentID;

    -- I umieszczenie jej z powrotem do bazy danych, dodaj¹c 1 do liczba_wypozycz.
    UPDATE katalog_bibl
      SET wypozyczono_dla = z_Wypozyczono_dla,
          liczba_wypozycz = liczba_wypozycz + 1
      WHERE Numer_katalogowy = p_NumerKatalogowy;
  END Wypozyczenie;

  -- Zwrot ksi¹¿ki o Numerze p_NumerKatalogowy przez studenta
  -- o identyfikatorze p_StudentID.
  PROCEDURE Zwrot(
    p_NumerKatalogowy IN katalog_bibl.Numer_katalogowy%TYPE,
    p_StudentID IN NUMBER) IS
    
    z_LiczbaEgz katalog_bibl.liczba_egz%TYPE;
    z_LiczbaWypozycz katalog_bibl.liczba_wypozycz%TYPE;
    z_Wypozyczono_dla katalog_bibl.wypozyczono_dla%TYPE;
    z_JuzWypozyczono BOOLEAN := FALSE;
  BEGIN
    -- Najpierw sprawdzenie, czy ksi¹¿ka istnieje
    BEGIN
      SELECT liczba_egz, liczba_wypozycz, wypozyczono_dla
        INTO z_LiczbaEgz, z_LiczbaWypozycz, z_Wypozyczono_Dla
        FROM katalog_bibl
        WHERE Numer_katalogowy = p_NumerKatalogowy
        FOR UPDATE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000,
          'W bibliotece nie ma ksi¹¿ki o Numerze katalogowym ' ||
          p_NumerKatalogowy || '');
    END;
    
    -- Przeszukiwanie listy w celu sprawdzenia, czy student j¹ 
    -- wypo¿yczy³.
    IF z_Wypozyczono_Dla IS NOT NULL THEN
      FOR z_Licznik IN 1..z_Wypozyczono_Dla.COUNT LOOP
        IF z_Wypozyczono_Dla(z_Licznik) = p_StudentID THEN
          z_JuzWypozyczono := TRUE;
          -- Usuniêcie ksi¹¿ki z listy.
          z_Wypozyczono_Dla.DELETE(z_Licznik);
        END IF;
      END LOOP;
    END IF;
    
    IF NOT z_JuzWypozyczono THEN
      RAISE_APPLICATION_ERROR(-20003,
        'Student ' || p_StudentID || ' nie wypo¿ycza³ ksi¹¿ki o Numerze ' ||
        p_NumerKatalogowy || '');
    END IF;
    
    -- I umieszczenie jej z powrotem w bazie danych, zmniejszaj¹c o 1 wartoœæ liczba_wypozycz.
    UPDATE katalog_bibl
      SET wypozyczono_dla = z_Wypozyczono_Dla,
          liczba_wypozycz = liczba_wypozycz - 1
      WHERE Numer_katalogowy = p_NumerKatalogowy;
  END Zwrot;
END Biblioteka;
/



