REM ZdublProgObsl.sql
REM Rozdzia³ 7., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten przyk³ad ilustruje powstawanie b³êdu PLS-483.

DECLARE
   -- Zadeklarowanie 2 wyj¹tków definiowanych przez u¿ytkownika
   w_Wyjatek1  EXCEPTION;
   w_Wyjatek2  EXCEPTION;
BEGIN
   -- Zg³oszenie wyj¹tku w_Wyjatek1.
   RAISE w_Wyjatek1;
  EXCEPTION
    WHEN w_Wyjatek2 THEN
      INSERT INTO dziennik_bledow(informacja)
        VALUES('Wykonano 1 program obs³ugi wyj¹tków');
    WHEN w_Wyjatek1 THEN
      INSERT INTO dziennik_bledow(informacja)
         VALUES('Wykonano 3 program obs³ugi wyj¹tków');
    WHEN w_Wyjatek1 OR w_Wyjatek2 THEN
      INSERT INTO dziennik_bledow(informacja)
         VALUES('Wykonano 4 program obs³ugi wyj¹tków');
END;
/