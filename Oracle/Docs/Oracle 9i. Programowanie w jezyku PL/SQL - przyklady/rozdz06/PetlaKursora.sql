REM PetlaKursora.sql
REM Rozdzia³ 6., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje jawn¹ pêtlê pobierania dla kursora.

DECLARE
  /* Zmienne wyjœciowe do przechowywania wyników zapytania */
  z_IDStudenta   studenci.id%TYPE;
  z_Imie         studenci.imie%TYPE;
  z_Nazwisko     studenci.nazwisko%TYPE;

  /* Zmienna dowi¹zana u¿yta w zapytaniu */
  z_Specjalnosc       studenci.specjalnosc%TYPE := 'Informatyka';

  /* Deklaracja kursora */
  CURSOR k_Studenci IS
    SELECT id, imie, nazwisko
      FROM studenci
      WHERE specjalnosc = z_Specjalnosc;
BEGIN 
  /* Zidentyfikuj wiersze w zbiorze wynikowym i przygotuj do dalszego 
     przetwarzania danych */
  OPEN k_Studenci;
  LOOP
    /* Pobierz ka¿dy wiersz zbioru wynikowego do zmiennych PL/SQL */
    FETCH k_Studenci INTO z_IDStudenta, z_Imie, z_Nazwisko;

    /* Wyjœcie z pêtli, je¿eli nie ma wiêcej wierszy do pobrania. */
    EXIT WHEN k_Studenci%NOTFOUND;
  END LOOP;

  /* Zwolnienie zasobów wykorzystanych przez zapytanie */
  CLOSE k_Studenci;
END; 
/
