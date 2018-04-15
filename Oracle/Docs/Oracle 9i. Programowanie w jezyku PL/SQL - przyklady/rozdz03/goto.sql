REM goto.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje instrukcjê GOTO.

DECLARE
  z_Licznik  BINARY_INTEGER := 1;
BEGIN
  LOOP
    INSERT INTO tabela_tymcz
      VALUES (z_Licznik, 'Licznik Pêtli');
    z_Licznik := z_Licznik + 1;
    IF z_Licznik > 50 THEN
      GOTO e_KoniecPetli;
    END IF;
  END LOOP;

  <<e_KoniecPetli>>
  INSERT INTO tabela_tymcz (kol_znak)
    VALUES ('Wykonane!');
END;
/
