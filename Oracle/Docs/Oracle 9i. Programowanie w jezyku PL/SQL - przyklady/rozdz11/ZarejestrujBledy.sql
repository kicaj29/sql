REM ZarejestrujBledy.sql
REM Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten wyzwalacz demonstruje zastosowanie 
REM funkcji DBMS_UTILITY.FORMAT_ERROR_STACK w wyzwalaczu  SERVERERROR.

DROP TABLE dziennik_bledow;

CREATE TABLE dziennik_bledow (
   datownik             DATE,
   nazwa_uzytkownika    VARCHAR2(30),
   egzemplarz           NUMBER,
   nazwa_bazy_danych    VARCHAR2(50),
   stos_bledow          VARCHAR2(2000)
);

CREATE OR REPLACE TRIGGER ZarejestrujBledy
    AFTER SERVERERROR ON DATABASE
BEGIN
    INSERT INTO dziennik_bledow
        VALUES (SYSDATE, SYS.LOGIN_USER, SYS.INSTANCE_NUM, SYS.DATABASE_NAME,
                DBMS_UTILITY.FORMAT_ERROR_STACK);

END ZarejestrujBledy;
/

REM Wygenerowanie kilku b³êdów
SELECT * FROM nie_istniejaca_tabela;

BEGIN
   INSERT INTO nie_istniejaca_tabela VALUES ('Witajcie!');
END;
/

BEGIN
-- To jest b³¹d syntaktyczny!
      DELETE FROM studenci
END;
/

DECLARE
   z_ZmLancuchowa VARCHAR2(2);
BEGIN
   -- To jest b³¹d wykonania!
   z_ZmLancuchowar := 'abcdef';
END;
/

COLUMN stos_bledow FORMAT a61 WRAPPED
SET LINE 80

SELECT *
  FROM dziennik_bledow;
