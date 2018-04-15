REM WbudowDynSQL.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt ilustruje zastosowanie wbudowanego dynamicznego SQL do 
REM przetwarzania zapytañ.

CREATE OR REPLACE PACKAGE WbudowDynSQL AS
  TYPE t_KurOdw IS REF CURSOR;

  -- Pobranie danych z tabeli studenci za pomoc¹ podanej klauzuli WHERE
  -- i zwrócenie otwartej zmiennej kursora.
  FUNCTION StudenciZapytanie(p_KlauzulaWhere IN VARCHAR2)
    RETURN t_KurOdw;

  -- Pobranie danych z tabeli studenci na podstawie podanej specjlanoœci
  -- i zwrócenie otwartej zmiennej kursora.
  FUNCTION StudenciZapytanie2(p_Specjalnosc IN VARCHAR2)
    RETURN t_KurOdw;
END WbudowDynSQL;
/
show errors

CREATE OR REPLACE PACKAGE BODY WbudowDynSQL AS
  -- Selects from studenci using the supplied WHERE clause,
  -- and returns the opened cursor variable.
  FUNCTION StudenciZapytanie(p_KlauzulaWhere IN VARCHAR2)
    RETURN t_KurOdw IS
    z_KursorWynikowy t_KurOdw;
    z_InstrukcjaSQL VARCHAR2(500);
  BEGIN
    -- Utworzenie zapytania za pomoc¹ dostarczonej klauzuli WHERE 
    z_InstrukcjaSQL := 'SELECT * FROM studenci ' || p_KlauzulaWhere;

    -- Otwarcie zmiennej kursora i zwrócenie jej.
    OPEN z_KursorWynikowy FOR z_InstrukcjaSQL;
    RETURN z_KursorWynikowy;
  END StudenciZapytanie;

  -- Pobranie danych z tabeli studenci  na podstawie podanej specjalnoœci
  -- i zwrócenie otwartej zmiennej kursora.
  FUNCTION StudenciZapytanie2(p_Specjalnosc IN VARCHAR2)
    RETURN t_KurOdw IS
    z_KursorWynikowy t_KurOdw;
    z_InstrukcjaSQL VARCHAR2(500);
  BEGIN
    z_InstrukcjaSQL := 'SELECT * FROM studenci WHERE specjalnosc = :m';

    -- Otwarcie zmiennej kursora i zwrócenie jej.
    OPEN z_KursorWynikowy FOR z_InstrukcjaSQL USING p_Specjalnosc;
    RETURN z_KursorWynikowy;
  END StudenciZapytanie2;
END WbudowDynSQL;
/
show errors

set serveroutput on format wrapped

DECLARE
      z_Student studenci%ROWTYPE;
      z_StudentKur WbudowDynSQL.t_KurOdw;
   BEGIN
      -- Wywo³anie procedury StudenciZapytanie w celu otwarcia kursora dla
      -- studentów z parzystymi identyfikatorami.
      z_StudentKur :=
      WbudowDynSQL.StudenciZapytanie('WHERE MOD(id, 2) = 0');
      -- Pêtla dla otwartego kursora i wyœwietlenie wyników.
      DBMS_OUTPUT.PUT_LINE('Parzyste identyfikatory maj¹ nastêpuj¹cy studenci:');
      LOOP
         FETCH z_StudentKur INTO z_Student;
         EXIT WHEN z_StudentKur%NOTFOUND;
         DBMS_OUTPUT.PUT_LINE('  ' || z_Student.id || ': ' ||
                             z_Student.imie || ' ' ||
                             z_Student.nazwisko);
      END LOOP;
      CLOSE z_StudentKur;
      -- Wywo³anie StudenciZapytanie2 w celu otwarcia kursora dla specjalnoœci Muzyka.
      z_StudentKur :=
      WbudowDynSQL.StudenciZapytanie2('Muzyka');
      -- Pêtla dla otwartego kursora i wyœwietlenie wyników.
     DBMS_OUTPUT.PUT_LINE(
      'Na specjalnoœci Muzyka studiuj¹ nastêpuj¹cy studenci:');
     LOOP
        FETCH z_StudentKur INTO z_Student;
        EXIT WHEN z_StudentKur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('  ' || z_Student.id || ': ' ||
                              z_Student.imie || ' ' ||
                              z_Student.nazwisko);
     END LOOP;
     CLOSE z_StudentKur;
   END;
/

-- Ten blok ilustruje zastosowanie instrukcji EXECUTE IMMEDIATE dla
-- zapytañ zwracaj¹cych pojedynczy wiersz.

DECLARE
      z_ZapytanieSQL VARCHAR2(200);
      z_Grupa grupy%ROWTYPE;
      z_Opis grupy.opis%TYPE;
    BEGIN
      -- Najpierw pobrano dane do zmiennej.
      z_ZapytanieSQL :=
        'SELECT opis ' ||
        '  FROM grupy ' ||
       '  WHERE wydzial = ''EKN''' ||
       '  AND kurs = 203';
     EXECUTE IMMEDIATE z_ZapytanieSQL
        INTO z_Opis;
     DBMS_OUTPUT.PUT_LINE('Pobrano ' || z_Opis);
     -- Teraz pobrano dane do rekordu za pomoc¹ zmiennej dowi¹zanej.
     z_ZapytanieSQL :=
          'SELECT * ' ||
          '  FROM grupy ' ||
          '  WHERE opis = :opis';
     EXECUTE IMMEDIATE z_ZapytanieSQL
          INTO z_Grupa
          USING z_Opis;
     DBMS_OUTPUT.PUT_LINE(
       'Pobrano ' || z_Grupa.wydzial || ' ' || z_Grupa.kurs);
     -- Pobranie wiêcej ni¿ jednego wiersza. Spowoduje to powstanie b³êdu ORA-1422.
     z_ZapytanieSQL := 'SELECT * FROM grupy';
     EXECUTE IMMEDIATE z_ZapytanieSQL
         INTO z_Grupa;
   END;
/
