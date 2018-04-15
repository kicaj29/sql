REM LokalizacjaTypu.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten plik zawiera przyk³ady ró¿nych lokalizacji
REM typów kolekcji.

-- Utworzenie typu sk³adowanego, widocznego zarówno dla SQL, jak i PL/SQL.
CREATE OR REPLACE TYPE ListaNazw AS
  VARRAY(20) OF VARCHAR2(30);
/

DECLARE
-- Ten typ jest lokalny dla tego bloku.
   TYPE ListaDat IS VARRAY(10) OF DATE;
-- W tym miejscu mo¿emy zadeklarowaæ zmienne obu typów - ListaDat oraz ListaNazw.
  z_Daty ListaDat;
  z_Nazwy ListaNazw;
BEGIN
   NULL;
END;
/

DECLARE
-- Poniewa¿ typ ListaNazw jest globalny dla PL/SQL, mo¿emy odwo³aæ siê do niego
-- tak¿e w innym bloku.
  z_Nazwy2 ListaNazw;
BEGIN
  NULL;
END;
/

