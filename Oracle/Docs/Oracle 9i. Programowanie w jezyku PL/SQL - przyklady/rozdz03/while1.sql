REM while1.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten kod ilustruje p�tl� WHILE.

DECLARE
  z_Licznik BINARY_INTEGER := 1;
BEGIN
  -- Testuj licznik p�tli przed ka�d� iteracja p�tli w celu 
  -- ustalenia, czy jego warto�� jest w dalszym ci�gu mniejsza lub r�wna 50.
  WHILE z_Licznik <= 50 LOOP
    INSERT INTO tabela_tymcz
      VALUES (z_Licznik, 'Indeks p�tli');
    z_Licznik := z_Licznik + 1;
  END LOOP;
END;
/
