REM indeksowane.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten plik zawiera kilka przyk�ad�w tabel indeksowanych.


DECLARE
  TYPE TabelaNazw IS TABLE OF studenci.imie%TYPE
    INDEX BY BINARY_INTEGER;
  TYPE TabelaDat IS TABLE OF DATE
    INDEX BY BINARY_INTEGER;
  z_Nazwy TabelaNazw;
  z_Daty  TabelaDat;

BEGIN
  z_Nazwy(1) := 'Scott';
  z_Daty(-4) := SYSDATE - 1;
END;
/

DECLARE
  TYPE TabelaZnak IS TABLE OF VARCHAR2(10)
    INDEX BY BINARY_INTEGER;
  z_Znaki TabelaZnak;
BEGIN
  -- Przypisanie warto�ci do trzech element�w tabeli.  Zwr��my uwag� na to, �e
  -- warto�ci kluczy nie s� sekwencyjne.
  z_Znaki(0) := 'Harold';
  z_Znaki(-7) := 'Susan';
  z_Znaki(3) := 'Steve';
END;
/

set serveroutput on

DECLARE
  TYPE TabelaLiczb IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
    z_Liczby TabelaLiczb;
  BEGIN
  -- Przypisanie warto�ci do kilku element�w.
     FOR z_Licznik IN 1..10 LOOP
        z_Liczby(z_Licznik) := z_Licznik * 10;
     END LOOP;
  
  -- I wy�wietlenie ich
  DBMS_OUTPUT.PUT_LINE('Elementy tabeli: ');
  FOR z_Licznik IN 1..10 LOOP
     DBMS_OUTPUT.PUT_LINE('  z_Liczby(' || z_Licznik || '): ' ||
                          z_Liczby(z_Licznik));
  END LOOP;
  
  -- odczytanie warto�ci elementu z_Liczby(11).  Poniewa� jeszcze nie przypisano 
  -- do niego warto�ci, spowoduje to zg�oszenie wyj�tku NO_DATA_FOUND.
  BEGIN
     DBMS_OUTPUT.PUT_LINE('z_Liczby(11): ' || z_Liczby(11));
  EXCEPTION
     WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
          'Nie znaleziono danych podczas odczytywania z_Liczby(11)!');
  END;
END;
/
