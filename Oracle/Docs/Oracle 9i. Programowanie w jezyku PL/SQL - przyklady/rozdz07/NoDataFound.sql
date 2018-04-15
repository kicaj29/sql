REM NoDataFound.sql
REM Rozdzia� 7., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok powoduje zg�oszenie wyj�tku NO_DATA_FOUND.

DECLARE
 TYPE t_TypTabeliNumerycznej IS TABLE OF NUMBER
   INDEX BY BINARY_INTEGER;
  z_TabelaNumeryczna t_TypTabeliNumerycznej;
  z_ZmTymcz NUMBER;
BEGIN
  z_ZmTymcz := z_TabelaNumeryczna(1);
END;
/