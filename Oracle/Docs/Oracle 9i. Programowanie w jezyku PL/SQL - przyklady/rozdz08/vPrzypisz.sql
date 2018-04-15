REM vPrzypisz.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten plik ilustruje prawid³owe i nieprawid³owe operacje przypisania do tablic varray.

DECLARE
  TYPE CiagiZnakow IS VARRAY(5) OF VARCHAR2(10);

  -- Zadeklarowanie tablicy varray zawieraj¹cej trzy elementy
  z_Lista CiagiZnakow :=
  CiagiZnakow('Jeden', 'Dwa', 'Trzy');
BEGIN
  -- Indeks pomiêdzy 1, a 3, zatem to przypisanie jest poprawne.
  z_Lista(2) := 'DWA';
  
 -- Indeks poza zakresem, powoduje b³¹d ORA-6533.
  z_Lista(4) := '!!!';
END;
/

DECLARE
  TYPE CiagiZnakow IS VARRAY(5) OF VARCHAR2(10);
  -- Zadeklarowanie tablicy varray sk³adaj¹cej siê z czterech elementów,
  z_Lista CiagiZnakow :=
  CiagiZnakow('Jeden', 'Dwa', 'Trzy', 'Cztery');
BEGIN
  -- Indeks pomiêdzy 1 a 4, zatem jest to operacja prawid³owa.
  z_Lista(2) := 'DWA';
   
  -- Rozszerzenie tablicy do 5 elementów i ustawienie wartoœci.
  z_Lista.EXTEND;
  z_Lista(5) := 'Piêæ';
   
  -- Próba rozszerzenia rozmiaru tablicy do 6 elementów.  Spowoduje to powstanie
  -- b³êdu ORA-6532. 
  z_Lista.EXTEND;
END;
/

