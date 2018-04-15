REM SzybkieKopiowanie.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten pakiet prezentuje zwiêkszenie wydajnoœci
REM dziêki modyfikatorowi NOCOPY wprowadzonemu w systemie 8i.

set serveroutput on

CREATE OR REPLACE PACKAGE SzybkieKopiowanie AS
  -- tablica studentów PL/SQL.
  TYPE TablicaStudentow IS
    TABLE OF studenci%ROWTYPE;

  -- Trzy procedury pobieraj¹ce Parametr typu TablicaStudentow na
  -- ró¿ne sposoby.  Wszystkie trzy nie wykonuj¹ ¿adnych dzia³añ.
  PROCEDURE PrzekazStudenci1(p_Parametr IN TablicaStudentow);
  PROCEDURE PrzekazStudenci2(p_Parametr IN OUT TablicaStudentow);
  PROCEDURE PrzekazStudenci3(p_Parametr IN OUT NOCOPY TablicaStudentow);

  -- Procedura testowa.
  PROCEDURE Ruszaj;
END SzybkieKopiowanie;
/
show errors

CREATE OR REPLACE PACKAGE BODY SzybkieKopiowanie AS
  PROCEDURE PrzekazStudenci1(p_Parametr IN TablicaStudentow) IS
  BEGIN
    NULL;
  END PrzekazStudenci1;

  PROCEDURE PrzekazStudenci2(p_Parametr IN OUT TablicaStudentow) IS
  BEGIN
    NULL;
  END PrzekazStudenci2;

  PROCEDURE PrzekazStudenci3(p_Parametr IN OUT NOCOPY TablicaStudentow) IS
  BEGIN
    NULL;
  END PrzekazStudenci3;

  PROCEDURE Ruszaj IS
    z_TablicaStudentow TablicaStudentow := TablicaStudentow(NULL);
    z_StudentRek studenci%ROWTYPE;
    z_Czas1 NUMBER;
    z_Czas2 NUMBER;
    z_Czas3 NUMBER;
    z_Czas4 NUMBER;
  BEGIN
    -- Wype³nienie tablicy za pomoc¹ 50,001 kopii rekordu Davida Dinsmore.
    SELECT *
      INTO z_TablicaStudentow(1)
      FROM studenci
      WHERE ID = 10007;
    z_TablicaStudentow.EXTEND(50000, 1);

    -- Wywo³anie ka¿dej z wersji procedury PrzekazStudenci i pomiar czasu ich dzia³ania.
    -- Procedura DBMS_UTILITY.GET_TIME zwraca bie¿¹cy czas
    -- w setnych sekundy.
    z_Czas1 := DBMS_UTILITY.GET_TIME;
    PrzekazStudenci1(z_TablicaStudentow);
    z_Czas2 := DBMS_UTILITY.GET_TIME;
    PrzekazStudenci2(z_TablicaStudentow);
    z_Czas3 := DBMS_UTILITY.GET_TIME;
    PrzekazStudenci3(z_TablicaStudentow);
    z_Czas4 := DBMS_UTILITY.GET_TIME;

    -- Wyœwietlenie wyników.
    DBMS_OUTPUT.PUT_LINE('Czas przekazania parametru IN: ' ||
                         TO_CHAR((z_Czas2 - z_Czas1) / 100));
    DBMS_OUTPUT.PUT_LINE('Czas przekazania parametru IN OUT: ' ||
                         TO_CHAR((z_Czas3 -   z_Czas2) / 100));
    DBMS_OUTPUT.PUT_LINE('Czas przekazania parametru IN OUT NOCOPY: ' ||
                         TO_CHAR((z_Czas4 - z_Czas3) / 100));
  END Ruszaj;
END SzybkieKopiowanie;
/
show errors

BEGIN
  SzybkieKopiowanie.Ruszaj;
END;
/
