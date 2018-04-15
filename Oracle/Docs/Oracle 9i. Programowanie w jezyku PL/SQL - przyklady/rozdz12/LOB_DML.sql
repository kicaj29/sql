REM LOB_DML.sql
REM Rozdzia� 12., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt ilustruje operacje z obiektami LOB za pomoc�
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

-- Nast�puj�ce dwie instrukcje INSERT spowoduj� dodanie dw�ch wierszy do tabeli.
INSERT INTO lobdemo (klucz, kol_clob, kol_blob, kol_bfile)
    VALUES (50, 'To jest litera� znakowy',
             HEXTORAW('FEFEFEFEFEFEFEFEFEFE'),
             NULL);

INSERT INTO lobdemo (klucz, kol_clob, kol_blob, kol_bfile)
    VALUES (51, 'To jest inny litera� znakowy',
             HEXTORAW('ABABABABABABABABABAB'),
             NULL);

-- Mo�na tak�e wykona� operacje INSERT pos�uguj�c si� wynikami zapytania. 
-- Poni�sza instrukcja powoduje skopiowanie wiersza 50 i 51 do wiersza 60 i 61.
INSERT INTO lobdemo
  SELECT klucz + 10, kol_clob, kol_blob, NULL
   FROM lobdemo
   WHERE klucz IN (50, 51);

-- Ta instrukcja powoduje aktualizacj� kolumny kol_blob i nadanie jej nowej 
-- warto�ci.
UPDATE lobdemo
   SET kol_blob = HEXTORAW('CDCDCDCDCDCDCDCDCDCDCDCD')
   WHERE klucz IN (60, 61);

-- Na koniec mo�emy usun�� wiersz 61.
DELETE FROM lobdemo
   WHERE klucz = 61;

COMMIT;


