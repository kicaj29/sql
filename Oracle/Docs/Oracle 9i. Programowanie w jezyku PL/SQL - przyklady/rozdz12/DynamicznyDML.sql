REM dynamicznyDML.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ta procedura demonstruje pakiet DBMS_SQL.

CREATE OR REPLACE PROCEDURE UaktualnijGrupy(
  /* Procedura wykorzystuje pakiet DBMS_SQL do aktualizacji tabeli grupy, ustawienia
   * zaliczeñ dla wszystkich grup na okreœlonym wydziale
   * na dan¹ wartoœæ.
   */
  p_Wydzial  IN grupy.Wydzial%TYPE,
  p_NoweZaliczenia  IN grupy.liczba_zaliczen%TYPE,
  p_UaktualnionoWierszy OUT INTEGER) AS

  z_IDKursora   INTEGER;
  z_InstrUpdate VARCHAR2(100);
BEGIN
  -- Otwarcie kursora do przetwarzania.
  z_IDKursora := DBMS_SQL.OPEN_CURSOR;

  -- Okreœlenie ci¹gu instrukcji SQL.
  z_InstrUpdate :=
    'UPDATE grupy
       SET liczba_zaliczen = :lz
       WHERE Wydzial = :wydz';

  -- Analiza instrukcji.
  DBMS_SQL.PARSE(z_IDKursora, z_InstrUpdate, DBMS_SQL.NATIVE);

  -- Powi¹zanie parametru p_NoweZaliczenia z symbolem zastêpczym :lz.  Ta przeci¹¿ona
  -- wersja zmiennej BIND_VARIABLE powi¹¿e parametr p_NoweZaliczenia jako dan¹ typu 
  -- NUMBER, poniewa¿ tak j¹ zadeklarowano.
  DBMS_SQL.BIND_VARIABLE(z_IDKursora, ':lz', p_NoweZaliczenia);

  -- Powi¹zanie parametru p_Wydzial do symbolu zastêpczego :wydz.  Ta przeci¹¿ona
  -- wersja zmiennej BIND_VARIABLE powi¹¿e parametr p_Wydzial jako dan¹ typu 
  -- CHAR, poniewa¿ tak j¹ zadeklarowano.
  DBMS_SQL.BIND_VARIABLE_CHAR(z_IDKursora, ':wydz', p_Wydzial);

  -- Wykonanie instrukcji.
  p_UaktualnionoWierszy := DBMS_SQL.EXECUTE(z_IDKursora);

  -- Zmkniêcie kursora.
  DBMS_SQL.CLOSE_CURSOR(z_IDKursora);
EXCEPTION
  WHEN OTHERS THEN
    -- Zamkniêcie kursora, a nastêpnie ponowne zg³oszenie b³êdu.
    DBMS_SQL.CLOSE_CURSOR(z_IDKursora);
    RAISE;
END UaktualnijGrupy;
/