REM RejestrowaniePolaczen.sql
REM Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Te wyzwalacze rejestruj¹ wszystkie po³¹czenia i roz³¹czenia z baz¹ danych

CREATE OR REPLACE TRIGGER RejestrowaniePolaczen
   AFTER LOGON ON DATABASE
   CALL PakietDziennika.RejestrujPolaczenia(SYS.LOGIN_USER)
/

CREATE OR REPLACE TRIGGER RejestrowanieRozlaczen
   AFTER LOGON ON DATABASE
   CALL PakietDziennika.RejestrujRozlaczenia(SYS.LOGIN_USER)
/
