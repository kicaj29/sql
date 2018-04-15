REM Kolekcje.sql
REM Rozdzia� 1, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok pokazuje kolekcje w j�zyku PL/SQL.

DECLARE
  TYPE t_IndexBy IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
  TYPE t_Zagniezdz IS TABLE OF NUMBER;
  TYPE t_Varray IS VARRAY(10) OF NUMBER;

  z_IndexBy t_IndexBy;
  z_Zagniezdz t_Zagniezdz;
  z_Varray t_Varray;
BEGIN
  z_IndexBy(1) := 1;
  z_IndexBy(2) := 2;
  z_Zagniezdz := t_Zagniezdz(1, 2, 3, 4, 5);
  z_Varray := t_Varray(1, 2);
END;
/
