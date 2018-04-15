REM count.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok demonstrujê metodê COUNT.

DECLARE
    z_TabelaZagniezdzona TablicaLiczb := TablicaLiczb(1, 2, 3);
    z_Varray LiczVar := LiczVar(-1, -2, -3, -4);
    z_TabelaIndeksowana Indeksowane.TablicaLiczb;
BEGIN
  -- Najpierw dodamy kilka elementów to tabeli indeksowanej. Zwróæmy uwagê na to, ¿e
  -- wartoœci indeksów nie s¹ sekwencyjne.
  z_TabelaIndeksowana(1) := 1;
  z_TabelaIndeksowana(8) := 8;
  z_TabelaIndeksowana(-1) := -1;
  z_TabelaIndeksowana(100) := 100;

 -- Wyœwietlenie liczników.
  DBMS_OUTPUT.PUT_LINE(
     'Liczba elementów w tabeli zagnie¿d¿onej: ' || z_TabelaZagniezdzona.COUNT);
  DBMS_OUTPUT.PUT_LINE(
     'Liczba elementów w tablicy Varray: ' || z_Varray.COUNT);
  DBMS_OUTPUT.PUT_LINE(
     'Liczba elementów w tabeli indeksowanej: ' || z_TabelaIndeksowana.COUNT);
END;
/
