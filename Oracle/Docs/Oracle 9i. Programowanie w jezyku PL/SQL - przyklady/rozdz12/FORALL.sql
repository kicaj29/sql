REM FORALL.sql
REM Rozdzia� 12., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt demonstruje kilka r�nych zastosowa� instrukcji FORALL,
REM wykorzystywanych we wi�zaniach masowych.

DECLARE
  TYPE t_Liczby IS TABLE OF tabela_tymcz.kol_num%TYPE;
  TYPE t_Ciagi IS TABLE OF tabela_tymcz.kol_znak%TYPE;
  z_Liczby t_Liczby := t_Liczby(1);
  z_Ciagi t_Ciagi := t_Ciagi(1);

  -- Wy�wietla ca�kowit� liczb� wierszy w tabeli tabela_tymcz.
  PROCEDURE WyswietlCalkLWierszy(p_Komunikat IN VARCHAR2) IS
    z_Licznik NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO z_Licznik
      FROM tabela_tymcz;
    DBMS_OUTPUT.PUT_LINE(p_Komunikat || ': Licznik wynosi ' || z_Licznik);
  END WyswietlCalkLWierszy;

BEGIN
  -- Usuni�cie wierszy z tabeli tabela_tymcz.
  DELETE FROM tabela_tymcz;

  -- Wype�nienie tabeli zagnie�d�onej PL/SQL za pomoc� 1000 warto�ci.
  z_Liczby.EXTEND(1000);
  z_Ciagi.EXTEND(1000);
  FOR z_Licznik IN 1..1000 LOOP
    z_Liczby(z_Licznik) := z_Licznik;
    z_Ciagi(z_Licznik) := 'Element #' || z_Licznik;
  END LOOP;

  -- Wstawienie wszystkich 1000 element�w za pomoc� pojedynczej instrukcji FORALL.
  FORALL z_Licznik IN 1..1000
    INSERT INTO tabela_tymcz VALUES
      (z_Liczby(z_Licznik), z_Ciagi(z_Licznik));

  -- W tabeli powinno by� teraz 1000 wierszy.
  WyswietlCalkLWierszy('Po pierwszej operacji INSERT');

  -- Ponowne wstawienie element�w od 501 do 1000.
  FORALL z_Licznik IN 501..1000
    INSERT INTO tabela_tymcz VALUES
      (z_Liczby(z_Licznik), z_Ciagi(z_Licznik));

  -- W tabeli powinno teraz znajdowa� si� 1500 wierszy
  WyswietlCalkLWierszy('Po drugiej operacji INSERT');

  -- Uaktualnienie wszystkich wierszy.
  FORALL z_Licznik IN 1..1000
    UPDATE tabela_tymcz
      SET kol_znak = 'Uaktualniono!'
      WHERE kol_num = z_Liczby(z_Licznik);

  -- Chocia� w tabeli znajduje si� tylko 1000 element�w, to jednak poprzednia
  -- instrukcja uaktualni�a 1500 wierszy, poniewa� warunek klauzuli  WHERE
  -- dla ostatnich 500 element�w spe�nia�y po 2 wiersze.
  DBMS_OUTPUT.PUT_LINE(
    'Instrukcja UPDATE przetworzy�a ' || SQL%ROWCOUNT || ' wierszy.');

  -- Podobnie, ta instrukcja DELETE spowoduje usuni�cie 300 wierszy
  FORALL z_Licznik IN 401..600
    DELETE FROM tabela_tymcz
      WHERE kol_num = z_Liczby(z_Licznik);

  -- Zatem w tabeli pozostanie 1200 wierszy.
  WyswietlCalkLWierszy('Po wykonaniu instrukcji DELETE');
END;
/

-- Ten blok pokazuje, �e wyj�tek spowoduje zatrzymanie masowej operacji INSERT.

