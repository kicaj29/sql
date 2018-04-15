REM DemoZbiorcze.sql
REM Rozdzia� 4., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt ilustruje przetwarzanie masowe.

DECLARE
  TYPE t_Liczby IS TABLE OF tabela_tymcz.kol_num%TYPE
    INDEX BY BINARY_INTEGER;
  TYPE t_Znaki IS TABLE OF tabela_tymcz.kol_znak%TYPE
    INDEX BY BINARY_INTEGER;
  z_Liczby t_Liczby;
  z_Znaki t_Znaki;
BEGIN
  -- Wype�nij tablic� wprowadzaj�c do niej 500 wierszy.
  FOR z_Licznik IN 1..500 LOOP
    z_Liczby(z_Licznik) := z_Licznik;
    z_Znaki(z_Licznik) := 'Numer wiersza ' || z_Licznik;
  END LOOP;

  -- a nast�pnie zapisz je w bazie danych.
  FOR z_Licznik IN 1..500 LOOP
    INSERT INTO tabela_tymcz VALUES
      (z_Liczby(z_Licznik), z_Znaki(z_Licznik));
  END LOOP;
END;
/

DECLARE
  TYPE t_Liczby IS TABLE OF tabela_tymcz.kol_num%TYPE
    INDEX BY BINARY_INTEGER;
  TYPE t_Znaki IS TABLE OF tabela_tymcz.kol_znak%TYPE
    INDEX BY BINARY_INTEGER;
  z_Liczby t_Liczby;
  z_Znaki t_Znaki;
BEGIN
  -- Wype�nienie tablicy poprzez wprowadzenie do niej 500 wierszy.
  FOR z_Licznik IN 1..500 LOOP
    z_Liczby(z_Licznik) := z_Licznik;
    z_Znaki(z_Licznik) := 'Numer wiersza ' || z_Licznik;
  END LOOP;

  -- a nast�pnie zapisanie ich do bazy danych.
  FOR z_Licznik IN 1..500 LOOP
    INSERT INTO tabela_tymcz VALUES
      (z_Liczby(z_Licznik), z_Znaki(z_Licznik));
  END LOOP;
END;
/
