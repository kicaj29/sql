REM Blad.sql
REM Rozdzia³ 1, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje mo¿liwoœci obs³ugi b³êdów 
REM w jêzyku PL/SQL.

DECLARE
  z_KodBledu NUMBER;                 -- Kod b³êdu
  z_KomunikatBledu VARCHAR2(200);    -- Tekst komunikatu o b³êdzie
  z_BiezacyUzytkownik VARCHAR2(8);   -- Bie¿¹cy u¿ytkownik bazy danych
  z_Informacje VARCHAR2(100);        -- Informacje o b³êdzie
BEGIN
  /* W tym miejscu bêdzie kod, który przetwarza wybrane dane */
EXCEPTION
  WHEN OTHERS THEN
    -- Przydziel wartosci rejestrowanym zmiennym, wykorzystuj¹c
    -- wbudowane funkcje.
    z_KodBledu := SQLCODE;
    z_KomunikatBledu := SQLERRM;
    z_BiezacyUzytkownik := USER;
    z_Informacje := 'U¿ytkownik bazy danych' || z_BiezacyUzytkownik
    'napotka³ na b³¹d w dniu' || TO_CHAR(SYSDATE) ||   ;
    -- Wprowadz komunikat do tabela_rejestru.
    INSERT INTO tabela_rejestru (kod, komunikat, informacje)
      VALUES (z_KodBledu, z_KomunikatBledu, z_Informacje);
END;

/
