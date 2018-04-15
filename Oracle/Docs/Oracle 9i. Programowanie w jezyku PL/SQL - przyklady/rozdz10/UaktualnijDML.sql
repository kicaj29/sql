REM UaktualnijDML.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Tê funkcjê mo¿na wywo³aæ z instrukcji DML w systemie Oracle8i.

CREATE OR REPLACE FUNCTION UaktualnijTymcz(p_ID IN studenci.ID%TYPE)
  RETURN studenci.ID%TYPE AS
BEGIN
  INSERT INTO tabela_tymcz (kol_num, kol_znak)
    VALUES(p_ID, 'Uaktualniono!');
  RETURN p_ID;
END UaktualnijTymcz;
/

UPDATE studenci
  SET specjalnosc = '¯ywienie'
  WHERE UaktualnijTymcz(ID) = ID;
