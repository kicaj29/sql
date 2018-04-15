REM Wywolujace.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt demonstruje dzia³anie procedury z uprawnieniami
REM wywo³uj¹cego.

set echo on
set serveroutput on

-- Najpierw utworzymy u¿ytkowników uzytkownikA oraz uzytkownikB, 
-- a tak¿e potrzebne obiekty.  Aby to zrobiæ nale¿y po³¹czyæ siê jako u¿ytkownik
-- posiadaj¹cy odpowiednie uprawnienia, np. u¿ytkownik SYSTEM.
-- Byæ mo¿e trzeba tak¿e zmieniæ uprawnienie UNLIMITED TABLESPACE
-- w celu przyznania jawnych limitów przestrzeni tabel
-- w bazie danych.
connect system/manager
DROP USER UzytkownikA CASCADE;
CREATE USER UzytkownikA IDENTIFIED BY UzytkownikA;
GRANT CREATE SESSION, CREATE TABLE, CREATE PROCEDURE,
      UNLIMITED TABLESPACE, CREATE ROLE, DROP ANY ROLE TO UzytkownikA;

DROP USER UzytkownikB CASCADE;
CREATE USER UzytkownikB IDENTIFIED BY UzytkownikB;
GRANT CREATE SESSION, CREATE TABLE, CREATE PROCEDURE,
      UNLIMITED TABLESPACE TO UzytkownikB;

-- ***********************************
-- Sytuacja pokazana na rysunku 10.18:  Procedura ZarejestrujPelneGrupy
                                       z prawami wywo³uj¹cego nale¿¹ca do
                                       u¿ytkownika UzytkownikA, tabelê 
                                       tabela_tymcz posiadaj¹ obaj u¿ytkownicy.
-- ***********************************
connect UzytkownikA/UzytkownikA

-- Najpierw utworzymy tabelê grupy.
CREATE TABLE grupy (
  wydzial           CHAR(3),
  kurs              NUMBER(3),
  opis              VARCHAR2(2000),
  maks_l_studentow  NUMBER(3),
  biez_l_studentow  NUMBER(3),
  liczba_zaliczen   NUMBER(1),
  pokoj_id          NUMBER(5));

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                     biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('HIS', 101, 'Historia 101', 30, 11, 4, 20000);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                     biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('HIS', 301, 'Historia 301', 30, 0, 4, 20004);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                     biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('INF', 101, 'Informatyka 101', 50, 0, 4, 20001);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                     biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('EKN', 203, 'Ekonomia 203', 15, 0, 3, 20002);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                     biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('INF', 102, 'Informatyka 102', 35, 3, 4, 20003);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                     biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('MUZ', 410, 'Muzyka 410', 5, 4, 3, 20005);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                     biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('EKN', 101, 'Ekonomia 101', 50, 0, 4, 20007);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                     biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('¯YW', 307, '¯ywienie 307', 20, 2, 4, 20008);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                     biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('MUZ', 100, 'Muzyka 100', 100, 0, 3, NULL);

COMMIT;

-- Oraz tabelê tabela_tymcz.
CREATE TABLE tabela_tymcz (
  kol_num    NUMBER,
  kol_znak   VARCHAR2(60)
  );

-- Potrzebna bêdzie tak¿e procedura PrawieKomplet:
CREATE OR REPLACE FUNCTION PrawieKomplet (
  p_Wydzial grupy.wydzial%TYPE,
  p_Kurs    grupy.kurs%TYPE)
  RETURN BOOLEAN IS

  z_Biez_l_Studentow NUMBER;
  z_Maks_L_Studentow NUMBER;
  z_WartoscWyniku    BOOLEAN;
  z_ProcentUkpl      CONSTANT NUMBER := 90;
BEGIN
  -- Uzyskanie bie¿¹cej i maksymalnej liczby studentów dla po¿¹danego kursu.
  SELECT biez_l_studentow, maks_l_studentow
    INTO z_Biez_L_Studentow, z_Maks_L_Studentow
    FROM grupy
    WHERE wydzial = p_Wydzial
    AND kurs = p_Kurs;

  -- Zwrócenie wartoœci TRUE, je¿eli stan liczebny studentów zarejestrowanych  
  -- na zajêcia jest wiêkszy ni¿ procent wartoœci maksymalnej okreœlony przez zmienn¹  
  -- z_Procent_Ukpl. W przeciwnym przypadku zwrócenie wartoœci FALSE.
  IF (z_Biez_L_Studentow / z_Maks_L_Studentow * 100) > z_ProcentUkpl 
  THEN
    z_WartoscWyniku := TRUE;
  ELSE
    z_WartoscWyniku := FALSE;
  END IF;

  RETURN z_WartoscWyniku;
END PrawieKomplet;
/

