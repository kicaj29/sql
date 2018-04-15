REM exists.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok demonstruje zastosowanie metody EXISTS.

DECLARE
   z_TabelaZagniezdzona TablicaLiczb := TablicaLiczb(-7, 14.3, 3.14159, NULL, 0);
   z_Licznik BINARY_INTEGER := 1;
   z_TabelaIndeksowana Indeksowane.TablicaLiczb;
BEGIN
   -- P�tla dla tabeli z_TabelaZagniezdzona i wy�wietlenie jej element�w, 
   -- z wykorzystaniem metody EXISTS w celu oznaczenia zako�czenia p�tli.
   LOOP
     IF z_TabelaZagniezdzona.EXISTS(z_Licznik) THEN
        DBMS_OUTPUT.PUT_LINE(
           'z_TabelaZagniezdzona(' || z_Licznik || '): ' ||
         z_TabelaZagniezdzona(z_Licznik));
         z_Licznik := z_Licznik + 1;
    ELSE
       EXIT;
    END IF;
 END LOOP;

  -- Przypisanie tych samych element�w do tabeli indeksowanej.
  z_TabelaIndeksowana(1) := -7;
  z_TabelaIndeksowana(2) := 14.3;
  z_TabelaIndeksowana(3) := 3.14159;
  z_TabelaIndeksowana(4) := NULL;
  z_TabelaIndeksowana(5) := 0;

  -- wykonanie p�tli podobnej do poprzedniej.
  z_Licznik := 1;
  LOOP
     IF z_TabelaIndeksowana.EXISTS(z_Licznik) THEN
       DBMS_OUTPUT.PUT_LINE(
         'z_TabelaIndeksowana(' || z_Licznik || '): ' ||
         z_TabelaIndeksowana(z_Licznik));
         z_Licznik := z_Licznik + 1;
     ELSE
       EXIT;
     END IF;
  END LOOP;
END;
/