REM BladWartosci.sql
REM Rozdzia� 7., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM W tym przyk�adzie nast�puje zg�oszenie wyj�tku VALUE_ERROR na 
REM dwa r�ne sposoby.

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