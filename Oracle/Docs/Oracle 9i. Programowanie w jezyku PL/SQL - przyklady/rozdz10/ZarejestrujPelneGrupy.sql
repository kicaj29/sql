REM ZarejestrujPelneGrupy.sql
REM Rozdzia� 10., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ta procedura zale�y od procedury PrawieKomplet oraz tabeli tabela_tymcz.

CREATE OR REPLACE PROCEDURE ZarejestrujPelneGrupy AS
  CURSOR k_Grupy IS
    SELECT wydzial, kurs
      FROM grupy;
BEGIN
  FOR z_RekordGrupy IN k_Grupy LOOP
    -- Zapisanie w tabeli tabela_tymcz wszystkich grup, kt�re nie maj� 
    -- du�ej liczby wolnych miejsc. 
    IF PrawieKomplet(z_RekordGrupy.wydzial, z_RekordGrupy.kurs) THEN
      INSERT INTO tabela_tymcz (kol_znak) VALUES
        ('Grupa' || z_RekordGrupy.wydzial || ' ' || z_RekordGrupy.kurs ||
         ' jest prawie pe�na!');
    END IF;
  END LOOP;
END ZarejestrujPelneGrupy;
/