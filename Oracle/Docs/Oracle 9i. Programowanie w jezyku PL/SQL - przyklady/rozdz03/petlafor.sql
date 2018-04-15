REM petlafor.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM To jest przyk³ad pêtli FOR.

BEGIN
  FOR z_Licznik IN 1..50 LOOP
    INSERT INTO tabela_tymcz
      VALUES (z_Licznik, 'Indeks pêtli');
  END LOOP;
END;
/
