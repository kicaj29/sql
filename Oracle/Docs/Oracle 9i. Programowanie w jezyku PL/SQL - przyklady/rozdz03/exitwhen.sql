REM exitwhen.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje zastosowanie klauzuli EXIT WHEN.

DECLARE
  z_Licznik BINARY_INTEGER := 1;
BEGIN
  LOOP
    -- Wstaw wiersz do tabeli tabela_tymcz dla bie��cej warto�ci
    -- licznika p�tli.
    INSERT INTO tabela_tymcz
      VALUES (z_Licznik, 'Indeks p�tli');
    z_Licznik := z_Licznik + 1;
    -- Warunek wyj�cia - kiedy licznik p�tli > 50 dzia�ania w p�tli
    -- zostan� zako�czone.
    EXIT WHEN z_Licznik > 50;
  END LOOP;
END;
/
