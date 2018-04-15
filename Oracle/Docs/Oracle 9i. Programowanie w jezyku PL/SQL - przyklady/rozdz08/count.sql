REM count.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok demonstruj� metod� COUNT.

DECLARE
    z_TabelaZagniezdzona TablicaLiczb := TablicaLiczb(1, 2, 3);
    z_Varray LiczVar := LiczVar(-1, -2, -3, -4);
    z_TabelaIndeksowana Indeksowane.TablicaLiczb;
BEGIN
  -- Najpierw dodamy kilka element�w to tabeli indeksowanej. Zwr��my uwag� na to, �e
  -- warto�ci indeks�w nie s� sekwencyjne.
  z_TabelaIndeksowana(1) := 1;
  z_TabelaIndeksowana(8) := 8;
  z_TabelaIndeksowana(-1) := -1;
  z_TabelaIndeksowana(100) := 100;

 -- Wy�wietlenie licznik�w.
  DBMS_OUTPUT.PUT_LINE(
     'Liczba element�w w tabeli zagnie�d�onej: ' || z_TabelaZagniezdzona.COUNT);
  DBMS_OUTPUT.PUT_LINE(
     'Liczba element�w w tablicy Varray: ' || z_Varray.COUNT);
  DBMS_OUTPUT.PUT_LINE(
     'Liczba element�w w tabeli indeksowanej: ' || z_TabelaIndeksowana.COUNT);
END;
/
