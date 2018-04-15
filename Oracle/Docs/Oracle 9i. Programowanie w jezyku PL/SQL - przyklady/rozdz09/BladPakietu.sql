REM BladPakietu.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten pakiet nie skompiluje siê, poniewa¿ treœæ nie zgadza siê ze
REM specyfikacj¹.

CREATE OR REPLACE PACKAGE PakietA AS
  FUNCTION FunkcjaA (p_Parametr1 IN NUMBER,
                     P_Parametr2 IN DATE)

    RETURN VARCHAR2;
END PakietA;
/

show errors

CREATE OR REPLACE PACKAGE BODY PakietA AS
  FUNCTION FunkcjaA (p_Parametr1 IN CHAR)
    RETURN VARCHAR2;
END PakietA;
/
show errors

