REM UaktualnijSpecStats.sql
REM Rozdzia� 11., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM To jest przyk�ad wyzwalacza DML.

CREATE OR REPLACE TRIGGER UaktualnijSpecStats
  /* Zapewnia ci�g�� aktualno�� tabeli spec_stats, 
     wprowadzaj�c zmiany dokonywane w tabeli studenci. */
  AFTER INSERT OR DELETE OR UPDATE ON studenci
DECLARE
  CURSOR k_Statystyka IS
    SELECT specjalnosc, COUNT(*) ogolem_studenci,
           SUM(biezace_zaliczenia) ogolem_zaliczenia
      FROM studenci
      GROUP BY specjalnosc;
BEGIN
  /* Najpierw zostan� usuni�te wiersze z tabeli spec_stats. Spowoduje to wyzerowanie
     statystyki i konieczno�� rozliczenia wszystkich student�w okre�lonej 
     specjalno�ci */
  DELETE FROM spec_stats;
  /* Nast�pnie b�dzie wykonana p�tla dla ka�dej specjalno�ci i wstawione odpowiednie    
     wiersze do tabeli spec_stats  */
  FOR z_RekordStat in k_Statystyka LOOP
    INSERT INTO spec_stats(specjalnosc, ogolem_zaliczenia, ogolem_studenci)
      VALUES(z_RekordStat.specjalnosc, z_RekordStat.ogolem_zaliczenia,
             z_RekordStat.ogolem_studenci);
  END LOOP;
END UaktualnijSpecStats;
/