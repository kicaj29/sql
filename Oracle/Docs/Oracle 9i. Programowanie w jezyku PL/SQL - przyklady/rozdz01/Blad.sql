REM Blad.sql
REM Rozdzia� 1, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje mo�liwo�ci obs�ugi b��d�w 
REM w j�zyku PL/SQL.

DECLARE
  z_KodBledu NUMBER;                 -- Kod b��du
  z_KomunikatBledu VARCHAR2(200);    -- Tekst komunikatu o b��dzie
  z_BiezacyUzytkownik VARCHAR2(8);   -- Bie��cy u�ytkownik bazy danych
  z_Informacje VARCHAR2(100);        -- Informacje o b��dzie
BEGIN
  /* W tym miejscu b�dzie kod, kt�ry przetwarza wybrane dane */
EXCEPTION
  WHEN OTHERS THEN
    -- Przydziel wartosci rejestrowanym zmiennym, wykorzystuj�c
    -- wbudowane funkcje.
    z_KodBledu := SQLCODE;
    z_KomunikatBledu := SQLERRM;
    z_BiezacyUzytkownik := USER;
    z_Informacje := 'U�ytkownik bazy danych' || z_BiezacyUzytkownik
    'napotka� na b��d w dniu' || TO_CHAR(SYSDATE) ||   ;
    -- Wprowadz komunikat do tabela_rejestru.
    INSERT INTO tabela_rejestru (kod, komunikat, informacje)
      VALUES (z_KodBledu, z_KomunikatBledu, z_Informacje);
END;

/
