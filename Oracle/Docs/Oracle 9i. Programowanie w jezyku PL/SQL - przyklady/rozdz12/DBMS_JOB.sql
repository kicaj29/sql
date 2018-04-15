REM DBMS_JOB.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt demonstruje zastosowanie pakietu DBMS_JOB. 

DROP SEQUENCE sek_tymcz;

CREATE SEQUENCE sek_tymcz
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE PROCEDURE TymczInsert AS
BEGIN
  INSERT INTO tabela_tymcz (kol_num, kol_znak)
    VALUES (sek_tymcz.NEXTVAL,
            TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));
  COMMIT;
END TymczInsert;
/

VARIABLE z_nrZadania NUMBER
BEGIN
   DBMS_JOB.SUBMIT(:z_nrZadania, 'TymczInsert;', SYSDATE,
                  'SYSDATE + (90/(24*60*60))');
   COMMIT;
END;
/

-- Ten blok spowoduje usuniêcie zadania.
BEGIN
  DBMS_JOB.REMOVE(:z_nrZadania);
  COMMIT;
END;
/