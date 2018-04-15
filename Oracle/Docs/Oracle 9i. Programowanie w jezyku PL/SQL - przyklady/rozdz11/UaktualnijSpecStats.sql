REM UaktualnijSpecStats.sql
REM Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM To jest przyk³ad wyzwalacza DML.

CREATE OR REPLACE TRIGGER UaktualnijSpecStats
  /* Zapewnia ci¹g³¹ aktualnoœæ tabeli spec_stats, 
     wprowadzaj¹c zmiany dokonywane w tabeli studenci. */
  AFTER INSERT OR DELETE OR UPDATE ON studenci
DECLARE
  CURSOR k_Statystyka IS
    SELECT specjalnosc, COUNT(*) ogolem_studenci,
           SUM(biezace_zaliczenia) ogolem_zaliczenia
      FROM studenci
      GROUP BY specjalnosc;
BEGIN
  /* Najpierw zostan¹ usuniête wiersze z tabeli spec_stats. Spowoduje to wyzerowanie
     statystyki i koniecznoœæ rozliczenia wszystkich studentów okreœlonej 
     specjalnoœci */
  DELETE FROM spec_stats;
  /* Nastêpnie bêdzie wykonana pêtla dla ka¿dej specjalnoœci i wstawione odpowiednie    
     wiersze do tabeli spec_stats  */
  FOR z_RekordStat in k_Statystyka LOOP
    INSERT INTO spec_stats(specjalnosc, ogolem_zaliczenia, ogolem_studenci)
      VALUES(z_RekordStat.specjalnosc, z_RekordStat.ogolem_zaliczenia,
             z_RekordStat.ogolem_studenci);
  END LOOP;
END UaktualnijSpecStats;
/