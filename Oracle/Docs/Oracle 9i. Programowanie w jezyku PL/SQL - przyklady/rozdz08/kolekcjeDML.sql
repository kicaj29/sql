REM kolekcjeDML.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten plik zawiera przyk³ady operacji DML dotycz¹cych kolekcji.

DECLARE
  z_KsiazkiINF ListaKsiazek := ListaKsiazek(1000, 1001, 1002);
  z_KsiazkiHIS ListaKsiazek := ListaKsiazek (2001);

BEGIN
  -- Wstawienie danych z wykorzystaniem nowo utworzonej, 2-elementowej tablicy  VARRAY.
  INSERT INTO grupy_materialy 
     VALUES('MUZ', 100, ListaKsiazek(3001, 3002));
  -- Wstawianie danych z wykorzystaniem poprzednio zainicjowanej, 3-elementowej tablicy VARRAY.
  INSERT INTO grupy_materialy VALUES('INF', 102, z_KsiazkiINF);
-- Wstawianie danych z wykorzystaniem poprzednio zainicjowanej, 1-elementowej tablicy VARRAY.
  INSERT INTO grupy_materialy VALUES('HIS', 101, z_KsiazkiHIS);
END;
/

DECLARE
  z_ListaStudentow1 ListaStudentow := ListaStudentow(10000, 10002, 10003);
  z_ListaStudentow2 ListaStudentow := ListaStudentow(10000, 10002, 10003);
  z_ListaStudentow3 ListaStudentow := ListaStudentow(10000, 10002, 10003);
BEGIN
  -- Najpierw wstawienie wierszy z tabelami zagnie¿d¿onymi o wartoœci NULL.
  INSERT INTO katalog_bibl (Numer_katalogowy, liczba_egz, liczba_wypozycz)
    VALUES (1000, 20, 3);
  INSERT INTO katalog_bibl (Numer_katalogowy, liczba_egz, liczba_wypozycz)
    VALUES (1001, 20, 3);
  INSERT INTO katalog_bibl (Numer_katalogowy, liczba_egz, liczba_wypozycz)
    VALUES (1002, 10, 3);
  INSERT INTO katalog_bibl (Numer_katalogowy, liczba_egz, liczba_wypozycz)
    VALUES (2001, 50, 0);
  INSERT INTO katalog_bibl (Numer_katalogowy, liczba_egz, liczba_wypozycz)
    VALUES (3001, 5, 0);
  INSERT INTO katalog_bibl (Numer_katalogowy, liczba_egz, liczba_wypozycz)
    VALUES (3002, 5, 1);
    
  -- Teraz zmodyfikujemy tabelê u¿ywaj¹c zmiennych PL/SQL.
  UPDATE katalog_bibl
    SET wypozyczono_dla = z_ListaStudentow1
    WHERE Numer_katalogowy = 1000;
  UPDATE katalog_bibl
    SET wypozyczono_dla = z_ListaStudentow2
    WHERE Numer_katalogowy = 1001;
  UPDATE katalog_bibl
    SET wypozyczono_dla = z_ListaStudentow3
    WHERE Numer_katalogowy = 1002;

  -- Oraz zmodyfikujemy ostatni wiersz wykorzystuj¹c now¹ zmienn¹.
  UPDATE katalog_bibl
    SET wypozyczono_dla = ListaStudentow(10009)
    WHERE Numer_katalogowy = 3002;
END;
/

DELETE FROM katalog_bibl
   WHERE Numer_katalogowy = 3001;
