REM KursorPetla.sql
REM Rozdzia³ 1, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje pêtlê pobierania danych dla kursora.

DECLARE
  z_Imie VARCHAR2(20);
  z_Nazwisko VARCHAR2(20);
  -- Deklaracja kursora. Definiuje instrukcjê SQL zwracaj¹c¹ wiersze.
  CURSOR k_Studenci IS
    SELECT imie, nazwisko
      FROM studenci;
BEGIN
  -- Rozpocznij przetwarzanie kursora.
  OPEN k_Studenci;
  LOOP
    -- Pobierz jeden wiersz.
    FETCH k_Studenci INTO z_Imie, z_Nazwisko;
    -- Opuœæ pêtlê po pobraniu wszystkich wierszy.
    EXIT WHEN k_Studenci%NOTFOUND;
    /* Przetwarzaj dane */
  END LOOP;
  -- Zakoñcz przetwarzanie.
  CLOSE k_Studenci;
END;
/
