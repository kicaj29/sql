REM Plik.sql
REM Rozdzia� 2, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten plik zawiera polecenia, kt�re mo�na wykona� w programie SQL*Plus.

BEGIN
  FOR z_Licznik IN 1..10 LOOP
    INSERT INTO tabela_tymcz (kol_num, kol_znak)
      VALUES (z_Licznik, 'Witajcie w �wiecie!');
  END LOOP;
END;
/

SELECT * FROM tabela_tymcz;

