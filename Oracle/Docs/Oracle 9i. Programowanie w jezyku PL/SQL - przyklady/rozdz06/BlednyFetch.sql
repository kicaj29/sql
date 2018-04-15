REM BlednyFetch.sql
REM Rozdzia� 6., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje prawid�owe i nieprawid�owe instrukcje FETCH.

DECLARE
  z_Wydzial  grupy.wydzial%TYPE;
  z_Kurs     grupy.kurs%TYPE;
  CURSOR k_WszystkieGrupy IS
    SELECT *
      FROM grupy;
  z_RekordGrup k_WszystkieGrupy%ROWTYPE;
BEGIN
  OPEN k_WszystkieGrupy;

  -- To jest prawid�owa instrukcja FETCH, zwracaj�ca pierwszy wiersz
  -- do rekordu PL/SQL, kt�ry odpowiada li�cie wyboru zapytania. 

FETCH k_WszystkieGrupy INTO z_RekordGrup;

  -- Ta instrukcja FETCH jest nieprawid�owa, poniewa� dla listy wyboru zapytania 
  -- zwracane s� wszystkie 7 kolumn z tabeli grupy, ale pobieranie odbywa si� tylko 
  -- do 2 zmiennych. Wyst�pi b��d "PLS-394: wrong number of values in the INTO 
  -- list of a FETCH statement" (PLS-394: niew�a�ciwa liczba warto�ci 
  -- na li�cie INTO instrukcji FETCH).
  FETCH k_WszystkieGrupy INTO z_Wydzial, z_Kurs;
END;
/
