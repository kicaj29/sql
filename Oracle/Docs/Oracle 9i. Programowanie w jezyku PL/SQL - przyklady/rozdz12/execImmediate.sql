REM execImmediate.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok demonstruje kilka poleceñ EXECUTE IMMEDIATE

set serveroutput on

DECLARE
      z_CiagSQL   VARCHAR2(200);
      z_BlokPLSQL VARCHAR2(200);
    BEGIN
      -- Najpierw utworzono tabelê tymczasow¹, wykorzystuj¹c litera³. Proszê zauwa¿yæ,
      -- ¿e w ci¹gu znaków nie ma koñcz¹cego znaku œrednika.
      EXECUTE IMMEDIATE
         'CREATE TABLE tabela_wykonania (col1 VARCHAR(10))';
      -- Wstawienie kilku wierszy za pomoc¹ ci¹gu. Ponownie ci¹g nie zawiera
      -- koñcz¹cego znaku œrednika.
      FOR z_Licznik IN 1..10 LOOP
         z_CiagSQL :=
            'INSERT INTO tabela_wykonania
                 VALUES (''Wiersz ' || z_Licznik || ''')';
         EXECUTE IMMEDIATE z_CiagSQL;
     END LOOP;
    -- Wyœwietlenie zawartoœci tabeli za pomoc¹ anonimowego bloku
    -- PL/SQL.  Wstawia siê ca³y blok do ci¹gu znaków
    -- (w³¹cznie ze œrednikiem).
    z_BlokPLSQL :=
      'BEGIN
         FOR z_Rek IN (SELECT * FROM tabela_wykonania) LOOP
            DBMS_OUTPUT.PUT_LINE(z_Rek.col1);
         END LOOP;
       END;';
    -- A teraz wykonuje anonimowy blok.
    EXECUTE IMMEDIATE z_BlokPLSQL;
    -- Usuniêcie tabeli.
    EXECUTE IMMEDIATE 'DROP TABLE tabela_wykonania';
  END;
/



