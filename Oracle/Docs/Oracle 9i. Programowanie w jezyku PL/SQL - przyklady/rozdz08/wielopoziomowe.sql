REM wielopoziomowe.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje kolekcje wielopoziomowe.

DECLARE
  -- Najpierw, zadeklarowanie indeksowanej tabeli liczb
  TYPE t_Liczby IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
    
  -- Teraz zadeklarowanie typu bêd¹cego tabel¹ indeksowan¹ wartoœci typu t_Liczby.
  -- Jest to kolekcja wielopoziomowa.
  TYPE t_MultiLiczby IS TABLE OF t_Liczby
    INDEX BY BINARY_INTEGER;
    
  -- Mo¿emy tak¿e zdefiniowaæ tablicê varray elementów typu tabeli indeksowanej
  TYPE t_MultiVarray IS VARRAY(10) OF t_Liczby;
  
  -- lub tabelê zagnie¿d¿on¹
  TYPE t_MultiZagniezdz IS TABLE OF t_Liczby;
  
  z_MultiLiczby t_MultiLiczby;

BEGIN
  z_MultiLiczby(1)(1) := 12345;
END;
/
