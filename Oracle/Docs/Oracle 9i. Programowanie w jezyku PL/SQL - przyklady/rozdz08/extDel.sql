REM extDel.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM W tym bloku zademonstrowano interakcje pomi�dzy metodami EXTEND oraz DELETE.

set serveroutput on

DECLARE
  -- Zainicjowanie tabeli 5-elementowej.
  z_Liczby TablicaLiczb := TablicaLiczb(-2, -1, 0, 1, 2);

  -- Procedura lokalna wy�wietlaj�ca tabele.
  PROCEDURE Wyswietl(p_Tabela IN TablicaLiczb) IS
    z_Indeks INTEGER;

  BEGIN
    z_Indeks := p_Tabela.FIRST;
    WHILE z_Indeks <= p_Tabela.LAST LOOP
      DBMS_OUTPUT.PUT('Element ' || z_Indeks || ': ');
      DBMS_OUTPUT.PUT_LINE(p_Tabela(z_Indeks));
      z_Indeks := p_Tabela.NEXT(z_Indeks);
    END LOOP;
  END Wyswietl;

BEGIN
  DBMS_OUTPUT.PUT_LINE('Po zainicjowaniu tabela z_Liczby zawiera ');
  Wyswietl(z_Liczby);

  -- Usuni�cie 3. elementu. Powoduje to usuni�cie elementu '0', ale miejsce
  -- po nim zostaje.
  z_Liczby.DELETE(3);

  DBMS_OUTPUT.PUT_LINE('Po usuni�ciu elementu tabela z_Liczby zawiera ');
  Wyswietl(z_Liczby);

  -- Dodanie do tabeli 2 kopii elementu 1 (r�wnego -2), czyli element�w 6 i 7.
  z_Liczby.EXTEND(2, 1);

  DBMS_OUTPUT.PUT_LINE('Po rozszerzeniu tabela z_Liczby zawiera ');
  Wyswietl(z_Liczby);

  DBMS_OUTPUT.PUT_LINE('z_Liczby.COUNT = ' || z_Liczby.COUNT);
  DBMS_OUTPUT.PUT_LINE('z_Liczby.LAST = ' || z_Liczby.LAST);
END;
/
