REM RefCursor.sql
REM Rozdzia� 6., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje kilka deklaracji REF CURSOR.

DECLARE
  -- Definicja z wykorzystaniem atrybutu %ROWTYPE
  TYPE t_StudenciOdw IS REF CURSOR
    RETURN studenci%ROWTYPE;

  -- Zdefiniowanie nowego typu rekordu,
  TYPE t_RekordNazwiska IS RECORD (
    Imie        studenci.imie%TYPE,
    Nazwisko    studenci.nazwisko%TYPE);

  -- deklaracja zmiennej tego typu
  z_RekordNazwiska   t_RekordNazwiska;
  -- oraz zmienna kursora wykorzystuj�ca typ rekordu.
  TYPE t_NazwiskaOdw IS REF CURSOR
    RETURN t_RekordNazwiska;

  -- Mo�na zadeklarowa� inny typ, wykorzystuj�c atrybut %TYPE dla 
  -- uprzednio zdefiniowanego rekordu.
  TYPE t_NazwiskaOdw2 IS REF CURSOR
    RETURN z_RekordNazwiska%TYPE;

  -- Zadeklarowanie zmiennych kursora z wykorzystaniem powy�szych typ�w
  z_ZKStudenta   t_StudenciOdw;
  z_ZKNazwa      t_NazwiskaOdw;

  -- Definicja nieograniczonego typu odno�nika.
  TYPE  t_OdwElastyczne IS REF CURSOR;

  -- oraz zmiennej tego typu.
  z_ZmiennaKursora t_OdwElastyczne;
  

BEGIN
  NULL;
END;
/
