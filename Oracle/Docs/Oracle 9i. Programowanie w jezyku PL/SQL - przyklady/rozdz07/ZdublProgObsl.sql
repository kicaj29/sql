REM ZdublProgObsl.sql
REM Rozdzia� 7., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten przyk�ad ilustruje powstawanie b��du PLS-483.

DECLARE
   -- Zadeklarowanie 2 wyj�tk�w definiowanych przez u�ytkownika
   w_Wyjatek1  EXCEPTION;
   w_Wyjatek2  EXCEPTION;
BEGIN
   -- Zg�oszenie wyj�tku w_Wyjatek1.
   RAISE w_Wyjatek1;
  EXCEPTION
    WHEN w_Wyjatek2 THEN
      INSERT INTO dziennik_bledow(informacja)
        VALUES('Wykonano 1 program obs�ugi wyj�tk�w');
    WHEN w_Wyjatek1 THEN
      INSERT INTO dziennik_bledow(informacja)
         VALUES('Wykonano 3 program obs�ugi wyj�tk�w');
    WHEN w_Wyjatek1 OR w_Wyjatek2 THEN
      INSERT INTO dziennik_bledow(informacja)
         VALUES('Wykonano 4 program obs�ugi wyj�tk�w');
END;
/