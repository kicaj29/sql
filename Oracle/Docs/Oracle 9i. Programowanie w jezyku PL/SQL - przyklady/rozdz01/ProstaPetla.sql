REM ProstaPetla.sql
REM Rozdzia� 1, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok zawiera prost� p�tl�.

DECLARE
  z_LicznikPetli BINARY_INTEGER := 1;
BEGIN
  LOOP
    INSERT INTO tabela_tymcz (kol_num)
      VALUES (z_LicznikPetli);
    z_LicznikPetli := z_LicznikPetli + 1;
    EXIT WHEN z_LicznikPetli > 50;
  END LOOP;
END;

/
