REM PokojePkt.sql
REM Rozdzia³ 1, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt zawiera pakiet w jêzyku PL/SQL.

CREATE OR REPLACE PACKAGE PokojePkt AS
  PROCEDURE NowyPokoj(p_Budynek pokoje.budynek%TYPE,
                    p_PokojNr pokoje.pokoj_numer%TYPE,
                    p_LiczbaMiejsc pokoje.liczba_miejsc%TYPE,
                    p_Opis pokoje.opis%TYPE);

  PROCEDURE UsunPokoj(p_PokojID IN pokoje.pokoj_id%TYPE);
END PokojePkt;
/


CREATE OR REPLACE PACKAGE BODY PokojePkt AS
  PROCEDURE NowyPokoj(p_Budynek pokoje.budynek%TYPE,
                    p_PokojNr pokoje.pokoj_numer%TYPE,
                    p_LiczbaMiejsc pokoje.liczba_miejsc%TYPE,
                    p_Opis pokoje.opis%TYPE) IS
  zmienna varchar2(10);                                                                               
  BEGIN
    INSERT INTO pokoje
      (pokoj_id, budynek, pokoj_numer, liczba_miejsc, opis)
      VALUES
      (pokoje_sekwencja.NEXTVAL, p_Budynek, p_PokojNr, p_LiczbaMiejsc,
       p_Opis);
  END NowyPokoj;

  PROCEDURE UsunPokoj(p_PokojID IN pokoje.pokoj_id%TYPE) IS
  BEGIN
    DELETE FROM pokoje
      WHERE pokoj_id = p_PokojID;
  END UsunPokoj;
END PokojePkt;
/


