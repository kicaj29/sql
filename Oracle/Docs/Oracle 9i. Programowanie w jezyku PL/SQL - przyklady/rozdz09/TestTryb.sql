REM TestTryb.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ta procedura ilustruje r�ne tryby parametr�w
REM oraz przypisania do parametr�w.

CREATE OR REPLACE PROCEDURE TestTryb (
  p_ParametrWe    IN NUMBER,
  p_ParametrWy    OUT NUMBER,
  p_ParametrWeWy  IN OUT NUMBER) IS

  z_ZmiennaLokalna  NUMBER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Wewn�trz procedury TestTryb:');
  IF (p_ParametrWe IS NULL) THEN
    DBMS_OUTPUT.PUT('p_ParametrWe ma warto�� NULL');
  ELSE
    DBMS_OUTPUT.PUT('p_ParametrWe = ' || p_ParametrWe);
  END IF;

  IF (p_ParametrWy IS NULL) THEN
    DBMS_OUTPUT.PUT('  p_ParametrWy ma warto�� NULL');
  ELSE
    DBMS_OUTPUT.PUT('  p_ParametrWy = ' || p_ParametrWy);
  END IF;

  IF (p_ParametrWeWy IS NULL) THEN
    DBMS_OUTPUT.PUT_LINE('  p_ParametrWeWy ma warto�� NULL');
  ELSE
    DBMS_OUTPUT.PUT_LINE('  p_ParametrWeWy = ' ||
                         p_ParametrWeWy);
  END IF;

  /* Przypisanie parametru p_ParametrWe do zmiennej z_ZmiennaLokalna. Jest to poprawne,
     poniewa� odczytujemy warto�� z parametru wej�ciowego (IN), a nie zapisujemy 
     do niego. */
  z_ZmiennaLokalna := p_ParametrWe;  -- Poprawne

  /* Przypisanie 7 do parametru p_ParametrWe. Jest to niepoprawne, poniewa�
     jest to pr�ba zapisu do parametru wej�ciowego (IN). */
  -- p_ParametrWe := 7;  -- Niepoprawne

  /* Przypisanie 7 do parametru p_ParametrWy. Jest to poprawne, poniewa� 
     jest to pr�ba zapisu do parametru wyj�ciowego (OUT). */
  p_ParametrWy := 7;  -- Poprawne

  /* Przypisanie parametru p_ParametrWy do zmiennej z_ZmiennaLokalna. W systemie Oracle7 
     w wersji 7.3.4 oraz Oracle8 w wersji 8.0.4 lub wy�szej (w��cznie z 8i)
     jest to poprawne.  W wersjach wcze�niejszych ni� 7.3.4 odczytywanie warto�ci
     parametru wyj�ciowego (OUT) jest niepoprawne. */
  z_ZmiennaLokalna := p_ParametrWy;  -- Mo�e by� poprawne

  /* Przypisanie warto�ci parametru p_ParametrWeWy do zmiennej z_ZmiennaLokalna.
     Jest to poprawne, poniewa� odczytujemy warto�� z parametru wej�ciowo-
     wyj�ciowego (IN OUT). */
  z_ZmiennaLokalna := p_ParametrWeWy;  -- Poprawne

  /* Przypisanie 8 do parametru p_ParametrWeWy. Jest to poprawne, poniewa� zapisujemy
     warto�� do parametru wej�ciowo-wyj�ciowego (IN OUT). */
  p_ParametrWeWy := 8;  -- Poprawne

  DBMS_OUTPUT.PUT_LINE('Na ko�cu procedury TestTryb:');
  IF (p_ParametrWe IS NULL) THEN
    DBMS_OUTPUT.PUT('p_ParametrWe ma warto�� NULL');
  ELSE
    DBMS_OUTPUT.PUT('p_ParametrWe = ' || p_ParametrWe);
  END IF;

  IF (p_ParametrWy IS NULL) THEN
    DBMS_OUTPUT.PUT('  p_ParametrWy ma warto�� NULL');
  ELSE
    DBMS_OUTPUT.PUT('  p_ParametrWy = ' || p_ParametrWy);
  END IF;

  IF (p_ParametrWeWy IS NULL) THEN
    DBMS_OUTPUT.PUT_LINE('  p_ParametrWeWy ma warto�� NULL');
  ELSE
    DBMS_OUTPUT.PUT_LINE('  p_ParametrWeWy = ' ||
                         p_ParametrWeWy);
  END IF;

END TestTryb;
/
