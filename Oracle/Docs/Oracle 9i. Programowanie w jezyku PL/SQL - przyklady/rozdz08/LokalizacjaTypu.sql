REM LokalizacjaTypu.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten plik zawiera przyk�ady r�nych lokalizacji
REM typ�w kolekcji.

-- Utworzenie typu sk�adowanego, widocznego zar�wno dla SQL, jak i PL/SQL.
CREATE OR REPLACE TYPE ListaNazw AS
  VARRAY(20) OF VARCHAR2(30);
/

DECLARE
-- Ten typ jest lokalny dla tego bloku.
   TYPE ListaDat IS VARRAY(10) OF DATE;
-- W tym miejscu mo�emy zadeklarowa� zmienne obu typ�w - ListaDat oraz ListaNazw.
  z_Daty ListaDat;
  z_Nazwy ListaNazw;
BEGIN
   NULL;
END;
/

DECLARE
-- Poniewa� typ ListaNazw jest globalny dla PL/SQL, mo�emy odwo�a� si� do niego
-- tak�e w innym bloku.
  z_Nazwy2 ListaNazw;
BEGIN
  NULL;
END;
/

