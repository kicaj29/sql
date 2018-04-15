REM NieZnalezionooDanych.sql
REM Rozdzia� 6., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt ilustruje powstanie wyj�tku NO_DATA_FOUND.

set serveroutput on

DECLARE
    -- Rekord do przechowywania danych o pokoju.
    z_DanePokoju   pokoje%ROWTYPE;
    BEGIN
    -- Pobranie danych dotycz�cych pokoju o identyfikatorze ID -1.
      SELECT *
        INTO z_DanePokoju
        FROM pokoje
        WHERE pokoj_id = -1;
 
     -- Nast�puj�ca instrukcja nigdy nie b�dzie wykonana, poniewa� 
     -- sterowanie jest natychmiast przekazywane do procedury obs�ugi sekcji wyj�tk�w.
     IF SQL%NOTFOUND THEN
       DBMS_OUTPUT.PUT_LINE('atrybut SQL%NOTFOUND ma warto�� TRUE!');
     END IF;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('B��d NO_DATA_FOUND');
   END;
   /
