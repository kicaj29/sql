REM Select.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok pokazuje sposób pobierania danych do rekordu.

DECLARE
  -- Nale¿y zdefiniowaæ rekord, aby dopasowaæ niektóre pola w tabeli studenci. 
  -- Dla tych pól nale¿y u¿yæ atrybutu %TYPE. 
  TYPE t_RekordStudenta IS RECORD (
    imie		 studenci.imie%TYPE,	 
    Nazwisko     studenci.nazwisko%TYPE,
    Specjalnosc  studenci.specjalnosc%TYPE);

  -- Zadeklarowanie zmiennej do pobrania danych.
  z_Student  t_RekordStudenta;
BEGIN
  -- Pobranie danych studenta o identyfikatorze ID 10 000.
  -- Nale¿y zwróciæ uwagê na to, jak zapytanie zwraca kolumny, które 
  -- odpowiadaj¹ polom w rekordzie z_Student.
  SELECT imie, nazwisko, specjalnosc
    INTO z_Student
    FROM studenci
    WHERE ID = 10000;
END;
/