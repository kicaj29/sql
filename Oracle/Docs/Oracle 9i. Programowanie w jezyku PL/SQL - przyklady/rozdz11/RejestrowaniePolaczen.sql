REM RejestrowaniePolaczen.sql
REM Rozdzia� 11., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Te wyzwalacze rejestruj� wszystkie po��czenia i roz��czenia z baz� danych

CREATE OR REPLACE TRIGGER RejestrowaniePolaczen
   AFTER LOGON ON DATABASE
   CALL PakietDziennika.RejestrujPolaczenia(SYS.LOGIN_USER)
/

CREATE OR REPLACE TRIGGER RejestrowanieRozlaczen
   AFTER LOGON ON DATABASE
   CALL PakietDziennika.RejestrujRozlaczenia(SYS.LOGIN_USER)
/
