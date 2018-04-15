REM kursor2.sql
REM Rozdzia³ 6., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ta procedura ilustruje zmienne kursora po stronie serwera.

CREATE OR REPLACE PROCEDURE PokazZmiennaKursora
  /* Demonstruje u¿ycie zmiennej kursora na serwerze. Je¿eli parametr 
     p_Tabela ma wartoœæ 'grupy', wtedy dane z tabeli grupy wstawiane s¹
     do tabeli tabela_tymcz. Je¿eli parametr p_Tabela ma wartoœæ 
     'pokoje', wtedy wstawiane s¹ dane z tabeli pokoje. */
  (p_Tabela IN VARCHAR2) AS

  /* Zdefiniowanie typu zmiennej kursora */
  TYPE t_GrupyPokoje IS REF CURSOR;

  /* oraz sama zmienna. */
  z_ZmKursora t_GrupyPokoje;
  /* Zmienne do przechowywania danych wyjœciowych. */
  z_Wydzial    grupy.wydzial%TYPE;
  z_Kurs       grupy.kurs%TYPE;
  z_PokojID    pokoje.pokoj_id%TYPE;
  z_Opis       pokoje.opis%TYPE;
BEGIN
  -- Otwarcie zmiennej kursora na podstawie parametru wejœciowego.
  IF p_Tabela = 'grupy' THEN
    OPEN z_ZmKursora FOR
      SELECT wydzial, kurs
        FROM grupy;
  ELSIF p_tabela = 'pokoje' THEN
    OPEN z_ZmKursora FOR
      SELECT pokoj_id, opis
        FROM pokoje;
  ELSE
    /* Nieprawid³owa wartoœæ przekazana jako dana wejœciowa - wyst¹pi b³¹d */
    RAISE_APPLICATION_ERROR(-20000,
      'Danymi wejœciowymi musz¹ byæ ''grupy'' lub ''pokoje''');
  END IF;

  /* Pêtla pobierania.  Nale¿y zwróciæ uwagê na klauzule EXIT WHEN po instrukcji FETCH*/
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

  /* Zamkniêcie kursora. */
  CLOSE z_ZmKursora;

  COMMIT;
END PokazZmiennaKursora;
/
