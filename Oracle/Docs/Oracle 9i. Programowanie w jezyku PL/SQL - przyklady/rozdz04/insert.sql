REM insert.sql
REM Rozdzia� 4., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje kilka instrukcji INSERT.

DECLARE
  z_StudentID  studenci.id%TYPE;
BEGIN
  -- Pobierz nowy identyfikator ID studenta 
  SELECT studenci_sekwencja.NEXTVAL
    INTO z_StudentID
    FROM dual;

  -- Dodaj wiersz do tabeli studenci.
  INSERT INTO studenci (id, imie, nazwisko)
    VALUES (z_StudentID, 'Timothy', 'Taller');

  -- Dodaj drugi wiersz, ale u�yj numeru sekwencji bezpo�rednio w 
  -- instrukcji INSERT.
  INSERT INTO studenci (id, imie, nazwisko)
    VALUES (studenci_sekwencja.NEXTVAL, 'Patrick', 'Poll');
END;
/


