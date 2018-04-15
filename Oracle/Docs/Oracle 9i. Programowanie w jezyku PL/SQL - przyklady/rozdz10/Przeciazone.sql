REM Przeciazone.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM W tym pakiecie zastosowano dyrektywê pragma RESTRICT_REFERENCES z
REM przeci¹¿onymi podprogramami.

CREATE OR REPLACE PACKAGE Przeciazone AS
  FUNCTION FunkcTest (p_Parametr1 IN NUMBER)
     RETURN VARCHAR2;
 PRAGMA RESTRICT_REFERENCES(FunkcTest, WNDS, RNPS, WNPS, RNPS);
  FUNCTION FunkcTest (p_ParametrA IN VARCHAR2,
                     P_ParametrB IN DATE)
     RETURN VARCHAR2;
  PRAGMA RESTRICT_REFERENCES(FunkcTest, WNDS, RNPS, WNPS, RNPS);
END Przeciazone; 
/

CREATE OR REPLACE PACKAGE BODY Przeciazone AS
  FUNCTION FunkcTest (p_Parametr1 IN NUMBER)
     RETURN VARCHAR2 IS
  BEGIN
     RETURN 'Wersja 1';
 END FunkcTest;

  FUNCTION FunkcTest (p_ParametrA IN VARCHAR2,
                      p_ParametrB IN DATE)
     RETURN VARCHAR2 IS
  BEGIN
     RETURN 'Wersja 2';
 END FunkcTest;

END Przeciazone;
/

SELECT Przeciazone.FunkcTest(1) FROM dual;
SELECT Przeciazone.FunkcTest('abc', SYSDATE) FROM dual;

