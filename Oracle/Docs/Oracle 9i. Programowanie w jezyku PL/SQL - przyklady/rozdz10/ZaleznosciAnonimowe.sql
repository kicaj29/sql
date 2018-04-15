REM ZaleznosciAnonimowe.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten pakiet s³u¿y do zilustrowania zale¿noœci pomiêdzy
REM wywo³uj¹cym anonimowym blokiem a stanem wykonywania pakietu.

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
