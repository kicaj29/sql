REM vPrzypisz.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten plik ilustruje prawid�owe i nieprawid�owe operacje przypisania do tablic varray.

DECLARE
  TYPE CiagiZnakow IS VARRAY(5) OF VARCHAR2(10);

  -- Zadeklarowanie tablicy varray zawieraj�cej trzy elementy
  z_Lista CiagiZnakow :=
  CiagiZnakow('Jeden', 'Dwa', 'Trzy');
BEGIN
  -- Indeks pomi�dzy 1, a 3, zatem to przypisanie jest poprawne.
  z_Lista(2) := 'DWA';
  
 -- Indeks poza zakresem, powoduje b��d ORA-6533.
  z_Lista(4) := '!!!';
END;
/

DECLARE
  TYPE CiagiZnakow IS VARRAY(5) OF VARCHAR2(10);
  -- Zadeklarowanie tablicy varray sk�adaj�cej si� z czterech element�w,
  z_Lista CiagiZnakow :=
  CiagiZnakow('Jeden', 'Dwa', 'Trzy', 'Cztery');
BEGIN
  -- Indeks pomi�dzy 1 a 4, zatem jest to operacja prawid�owa.
  z_Lista(2) := 'DWA';
   
  -- Rozszerzenie tablicy do 5 element�w i ustawienie warto�ci.
  z_Lista.EXTEND;
  z_Lista(5) := 'Pi��';
   
  -- Pr�ba rozszerzenia rozmiaru tablicy do 6 element�w.  Spowoduje to powstanie
  -- b��du ORA-6532. 
  z_Lista.EXTEND;
END;
/

