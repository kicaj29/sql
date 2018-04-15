REM Plik.sql
REM Rozdzia³ 2, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten plik zawiera polecenia, które mo¿na wykonaæ w programie SQL*Plus.

BEGIN
  FOR z_Licznik IN 1..10 LOOP
    INSERT INTO tabela_tymcz (kol_num, kol_znak)
      VALUES (z_Licznik, 'Witajcie w Œwiecie!');
  END LOOP;
END;
/

SELECT * FROM tabela_tymcz;

