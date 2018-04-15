REM dynamicznyDML.sql
REM Rozdzia� 12., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ta procedura demonstruje pakiet DBMS_SQL.

CREATE OR REPLACE PROCEDURE UaktualnijGrupy(
  /* Procedura wykorzystuje pakiet DBMS_SQL do aktualizacji tabeli grupy, ustawienia
   * zalicze� dla wszystkich grup na okre�lonym wydziale
   * na dan� warto��.
   */
  p_Wydzial  IN grupy.Wydzial%TYPE,
  p_NoweZaliczenia  IN grupy.liczba_zaliczen%TYPE,
  p_UaktualnionoWierszy OUT INTEGER) AS

  z_IDKursora   INTEGER;
  z_InstrUpdate VARCHAR2(100);
BEGIN
  -- Otwarcie kursora do przetwarzania.
  z_IDKursora := DBMS_SQL.OPEN_CURSOR;

  -- Okre�lenie ci�gu instrukcji SQL.
  z_InstrUpdate :=
    'UPDATE grupy
       SET liczba_zaliczen = :lz
       WHERE Wydzial = :wydz';

  -- Analiza instrukcji.
  DBMS_SQL.PARSE(z_IDKursora, z_InstrUpdate, DBMS_SQL.NATIVE);

  -- Powi�zanie parametru p_NoweZaliczenia z symbolem zast�pczym :lz.  Ta przeci��ona
  -- wersja zmiennej BIND_VARIABLE powi��e parametr p_NoweZaliczenia jako dan� typu 
  -- NUMBER, poniewa� tak j� zadeklarowano.
  DBMS_SQL.BIND_VARIABLE(z_IDKursora, ':lz', p_NoweZaliczenia);

  -- Powi�zanie parametru p_Wydzial do symbolu zast�pczego :wydz.  Ta przeci��ona
  -- wersja zmiennej BIND_VARIABLE powi��e parametr p_Wydzial jako dan� typu 
  -- CHAR, poniewa� tak j� zadeklarowano.
  DBMS_SQL.BIND_VARIABLE_CHAR(z_IDKursora, ':wydz', p_Wydzial);

  -- Wykonanie instrukcji.
  p_UaktualnionoWierszy := DBMS_SQL.EXECUTE(z_IDKursora);

  -- Zmkni�cie kursora.
  DBMS_SQL.CLOSE_CURSOR(z_IDKursora);
EXCEPTION
  WHEN OTHERS THEN
    -- Zamkni�cie kursora, a nast�pnie ponowne zg�oszenie b��du.
    DBMS_SQL.CLOSE_CURSOR(z_IDKursora);
    RAISE;
END UaktualnijGrupy;
/