REM kursor2.sql
REM Rozdzia� 6., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ta procedura ilustruje zmienne kursora po stronie serwera.

CREATE OR REPLACE PROCEDURE PokazZmiennaKursora
  /* Demonstruje u�ycie zmiennej kursora na serwerze. Je�eli parametr 
     p_Tabela ma warto�� 'grupy', wtedy dane z tabeli grupy wstawiane s�
     do tabeli tabela_tymcz. Je�eli parametr p_Tabela ma warto�� 
     'pokoje', wtedy wstawiane s� dane z tabeli pokoje. */
  (p_Tabela IN VARCHAR2) AS

  /* Zdefiniowanie typu zmiennej kursora */
  TYPE t_GrupyPokoje IS REF CURSOR;

  /* oraz sama zmienna. */
  z_ZmKursora t_GrupyPokoje;
  /* Zmienne do przechowywania danych wyj�ciowych. */
  z_Wydzial    grupy.wydzial%TYPE;
  z_Kurs       grupy.kurs%TYPE;
  z_PokojID    pokoje.pokoj_id%TYPE;
  z_Opis       pokoje.opis%TYPE;
BEGIN
  -- Otwarcie zmiennej kursora na podstawie parametru wej�ciowego.
  IF p_Tabela = 'grupy' THEN
    OPEN z_ZmKursora FOR
      SELECT wydzial, kurs
        FROM grupy;
  ELSIF p_tabela = 'pokoje' THEN
    OPEN z_ZmKursora FOR
      SELECT pokoj_id, opis
        FROM pokoje;
  ELSE
    /* Nieprawid�owa warto�� przekazana jako dana wej�ciowa - wyst�pi b��d */
    RAISE_APPLICATION_ERROR(-20000,
      'Danymi wej�ciowymi musz� by� ''grupy'' lub ''pokoje''');
  END IF;

  /* P�tla pobierania.  Nale�y zwr�ci� uwag� na klauzule EXIT WHEN po instrukcji FETCH*/
  LOOP
    IF p_Tabela = 'grupy' THEN
      FETCH z_ZmKursora INTO
        z_Wydzial, z_Kurs;
      EXIT WHEN z_ZmKursora%NOTFOUND;

      INSERT INTO tabela_tymcz (kol_num, kol_znak)
        VALUES (z_Kurs, z_Wydzial);
    ELSE
      FETCH z_ZmKursora INTO
        z_PokojID, z_Opis;
      EXIT WHEN z_ZmKursora%NOTFOUND;

      INSERT INTO tabela_tymcz (kol_num, kol_znak)
        VALUES (z_PokojID, SUBSTR(z_Opis, 1, 60));
    END IF;
  END LOOP;

  /* Zamkni�cie kursora. */
  CLOSE z_ZmKursora;

  COMMIT;
END PokazZmiennaKursora;
/
