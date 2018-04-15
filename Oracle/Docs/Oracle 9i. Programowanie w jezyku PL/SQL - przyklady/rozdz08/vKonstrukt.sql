REM vKonstrukt.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje kilka konstruktor�w tablic varray.

DECLARE
 -- Definicja typu VARRAY.
 TYPE Liczby IS VARRAY(20) OF NUMBER(3);

 -- Zadeklarowanie tablicy VARRAY o warto�ci NULL.
 z_ListaNull Liczby;
 
 -- Ta tablica varray ma 2 elementy.
 z_Lista1 Liczby := Liczby(1, 2);
  
 -- Ta tablica varray ma jeden element, kt�ry ma warto�� NULL.
 z_Lista2 Liczby := Liczby(NULL);
BEGIN
 IF z_ListaNull IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('z_ListaNull ma warto�� NULL');
 END IF;
 
 IF z_Lista2(1) IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('z_Lista2(1) ma warto�� NULL');
 END IF;
END;
/