REM while2.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Pêtla WHILE w tym przyk³¹dzie zawiera warunek NULL.

DECLARE
  z_Licznik BINARY_INTEGER;
BEGIN
  -- Ten warunek bêdzie oceniony na wartoœæ NULL, poniewa¿ zmienna z_Licznik
  -- jest domyœlnie ustawiona na wartoœæ NULL.
  WHILE z_Licznik <= 50 LOOP
    INSERT INTO tabela_tymcz
      VALUES (z_Licznik, 'Indeks pêtli');
    z_Licznik := z_Licznik + 1;
  END LOOP;
END;
/
