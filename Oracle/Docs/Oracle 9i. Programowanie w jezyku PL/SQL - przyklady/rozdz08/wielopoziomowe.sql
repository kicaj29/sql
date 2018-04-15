REM wielopoziomowe.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje kolekcje wielopoziomowe.

DECLARE
  -- Najpierw, zadeklarowanie indeksowanej tabeli liczb
  TYPE t_Liczby IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
    
  -- Teraz zadeklarowanie typu b�d�cego tabel� indeksowan� warto�ci typu t_Liczby.
  -- Jest to kolekcja wielopoziomowa.
  TYPE t_MultiLiczby IS TABLE OF t_Liczby
    INDEX BY BINARY_INTEGER;
    
  -- Mo�emy tak�e zdefiniowa� tablic� varray element�w typu tabeli indeksowanej
  TYPE t_MultiVarray IS VARRAY(10) OF t_Liczby;
  
  -- lub tabel� zagnie�d�on�
  TYPE t_MultiZagniezdz IS TABLE OF t_Liczby;
  
  z_MultiLiczby t_MultiLiczby;

BEGIN
  z_MultiLiczby(1)(1) := 12345;
END;
/
