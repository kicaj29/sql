REM 3gl_4gl.sql
REM Rozdzia� 1, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok pokazuje zar�wno instrukcje 3GL, jak r�wnie� 4GL.	

DECLARE
  /* Zadeklaruj zmienne, kt�re b�d� stosowane w instrukcjach SQL */
   z_NowaSpecjalnosc VARCHAR2(10) := 'Historia';
   z_Imie VARCHAR2(10) := 'Scott';
   z_Nazwisko VARCHAR2(10) := 'Urman';
BEGIN
  /* Uaktualnij tabel� studenci. */
  UPDATE studenci
    SET specjalnosc = z_NowaSpecjalnosc
    WHERE imie = z_Imie
    AND nazwisko = z_Nazwisko;
  /* Sprawd�, czy rekord zosta� znaleziony. Je�eli nie, wstaw rekord. */
  IF SQL%NOTFOUND THEN
    INSERT INTO studenci (ID, imie, nazwisko, specjalnosc)
      VALUES (studenci_sekwencja.NEXTVAL, z_Imie, z_Nazwisko, z_NowaSpecjalnosc);
  END IF;
END;
/
ROLLBACK;
