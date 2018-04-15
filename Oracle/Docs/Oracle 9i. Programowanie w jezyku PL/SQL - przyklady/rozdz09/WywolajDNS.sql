REM WywolajDNS.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje wywo³anie funkcji DodajNowegoStudenta.

DECLARE
  -- Zmienne opisuj¹ce nowego studenta
  z_NoweImie  studenci.imie%TYPE := 'Cynthia';
  z_NoweNazwisko   studenci.nazwisko%TYPE := 'Camino';
  z_NowaSpecjalnosc studenci.specjalnosc%TYPE := 'Historia';
BEGIN
  -- Dodaj Cynthia'ê Camino do bazy danych.
  DodajNowegoStudenta(z_NoweImie, z_NoweNazwisko, z_NowaSpecjalnosc);
END;
/
