REM ExceptionInit.sql
REM Rozdzia� 7.1, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje zastosowanie dyrektywy pragma EXCEPTION_INIT.


DELETE FROM dziennik_bledow;

DECLARE
  w_BrakujacyNull EXCEPTION;
  PRAGMA EXCEPTION_INIT(w_BrakujacyNull, -1400);
BEGIN
  INSERT INTO studenci (id) VALUES (NULL);
EXCEPTION
  WHEN w_BrakujacyNull then
    INSERT INTO dziennik_bledow (informacja) VALUES ('Wyst�pi� b��d ORA-1400');
END;
/

SELECT * FROM dziennik_bledow;
