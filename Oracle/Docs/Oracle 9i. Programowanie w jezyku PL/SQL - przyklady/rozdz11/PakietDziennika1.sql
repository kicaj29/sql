REM PakietDziennika1.sql
REM Rozdzia� 11., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten pakiet s�u�y do rejestrowania po��cze� i roz��cze� z baz� danych

CREATE OR REPLACE PACKAGE PakietDziennika AS
  PROCEDURE RejestrujPolaczenia(p_UzytkID IN VARCHAR2);
  PROCEDURE RejestrujRozlaczenia(p_UzytkID IN VARCHAR2);
END PakietDziennika;
/

CREATE OR REPLACE PACKAGE BODY PakietDziennika AS
  PROCEDURE RejestrujPolaczenia(p_UzytkID IN VARCHAR2) IS
  BEGIN
    INSERT INTO audyt_polaczen (nazwa_uzytkownika, operacja, datownik)
      VALUES (p_UzytkID, 'POLACZENIE', SYSDATE);
  END RejestrujPolaczenia;

  PROCEDURE RejestrujRozlaczenia(p_UzytkID IN VARCHAR2) IS
  BEGIN
    INSERT INTO audyt_polaczen (nazwa_uzytkownika, operacja, datownik)
      VALUES (p_UzytkID, 'ROZLACZENIE', SYSDATE);
  END RejestrujRozlaczenia;
END PakietDziennika;
/
