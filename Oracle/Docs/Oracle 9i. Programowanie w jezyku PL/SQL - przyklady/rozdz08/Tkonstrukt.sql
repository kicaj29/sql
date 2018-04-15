REM Tkonstrukt.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje konstruktory tabel zagnie¿d¿onych.

DECLARE
  TYPE TablicaLiczb IS TABLE OF NUMBER;

 -- Utworzenie tabeli z jednym elementem.
   z_Tab1 TablicaLiczb := TablicaLiczb(-1);

 -- Utworzenie tabeli z piêcioma elementami.
   z_LPierwsze TablicaLiczb := TablicaLiczb(1, 2, 3, 5, 7);
 
 -- Utworzenie tabeli nie zawieraj¹cej elementów
   z_Tab2 TablicaLiczb := TablicaLiczb();
BEGIN
 -- Przypisanie wartoœci do pierwszego elementu tabeli z_Tab1. Zmieni
 -- siê pocz¹tkowa wartoœæ tego elementu równa -1.
  z_Tab1(1) := 12345;

 -- Wyœwietlenie zawartoœci tablicy z_Lpierwsze.
  FOR z_Licznik IN 1..5 LOOP
     DBMS_OUTPUT.PUT(z_Lpierwsze(z_Licznik) || ' ');
  END LOOP;
     DBMS_OUTPUT.NEW_LINE;
END;
/


