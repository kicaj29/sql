REM zagniezdz.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten przyk³ad pokazuje 2 zagnie¿d¿one bloki.

DECLARE
  /* Pocz¹tek sekcji deklaracji */
  z_StudentID NUMBER(5) := 10000;  -- Zainicjowanie zmiennej numerycznej
                                   -- i nadanie jej wartoœci 10,000
  z_Imie VARCHAR2(20);            -- Ci¹g znaków o zmiennej d³ugoœci i o okreœlonej                                      
                                 -- maksymalnej d³ugoœci 20 znaków
BEGIN
  /* Pocz¹tek sekcji wykonania */
  -- Pobranie imienia studenta o numerze ID 10,000
  SELECT imie
    INTO z_Imie
    FROM studenci
    WHERE id = z_StudentID;
    
  -- Pocz¹tek bloku zagnie¿d¿onego, który zawiera jedynie
  -- sekcjê wykonania
  BEGIN
    INSERT INTO dziennik_bledow (informacja)
      VALUES ('Witajcie z bloku zagnie¿d¿onego!');
  END;
EXCEPTION
  /* Pocz¹tek sekcji wyj¹tków */
  WHEN NO_DATA_FOUND THEN
    -- Pocz¹tek bloku zagnie¿d¿onego, który zawiera sekcjê wykonania
    -- i sekcjê wyj¹tków
    BEGIN
      -- Obs³uga b³êdu
      INSERT INTO dziennik_bledow (informacja)
        VALUES ('Student o identyfikatorze 10,000 nie istnieje!');
    EXCEPTION
      WHEN OTHERS THEN
        -- B³¹d operacji INSERT
        DBMS_OUTPUT.PUT_LINE('B³¹d wprowadzania danych do tabeli log_tab!');
    END;
END;
