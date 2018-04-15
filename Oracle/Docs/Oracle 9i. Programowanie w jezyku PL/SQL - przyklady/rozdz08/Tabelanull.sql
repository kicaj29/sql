REM TabelaNull.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje tabelê NULL, oraz tabelê zawieraj¹c¹ 
REM element NULL.

DECLARE
   TYPE TablicaSlow IS TABLE OF VARCHAR2(50);
 
 -- Utworzenie tabeli NULL.
   z_Tab1 TablicaSlow;

 -- Utworzenie tabeli z jednym elementem, który sam ma wartoœæ (NULL).
   z_Tab2 TablicaSlow := TablicaSlow();
BEGIN
   IF z_Tab1 IS NULL THEN
     DBMS_OUTPUT.PUT_LINE('z_Tab1 ma wartoœæ NULL');
   ELSE
     DBMS_OUTPUT.PUT_LINE('z_Tab1 nie ma wartoœci NULL');
   END IF;
 
   IF z_Tab2 IS NULL THEN
     DBMS_OUTPUT.PUT_LINE('z_Tab2 ma wartoœæ NULL');
   ELSE
     DBMS_OUTPUT.PUT_LINE('z_Tab2 nie ma wartoœci NULL');
   END IF;
END;
/

