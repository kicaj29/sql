REM wszystkietrzy.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok zawiera wszystkie trzy sekcje - deklaracyjn�, wykonania
REM oraz obs�ugi wyj�tk�w.

DECLARE
  /* Pocz�tek sekcji deklaracji */
z_StudentID NUMBER(5) := 10000;  -- Zainicjowanie zmiennej numerycznej 
  -- i nadanie jej warto�ci 10 000
z_Imie VARCHAR2(20);             -- Ci�g znak�w o zmiennej d�ugo�ci i o okre�lonej
                                 -- maksymalnej d�ugo�ci 20 znak�w
BEGIN 
  /* Pocz�tek sekcji wykonania */
  -- Pobranie imienia studenta z ID 10 000
  SELECT imie
    INTO z_Imie
    FROM studenci
    WHERE id = z_StudentID;
EXCEPTION
  /* Pocz�tek sekcji wyj�tk�w */
  WHEN NO_DATA_FOUND THEN
    -- Obs�uga b��du 
    INSERT INTO dziennik_bledow (informacja) 
      VALUES ('Student 10 000 nie istnieje!');
END;
