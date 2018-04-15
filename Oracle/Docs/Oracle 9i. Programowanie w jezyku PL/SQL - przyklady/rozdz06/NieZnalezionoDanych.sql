REM NieZnalezionooDanych.sql
REM Rozdzia³ 6., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt ilustruje powstanie wyj¹tku NO_DATA_FOUND.

set serveroutput on

DECLARE
    -- Rekord do przechowywania danych o pokoju.
    z_DanePokoju   pokoje%ROWTYPE;
    BEGIN
    -- Pobranie danych dotycz¹cych pokoju o identyfikatorze ID -1.
      SELECT *
        INTO z_DanePokoju
        FROM pokoje
        WHERE pokoj_id = -1;
 
     -- Nastêpuj¹ca instrukcja nigdy nie bêdzie wykonana, poniewa¿ 
     -- sterowanie jest natychmiast przekazywane do procedury obs³ugi sekcji wyj¹tków.
     IF SQL%NOTFOUND THEN
       DBMS_OUTPUT.PUT_LINE('atrybut SQL%NOTFOUND ma wartoœæ TRUE!');
     END IF;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('B³¹d NO_DATA_FOUND');
   END;
   /
