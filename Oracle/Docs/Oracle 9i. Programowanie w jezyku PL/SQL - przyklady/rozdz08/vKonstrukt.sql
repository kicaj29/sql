REM vKonstrukt.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje kilka konstruktorów tablic varray.

DECLARE
 -- Definicja typu VARRAY.
 TYPE Liczby IS VARRAY(20) OF NUMBER(3);

 -- Zadeklarowanie tablicy VARRAY o wartoœci NULL.
 z_ListaNull Liczby;
 
 -- Ta tablica varray ma 2 elementy.
 z_Lista1 Liczby := Liczby(1, 2);
  
 -- Ta tablica varray ma jeden element, który ma wartoœæ NULL.
 z_Lista2 Liczby := Liczby(NULL);
BEGIN
 IF z_ListaNull IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('z_ListaNull ma wartoœæ NULL');
 END IF;
 
 IF z_Lista2(1) IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('z_Lista2(1) ma wartoœæ NULL');
 END IF;
END;
/