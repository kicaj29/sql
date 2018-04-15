REM UTL_FILE.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok demonstruje zastosowanie pakietu UTL_FILE. 

DECLARE
  z_UchwytPliku UTL_FILE.FILE_TYPE;
BEGIN
  -- Otwarcie pliku /tmp/utl_file.txt do zapisu.  Je¿eli plik 
  -- nie istnieje - utworzenie go.  Je¿eli plik istnieje -
  -- nadpisanie jego zawartoœæi
  z_UchwytPliku := UTL_FILE.FOPEN('/tmp/', 'utl_file.txt', 'w');
  
  -- Zapisanie kilku wierszy do pliku.
  UTL_FILE.PUT_LINE(z_UchwytPliku, 'To jest wiersz 1!');
  FOR z_Licznik IN 2..11 LOOP
    UTL_FILE.PUTF(z_UchwytPliku, 'To jest wiersz %s!\n', z_Licznik);
  END LOOP;
  
  -- Zamkniêcie pliku.
  UTL_FILE.FCLOSE(z_UchwytPliku);
END;
/

