REM varray.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok pokazuje kilka deklaracji tablic varray.

DECLARE
  -- Kilka poprawnych typ�w varray.
  -- Lista liczb, dla kt�rych wprowadzono ograniczenie, �e 
  -- �adna z nich nie mo�e przyj�� warto�ci null.
  TYPE ListaLiczb IS VARRAY(10) OF NUMBER(3) NOT NULL;

  -- Lista rekord�w PL/SQL.
  TYPE ListaStudentow IS VARRAY(100) OF studenci%ROWTYPE;

  -- Lista obiekt�w.
  TYPE ListaObiektow is VARRAY(25) OF MojObiekt;

BEGIN
  NULL;
END;
/
