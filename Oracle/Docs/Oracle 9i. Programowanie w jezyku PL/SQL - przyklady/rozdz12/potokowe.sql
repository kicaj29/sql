REM potokowe.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM To jest przyk³ad potokowej funkcji tabel.

DROP TYPE MojTyp;

CREATE TYPE MojTyp AS OBJECT (
  pole1 NUMBER,
  pole2 VARCHAR2(50));
/

DROP TYPE MojTypLista;

CREATE TYPE MojTypLista AS TABLE OF MojTyp;
/

CREATE OR REPLACE FUNCTION MojPotok
  RETURN MojTypLista PIPELINED AS
  z_MojTyp MojTyp;
BEGIN
  FOR z_Licznik IN 1..20 LOOP
    z_MojTyp := MojTyp(z_Licznik, 'Wiersz ' || z_Licznik);
    PIPE ROW(z_MojTyp);
  END LOOP;
  RETURN;
END MojPotok;
/

SELECT * FROM TABLE(MojPotok);