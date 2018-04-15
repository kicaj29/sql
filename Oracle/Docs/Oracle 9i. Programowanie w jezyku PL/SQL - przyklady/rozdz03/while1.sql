REM while1.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten kod ilustruje pêtlê WHILE.

DECLARE
  z_Licznik BINARY_INTEGER := 1;
BEGIN
  -- Testuj licznik pêtli przed ka¿d¹ iteracja pêtli w celu 
  -- ustalenia, czy jego wartoœæ jest w dalszym ci¹gu mniejsza lub równa 50.
  WHILE z_Licznik <= 50 LOOP
    INSERT INTO tabela_tymcz
      VALUES (z_Licznik, 'Indeks pêtli');
    z_Licznik := z_Licznik + 1;
  END LOOP;
END;
/