-- Wersja procedury ZarejestrujPelneGrupy z prawami wywo³uj¹cego. Ta wersja
-- uruchamia siê z zestawem uprawnieñ u¿ytkownika wywo³uj¹cego, a nie w³aœciciela.
CREATE OR REPLACE PROCEDURE ZarejestrujPelneGrupy 
  AUTHID CURRENT_USER AS

  -- Zwróæmy uwagê, ¿e musimy poprzedziæ tabelê grupy 
  -- nazw¹ UzytkownikA, poniewa¿ nale¿y ona wy³¹cznie do u¿ytkownika UzytkownikA
  CURSOR k_Grupy IS
    SELECT wydzial, kurs
      FROM UzytkownikA.grupy;
BEGIN
  FOR z_RekordGrupy IN k_Grupy LOOP
    -- Zapisanie w tabeli tabela_tymcz wszystkich grup, które nie maj¹ 
    -- du¿ej liczby wolnych miejsc. 
    IF PrawieKomplet(z_RekordGrupy.wydzial, z_RekordGrupy.kurs) THEN
      INSERT INTO tabela_tymcz (kol_znak) VALUES
        ('Grupa' || z_RekordGrupy.wydzial || ' ' || z_RekordGrupy.kurs ||
         ' jest prawie pe³na!');
    END IF;
  END LOOP;
END ZarejestrujPelneGrupy;
/

-- Nadajemy potrzebne uprawnienia u¿ytkownikowi UzytkownikB.
GRANT EXECUTE ON ZarejestrujPelneGrupy to UzytkownikB;
GRANT SELECT ON grupy TO UzytkownikB;

-- Wywo³amy procedurê jako UzytkownikA. Spowoduje to wstawienie danych do tabeli   
-- UzytkownikA.tabela_tymcz. 

BEGIN
  ZarejestrujPelneGrupy;
  COMMIT;
END;
/

-- Wykonamy zapytanie do tabeli tabela_tymcz. Powinniœmy otrzymaæ jeden wiersz
SELECT * FROM tabela_tymcz;


-- Po³¹czymy siê jako UzytkownikB i utworzymy tabelê tabela_tymcz.
connect UzytkownikB/UzytkownikB
CREATE TABLE tabela_tymcz (
  kol_num    NUMBER,
  kol_znak   VARCHAR2(60)
  );

-- Teraz, je¿eli wywo³amy procedurê ZarejestrujPelneGrupy, to dane bêd¹ wstawione 
-- do tabeli UzytkownikB.tabela_tymcz.
BEGIN
  UzytkownikA.ZarejestrujPelneGrupy;
  COMMIT;
END;
/

-- Zatem równie¿ powinniœmy otrzymaæ jeden wiersz.
SELECT * FROM tabela_tymcz;


-- ***********************************
-- Sytuacja przedstawiona na rysunku 10.19: UzytkownikB bez uprawnienia SELECT
--                                         do tabeli grupy.
-- ***********************************

-- Po³¹czymy siê jako UzytkownikA i odbierzemy uprawnienia.
connect UzytkownikA/UzytkownikA
REVOKE SELECT ON grupy FROM UzytkownikB;

-- Wywo³anie jako UzytkownikA dalej bêdzie dzia³aæ:
-- Wywo³ujemy procedurê jako UzytkownikA. Spowoduje to wstawienie wierszy do tabeli UzytkownikA.tabela_tymcz.

BEGIN
  ZarejestrujPelneGrupy;
  COMMIT;
END;
/

-- To zapytanie powinno zwróciæ jeden wiersz.
SELECT * FROM tabela_tymcz;

-- Po³¹czymy siê jako UzytkownikB i wywo³amy procedurê.
connect UzytkownikB/UzytkownikB

-- Teraz wywo³anie procedury ZarejestrujPelneGrupy nie powiedzie siê.
BEGIN
  UzytkownikA.ZarejestrujPelneGrupy;
END;
/

-- ***********************************
-- Sytuacja przedstawiona na rysunku 10.20: Uprawnienie SELECT do tabeli grupy 
--                                         nadane za poœrednictwem roli
-- ***********************************

-- Po³¹czymy siê jako UzytkownikB i utworzymy rolê.
connect UzytkownikA/UzytkownikA
DROP ROLE Rola_UzytkownikA;
CREATE ROLE Rola_UzytkownikA;
GRANT SELECT ON grupy TO Rola_UzytkownikA;
GRANT Rola_UzytkownikA TO UzytkownikB;

-- Po³¹czenie jako UzytkownikB i wywo³anie procedury.
connect UzytkownikB/UzytkownikB

-- Teraz wywo³anie procedury ZarejestrujPelneGrupy powiedzie siê.

BEGIN
  UzytkownikA.ZarejestrujPelneGrupy;
  COMMIT;
END;
/

-- To zapytanie powinno zwróciæ dwa wiersze.
SELECT * FROM tabela_tymcz;
