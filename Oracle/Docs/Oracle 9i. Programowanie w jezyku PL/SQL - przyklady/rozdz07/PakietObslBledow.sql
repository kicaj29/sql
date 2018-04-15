REM PakietObslBledow.sql
REM Rozdzia³ 7., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten plik ilustruje pakiet z zaawansowan¹ obs³ug¹ b³edów.

set serveroutput on size 200000
set linesize 250

-- Te 3 procedury ilustruj¹ zastosowanie funkcji FORMAT_CALL_STACK.

CREATE OR REPLACE PROCEDURE C AS 
  z_CallStack VARCHAR2(2000);
BEGIN
    z_CallStack := DBMS_UTILITY.FORMAT_CALL_STACK;
    INSERT INTO tabela_tymcz (kol_znak) VALUES (z_CallStack);
    INSERT INTO tabela_tymcz (kol_num)
      VALUES (-1);
END C;
/

CREATE OR REPLACE PROCEDURE B AS
BEGIN
  C;
END B;
/

CREATE OR REPLACE PROCEDURE A AS
BEGIN
  B;
END A;
/

exec A;

DROP TABLE bledy;
CREATE TABLE bledy (
  modul            VARCHAR2(50),
  numer_sekw       NUMBER,
  numer_bledu      NUMBER,
  komunikat_bledu  VARCHAR2(100),
  stos_bledow      VARCHAR2(2000),
  stos_wywolan     VARCHAR2(2000),
  et_czasowa       DATE,
  PRIMARY KEY (modul, numer_sekw));

CREATE TABLE stos_wywolan (
  modul            VARCHAR2(50),
  numer_sekw       NUMBER,
  kolejn_wywolan   NUMBER,
  uchwyt_obiektu   VARCHAR2(10),
  num_wiersza      NUMBER,
  nazwa_obiektu    VARCHAR2(80),
  PRIMARY KEY (modul, numer_sekw, kolejn_wywolan),
  FOREIGN KEY (modul, numer_sekw) REFERENCES bledy ON DELETE CASCADE);

DROP TABLE stos_bledow;
CREATE TABLE stos_bledow (
  modul           VARCHAR2(50),
  numer_sekw      NUMBER,
  kolejn_bledow   NUMBER,
  skrot           CHAR(3),
  numer_bledu     NUMBER(5),
  komunikat_bledu VARCHAR2(100),
  PRIMARY KEY (modul, numer_sekw, kolejn_bledow),
  FOREIGN KEY (modul, numer_sekw) REFERENCES bledy ON DELETE CASCADE);

CREATE SEQUENCE sekw_bledy
  START WITH 1
  INCREMENT BY 1;

/* Ogólny pakiet obs³ugi b³êdów, wykorzystuj¹cy funkcje 
     DBMS_UTILITY.FORMAT_ERROR_STACK oraz 
     DBMS_UTILITY.FORMAT_CALL_STACK. Pakiet ten zapisuje ogólne 
     informacje o b³êdach w tabeli bledy z uwzglêdnieniem 
     szczegó³owych informacji ze stosu wywo³añ oraz ze stosu b³êdów 
     odpowiednio w tabelach stos_wywolan oraz stos_bledow. */
CREATE OR REPLACE PACKAGE PakietObslBledow AS

  -- Punkt wejœciowy do obs³ugi b³êdów. Procedura ObsluzWszystkie powinna 
  -- byæ wywo³ywana ze wszystkich programów obs³ugi wyj¹tków tam, 
  -- gdzie chcemy rejestrowaæ b³êdy. Parametr p_Top powinien 
  -- mieæ wartoœæ TRUE tylko na najwy¿szym poziomie zagnie¿d¿enia
  -- procedury. Dla pozosta³ych poziomów parametr ten powinien mieæ wartoœæ FALSE.

  PROCEDURE ObsluzWszystkie(p_Top BOOLEAN);

  -- Wyœwietla informacje ze stosów wywo³añ i b³êdów (przy wykorzystaniu pakietu     
  -- DBMS_OUTPUT) dla danego modu³u i numeru sekwencji
  PROCEDURE WyswietlStosy(p_Modul IN bledy.modul%TYPE,
                        p_NumSekw IN bledy.numer_sekw%TYPE);

  -- Pobranie informacji ze stosów wywo³añ i b³êdów i zapisanie ich 
  -- w tabelach bledy i stos_wywolan. Zwraca numer 
  -- sekwencji pod którym zapisano b³¹d. Je¿eli parametr 
  -- p_FlagaZatw ma wartoœæ TRUE, wtedy wstawienia s¹ zatwierdzane. 
  -- W celu u¿ycia procedury ZapiszStosy, nale¿y obs³u¿yæ b³¹d. 
  -- A zatem procedura ObsluzWszystkie powinna byæ wywo³ana z parametrem p_Top = TRUE.
  PROCEDURE ZapiszStosy(p_Modul IN bledy.modul%TYPE,
                        p_NumSekw OUT bledy.numer_sekw%TYPE,
                        p_FlagaZatw BOOLEAN DEFAULT FALSE);

