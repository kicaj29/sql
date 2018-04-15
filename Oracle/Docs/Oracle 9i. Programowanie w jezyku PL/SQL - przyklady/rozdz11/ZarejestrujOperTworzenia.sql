REM ZarejestrujOperTworzenia.sql
REM Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten plik zawiera wyzwalacz systemowy.

DROP TABLE tworzenie_ddl;

CREATE TABLE tworzenie_ddl(
   id_uzytkownika     VARCHAR2(30),
   typ_obiektu        VARCHAR2(20),
   nazwa_obiektu      VARCHAR2(30),
   wlasciciel_obiektu VARCHAR2(30),
   data_utworzenia    DATE);

CREATE OR REPLACE TRIGGER ZarejestrujOperTworzenia
  AFTER CREATE ON DATABASE
BEGIN
  INSERT INTO tworzenie_ddl (id_uzytkownika, typ_obiektu, nazwa_obiektu,
                             wlasciciel_obiektu, data_utworzenia)
    VALUES (USER, SYS.DICTIONARY_OBJ_TYPE, SYS.DICTIONARY_OBJ_NAME,
            SYS.DICTIONARY_OBJ_OWNER, SYSDATE);
END ZarejestrujOperTworzenia;
/
