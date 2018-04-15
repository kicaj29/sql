REM execImmediate.sql
REM Rozdzia� 12., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok demonstruje kilka polece� EXECUTE IMMEDIATE

set serveroutput on

DECLARE
      z_CiagSQL   VARCHAR2(200);
      z_BlokPLSQL VARCHAR2(200);
    BEGIN
      -- Najpierw utworzono tabel� tymczasow�, wykorzystuj�c litera�. Prosz� zauwa�y�,
      -- �e w ci�gu znak�w nie ma ko�cz�cego znaku �rednika.
      EXECUTE IMMEDIATE
         'CREATE TABLE tabela_wykonania (col1 VARCHAR(10))';
      -- Wstawienie kilku wierszy za pomoc� ci�gu. Ponownie ci�g nie zawiera
      -- ko�cz�cego znaku �rednika.
      FOR z_Licznik IN 1..10 LOOP
         z_CiagSQL :=
            'INSERT INTO tabela_wykonania
                 VALUES (''Wiersz ' || z_Licznik || ''')';
         EXECUTE IMMEDIATE z_CiagSQL;
     END LOOP;
    -- Wy�wietlenie zawarto�ci tabeli za pomoc� anonimowego bloku
    -- PL/SQL.  Wstawia si� ca�y blok do ci�gu znak�w
    -- (w��cznie ze �rednikiem).
    z_BlokPLSQL :=
      'BEGIN
         FOR z_Rek IN (SELECT * FROM tabela_wykonania) LOOP
            DBMS_OUTPUT.PUT_LINE(z_Rek.col1);
         END LOOP;
       END;';
    -- A teraz wykonuje anonimowy blok.
    EXECUTE IMMEDIATE z_BlokPLSQL;
    -- Usuni�cie tabeli.
    EXECUTE IMMEDIATE 'DROP TABLE tabela_wykonania';
  END;
/



