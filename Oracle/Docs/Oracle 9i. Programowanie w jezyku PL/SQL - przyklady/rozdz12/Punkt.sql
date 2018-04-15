REM Punkt.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten obiekt reprezentuje punkt w uk³adzie Kartezjañskim.

CREATE OR REPLACE TYPE Punkt AS OBJECT (
  -- Punkt jest reprezentowany przez swoje po³o¿enie w uk³adzie
  -- kartezjañskim X-Y.
  x NUMBER,
  y NUMBER,

  -- Zwraca ci¹g '(x, y)'
  MEMBER FUNCTION NaCiag RETURN VARCHAR2,
  PRAGMA RESTRICT_REFERENCES(NaCiag, RNDS, WNDS, RNPS, WNPS),

  -- Zwraca odleg³oœæ pomiêdzy p, a bie¿¹cym punktem (SELF).
  -- Je¿eli  nie okreœlono p, wartoœci¹ domyœln¹ jest (0, 0).
  MEMBER FUNCTION Dystans(p IN Punkt DEFAULT Punkt(0,0))
    RETURN NUMBER,
  PRAGMA RESTRICT_REFERENCES(Dystans, RNDS, WNDS, RNPS, WNPS),

  -- Zwraca sumê parametru  p i bie¿¹cego punktu.
  MEMBER FUNCTION Plus(p IN Punkt) RETURN Punkt,
  PRAGMA RESTRICT_REFERENCES(Plus, RNDS, WNDS, RNPS, WNPS),

  -- Zwraca iloczyn bie¿¹cego punktu * n.
  MEMBER FUNCTION Razy(n IN NUMBER) RETURN Punkt,
  PRAGMA RESTRICT_REFERENCES(Razy, RNDS, WNDS, RNPS, WNPS)
);

CREATE OR REPLACE TYPE BODY Punkt AS
  -- Zwraca ci¹g '(x, y)'
  MEMBER FUNCTION NaCiag RETURN VARCHAR2 IS
    z_Wynik VARCHAR2(20);
    z_Ciagx VARCHAR2(8) := SUBSTR(TO_CHAR(x), 1, 8);
    z_Ciagy VARCHAR2(8) := SUBSTR(TO_CHAR(y), 1, 8);
  BEGIN
    z_Wynik := '(' || z_Ciagx || ', ';
    z_Wynik := z_Wynik || z_Ciagy || ')';
    RETURN z_Wynik;
  END NaCiag;

  
  -- Zwraca odleg³oœæ pomiêdzy p, a bie¿¹cym punktem (SELF).
  -- Je¿eli  nie okreœlono p, wartoœci¹ domyœln¹ jest (0, 0).
  MEMBER FUNCTION Dystans(p IN Punkt DEFAULT Punkt(0,0))
    RETURN NUMBER IS
  BEGIN
    RETURN SQRT(POWER(x - p.x, 2) + POWER(y - p.y, 2));
  END Dystans;

  -- Zwraca sumê parametru  p i bie¿¹cego punktu.
  MEMBER FUNCTION Plus(p IN Punkt) RETURN Punkt IS
    z_Wynik Punkt;
  BEGIN
    z_Wynik := Punkt(x + p.x, y + p.y);
    RETURN z_Wynik;
  END Plus;

  -- Zwraca iloczyn bie¿¹cego punktu * n.
  MEMBER FUNCTION Razy(n IN NUMBER) RETURN Punkt IS
    z_Wynik Punkt;
  BEGIN
    z_Wynik := Punkt(x * n, y * n);
    RETURN z_Wynik;
  END Razy;
END;
/
show errors

set serveroutput on

-- Demonstracja kilku punktów.

DECLARE
     z_Punkt1 Punkt := Punkt(1, 2);
     z_Punkt2 Punkt;
     z_Punkt3 Punkt;
   BEGIN
     z_Punkt2 := z_Punkt1.Razy(4);
     z_Punkt3 := z_Punkt1.Plus(z_Punkt2);
     DBMS_OUTPUT.PUT_LINE('Punkt 2.: ' || z_Punkt2.NaCiag);
     DBMS_OUTPUT.PUT_LINE('Punkt 3.: ' || z_Punkt3.NaCiag);
     DBMS_OUTPUT.PUT_LINE('Dystans od pocz¹tku uk³adu do Punktu 1.: ' ||
         z_Punkt1.Dystans);
     DBMS_OUTPUT.PUT_LINE('Dystans pomiêdzy Punktem 1., a Punktem 2.: ' ||
         z_Punkt1.Dystans(z_Punkt2));
  END;
/