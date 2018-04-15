REM PrzypiszTab.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje prawid�owe i nieprawid�owe operacje przypisania tabel.

DECLARE
   TYPE TablicaLiczb IS TABLE OF NUMBER;
   z_Liczby TablicaLiczb := TablicaLiczb(1, 2, 3);
BEGIN
  -- zmienn� z_Liczby zainicjowano z trzema elementami.
  -- Dlatego poni�sze przypisania s� poprawne.
  z_Liczby(1) := 7;
  z_Liczby(2) := -1;
 
  -- Natomiast to przypisanie spowoduje b��d ORA-6533.
  z_Liczby(4) := 4;
END;
/