REM PetlaKursora.sql
REM Rozdzia� 6., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje jawn� p�tl� pobierania dla kursora.

DECLARE
  /* Zmienne wyj�ciowe do przechowywania wynik�w zapytania */
  z_IDStudenta   studenci.id%TYPE;
  z_Imie         studenci.imie%TYPE;
  z_Nazwisko     studenci.nazwisko%TYPE;

  /* Zmienna dowi�zana u�yta w zapytaniu */
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
    /* Pobierz ka�dy wiersz zbioru wynikowego do zmiennych PL/SQL */
    FETCH k_Studenci INTO z_IDStudenta, z_Imie, z_Nazwisko;

    /* Wyj�cie z p�tli, je�eli nie ma wi�cej wierszy do pobrania. */
    EXIT WHEN k_Studenci%NOTFOUND;
  END LOOP;

  /* Zwolnienie zasob�w wykorzystanych przez zapytanie */
  CLOSE k_Studenci;
END; 
/
