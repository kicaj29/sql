REM trim.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM W tym bloku zaprezentowano metod� TRIM.

set serveroutput on

DECLARE
  -- Zainicjowanie tabeli 7-elementowej.
  z_Liczby TablicaLiczb := TablicaLiczb(-3, -2, -1, 0, 1, 2, 3);
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
  z_Liczby.DELETE(6);
  DBMS_OUTPUT.PUT_LINE('Po usuni�ciu elementu tabela z_Liczby zawiera');
  Wyswietl(z_Liczby);

  -- Odci�cie 3 ostatnich element�w, czyli 2, 3 oraz miejsca (kt�re teraz jest 
  -- puste), po elemencie o warto�ci 1.
  z_Liczby.TRIM(3);
  DBMS_OUTPUT.PUT_LINE('Po odci�ciu element�w tabela z_Liczby zawiera');
  Wyswietl(z_Liczby);
END;
/
