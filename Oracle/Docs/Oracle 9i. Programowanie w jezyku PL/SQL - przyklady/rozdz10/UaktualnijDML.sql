REM UaktualnijDML.sql
REM Rozdzia� 10., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM T� funkcj� mo�na wywo�a� z instrukcji DML w systemie Oracle8i.

CREATE OR REPLACE FUNCTION UaktualnijTymcz(p_ID IN studenci.ID%TYPE)
  RETURN studenci.ID%TYPE AS
BEGIN
  INSERT INTO tabela_tymcz (kol_num, kol_znak)
    VALUES(p_ID, 'Uaktualniono!');
  RETURN p_ID;
END UaktualnijTymcz;
/

UPDATE studenci
  SET specjalnosc = '�ywienie'
  WHERE UaktualnijTymcz(ID) = ID;
