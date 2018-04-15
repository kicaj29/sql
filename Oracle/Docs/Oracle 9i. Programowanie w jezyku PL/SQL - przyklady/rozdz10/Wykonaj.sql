REM Wykonaj.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt demonstruje dzia³anie uprawnienia systemowego EXECUTE.

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
-- Sytuacja pokazana na rysunku 10.14: Wszystkie obiekty nale¿¹ do uzystkownika UzytkownikA.
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

-- oraz ZarejestrujPelneGrupy:
CREATE OR REPLACE PROCEDURE ZarejestrujPelneGrupy AS
  CURSOR k_Grupy IS
    SELECT wydzial, kurs
      FROM grupy;
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

-- Teraz, kiedy wszystkie obiekty utworzono, udzielimy u¿ytkownikowi UzytkownikB 
-- uprawnienia EXECUTE do procedury ZarejestrujPelneGrupy.  Zwróæmy uwage, ¿e UzytkownikB
-- nie ma innych uprawnieñ do obiektów u¿ytkownika UzytkownikA.
GRANT EXECUTE ON ZarejestrujPelneGrupy to UzytkownikB;

-- po³¹czymy siê jako UzytkownikB i uruchomimy procedurê ZarejestrujPelneGrupy.  
-- Wyniki zaostan¹ zapisane w tabeli tabela_tymcz, która nale¿y do u¿ytkownika UzytkownikA, 
-- poniewa¿ jest to jedyna kopia tabeli tabela_tymcz.
connect UzytkownikB/UzytkownikB
BEGIN
  UzytkownikA.ZarejestrujPelneGrupy;
  COMMIT;
END;
/

-- Wykonamy zapytanie do tabeli tabela_tymcz jako UzytkownikA, aby sprawdziæ wyniki.
connect UzytkownikA/UzytkownikA
SELECT * FROM tabela_tymcz;

-- ***********************************
-- Sytuacja pokazana na rysunku 10.15: UzytkownikB tak¿e posiada kopiê tabeli
--                                      tabela_tymcz.
-- ***********************************

-- Create UzytkownikB.tabela_tymcz.
connect UzytkownikB/UzytkownikB
CREATE TABLE tabela_tymcz (
  kol_num    NUMBER,
  kol_znak   VARCHAR2(60)
  );

-- Teraz, je¿eli wywo³amy procedurê UzytkownikA.ZarejestrujPelneGrupy, Kopia tabeli 
-- tabela_tymcz nale¿¹ca do u¿ytkownika UzytkownikA ulegnie modyfikacji.
BEGIN
  UzytkownikA.ZarejestrujPelneGrupy;
  COMMIT;
END;
/

-- Wykonamy zapytanie do tabeli tabela_tymcz nale¿¹cej do u¿ytkownika UzytkownikB: 
-- To zapytanie nie powinno zwróciæ ¿adnych wierszy.
SELECT * FROM tabela_tymcz;

-- Wykonamy zapytanie do tabeli tabela_tymcz nale¿¹cej do u¿ytkownika UzytkownikA:
-- To zapytanie zwróci dwa wiersze - po jednym dla ka¿dego wykonania.
connect UzytkownikA/UzytkownikA
SELECT * FROM tabela_tymcz;

-- ***********************************
-- Sytuacja przedstawiona na rysunku 10.16: UzytkownikB jest w³ascicielem
-- tabeli tabela_tymcz oraz procedury ZarejestrujPelneGrupy, Uprawnienia nadane 
-- bezpoœrednio.
-- ***********************************

-- Najpierw usuniemy tabelê i procedurê bêd¹c po³¹czonym jako UzytkownikA:
connect UzytkownikA/UzytkownikA
DROP TABLE tabela_tymcz;
DROP PROCEDURE ZarejestrujPelneGrupy;

-- Teraz nadamy uprawnienia uzytkownikowi UzytkownikB do procedury PrawieKomplet oraz tabeli grupy:

GRANT SELECT ON grupy TO UzytkownikB;
GRANT EXECUTE ON PrawieKomplet TO UzytkownikB;

-- UzytkownikB ju¿ posiada tabelê tabela_tymcz, zatem musimy tylko utworzyæ
-- procedurê.  Zwróæmy uwagê na ti, ¿e dziêki notacji z kropk¹ odnosimy siê do procedury PrawieKomplet 
-- w schemacie u¿ytkownika UzytkownikA.  Gdybyœmy nie udzielili powy¿szych uprawnieñ,
-- procedura nie skompilowa³aby siê.
connect UzytkownikB/UzytkownikB
CREATE OR REPLACE PROCEDURE ZarejestrujPelneGrupy AS
CURSOR k_Grupy IS
    SELECT wydzial, kurs
      FROM grupy;
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

-- Je¿eli teraz wykonamy procedurê ZarejestrujPelneGrupy, wyniki bêd¹ zapisane
-- w tabeli tabela_tymcz nale¿¹cej do u¿ytkownika UzytkownikB.
BEGIN
  ZarejestrujPelneGrupy;
  COMMIT;
END;
/

-- To zapytanie powinno zwróciæ jeden wiersz.
SELECT * FROM tabela_tymcz;

-- ***********************************
-- Sytuacja przedstawiona na rysunku 10.17: UzytkownikB jest w³aœcicielem tabeli tabela_tymcz oraz
--                                      procedury ZarejestrujPelneGrupy, Uprawnienia nadawane
--                                      za poœrednictwem roli.
-- ***********************************

connect UzytkownikA/UzytkownikA
-- Najpierw odbierzemy uprzednio nadane uprawnienia
REVOKE SELECT ON grupy FROM UzytkownikB;
REVOKE EXECUTE ON PrawieKomplet FROM UzytkownikB;

-- Teraz utworzymy rolê
DROP ROLE Rola_UzytkownikA;
CREATE ROLE Rola_UzytkownikA;
GRANT SELECT ON grupy TO Rola_UzytkownikA;
GRANT EXECUTE ON PrawieKomplet TO Rola_UzytkownikA;
GRANT Rola_UzytkownikA TO UzytkownikB;

-- Próba utworzenia procedury ZarejestrujPelneGrupy w schemacie u¿ytkownika UzytkownikB
-- spowoduje teraz powstanie b³êdów PLS-201:
connect UzytkownikB/UzytkownikB
CREATE OR REPLACE PROCEDURE ZarejestrujPelneGrupy AS
CURSOR k_Grupy IS
    SELECT wydzial, kurs
      FROM grupy;
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

show errors