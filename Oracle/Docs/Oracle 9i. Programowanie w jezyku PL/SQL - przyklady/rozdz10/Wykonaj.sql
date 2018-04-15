REM Wykonaj.sql
REM Rozdzia� 10., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt demonstruje dzia�anie uprawnienia systemowego EXECUTE.

set echo on
set serveroutput on


-- Najpierw utworzymy u�ytkownik�w uzytkownikA oraz uzytkownikB, 
-- a tak�e potrzebne obiekty.  Aby to zrobi� nale�y po��czy� si� jako u�ytkownik
-- posiadaj�cy odpowiednie uprawnienia, np. u�ytkownik SYSTEM.
-- By� mo�e trzeba tak�e zmieni� uprawnienie UNLIMITED TABLESPACE
-- w celu przyznania jawnych limit�w przestrzeni tabel
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
-- Sytuacja pokazana na rysunku 10.14: Wszystkie obiekty nale�� do uzystkownika UzytkownikA.
-- ***********************************
connect UzytkownikA/UzytkownikA

-- Najpierw utworzymy tabel� grupy.
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
  VALUES ('�YW', 307, '�ywienie 307', 20, 2, 4, 20008);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                     biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('MUZ', 100, 'Muzyka 100', 100, 0, 3, NULL);

COMMIT;

-- Oraz tabel� tabela_tymcz.
CREATE TABLE tabela_tymcz (
  kol_num    NUMBER,
  kol_znak   VARCHAR2(60)
  );

-- Potrzebna b�dzie tak�e procedura PrawieKomplet:
CREATE OR REPLACE FUNCTION PrawieKomplet (
  p_Wydzial grupy.wydzial%TYPE,
  p_Kurs    grupy.kurs%TYPE)
  RETURN BOOLEAN IS

  z_Biez_l_Studentow NUMBER;
  z_Maks_L_Studentow NUMBER;
  z_WartoscWyniku    BOOLEAN;
  z_ProcentUkpl      CONSTANT NUMBER := 90;
BEGIN
  -- Uzyskanie bie��cej i maksymalnej liczby student�w dla po��danego kursu.
  SELECT biez_l_studentow, maks_l_studentow
    INTO z_Biez_L_Studentow, z_Maks_L_Studentow
    FROM grupy
    WHERE wydzial = p_Wydzial
    AND kurs = p_Kurs;

  -- Zwr�cenie warto�ci TRUE, je�eli stan liczebny student�w zarejestrowanych  
  -- na zaj�cia jest wi�kszy ni� procent warto�ci maksymalnej okre�lony przez zmienn�  
  -- z_Procent_Ukpl. W przeciwnym przypadku zwr�cenie warto�ci FALSE.
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
    -- Zapisanie w tabeli tabela_tymcz wszystkich grup, kt�re nie maj� 
    -- du�ej liczby wolnych miejsc. 
    IF PrawieKomplet(z_RekordGrupy.wydzial, z_RekordGrupy.kurs) THEN
      INSERT INTO tabela_tymcz (kol_znak) VALUES
        ('Grupa' || z_RekordGrupy.wydzial || ' ' || z_RekordGrupy.kurs ||
         ' jest prawie pe�na!');
    END IF;
  END LOOP;
END ZarejestrujPelneGrupy;
/

-- Teraz, kiedy wszystkie obiekty utworzono, udzielimy u�ytkownikowi UzytkownikB 
-- uprawnienia EXECUTE do procedury ZarejestrujPelneGrupy.  Zwr��my uwage, �e UzytkownikB
-- nie ma innych uprawnie� do obiekt�w u�ytkownika UzytkownikA.
GRANT EXECUTE ON ZarejestrujPelneGrupy to UzytkownikB;

-- po��czymy si� jako UzytkownikB i uruchomimy procedur� ZarejestrujPelneGrupy.  
-- Wyniki zaostan� zapisane w tabeli tabela_tymcz, kt�ra nale�y do u�ytkownika UzytkownikA, 
-- poniewa� jest to jedyna kopia tabeli tabela_tymcz.
connect UzytkownikB/UzytkownikB
BEGIN
  UzytkownikA.ZarejestrujPelneGrupy;
  COMMIT;
END;
/

-- Wykonamy zapytanie do tabeli tabela_tymcz jako UzytkownikA, aby sprawdzi� wyniki.
connect UzytkownikA/UzytkownikA
SELECT * FROM tabela_tymcz;

-- ***********************************
-- Sytuacja pokazana na rysunku 10.15: UzytkownikB tak�e posiada kopi� tabeli
--                                      tabela_tymcz.
-- ***********************************

-- Create UzytkownikB.tabela_tymcz.
connect UzytkownikB/UzytkownikB
CREATE TABLE tabela_tymcz (
  kol_num    NUMBER,
  kol_znak   VARCHAR2(60)
  );

-- Teraz, je�eli wywo�amy procedur� UzytkownikA.ZarejestrujPelneGrupy, Kopia tabeli 
-- tabela_tymcz nale��ca do u�ytkownika UzytkownikA ulegnie modyfikacji.
BEGIN
  UzytkownikA.ZarejestrujPelneGrupy;
  COMMIT;