END PakietObslBledow;

CREATE OR REPLACE PACKAGE BODY PakietObslBledow AS

  z_NowyWiersz     CONSTANT CHAR(1) := CHR(10);

  z_Obsluzony      BOOLEAN := FALSE;
  z_StosBledow     VARCHAR2(2000);
  z_StosWywolan    VARCHAR2(2000);

  PROCEDURE ObsluzWszystkie(p_Top BOOLEAN) IS
  BEGIN
    IF p_Top THEN
      z_Obsluzony := FALSE;
    ELSIF NOT z_Obsluzony THEN
      z_Obsluzony := TRUE;
      z_StosBledow := DBMS_UTILITY.FORMAT_ERROR_STACK;
      z_StosWywolan := DBMS_UTILITY.FORMAT_CALL_STACK;
    END IF;      
  END ObsluzWszystkie;

  PROCEDURE WyswietlStosy(p_Modul IN bledy.modul%TYPE,
                        p_NumSekw IN bledy.numer_sekw%TYPE) IS
    z_EtykietaCzas bledy.et_czasowa%TYPE;
    z_KomunikatBledu bledy.komunikat_bledu%TYPE;

    CURSOR k_KursWywolan IS
      SELECT uchwyt_obiektu, num_wiersza, nazwa_obiektu
        FROM stos_wywolan
        WHERE modul = p_Modul
        AND numer_sekw = p_NumSekw
        ORDER BY kolejn_wywolan;

    CURSOR k_KursBledow IS
      SELECT skrot, numer_bledu, komunikat_bledu
        FROM stos_bledow
        WHERE modul = p_Modul
        AND numer_sekw = p_NumSekw
        ORDER BY kolejn_bledow;
  BEGIN
    SELECT et_czasowa, komunikat_bledu
      INTO z_EtykietaCzas, z_KomunikatBledu
      FROM bledy
      WHERE modul = p_Modul
      AND numer_sekw = p_NumSekw;

    -- Wyœwietlenie ogólnych informacji o b³êdzie.
    DBMS_OUTPUT.PUT(TO_CHAR(z_EtykietaCzas, 'DD-MON-YY HH24:MI:SS'));
    DBMS_OUTPUT.PUT('  Modu³: ' || p_Modul);
    DBMS_OUTPUT.PUT('  B³¹d #' || p_NumSekw || ':  ');
    DBMS_OUTPUT.PUT_LINE(z_KomunikatBledu);

    -- Wyœwietlenie informacji dotycz¹cych stosu wywo³ania.
    DBMS_OUTPUT.PUT_LINE('Pe³ny stos wywo³an:');
    DBMS_OUTPUT.PUT_LINE('  Uchwyt obiektu  Numer wiersza  Nazwa obiektu');
    DBMS_OUTPUT.PUT_LINE('  -------------  -----------  -----------');
    FOR z_RekWywolan in k_KursWywolan LOOP
      DBMS_OUTPUT.PUT(RPAD('  ' || z_RekWywolan.uchwyt_obiektu, 15));
      DBMS_OUTPUT.PUT(RPAD('  ' || TO_CHAR(z_RekWywolan.num_wiersza), 13));
      DBMS_OUTPUT.PUT_LINE('  ' || z_RekWywolan.nazwa_obiektu);
    END LOOP;

    -- Wyœwietlenie informacji dotycz¹cych stosu b³êdów.
    DBMS_OUTPUT.PUT_LINE('Pe³ny stos b³êdów:');
    FOR z_RekBledow in k_KursBledow LOOP
      DBMS_OUTPUT.PUT('  ' || z_RekBledow.skrot || '-');
      DBMS_OUTPUT.PUT(TO_CHAR(z_RekBledow.numer_bledu) || ': ');
      DBMS_OUTPUT.PUT_LINE(z_RekBledow.komunikat_bledu);
    END LOOP;
    
  END WyswietlStosy;

  PROCEDURE ZapiszStosy(p_Modul IN bledy.modul%TYPE,
                        p_NumSekw OUT bledy.numer_sekw%TYPE,
                        p_FlagaZatw BOOLEAN DEFAULT FALSE) IS
    z_NumSekw     NUMBER;

    z_Indeks     NUMBER;
    z_Dlugosc    NUMBER;
    z_Koniec     NUMBER;

    z_Wywolanie        VARCHAR2(100);
    z_KolejnWywolan    NUMBER := 1;
    z_Uchwyt       stos_wywolan.uchwyt_obiektu%TYPE;
    z_NumWiersza   stos_wywolan.num_wiersza%TYPE;
    z_NazwaObiektu stos_wywolan.nazwa_obiektu%TYPE;

    z_Blad         VARCHAR2(120);
    z_KolejnBledu  NUMBER := 1;
    z_Skrot        stos_bledow.skrot%TYPE;
    z_NumBledu     stos_bledow.numer_bledu%TYPE;
    z_KomBledu     stos_bledow.komunikat_bledu%TYPE;

    z_NumPierwszBledu bledy.numer_bledu%TYPE;
    z_KomPierwszBledu bledy.komunikat_bledu%TYPE;
  BEGIN
    -- Najpierw uzyskanie numeru sekwencji b³êdu.
    SELECT sekw_bledy.nextval
      INTO z_NumSekw
      FROM dual;

    p_NumSekw := z_NumSekw;

    -- Wstawienie pierwszej czêœci informacji-nag³ówka do tabeli bledy.
    INSERT INTO bledy
      (modul, numer_sekw, stos_bledow, stos_wywolan, et_czasowa)
    VALUES
      (p_Modul, z_NumSekw, z_StosBledow, z_StosWywolan, SYSDATE);

    -- Pobranie informacji ze stosu b³êdów w celu uzyskania opisu ka¿dego b³êdu. Jest to 
    -- wykonywane przez przeszukiwanie ci¹gu znaków stosu b³êdów. 
    -- Rozpocznij z indeksem na pocz¹tku ci¹gu znaków.
    z_Indeks := 1;
    -- Wykonanie pêtli dla ci¹gu znaków, w celu odszukania  wszystkich znaków 
    -- nowego wiersza. Ka¿dy b³¹d na stosie b³êdów koñczy siê znakiem nowego wiersza.
    WHILE z_Indeks <  LENGTH(z_StosBledow) LOOP
      -- z_Koniec oznacza pozycjê znaku nowego wiersza.
      z_Koniec := INSTR(z_StosBledow, z_NowyWiersz, z_Indeks);

      -- Zatem b³¹d zawiera siê pomiêdzy bie¿¹cym indeksem a znakiem nowego wiersza.
      z_Blad := SUBSTR(z_StosBledow, z_Indeks, z_Koniec - z_Indeks);

      -- Pominiêcie bie¿¹cego b³êdu dla nastêpnej iteracji.
      z_Indeks := z_Indeks + LENGTH(z_Blad) + 1;

      -- B³¹d ma nastêpuj¹c¹ postaæ 'skrot-numer: komunikat'.  Konieczne jest 
      -- uzyskanie ka¿dej czêœci do wstawienia.

      -- Po pierwsze, skrót oznacza 3 pierwsze znaki b³êdu.
      z_Skrot := SUBSTR(z_Blad, 1, 3); 

      -- Usuniêcie skrótu oraz myœlnika (zawsze 4 znaki).
      z_Blad := SUBSTR(z_Blad, 5);

      -- Teraz mo¿na uzyskaæ numer b³êdu.
      z_NumBledu := TO_NUMBER(SUBSTR(z_Blad,1,INSTR(z_Blad,':') - 1));

      -- Usuniêcie numeru b³êdu, dwukropka oraz spacji (zawsze 7 znaków).
      z_Blad := SUBSTR(z_Blad, 8);

      -- To, co pozosta³o, jest komunikatem o b³êdzie.
      z_KomBledu := z_Blad;

      -- Wstawienie b³êdów i przechwycenie pierwszego numeru b³êdu oraz komunikatu, 
      -- który mu towarzyszy.
      INSERT INTO stos_bledow
        (modul, numer_sekw, kolejn_bledow, skrot, numer_bledu, 
         komunikat_bledu)
      VALUES
        (p_Modul, p_NumSekw, z_KolejnBledu, z_Skrot, z_NumBledu, 
         z_KomBledu);

      IF z_KolejnBledu = 1 THEN
        z_NumPierwszBledu := z_NumBledu;
        z_KomPierwszBledu := z_Skrot || '-' || TO_NUMBER(z_NumBledu) || ': ' || z_KomBledu;
      END IF;

      z_KolejnBledu := z_KolejnBledu + 1;
    END LOOP;
 
    -- Aktualizacja tabeli bledy o komunikat i kod.
    UPDATE bledy
      SET numer_bledu = z_NumPierwszBledu,
          komunikat_bledu = z_KomPierwszBledu
      WHERE modul = p_Modul
      AND numer_sekw = z_NumSekw;

    -- Pobranie informacji ze stosu wywo³añ w celu uzyskania informacji o ka¿dym  
    -- wywo³aniu. Jest to wykonywane przez przeszukiwanie ci¹gu znaków stosu 
    -- wywo³añ. Rozpocznij z indeksem po pierwszym wywo³aniu 
    -- w stosie. Bêdzie to po pierwszym wyst¹pieniu 'name' oraz znaku nowego wiersza.
    z_Indeks := INSTR(z_StosWywolan, 'name') + 5;
    -- Wykonanie pêtli dla ci¹gu znaków ze znalezieniem ka¿dego znaku nowego 
    -- wiersza. Ka¿de wywo³anie na stosie wywo³añ koñczy siê znakiem nowego wiersza.
    WHILE z_Indeks <  LENGTH(z_StosWywolan) LOOP
      -- z_Koniec oznacza pozycjê nowego wiersza.
      z_Koniec := INSTR(z_StosWywolan, z_NowyWiersz, z_Indeks);

      -- Zatem wywo³anie znajduje siê pomiêdzy bie¿¹cym indeksem a 
      -- znakiem nowego wiersza.
      z_Wywolanie := SUBSTR(z_StosWywolan, z_Indeks, z_Koniec - z_Indeks);

      -- Pominiêcie bie¿¹cego b³êdu dla nastêpnej iteracji.
      z_Indeks := z_Indeks + LENGTH(z_wywolanie) + 1;

      -- Wewn¹trz wywo³ania znajduj¹ siê oddzielone spacjami uchwyt obiektu,
      -- potem numer wiersza, a nastêpnie nazwa obiektu. Konieczne 
      -- jest oddzielenie ich przed wstawieniem do bazy danych.

      -- Najpierw obciêcie spacji w wywo³aniu.
      z_Wywolanie := LTRIM(z_Wywolanie);

      -- Uzyskanie uchwytu do obiektu.
      z_Uchwyt := SUBSTR(z_Wywolanie, 1, INSTR(z_Wywolanie, ' '));

      -- Teraz usuniêcie uchwytu do obiektu, a nastêpnie spacji z wywo³ania.
      z_Wywolanie := SUBSTR(z_Wywolanie, LENGTH(z_Uchwyt) + 1);
      z_Wywolanie := LTRIM(z_Wywolanie);

      -- Teraz mo¿na uzyskaæ numer wiersza.
      z_NumWiersza := TO_NUMBER(SUBSTR(z_Wywolanie, 1, INSTR(z_Wywolanie, ' ')));

      -- Usuniêcie numeru wiersza oraz spacji.
      z_Wywolanie := SUBSTR(z_Wywolanie, LENGTH(z_NumWiersza) + 1);
      z_Wywolanie := LTRIM(z_Wywolanie);

      -- To, co pozosta³o, jest nazw¹ obiektu.
      z_NazwaObiektu := z_Wywolanie;

      -- Wstawienie wszystkich wywo³añ oprócz wywo³ania PakietObslBledow.
      IF z_KolejnWywolan > 1 THEN
        INSERT INTO stos_wywolan
          (modul, numer_sekw, kolejn_wywolan, uchwyt_obiektu, num_wiersza, 
           nazwa_obiektu)
        VALUES
          (p_Modul, z_NumSekw, z_KolejnWywolan, z_Uchwyt, z_NumWiersza, 
           z_NazwaObiektu);
      END IF;

      z_KolejnWywolan := z_KolejnWywolan + 1;

    END LOOP;

    IF p_FlagaZatw THEN 
      commit; 
    END IF;
  END ZapiszStosy;

