REM BULK_COLLECT.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt ilustruje ró¿ne zastosowania instrukcji BULK_COLLECT 
REM wykorzystywanych do powi¹zañ masowych

set serveroutput on format wrapped

DECLARE
  TYPE t_Liczby IS TABLE OF tabela_tymcz.kol_num%TYPE;
  TYPE t_Ciagi IS TABLE OF tabela_tymcz.kol_znak%TYPE;
  z_Liczby t_Liczby := t_Liczby(1);
  z_Ciagi t_Ciagi := t_Ciagi(1);
  z_Liczby2 t_Liczby;
  z_Ciagi2 t_Ciagi;

  CURSOR k_znak IS
    SELECT kol_znak
    FROM tabela_tymcz
    WHERE kol_num > 800
    ORDER BY kol_num;

BEGIN
  -- Za³adowanie do tabeli tabela_tymcz 1500 wierszy, z których 500 
  -- to duplikaty.
  z_Liczby.EXTEND(1500);
  z_Ciagi.EXTEND(1500);
  FOR z_Licznik IN 1..1000 LOOP
    z_Liczby(z_Licznik) := z_Licznik;
    z_Ciagi(z_Licznik) := 'Element #' || z_Licznik;
    IF z_Licznik > 500 THEN
      z_Liczby(z_Licznik + 500) := z_Licznik;
      z_Ciagi(z_Licznik + 500) := 'Element #' || z_Licznik;
    END IF;
  END LOOP;

  DELETE FROM tabela_tymcz;
  FORALL z_Licznik IN 1..1500
    INSERT INTO tabela_tymcz (kol_num, kol_znak)
      VALUES (z_Liczby(z_Licznik), z_Ciagi(z_Licznik));

  -- Pobranie wszystkich wierszy do tabeli zagnie¿d¿onej
  -- w jednej operacji.
  SELECT kol_num, kol_znak
    BULK COLLECT INTO z_Liczby, z_Ciagi
    FROM tabela_tymcz
    ORDER BY kol_num;

  DBMS_OUTPUT.PUT_LINE(
    'W pierwszym zapytaniu pobrano ' || z_Liczby.COUNT || ' wierszy');

  -- Nie trzeba inicjowaæ tabeli, klauzula BULK COLLECT
  -- odpowiednio doda elementy :
  SELECT kol_num
    BULK COLLECT INTO z_Liczby2
    FROM tabela_tymcz;

  DBMS_OUTPUT.PUT_LINE(
    'W drugim zapytaniu pobrano ' || z_Liczby2.COUNT || ' wierszy');

  -- Mo¿na tak¿e dokonaæ masowego pobrania z kursora.
  OPEN k_znak;
  FETCH k_znak BULK COLLECT INTO z_Ciagi2;
  CLOSE k_znak;

  DBMS_OUTPUT.PUT_LINE(
    'Do kursora pobrano ' || z_Ciagi2.COUNT || ' wierszy');

END;
/

DECLARE
      TYPE t_Liczby IS TABLE OF tabela_tymcz.kol_num%TYPE
          INDEX BY BINARY_INTEGER;
      TYPE t_Ciagi IS TABLE OF tabela_tymcz.kol_znak%TYPE
          INDEX BY BINARY_INTEGER;
      z_Liczby t_Liczby;
      z_Ciagi t_Ciagi;
   BEGIN
      -- Usuniêcie danych z tabeli, a nastêpnie wstawienie do niej 55 wierszy.
      -- Skonfigurowanie typu t_Liczby.
      DELETE FROM tabela_tymcz;
      FOR z_Zewn IN 1..10 LOOP
        FOR z_Wewn IN 1..z_Zewn LOOP
           INSERT INTO tabela_tymcz (kol_num, kol_znak)
              VALUES (z_Zewn, 'Element #' || z_Wewn);
        END LOOP;
        z_Liczby(z_Zewn) := z_Zewn;
      END LOOP;
      -- Usuniêcie kilku wierszy, ale zachowanie danych znakowych
      FORALL z_Licznik IN 1..5
         DELETE FROM tabela_tymcz
            WHERE kol_num = z_Liczby(z_Licznik)
            RETURNING kol_znak BULK COLLECT INTO z_Ciagi;
      -- Zmienna z_Ciagi zawiera teraz 15 wierszy, tzn. 1+2+3+4+5.
      DBMS_OUTPUT.PUT_LINE('Po operacji DELETE:');
      FOR z_Licznik IN 1..z_Ciagi.COUNT LOOP
         DBMS_OUTPUT.PUT_LINE(
              '  z_Ciagi(' || z_Licznik || ') = ' || z_Ciagi(z_Licznik));
     END LOOP;
   END;
/
