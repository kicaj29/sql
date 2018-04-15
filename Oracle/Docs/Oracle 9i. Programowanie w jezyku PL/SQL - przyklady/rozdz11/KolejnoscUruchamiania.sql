REM KolejnoscUruchamiania.sql
REM Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt prezentuje kolejnoœæ uruchamiania wyzwalaczy.

DROP SEQUENCE kolejn_wyzwalaczy;

CREATE SEQUENCE kolejn_wyzwalaczy
  START WITH 1
  INCREMENT BY 1;

CREATE OR REPLACE PACKAGE PakietWyzwalaczy AS
  -- Globalny licznik do wykorzystania w wyzwalaczach
  z_Licznik NUMBER;
END PakietWyzwalaczy;
/

CREATE OR REPLACE TRIGGER GrupyBInstrukcja
  BEFORE UPDATE ON grupy
BEGIN
  -- Najpierw  licznik zostanie wyzerowany.
  PakietWyzwalaczy.z_Licznik := 0;

  INSERT INTO tabela_tymcz (kol_num, kol_znak)
    VALUES (kolejn_wyzwalaczy.NEXTVAL,
      'BEFORE, na poziomie instrukcji: licznik = ' || PakietWyzwalaczy.z_Licznik);

  -- A teraz zostanie zwiêkszona jego wartoœæ o jeden dla kolejnego wyzwalacza.
  PakietWyzwalaczy.z_Licznik := PakietWyzwalaczy.z_Licznik + 1;
END GrupyBInstrukcja;

/

CREATE OR REPLACE TRIGGER GrupyAInstrukcja1
  AFTER UPDATE ON grupy
BEGIN
  INSERT INTO tabela_tymcz (kol_num, kol_znak)
    VALUES (kolejn_wyzwalaczy.NEXTVAL,
      'AFTER, na poziomie instrukcji 1: licznik = ' || PakietWyzwalaczy.z_Licznik);

  -- Zwiêkszenie o jeden dla nastêpnego wyzwalacza.
  PakietWyzwalaczy.z_Licznik := PakietWyzwalaczy.z_Licznik + 1;
END GrupyAInstrukcja1;
/

CREATE OR REPLACE TRIGGER GrupyAInstrukcja2
  AFTER UPDATE ON grupy
BEGIN
  INSERT INTO tabela_tymcz (kol_num, kol_znak)
    VALUES (kolejn_wyzwalaczy.NEXTVAL,
      'AFTER, na poziomie instrukcji 2: licznik = ' || PakietWyzwalaczy.z_Licznik);

  -- Zwiêkszenie licznika dla nastêpnego wyzwalacza.
  PakietWyzwalaczy.z_Licznik := PakietWyzwalaczy.z_Licznik + 1;
END GrupyAInstrukcja2;
/

CREATE OR REPLACE TRIGGER GrupyBWiersz1
  BEFORE UPDATE ON grupy
  FOR EACH ROW
BEGIN
  INSERT INTO tabela_tymcz (kol_num, kol_znak)
    VALUES (kolejn_wyzwalaczy.NEXTVAL,
      'BEFORE, na poziomie wiersza 1: licznik = ' || PakietWyzwalaczy.z_Licznik);

  -- Zwiêkszenie licznika dla nastêpnego wyzwalacza.
  PakietWyzwalaczy.z_Licznik := PakietWyzwalaczy.z_Licznik + 1;
END GrupyBWiersz1;
/

CREATE OR REPLACE TRIGGER GrupyBWiersz2
  BEFORE UPDATE ON grupy
  FOR EACH ROW
BEGIN
  INSERT INTO tabela_tymcz (kol_num, kol_znak)
    VALUES (kolejn_wyzwalaczy.NEXTVAL,
      'BEFORE, na poziomie wiersza 2.: licznik = ' || PakietWyzwalaczy.z_Licznik);

  -- Zwiêkszenie licznika dla nastêpnego wyzwalacza.
  PakietWyzwalaczy.z_Licznik := PakietWyzwalaczy.z_Licznik + 1;
END GrupyBWiersz2;

/

CREATE OR REPLACE TRIGGER GrupyBWiersz3
  BEFORE UPDATE ON grupy
  FOR EACH ROW
BEGIN
  INSERT INTO tabela_tymcz (kol_num, kol_znak)
    VALUES (kolejn_wyzwalaczy.NEXTVAL,
      'BEFORE, na poziomie wiersza 3: licznik = ' || PakietWyzwalaczy.z_Licznik);

  -- Zwiêkszenie licznika dla nastêpnego wyzwalacza.
  PakietWyzwalaczy.z_Licznik := PakietWyzwalaczy.z_Licznik + 1;
END GrupyBWiersz3;
/

CREATE OR REPLACE TRIGGER GrupyAWiersz
  AFTER UPDATE ON grupy
  FOR EACH ROW
BEGIN
  INSERT INTO tabela_tymcz (kol_num, kol_znak)
    VALUES (kolejn_wyzwalaczy.NEXTVAL,
      'AFTER, na poziomie wiersza: licznik = ' || PakietWyzwalaczy.z_Licznik);

  -- Zwiêkszenie licznika dla nastêpnego wyzwalacza.
     PakietWyzwalaczy.z_Licznik := PakietWyzwalaczy.z_Licznik + 1;
END GrupyAwiersz;
/

DELETE FROM tabela_tymcz;

UPDATE grupy
  SET liczba_zaliczen = 4
  WHERE wydzial IN ('HIS', 'INF');

SELECT *
  FROM tabela_tymcz
  ORDER BY kol_num;