END PakietObslBledow;
/

show errors

CREATE OR REPLACE TRIGGER tymcz_wstaw
  BEFORE INSERT ON tabela_tymcz
BEGIN
  RAISE ZERO_DIVIDE;
END tymcz_wstaw;
/

CREATE OR REPLACE PROCEDURE C AS
BEGIN
  INSERT INTO tabela_tymcz (kol_num) VALUES (7);
EXCEPTION
  WHEN OTHERS THEN
    PakietObslBledow.ObsluzWszystkie(FALSE);
    RAISE;
END C;
/

CREATE OR REPLACE PROCEDURE B AS
BEGIN
  C;
EXCEPTION
  WHEN OTHERS THEN
    PakietObslBledow.ObsluzWszystkie(FALSE);
    RAISE;
END B;
/

CREATE OR REPLACE PROCEDURE A AS
  z_SekwBledow NUMBER;
BEGIN
  B;
EXCEPTION
  WHEN OTHERS THEN
    PakietObslBledow.ObsluzWszystkie(TRUE);
    PakietObslBledow.ZapiszStosy('Test B³êdu', z_SekwBledow, TRUE);
    PakietObslBledow.WyswietlStosy('Test B³êdu', z_SekwBledow);
END A;
/


SET SERVEROUTPUT ON SIZE 1000000 FORMAT TRUNCATED
exec A;
