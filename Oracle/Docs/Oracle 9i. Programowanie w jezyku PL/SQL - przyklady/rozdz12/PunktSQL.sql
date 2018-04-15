REM PunktSQL.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt demonstruje operacje SQL na danych typów obiektowych.


DROP TABLE tab_obiekt_punkt;

CREATE TABLE tab_obiekt_punkt OF Punkt;

DROP TABLE tab_kolumn_punkt;

CREATE TABLE tab_kolumn_punkt (
    klucz VARCHAR2(20),
    wartosc Punkt);

set serveroutput on

DECLARE
     z_Punkt Punkt := Punkt(1, 1);
     z_NowyPunkt Punkt;
     z_Klucz tab_kolumn_punkt.klucz%TYPE;
     z_WspolX NUMBER;
     z_WspolY NUMBER;
   BEGIN
    -- Wprowadzenie danych do obu tabel.
    INSERT INTO tab_obiekt_punkt VALUES (z_Punkt);
    INSERT INTO tab_kolumn_punkt VALUES ('Mój Punkt', z_Punkt);
    -- W przypadkuutworzenia zapytania do tabeli obiektowej, uzyska siê
    -- ka¿dy wiersz zbioru elementów, podobnie jak w tabeli relacyjnej.
    SELECT *
       INTO z_WspolX, z_WspolY
       FROM tab_obiekt_punkt;
    DBMS_OUTPUT.PUT_LINE('Relacyjne zapytanie do tabeli obiektowej: ' ||
       z_WspolX || ', ' || z_WspolY);
    -- W przypadku zastosowaniaoperatora VALUE, ka¿dy wiersz uzyska siê
    -- jako obiekt.
    SELECT VALUE(ot)
       INTO z_NowyPunkt
       FROM tab_obiekt_punkt ot;
    DBMS_OUTPUT.PUT_LINE('tabela obiektowa: ' || z_NowyPunkt.NaCiag);
    -- Wybieranie danych z kolumny obiektowej zawsze zwraca
    -- egzemplarz obiektu.
    SELECT klucz, wartosc
       INTO z_Klucz, z_NowyPunkt
       FROM tab_kolumn_punkt;
    DBMS_OUTPUT.PUT_LINE('tabela z kolumn¹ obiektow¹: ' || z_NowyPunkt.NaCiag);
  END;
/

-- Ten blok ilustruje zastosowanie odnoœników do obiektów

DECLARE
     z_Punkt Punkt := Punkt(1, 1);
     z_NowyPunkt Punkt;
     z_Klucz tab_kolumn_punkt.klucz%TYPE;
     z_WspolX NUMBER;
     z_WspolY NUMBER;
   BEGIN
    -- Wprowadzenie danych do obu tabel.
    INSERT INTO tab_obiekt_punkt VALUES (z_Punkt);
    INSERT INTO tab_kolumn_punkt VALUES ('Mój Punkt', z_Punkt);
    -- W przypadkuutworzenia zapytania do tabeli obiektowej, uzyska siê
    -- ka¿dy wiersz zbioru elementów, podobnie jak w tabeli relacyjnej.
    SELECT *
       INTO z_WspolX, z_WspolY
       FROM tab_obiekt_punkt;
    DBMS_OUTPUT.PUT_LINE('Relacyjne zapytanie do tabeli obiektowej: ' ||
       z_WspolX || ', ' || z_WspolY);
    -- W przypadku zastosowaniaoperatora VALUE, ka¿dy wiersz uzyska siê
    -- jako obiekt.
    SELECT VALUE(ot)
       INTO z_NowyPunkt
       FROM tab_obiekt_punkt ot;
    DBMS_OUTPUT.PUT_LINE('tabela obiektowa: ' || z_NowyPunkt.NaCiag);
    -- Wybieranie danych z kolumny obiektowej zawsze zwraca
    -- egzemplarz obiektu.
    SELECT klucz, wartosc
       INTO z_Klucz, z_NowyPunkt
       FROM tab_kolumn_punkt;
    DBMS_OUTPUT.PUT_LINE('tabela z kolumn¹ obiektow¹: ' || z_NowyPunkt.NaCiag);
  END;
/

