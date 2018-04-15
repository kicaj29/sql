REM ReturningInto.sql
REM Rozdzia� 4., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok prezentuje klauzul� RETURNING INTO.

set serveroutput on

DECLARE
    z_NowyRowid ROWID;
    z_Imie studenci.imie%TYPE;
    z_Nazwisko studenci.nazwisko%TYPE;
    z_ID studenci.ID%TYPE;
   BEGIN
    -- Wprowadzenie nowego wiersza do tabeli studenci i jednoczesne pobranie
    -- identyfikatora rowid nowego wiersza.
    INSERT INTO studenci
     (ID, imie, nazwisko, specjalnosc, biezace_zaliczenia)
   VALUES
     (studenci_sekwencja.NEXTVAL, 'Xavier', 'Xemes', '�ywienie', 0)
   RETURNING rowid INTO z_NowyRowid;
   
   DBMS_OUTPUT.PUT_LINE('Identyfikator rowid nowego wiersza wynosi ' || z_NowyRowid);
   
   -- Uaktualnienie tego nowego wiersza - zwi�kszenie warto�ci pola biezace_zaliczenia
   -- i jednoczesne uzyskanie imienia i nazwiska studenta.
   UPDATE studenci
     SET biezace_zaliczenia = biezace_zaliczenia + 3
     WHERE rowid = z_NowyRowid
     RETURNING imie, nazwisko INTO z_Imie, z_Nazwisko;
     
   DBMS_OUTPUT.PUT_LINE('Nazwisko: ' || z_Imie || ' ' || z_Nazwisko);
   
   -- Usuni�cie wiersza i uzyskanie identyfikatora ID usuni�tego wiersza.
   DELETE FROM studenci
     WHERE rowid = z_NowyRowid
     RETURNING ID INTO z_ID;
     
   DBMS_OUTPUT.PUT_LINE('Identyfikator ID nowego wiersza wynosi ' || z_ID);
  END;
  /



