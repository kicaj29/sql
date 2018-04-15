REM WywolaniaGR.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt pokazuje spos�b wywo�ywania procedury w pakiecie.


DELETE FROM tabela_tymcz;

DECLARE
  z_StudenciHistorii PakietGrupy.t_TabelaIDStudentow;
  z_LiczbaStudentow  BINARY_INTEGER := 20;
BEGIN
  -- Wprowadzenie do tabeli PL/SQL pierwszych 20 student�w studiuj�cych 
  -- przedmiot Historia, z kursu 101.
PakietGrupy.ListaGrupy('HIS', 101, z_StidenciHistorii, z_LiczbaStudentow);

  -- Wprowadzenie tych student�w do tabeli tabela_tymcz.
  FOR z_LicznikPetli IN 1..z_LiczbaStudentow LOOP
    INSERT INTO tabela_tymcz (kol_num, kol_znak)
      VALUES (z_StudenciHistorii(z_LicznikPetli), 'Historia, kurs 101');
  END LOOP;
END;
/

SELECT * FROM tabela_tymcz;
