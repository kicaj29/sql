REM ZmienneDowiazane.sql
REM Rozdzia³ 4., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje zastosowanie zmiennych dowi¹zanyh.

DECLARE
  z_LiczZaliczen  grupy.liczba_zaliczen%TYPE;
BEGIN
  /* Przypisz wartoœæ zmiennej z_LiczZaliczen */
  z_LiczZaliczen := 3;
  UPDATE GRUPY
    SET liczba_zaliczen = z_LiczZaliczen
    WHERE wydzial = 'HIS'
    AND kurs = 101;
END;
/
