REM extend.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok demonstruje zastosowanie metody EXTEND.

set serveroutput on

DECLARE
    z_TablicaLiczb TablicaLiczb := TablicaLiczb(1, 2, 3, 4, 5);
    z_ListaLiczb Licz_Var := Licz_Var(1, 2, 3, 4, 5);
BEGIN
    BEGIN
    -- To przypisanie spowoduje zg�oszenie wyj�tku SUBSCRIPT_BEYOND_COUNT,    
    -- poniewa� tablica z_TablicaLiczb ma tylko 5 element�w.
    z_TablicaLiczb(26) := -7;
    EXCEPTION
    WHEN SUBSCRIPT_BEYOND_COUNT THEN
        DBMS_OUTPUT.PUT_LINE(
           'Zg�oszono ORA-6533 z powodu przypisania do z_TablicaLiczb(26)');
    END;

    -- Mo�emy temu zaradzi� dodaj�c 30 dodatkowych element�w do
    -- tablicy z_TablicaLiczb.
    z_TablicaLiczb.EXTEND(30);
    -- I spr�bowa� przypisania raz jeszcze.
    z_TablicaLiczb(26) := -7;

 -- Tablic� varray mo�emy rozszerzy� tylko do jej maksymalnego rozmiaru
 -- (mo�emy go uzyska� za pomoc� metody LIMIT).  Przyk�adowo, poni�sza 
 -- instrukcja spowoduje zg�oszenie wyj�tku SUBSCRIPT_OUTSIDE_LIMIT:
BEGIN
    z_ListaLiczb.EXTEND(30);
 EXCEPTION
   WHEN SUBSCRIPT_OUTSIDE_LIMIT THEN
      DBMS_OUTPUT.PUT_LINE(
        'Zg�oszono ORA-6532 z powodu wywo�ania z_ListaLiczb.EXTEND(30)');
 END;

 -- Natomiast taka instrukcja jest poprawna.
  z_ListaLiczb.EXTEND(20);

 -- Mo�emy teraz przypisa� warto�� do elementu tablicy VARRAY o najwy�szym indeksie.
  z_ListaLiczb(25) := 25;
END;
/