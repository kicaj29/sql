REM 3gl_4gl.sql
REM Rozdzia³ 1, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok pokazuje zarówno instrukcje 3GL, jak równie¿ 4GL.	

DECLARE
  /* Zadeklaruj zmienne, które bêd¹ stosowane w instrukcjach SQL */
   z_NowaSpecjalnosc VARCHAR2(10) := 'Historia';
   z_Imie VARCHAR2(10) := 'Scott';
   z_Nazwisko VARCHAR2(10) := 'Urman';
BEGIN
  /* Uaktualnij tabelê studenci. */
  UPDATE studenci
    SET specjalnosc = z_NowaSpecjalnosc
    WHERE imie = z_Imie
    AND nazwisko = z_Nazwisko;
  /* SprawdŸ, czy rekord zosta³ znaleziony. Je¿eli nie, wstaw rekord. */
  IF SQL%NOTFOUND THEN
    INSERT INTO studenci (ID, imie, nazwisko, specjalnosc)
      VALUES (studenci_sekwencja.NEXTVAL, z_Imie, z_Nazwisko, z_NowaSpecjalnosc);
  END IF;
END;
/
ROLLBACK;
