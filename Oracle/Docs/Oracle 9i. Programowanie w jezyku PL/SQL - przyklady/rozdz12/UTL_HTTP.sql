REM UTL_HTTP.sql
REM Rozdzia� 12., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok demonstruje zastosowanie pakietu UTL_TCP. 

set serveroutput on size 200000

DROP TABLE wyniki_http;

CREATE TABLE wyniki_http (
  nr_sekwencji NUMBER PRIMARY KEY,
  fragment VARCHAR2(2000));
  
DECLARE
  z_Wynik UTL_HTTP.HTML_PIECES;
  z_URL VARCHAR2(100) := 'http://www.oracle.com';
  z_Proxy VARCHAR2(100) := 'TWOJ_SERWER_PROXY';
BEGIN
  -- To wywo�anie ilustruje dzia�anie pakietu UTL_HTTP
  -- w wydaniu 8.0.6. Spowoduje uzyskanie do 10 fragment�w
  -- odpowiedzi, ka�dy zawieraj�cy do 2000 znak�w.
  z_Wynik := UTL_HTTP.REQUEST_PIECES(z_URL, 10, z_Proxy);
  FOR z_Licznik IN 1..10 LOOP
    INSERT INTO wyniki_http VALUES (z_Licznik, z_Wynik(z_Licznik));
  END LOOP;
END;
/

SELECT * FROM wyniki_http
  ORDER BY nr_sekwencji;