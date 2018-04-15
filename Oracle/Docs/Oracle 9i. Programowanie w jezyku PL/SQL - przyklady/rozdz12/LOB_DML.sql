REM LOB_DML.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt ilustruje operacje z obiektami LOB za pomoc¹
REM instrukcji DML.

set serveroutput on

DROP TABLE lobdemo;

CREATE TABLE lobdemo (
   klucz NUMBER PRIMARY KEY,
   kol_clob  CLOB,
   kol_blob  BLOB,
   kol_bfile BFILE
);

DELETE FROM lobdemo
  WHERE klucz IN (50, 51, 60, 61);

-- Nastêpuj¹ce dwie instrukcje INSERT spowoduj¹ dodanie dwóch wierszy do tabeli.
INSERT INTO lobdemo (klucz, kol_clob, kol_blob, kol_bfile)
    VALUES (50, 'To jest litera³ znakowy',
             HEXTORAW('FEFEFEFEFEFEFEFEFEFE'),
             NULL);

INSERT INTO lobdemo (klucz, kol_clob, kol_blob, kol_bfile)
    VALUES (51, 'To jest inny litera³ znakowy',
             HEXTORAW('ABABABABABABABABABAB'),
             NULL);

-- Mo¿na tak¿e wykonaæ operacje INSERT pos³uguj¹c siê wynikami zapytania. 
-- Poni¿sza instrukcja powoduje skopiowanie wiersza 50 i 51 do wiersza 60 i 61.
INSERT INTO lobdemo
  SELECT klucz + 10, kol_clob, kol_blob, NULL
   FROM lobdemo
   WHERE klucz IN (50, 51);

-- Ta instrukcja powoduje aktualizacjê kolumny kol_blob i nadanie jej nowej 
-- wartoœci.
UPDATE lobdemo
   SET kol_blob = HEXTORAW('CDCDCDCDCDCDCDCDCDCDCDCD')
   WHERE klucz IN (60, 61);

-- Na koniec mo¿emy usun¹æ wiersz 61.
DELETE FROM lobdemo
   WHERE klucz = 61;

COMMIT;


