REM BladPakietu.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten pakiet nie skompiluje si�, poniewa� tre�� nie zgadza si� ze
REM specyfikacj�.

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

