REM petlafor.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM To jest przyk�ad p�tli FOR.

BEGIN
  FOR z_Licznik IN 1..50 LOOP
    INSERT INTO tabela_tymcz
      VALUES (z_Licznik, 'Indeks p�tli');
  END LOOP;
END;
/
