REM BladWartosci.sql
REM Rozdzia³ 7., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM W tym przyk³adzie nastêpuje zg³oszenie wyj¹tku VALUE_ERROR na 
REM dwa ró¿ne sposoby.

DECLARE
  z_ZmTymcz VARCHAR2(3);
BEGIN
  z_ZmTymcz := 'ABCD';
END;
/

DECLARE
  z_ZmTymcz VARCHAR2(2);
BEGIN
  SELECT id
    INTO z_ZmTymcz
    FROM studenci
    WHERE nazwisko = 'Smith';
END;
/