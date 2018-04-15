REM AnonimowyBlok.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM To jest przyk�ad bloku anonimowego.
DECLARE
   /* Zadeklarowanie zmiennych wykorzystywanych w tym bloku. */
   z_Num1      NUMBER := 1;
   z_Num2      NUMBER := 2;
   z_Ciag1  VARCHAR2(50) := 'Witaj �wiecie!';
   z_Ciag2  VARCHAR2(50) := 
   'Ten komunikat pojawi� si� dzi�ki j�zykowi PL/SQL!';
   z_CiagWynikowy VARCHAR2(50);
  BEGIN
  /* Wstawienie dw�ch wierszy do tabeli tabela_tymcz, 
     wykorzystuj�c warto�ci zmiennych. */
  INSERT INTO tabela_tymcz (kol_num, kol_znak)
    VALUES (z_Num1, z_Ciag1);
  INSERT INTO tabela_tymcz (kol_num, kol_znak)
    VALUES (z_Num2, z_Ciag2);
  /*  Wys�anie zapytania dotycz�cego dw�ch wierszy, kt�re w�a�nie zosta�y wstawione 
  do tabeli tabela_tymcz i wy�wietlenie ich na ekranie 
  za pomoc� pakietu DBMS_OUTPUT. */
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
 
  /* Cofni�cie wprowadzonych zmian */
  ROLLBACK;
 END;
 /
