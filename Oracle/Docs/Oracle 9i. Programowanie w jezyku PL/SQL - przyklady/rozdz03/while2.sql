REM while2.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM P�tla WHILE w tym przyk��dzie zawiera warunek NULL.

DECLARE
  z_Licznik BINARY_INTEGER;
BEGIN
  -- Ten warunek b�dzie oceniony na warto�� NULL, poniewa� zmienna z_Licznik
  -- jest domy�lnie ustawiona na warto�� NULL.
  WHILE z_Licznik <= 50 LOOP
    INSERT INTO tabela_tymcz
      VALUES (z_Licznik, 'Indeks p�tli');
    z_Licznik := z_Licznik + 1;
  END LOOP;
END;
/