END;
/

-- Wykonamy zapytanie do tabeli tabela_tymcz nale��cej do u�ytkownika UzytkownikB: 
-- To zapytanie nie powinno zwr�ci� �adnych wierszy.
SELECT * FROM tabela_tymcz;

-- Wykonamy zapytanie do tabeli tabela_tymcz nale��cej do u�ytkownika UzytkownikA:
-- To zapytanie zwr�ci dwa wiersze - po jednym dla ka�dego wykonania.
connect UzytkownikA/UzytkownikA
SELECT * FROM tabela_tymcz;

-- ***********************************
-- Sytuacja przedstawiona na rysunku 10.16: UzytkownikB jest w�ascicielem
-- tabeli tabela_tymcz oraz procedury ZarejestrujPelneGrupy, Uprawnienia nadane 
-- bezpo�rednio.
-- ***********************************

-- Najpierw usuniemy tabel� i procedur� b�d�c po��czonym jako UzytkownikA:
connect UzytkownikA/UzytkownikA
DROP TABLE tabela_tymcz;
DROP PROCEDURE ZarejestrujPelneGrupy;

-- Teraz nadamy uprawnienia uzytkownikowi UzytkownikB do procedury PrawieKomplet oraz tabeli grupy:

GRANT SELECT ON grupy TO UzytkownikB;
GRANT EXECUTE ON PrawieKomplet TO UzytkownikB;

-- UzytkownikB ju� posiada tabel� tabela_tymcz, zatem musimy tylko utworzy�
-- procedur�.  Zwr��my uwag� na ti, �e dzi�ki notacji z kropk� odnosimy si� do procedury PrawieKomplet 
-- w schemacie u�ytkownika UzytkownikA.  Gdyby�my nie udzielili powy�szych uprawnie�,
-- procedura nie skompilowa�aby si�.
connect UzytkownikB/UzytkownikB
CREATE OR REPLACE PROCEDURE ZarejestrujPelneGrupy AS
CURSOR k_Grupy IS
    SELECT wydzial, kurs
      FROM grupy;
BEGIN
  FOR z_RekordGrupy IN k_Grupy LOOP
    -- Zapisanie w tabeli tabela_tymcz wszystkich grup, kt�re nie maj� 
    -- du�ej liczby wolnych miejsc. 
    IF PrawieKomplet(z_RekordGrupy.wydzial, z_RekordGrupy.kurs) THEN
      INSERT INTO tabela_tymcz (kol_znak) VALUES
        ('Grupa' || z_RekordGrupy.wydzial || ' ' || z_RekordGrupy.kurs ||
         ' jest prawie pe�na!');
    END IF;
  END LOOP;
END ZarejestrujPelneGrupy;
/

-- Je�eli teraz wykonamy procedur� ZarejestrujPelneGrupy, wyniki b�d� zapisane
-- w tabeli tabela_tymcz nale��cej do u�ytkownika UzytkownikB.
BEGIN
  ZarejestrujPelneGrupy;
  COMMIT;
END;
/

-- To zapytanie powinno zwr�ci� jeden wiersz.
SELECT * FROM tabela_tymcz;

-- ***********************************
-- Sytuacja przedstawiona na rysunku 10.17: UzytkownikB jest w�a�cicielem tabeli tabela_tymcz oraz
--                                      procedury ZarejestrujPelneGrupy, Uprawnienia nadawane
--                                      za po�rednictwem roli.
-- ***********************************

connect UzytkownikA/UzytkownikA
-- Najpierw odbierzemy uprzednio nadane uprawnienia
REVOKE SELECT ON grupy FROM UzytkownikB;
REVOKE EXECUTE ON PrawieKomplet FROM UzytkownikB;

-- Teraz utworzymy rol�
DROP ROLE Rola_UzytkownikA;
CREATE ROLE Rola_UzytkownikA;
GRANT SELECT ON grupy TO Rola_UzytkownikA;
GRANT EXECUTE ON PrawieKomplet TO Rola_UzytkownikA;
GRANT Rola_UzytkownikA TO UzytkownikB;

-- Pr�ba utworzenia procedury ZarejestrujPelneGrupy w schemacie u�ytkownika UzytkownikB
-- spowoduje teraz powstanie b��d�w PLS-201:
connect UzytkownikB/UzytkownikB
CREATE OR REPLACE PROCEDURE ZarejestrujPelneGrupy AS
CURSOR k_Grupy IS
    SELECT wydzial, kurs
      FROM grupy;
BEGIN
  FOR z_RekordGrupy IN k_Grupy LOOP
    -- Zapisanie w tabeli tabela_tymcz wszystkich grup, kt�re nie maj� 
    -- du�ej liczby wolnych miejsc. 
    IF PrawieKomplet(z_RekordGrupy.wydzial, z_RekordGrupy.kurs) THEN
      INSERT INTO tabela_tymcz (kol_znak) VALUES
        ('Grupa' || z_RekordGrupy.wydzial || ' ' || z_RekordGrupy.kurs ||
         ' jest prawie pe�na!');
    END IF;
  END LOOP;
END ZarejestrujPelneGrupy;
/

show errors