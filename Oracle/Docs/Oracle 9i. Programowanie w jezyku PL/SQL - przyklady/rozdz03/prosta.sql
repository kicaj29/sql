REM prosta.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM To jest przyk³ad prostej pêtli.

DECLARE
  z_Licznik BINARY_INTEGER := 1;
BEGIN
  LOOP
    -- Wstaw wiersz do tabeli tabela_tymcz dla bie¿¹cej wartoœci licznika pêtli.
    INSERT INTO tabela_tymcz
      VALUES (z_Licznik, 'Indeks pêtli');
    z_Licznik := z_Licznik + 1;
    -- Warunek wyjœcia - kiedy licznik pêtli > 50 dzia³ania wykonywane
    -- w pêtli zostan¹ zakoñczone.
    IF z_Licznik > 50 THEN
      EXIT;
    END IF;
  END LOOP;
END;
/
