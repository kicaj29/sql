REM ZaleznosciAnonimowe.sql
REM Rozdzia� 10., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten pakiet s�u�y do zilustrowania zale�no�ci pomi�dzy
REM wywo�uj�cym anonimowym blokiem a stanem wykonywania pakietu.

CREATE OR REPLACE PACKAGE ProstyPakiet AS
  z_ZmGlobalna NUMBER := 1;
  PROCEDURE UaktualnijZm;
END ProstyPakiet;
/

CREATE OR REPLACE PACKAGE BODY ProstyPakiet AS
  PROCEDURE UaktualnijZm IS
  BEGIN
    z_ZmGlobalna := 7;
  END UaktualnijZm;
END ProstyPakiet;
/