DECLARE
         TYPE t_Ciagi IS TABLE OF tabela_tymcz.kol_znak%TYPE
         INDEX BY BINARY_INTEGER;
      TYPE t_Liczby IS TABLE OF tabela_tymcz.kol_num%TYPE
         INDEX BY BINARY_INTEGER;
       z_Ciagi t_Ciagi;
       z_Liczby t_Liczby;
    BEGIN
      -- Usuni�cie wierszy z tabeli i skonfigurowanie tabeli indeksowanej.
     DELETE FROM tabela_tymcz;
     FOR z_Licznik IN 1..10 LOOP
         z_Ciagi(z_Licznik) := '123456789012345678901234567890';
         z_Liczby(z_Licznik) := z_Licznik;
     END LOOP;
     FORALL z_Licznik IN 1..10
        INSERT INTO tabela_tymcz (kol_num, kol_znak)
           VALUES (z_Liczby(z_Licznik), z_Ciagi(z_Licznik));
       -- Dodanie dodatkowego znaku do elementu z_Ciagi(6).
       z_Ciagi(6) := z_Ciagi(6) || 'a';
    -- Ta masowa operacja UPDATE nie powiedzie si� dla sz�stego wiersza, ale
    -- pierwsze pi�� wierszy b�dzie zmodyfikowane.
    FORALL z_Licznik IN 1..10
       UPDATE tabela_tymcz
          SET kol_znak = kol_znak || z_Ciagi(z_Licznik)
          WHERE kol_num = z_Liczby(z_Licznik);
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('Zg�oszono wyj�tek: ' || SQLERRM);
         COMMIT;
   END;
/


 -- To zapytanie poka�e, �e pierwsze 5 wierszy zmodyfikowano
 SELECT kol_znak
    FROM tabela_tymcz
     ORDER BY kol_num;


-- Oracle9i only: The SAVE EXCEPTIONS clause will record any
-- exception during the bulk operation, and continue processing.
DECLARE
  TYPE t_Ciagi IS TABLE OF tabela_tymcz.kol_znak%TYPE
    INDEX BY BINARY_INTEGER;
  TYPE t_Liczby IS TABLE OF tabela_tymcz.kol_num%TYPE
    INDEX BY BINARY_INTEGER;
  z_Ciagi t_Ciagi;
  z_Liczby t_Liczby;
  z_LiczbaBledow NUMBER;
BEGIN
  -- Usuni�cie wierszy z tabeli i skonfigurowanie tabeli indeksowanej.
  DELETE FROM tabela_tymcz;
  FOR z_Licznik IN 1..10 LOOP
     z_Ciagi(z_Licznik) := '123456789012345678901234567890';
     z_Liczby(z_Licznik) := z_Licznik;
  END LOOP;

  FORALL z_Licznik IN 1..10
     INSERT INTO tabela_tymcz (kol_num, kol_znak)
         VALUES (z_Liczby(z_Licznik), z_Ciagi(z_Licznik));

  -- Dodanie dodatkowego znaku do elementu z_Ciagi(6).
  z_Ciagi(6) := z_Ciagi(6) || 'a';

  -- Ta masowa operacja UPDATE nie powiedzie si� dla sz�stego wiersza, ale
  -- pierwsze pi�� wierszy b�dzie zmodyfikowane.
FORALL z_Licznik IN 1..10 SAVE EXCEPTIONS
   UPDATE tabela_tymcz
      SET kol_znak = kol_znak || z_Ciagi(z_Licznik)
      WHERE kol_num = z_Liczby(z_Licznik);
EXCEPTION
   WHEN OTHERS THEN
      DBMS_WYNIK.PUT_LINE('Zg�oszono wyj�tek: ' || SQLERRM);
      -- Wy�wietlenie b��d�w.
      z_LiczbaBledow := SQL%BULK_EXCEPTIONS.COUNT;
      DBMS_WYNIK.PUT_LINE(
      'Liczba b��d�w w czasie przetwarzania: ' || z_LiczbaBledow);
   FOR z_Licznik IN 1..z_LiczbaBledow LOOP
       DBMS_WYNIK.PUT_LINE('B��d   ' || z_Licznik || ', iteracja ' ||
       SQL%BULK_EXCEPTIONS(z_Licznik).error_index || ': ' ||
       SQLERRM(0 - SQL%BULK_EXCEPTIONS(z_Licznik).error_code));
   END LOOP;

   COMMIT;
END;
/

-- To zapytanie poka�e, �e wiersze 1-5 oraz 7-10 zmodyfikowano
-- pomimo tego, �e w wierszu 6 wyst�pi� b��d.
SELECT kol_znak
  FROM tabela_tymcz
     ORDER BY kol_num;
