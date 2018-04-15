REM zagniezdz.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten przyk�ad pokazuje 2 zagnie�d�one bloki.

DECLARE
  /* Pocz�tek sekcji deklaracji */
  z_StudentID NUMBER(5) := 10000;  -- Zainicjowanie zmiennej numerycznej
                                   -- i nadanie jej warto�ci 10,000
  z_Imie VARCHAR2(20);            -- Ci�g znak�w o zmiennej d�ugo�ci i o okre�lonej                                      
                                 -- maksymalnej d�ugo�ci 20 znak�w
BEGIN
  /* Pocz�tek sekcji wykonania */
  -- Pobranie imienia studenta o numerze ID 10,000
  SELECT imie
    INTO z_Imie
    FROM studenci
    WHERE id = z_StudentID;
    
  -- Pocz�tek bloku zagnie�d�onego, kt�ry zawiera jedynie
  -- sekcj� wykonania
  BEGIN
    INSERT INTO dziennik_bledow (informacja)
      VALUES ('Witajcie z bloku zagnie�d�onego!');
  END;
EXCEPTION
  /* Pocz�tek sekcji wyj�tk�w */
  WHEN NO_DATA_FOUND THEN
    -- Pocz�tek bloku zagnie�d�onego, kt�ry zawiera sekcj� wykonania
    -- i sekcj� wyj�tk�w
    BEGIN
      -- Obs�uga b��du
      INSERT INTO dziennik_bledow (informacja)
        VALUES ('Student o identyfikatorze 10,000 nie istnieje!');
    EXCEPTION
      WHEN OTHERS THEN
        -- B��d operacji INSERT
        DBMS_OUTPUT.PUT_LINE('B��d wprowadzania danych do tabeli log_tab!');
    END;
END;
