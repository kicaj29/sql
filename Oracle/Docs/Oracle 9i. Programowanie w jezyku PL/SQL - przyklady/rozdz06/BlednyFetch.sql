REM BlednyFetch.sql
REM Rozdzia³ 6., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje prawid³owe i nieprawid³owe instrukcje FETCH.

DECLARE
  z_Wydzial  grupy.wydzial%TYPE;
  z_Kurs     grupy.kurs%TYPE;
  CURSOR k_WszystkieGrupy IS
    SELECT *
      FROM grupy;
  z_RekordGrup k_WszystkieGrupy%ROWTYPE;
BEGIN
  OPEN k_WszystkieGrupy;

  -- To jest prawid³owa instrukcja FETCH, zwracaj¹ca pierwszy wiersz
  -- do rekordu PL/SQL, który odpowiada liœcie wyboru zapytania. 

FETCH k_WszystkieGrupy INTO z_RekordGrup;

  -- Ta instrukcja FETCH jest nieprawid³owa, poniewa¿ dla listy wyboru zapytania 
  -- zwracane s¹ wszystkie 7 kolumn z tabeli grupy, ale pobieranie odbywa siê tylko 
  -- do 2 zmiennych. Wyst¹pi b³¹d "PLS-394: wrong number of values in the INTO 
  -- list of a FETCH statement" (PLS-394: niew³aœciwa liczba wartoœci 
  -- na liœcie INTO instrukcji FETCH).
  FETCH k_WszystkieGrupy INTO z_Wydzial, z_Kurs;
END;
/
