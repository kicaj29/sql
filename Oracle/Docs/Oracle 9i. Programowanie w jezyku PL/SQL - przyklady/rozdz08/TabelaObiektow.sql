REM tabObject.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok prezentuje tabelê indeksowan¹ z³o¿on¹ z typów obiektowych.

CREATE OR REPLACE TYPE MojObiekt AS OBJECT (
  pole1 NUMBER,
  pole2 VARCHAR2(20),
  pole3 DATE);
/

DECLARE
  TYPE TabelaObiektow IS TABLE OF MojObiekt
    INDEX BY BINARY_INTEGER;
  /* Ka¿dy element zmiennej z_Obiekty jest egzemplarzem obiektu typu MojObiekt */
  z_Obiekty TabelaObiektow;
BEGIN
  /* Bezpoœrednie przypisanie wartoœci do z_Obiekty(1).  Najpierw nale¿y zainicjowaæ
   * typ obiektowy. */
  z_Obiekty(1) := MojObiekt(1, NULL, NULL);
  z_Obiekty(1).pole2 := 'Witajcie w Œwiecie!';
  z_Obiekty(1).pole3 := SYSDATE;
END;
/
