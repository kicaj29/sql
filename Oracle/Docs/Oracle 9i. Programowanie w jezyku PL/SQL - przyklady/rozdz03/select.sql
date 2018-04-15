REM Select.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok pokazuje spos�b pobierania danych do rekordu.

DECLARE
  -- Nale�y zdefiniowa� rekord, aby dopasowa� niekt�re pola w tabeli studenci. 
  -- Dla tych p�l nale�y u�y� atrybutu %TYPE. 
  TYPE t_RekordStudenta IS RECORD (
    imie		 studenci.imie%TYPE,	 
    Nazwisko     studenci.nazwisko%TYPE,
    Specjalnosc  studenci.specjalnosc%TYPE);

  -- Zadeklarowanie zmiennej do pobrania danych.
  z_Student  t_RekordStudenta;
BEGIN
  -- Pobranie danych studenta o identyfikatorze ID 10 000.
  -- Nale�y zwr�ci� uwag� na to, jak zapytanie zwraca kolumny, kt�re 
  -- odpowiadaj� polom w rekordzie z_Student.
  SELECT imie, nazwisko, specjalnosc
    INTO z_Student
    FROM studenci
    WHERE ID = 10000;
END;
/