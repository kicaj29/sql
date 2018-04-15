REM TabelaNull.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje tabel� NULL, oraz tabel� zawieraj�c� 
REM element NULL.

DECLARE
   TYPE TablicaSlow IS TABLE OF VARCHAR2(50);
 
 -- Utworzenie tabeli NULL.
   z_Tab1 TablicaSlow;

 -- Utworzenie tabeli z jednym elementem, kt�ry sam ma warto�� (NULL).
   z_Tab2 TablicaSlow := TablicaSlow();
BEGIN
   IF z_Tab1 IS NULL THEN
     DBMS_OUTPUT.PUT_LINE('z_Tab1 ma warto�� NULL');
   ELSE
     DBMS_OUTPUT.PUT_LINE('z_Tab1 nie ma warto�ci NULL');
   END IF;
 
   IF z_Tab2 IS NULL THEN
     DBMS_OUTPUT.PUT_LINE('z_Tab2 ma warto�� NULL');
   ELSE
     DBMS_OUTPUT.PUT_LINE('z_Tab2 nie ma warto�ci NULL');
   END IF;
END;
/

