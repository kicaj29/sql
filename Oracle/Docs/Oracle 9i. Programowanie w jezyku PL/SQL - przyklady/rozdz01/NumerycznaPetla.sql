REM NumerycznaPetla.sql
REM Rozdzia� 1, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje numeryczn� p�tl� FOR.

BEGIN
  FOR z_LicznikPetli IN 1..50 LOOP
    INSERT INTO tabela_tymcz (kol_num)
      VALUES (z_LicznikPetli);
  END LOOP;
END;
/
