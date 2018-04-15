REM TestTryb.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ta procedura ilustruje ró¿ne tryby parametrów
REM oraz przypisania do parametrów.

CREATE OR REPLACE PROCEDURE TestTryb (
  p_ParametrWe    IN NUMBER,
  p_ParametrWy    OUT NUMBER,
  p_ParametrWeWy  IN OUT NUMBER) IS

  z_ZmiennaLokalna  NUMBER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Wewn¹trz procedury TestTryb:');
  IF (p_ParametrWe IS NULL) THEN
    DBMS_OUTPUT.PUT('p_ParametrWe ma wartoœæ NULL');
  ELSE
    DBMS_OUTPUT.PUT('p_ParametrWe = ' || p_ParametrWe);
  END IF;

  IF (p_ParametrWy IS NULL) THEN
    DBMS_OUTPUT.PUT('  p_ParametrWy ma wartoœæ NULL');
  ELSE
    DBMS_OUTPUT.PUT('  p_ParametrWy = ' || p_ParametrWy);
  END IF;

  IF (p_ParametrWeWy IS NULL) THEN
    DBMS_OUTPUT.PUT_LINE('  p_ParametrWeWy ma wartoœæ NULL');
  ELSE
    DBMS_OUTPUT.PUT_LINE('  p_ParametrWeWy = ' ||
                         p_ParametrWeWy);
  END IF;

  /* Przypisanie parametru p_ParametrWe do zmiennej z_ZmiennaLokalna. Jest to poprawne,
     poniewa¿ odczytujemy wartoœæ z parametru wejœciowego (IN), a nie zapisujemy 
     do niego. */
  z_ZmiennaLokalna := p_ParametrWe;  -- Poprawne

  /* Przypisanie 7 do parametru p_ParametrWe. Jest to niepoprawne, poniewa¿
     jest to próba zapisu do parametru wejœciowego (IN). */
  -- p_ParametrWe := 7;  -- Niepoprawne

  /* Przypisanie 7 do parametru p_ParametrWy. Jest to poprawne, poniewa¿ 
     jest to próba zapisu do parametru wyjœciowego (OUT). */
  p_ParametrWy := 7;  -- Poprawne

  /* Przypisanie parametru p_ParametrWy do zmiennej z_ZmiennaLokalna. W systemie Oracle7 
     w wersji 7.3.4 oraz Oracle8 w wersji 8.0.4 lub wy¿szej (w³¹cznie z 8i)
     jest to poprawne.  W wersjach wczeœniejszych ni¿ 7.3.4 odczytywanie wartoœci
     parametru wyjœciowego (OUT) jest niepoprawne. */
  z_ZmiennaLokalna := p_ParametrWy;  -- Mo¿e byæ poprawne

  /* Przypisanie wartoœci parametru p_ParametrWeWy do zmiennej z_ZmiennaLokalna.
     Jest to poprawne, poniewa¿ odczytujemy wartoœæ z parametru wejœciowo-
     wyjœciowego (IN OUT). */
  z_ZmiennaLokalna := p_ParametrWeWy;  -- Poprawne

  /* Przypisanie 8 do parametru p_ParametrWeWy. Jest to poprawne, poniewa¿ zapisujemy
     wartoœæ do parametru wejœciowo-wyjœciowego (IN OUT). */
  p_ParametrWeWy := 8;  -- Poprawne

  DBMS_OUTPUT.PUT_LINE('Na koñcu procedury TestTryb:');
  IF (p_ParametrWe IS NULL) THEN
    DBMS_OUTPUT.PUT('p_ParametrWe ma wartoœæ NULL');
  ELSE
    DBMS_OUTPUT.PUT('p_ParametrWe = ' || p_ParametrWe);
  END IF;

  IF (p_ParametrWy IS NULL) THEN
    DBMS_OUTPUT.PUT('  p_ParametrWy ma wartoœæ NULL');
  ELSE
    DBMS_OUTPUT.PUT('  p_ParametrWy = ' || p_ParametrWy);
  END IF;

  IF (p_ParametrWeWy IS NULL) THEN
    DBMS_OUTPUT.PUT_LINE('  p_ParametrWeWy ma wartoœæ NULL');
  ELSE
    DBMS_OUTPUT.PUT_LINE('  p_ParametrWeWy = ' ||
                         p_ParametrWeWy);
  END IF;

END TestTryb;
/
