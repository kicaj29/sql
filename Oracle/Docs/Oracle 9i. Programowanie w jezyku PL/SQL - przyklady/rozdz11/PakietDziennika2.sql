REM PakietDziennika2.sql
REM Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten pakiet s³u¿y do rejestrowania po³¹czen i roz³¹czeñ z baz¹ danych
REM Treœæ pakietu jest zaimplementowana jako procedury sk³adowane 
REM zapisane w jêzyku Java.

CREATE OR REPLACE PACKAGE PakietDziennika AS
  PROCEDURE RejestrujPolaczenia(p_UzytkID IN VARCHAR2);
  PROCEDURE RejestrujRozlaczenia(p_UzytkID IN VARCHAR2);
END PakietDziennika;
/

CREATE OR REPLACE PACKAGE BODY PakietDziennika AS
  PROCEDURE RejestrujPolaczenia(p_UzytkID IN VARCHAR2) IS
     LANGUAGE JAVA
     NAME 'Rejestrator.RejestrowaniePolaczen(java.lang.String)';
  PROCEDURE RejestrujRozlaczenia(p_UzytkID IN VARCHAR2) IS
  LANGUAGE JAVA
     NAME 'Rejestrator.RejestrowanieRozlaczen(java.lang.String)'; 
END PakietDziennika;
/