REM NoDataFound.sql
REM Rozdzia³ 7., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok powoduje zg³oszenie wyj¹tku NO_DATA_FOUND.

DECLARE
 TYPE t_TypTabeliNumerycznej IS TABLE OF NUMBER
   INDEX BY BINARY_INTEGER;
  z_TabelaNumeryczna t_TypTabeliNumerycznej;
  z_ZmTymcz NUMBER;
BEGIN
  z_ZmTymcz := z_TabelaNumeryczna(1);
END;
/