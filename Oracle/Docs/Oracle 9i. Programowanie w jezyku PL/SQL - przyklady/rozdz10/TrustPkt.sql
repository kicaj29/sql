REM TrustPkt.sql
REM Rozdzia� 10., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM W tym pakiecie zastosowano s�owo kluczowe TRUST wraz z dyrektyw� pragma RESTRICT_REFERENCES.

CREATE OR REPLACE PACKAGE TrustPkt AS
  FUNCTION NaWielkie (p_a VARCHAR2) RETURN VARCHAR2 IS
    LANGUAGE JAVA
    NAME 'Test.NaWielkie(char[]) return char[]';
    PRAGMA RESTRICT_REFERENCES(NaWielkie, WNDS, TRUST);

  PROCEDURE Demo(p_we IN VARCHAR2, p_wy OUT VARCHAR2);
  PRAGMA RESTRICT_REFERENCES(Demo, WNDS);
END TrustPkt;
/

CREATE OR REPLACE PACKAGE BODY TrustPkt AS
  PROCEDURE Demo(p_we IN VARCHAR2, p_wy OUT VARCHAR2) IS
  BEGIN
    p_wy := NaWielkie(p_we);
  END Demo;
END TrustPkt;
/
