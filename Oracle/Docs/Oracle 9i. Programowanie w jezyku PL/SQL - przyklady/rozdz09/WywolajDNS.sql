REM WywolajDNS.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje wywo�anie funkcji DodajNowegoStudenta.

DECLARE
  -- Zmienne opisuj�ce nowego studenta
  z_NoweImie  studenci.imie%TYPE := 'Cynthia';
  z_NoweNazwisko   studenci.nazwisko%TYPE := 'Camino';
  z_NowaSpecjalnosc studenci.specjalnosc%TYPE := 'Historia';
BEGIN
  -- Dodaj Cynthia'� Camino do bazy danych.
  DodajNowegoStudenta(z_NoweImie, z_NoweNazwisko, z_NowaSpecjalnosc);
END;
/
