REM PakietDziennika2.sql
REM Rozdzia� 11., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten pakiet s�u�y do rejestrowania po��czen i roz��cze� z baz� danych
REM Tre�� pakietu jest zaimplementowana jako procedury sk�adowane 
REM zapisane w j�zyku Java.

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