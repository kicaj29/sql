REM StudentOps2.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ta wersja pakietu StudentOps nie zawiera dyrektywy pragma RESTRICT_REFERENCES

CREATE OR REPLACE PACKAGE StudentOps AS
  FUNCTION ImieNazwisko(p_StudenciID IN studenci.id%TYPE)
    RETURN VARCHAR2;
  
  /* Zwraca liczbê studentów na specjalnoœci Historia. */
  FUNCTION LiczbaStudentowHistorii
    RETURN NUMBER;
END StudentOps;
/

CREATE OR REPLACE PACKAGE BODY StudentOps AS
  -- Zmienna pakietowa do przechowywania liczby studentów na specjalnoœci Historia. 
  z_LiczHist NUMBER;

  FUNCTION ImieNazwisko(p_StudenciID IN studenci.id%TYPE)
    RETURN VARCHAR2 IS
    z_Wynik  VARCHAR2(100);
  BEGIN
    SELECT imie || ' ' || nazwisko
      INTO z_Wynik
      FROM studenci
      WHERE ID = p_StudenciID;

    RETURN z_Wynik;
  END ImieNazwisko;

  FUNCTION LiczbaStudentowHistorii RETURN NUMBER IS
    z_Wynik NUMBER;
  BEGIN
    IF z_LiczHist IS NULL THEN
      /*Wyznacz odpowiedz. */
      SELECT COUNT(*)
        INTO z_Wynik
        FROM studenci
        WHERE specjalnosc = 'Historia';
      /* Zapisz wynik do przysz³ego wykorzystania. */
      z_LiczHist := z_Wynik;
    ELSE
      z_Wynik := z_LiczHist;
    END IF;
    RETURN z_Wynik;
  END LiczbaStudentowHistorii;
END StudentOps;
/
