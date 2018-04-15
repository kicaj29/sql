REM wszystkietrzy.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok zawiera wszystkie trzy sekcje - deklaracyjn¹, wykonania
REM oraz obs³ugi wyj¹tków.

DECLARE
  /* Pocz¹tek sekcji deklaracji */
z_StudentID NUMBER(5) := 10000;  -- Zainicjowanie zmiennej numerycznej 
  -- i nadanie jej wartoœci 10 000
z_Imie VARCHAR2(20);             -- Ci¹g znaków o zmiennej d³ugoœci i o okreœlonej
                                 -- maksymalnej d³ugoœci 20 znaków
BEGIN 
  /* Pocz¹tek sekcji wykonania */
  -- Pobranie imienia studenta z ID 10 000
  SELECT imie
    INTO z_Imie
    FROM studenci
    WHERE id = z_StudentID;
EXCEPTION
  /* Pocz¹tek sekcji wyj¹tków */
  WHEN NO_DATA_FOUND THEN
    -- Obs³uga b³êdu 
    INSERT INTO dziennik_bledow (informacja) 
      VALUES ('Student 10 000 nie istnieje!');
END;
