REM zagniezdzone.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje zastosowanie tabel zagnie¿d¿onych.

DECLARE
  -- Definicja typu tablicowego na podstawie typu obiektowego
  TYPE TablicaObiektow IS TABLE OF MojObiekt;

  -- Tabela zagnie¿d¿ona z u¿yciem %ROWTYPE
  TYPE TablicaStudentow IS TABLE OF studenci%ROWTYPE;

  -- Zmienne typów zdefiniowanych powy¿ej
  z_ListaGrupy TablicaStudentow;
  z_ListaObiektow TablicaObiektow;

BEGIN
  -- Takie przypisanie spowoduje zg³oszenie wyj¹tku COLLECTION_IS_NULL, poniewa¿
  -- do zmiennej z_ListaObiektow automatycznie przypisano wartoœæ NULL.
  z_ListaObiektow(1) := MojObiekt(-17, 'Do widzenia', TO_DATE('01-01-2001', 'DD-MM-YYYY'));
END;
/
