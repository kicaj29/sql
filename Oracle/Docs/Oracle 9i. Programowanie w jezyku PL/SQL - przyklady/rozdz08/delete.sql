REM delete.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM W tym bloku zilustrowano metod� DELETE.

set serveroutput on

DECLARE
  -- Zainicjowanie tabeli 10-elementowej.
  z_Liczby TablicaLiczb := TablicaLiczb(10, 20, 30, 40, 50, 60, 70, 80, 90, 100);

  -- Procedura lokalna wy�wietlaj�ca tabel�.
  PROCEDURE Wyswietl(p_Tabela IN TablicaLiczb) IS
    z_Indeks INTEGER;
  BEGIN
    z_Indeks := p_Tabela.FIRST;
    WHILE z_Indeks <= p_Tabela.LAST LOOP
      DBMS_OUTPUT.PUT('Element ' || z_Indeks || ': ');
      DBMS_OUTPUT.PUT_LINE(p_Tabela(z_Indeks));
      z_Indeks := p_Tabela.NEXT(z_Indeks);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('COUNT = ' || p_Tabela.COUNT);
    DBMS_OUTPUT.PUT_LINE('LAST = ' || p_Tabela.LAST);
  END Wyswietl;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Po zainicjowaniu tabela z_Liczby zawiera');
  Wyswietl(z_Liczby);

  -- Usuni�cie elementu 6.
  DBMS_OUTPUT.PUT_LINE('Po usuni�ciu elementu 6 tabela z_Liczby zawiera');
  z_Liczby.DELETE(6);
  Wyswietl(z_Liczby);

  -- Usuni�cie element�w od 7 do 9.
  DBMS_OUTPUT.PUT_LINE('Po usuni�ciu element�w 7-9 tabela z_Liczby zawiera');
  z_Liczby.DELETE(7,9);
  Wyswietl(z_Liczby);
END;
/
