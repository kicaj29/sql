REM Procedura.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten plik ilustruje procedury PL/SQL.

CREATE OR REPLACE PROCEDURE WstawDoTymcz AS
  /* Zadeklarowanie zmiennych, które maj¹ byæ stosowane w tym bloku. */
  z_Num1            NUMBER := 5;
  z_Num2            NUMBER := 6;
  z_Ciag1           VARCHAR2(50) := 'Witaj Œwiecie!';
  z_Ciag2        VARCHAR2(50) := 
   'Ten komunikat pojawi³ siê dziêki jêzykowi PL/SQL!';
  z_CiagWynikowy      VARCHAR2(50);
BEGIN
  /* Wstawienie dwóch wierszy do tabeli tabela_tymcz z wykorzystaniem wartoœci zmiennych. */
  INSERT INTO tabela_tymcz (kol_num,kol_znak)
    VALUES (z_Num1, z_Ciag1);
  INSERT INTO tabela_tymcz (kol_num, kol_znak)
    VALUES (z_Num2, z_Ciag2);
  /*  Wys³anie zapytania dotycz¹cego dwóch wierszy, które w³aœnie zosta³y wstawione 
     do tabeli tabela_tymcz i wyœwietlenie ich na ekranie 
     za pomoc¹  pakietu DBMS_OUTPUT. */

SELECT kol_znak 
  INTO z_CiagWynikowy      
FROM tabela_tymcz
WHERE kol_num = z_Num1;
DBMS_OUTPUT.PUT_LINE(z_CiagWynikowy);
  
SELECT kol_znak
  INTO z_CiagWynikowy      
FROM tabela_tymcz
WHERE kol_num = z_Num2;
DBMS_OUTPUT.PUT_LINE(z_CiagWynikowy);

 /* Cofniêcie wprowadzonych zmian */
 ROLLBACK;

END WstawDoTymcz;
/
BEGIN
    WstawDoTymcz;
END;
/
