REM trim.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM W tym bloku zaprezentowano metodê TRIM.

set serveroutput on

DECLARE
  -- Zainicjowanie tabeli 7-elementowej.
  z_Liczby TablicaLiczb := TablicaLiczb(-3, -2, -1, 0, 1, 2, 3);
  -- Procedura lokalna wyœwietlaj¹ca tabelê.
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

  -- Usuniêcie elementu 6.
  z_Liczby.DELETE(6);
  DBMS_OUTPUT.PUT_LINE('Po usuniêciu elementu tabela z_Liczby zawiera');
  Wyswietl(z_Liczby);

  -- Odciêcie 3 ostatnich elementów, czyli 2, 3 oraz miejsca (które teraz jest 
  -- puste), po elemencie o wartoœci 1.
  z_Liczby.TRIM(3);
  DBMS_OUTPUT.PUT_LINE('Po odciêciu elementów tabela z_Liczby zawiera');
  Wyswietl(z_Liczby);
END;
/
