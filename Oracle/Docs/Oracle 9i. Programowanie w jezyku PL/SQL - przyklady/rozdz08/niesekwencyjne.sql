REM niesekwencyjne.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten plik prezentuje zapisywanie i pobieranie
REM tabeli zagnie¿d¿onej o kluczach niesekwencyjnych.


DROP TABLE znane_daty;
DROP TYPE TabelaDat;

CREATE OR REPLACE TYPE TabelaDat AS
  TABLE OF DATE;
/

CREATE TABLE znane_daty (
  klucz        VARCHAR2(100) PRIMARY KEY,
  lista_dat  TabelaDat)
  NESTED TABLE lista_dat STORE AS tabela_dat;

DECLARE
  -- Utworzenie tabeli zagnie¿d¿onej zawieraj¹cej 5 dat.
  z_Daty TabelaDat := TabelaDat(TO_DATE('04-JUL-1776', 'DD-MON-YYYY'),
                             TO_DATE('12-APR-1861', 'DD-MON-YYYY'),
                             TO_DATE('05-JUN-1968', 'DD-MON-YYYY'),
                             TO_DATE('26-JAN-1986', 'DD-MON-YYYY'),
                             TO_DATE('01-JAN-2001', 'DD-MON-YYYY'));

  -- Lokalna procedura wyœwietlaj¹ca zawartoœæ danych typu TabelaDat.
  PROCEDURE Wyswietl(p_Daty IN TabelaDat) IS
    z_Indeks BINARY_INTEGER := p_Daty.FIRST;
  BEGIN
    WHILE z_Indeks <= p_Daty.LAST LOOP
      DBMS_OUTPUT.PUT('  ' || z_Indeks || ': ');
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(p_Daty(z_Indeks), 
                                   'DD-MON-YYYY'));
      z_Indeks := p_Daty.NEXT(z_Indeks);
    END LOOP;
  END Wyswietl;

BEGIN
  -- Usuniêcie 2 elementu tabeli.  W wyniku otrzymamy tabelê z³o¿on¹ z
  -- 4 elementów.
  z_Daty.DELETE(2);

  DBMS_OUTPUT.PUT_LINE('Pocz¹tkowe wartoœci tabeli:');
  Wyswietl(z_Daty);

  -- Wstawienie tabeli zagnie¿d¿onej do bazy danych, a nastêpnie pobranie jej
  -- z bazy.
  INSERT INTO znane_daty (klucz, lista_dat)
    VALUES ('Daty w historii Ameryki', z_Daty);

  SELECT lista_dat
    INTO z_Daty
    FROM znane_daty
    WHERE klucz = 'Daty w historii Ameryki';

  DBMS_OUTPUT.PUT_LINE('Tabela po wykonaniu instrukcji INSERT i SELECT:');
  Wyswietl(z_Daty);
END;
/

