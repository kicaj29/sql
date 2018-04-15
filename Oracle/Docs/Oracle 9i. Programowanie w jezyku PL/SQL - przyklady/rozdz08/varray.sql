REM varray.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok pokazuje kilka deklaracji tablic varray.

DECLARE
  -- Kilka poprawnych typów varray.
  -- Lista liczb, dla których wprowadzono ograniczenie, ¿e 
  -- ¿adna z nich nie mo¿e przyj¹æ wartoœci null.
  TYPE ListaLiczb IS VARRAY(10) OF NUMBER(3) NOT NULL;

  -- Lista rekordów PL/SQL.
  TYPE ListaStudentow IS VARRAY(100) OF studenci%ROWTYPE;

  -- Lista obiektów.
  TYPE ListaObiektow is VARRAY(25) OF MojObiekt;

BEGIN
  NULL;
END;
/
