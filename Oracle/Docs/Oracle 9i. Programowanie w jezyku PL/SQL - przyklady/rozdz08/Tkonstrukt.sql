REM Tkonstrukt.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje konstruktory tabel zagnie�d�onych.

DECLARE
  TYPE TablicaLiczb IS TABLE OF NUMBER;

 -- Utworzenie tabeli z jednym elementem.
   z_Tab1 TablicaLiczb := TablicaLiczb(-1);

 -- Utworzenie tabeli z pi�cioma elementami.
   z_LPierwsze TablicaLiczb := TablicaLiczb(1, 2, 3, 5, 7);
 
 -- Utworzenie tabeli nie zawieraj�cej element�w
   z_Tab2 TablicaLiczb := TablicaLiczb();
BEGIN
 -- Przypisanie warto�ci do pierwszego elementu tabeli z_Tab1. Zmieni
 -- si� pocz�tkowa warto�� tego elementu r�wna -1.
  z_Tab1(1) := 12345;

 -- Wy�wietlenie zawarto�ci tablicy z_Lpierwsze.
  FOR z_Licznik IN 1..5 LOOP
     DBMS_OUTPUT.PUT(z_Lpierwsze(z_Licznik) || ' ');
  END LOOP;
     DBMS_OUTPUT.NEW_LINE;
END;
/


