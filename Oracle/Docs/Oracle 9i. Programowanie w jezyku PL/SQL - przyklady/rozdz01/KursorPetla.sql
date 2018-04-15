REM KursorPetla.sql
REM Rozdzia� 1, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje p�tl� pobierania danych dla kursora.

DECLARE
  z_Imie VARCHAR2(20);
  z_Nazwisko VARCHAR2(20);
  -- Deklaracja kursora. Definiuje instrukcj� SQL zwracaj�c� wiersze.
  CURSOR k_Studenci IS
    SELECT imie, nazwisko
      FROM studenci;
BEGIN
  -- Rozpocznij przetwarzanie kursora.
  OPEN k_Studenci;
  LOOP
    -- Pobierz jeden wiersz.
    FETCH k_Studenci INTO z_Imie, z_Nazwisko;
    -- Opu�� p�tl� po pobraniu wszystkich wierszy.
    EXIT WHEN k_Studenci%NOTFOUND;
    /* Przetwarzaj dane */
  END LOOP;
  -- Zako�cz przetwarzanie.
  CLOSE k_Studenci;
END;
/
