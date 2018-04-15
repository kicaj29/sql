REM PakietDziennika1.sql
REM Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten pakiet s³u¿y do rejestrowania po³¹czeñ i roz³¹czeñ z baz¹ danych

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
