REM Losowe.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten pakiet zawiera sekcj� inicjalizacj.

CREATE OR REPLACE PACKAGE Losowe AS
/* Generator liczb losowych. Wykorzystuje ten sam algorytm, kt�ry funkcja 
   rand()w jezyku C. */

  -- Procedura s�u��ca do zmiany warto�ci pocz�tkowej generatora liczb losowych. 
  -- Od danej warto�ci pocz�tkowej b�dzie generowana ta sama sekwencja liczb losowych. 
  PROCEDURE ZmienZiarno(p_NoweZiarno IN NUMBER);

  -- Zwraca wybrana losowo liczb� ca�kowit� z przedzia�u od 1 do 32767.
  FUNCTION Losowa RETURN NUMBER;

  -- To samo co funkcja Losowa, ale z interfejsem proceduralnym.
  PROCEDURE WezLosowa(p_LiczbaLosowa OUT NUMBER);

  -- Zwraca wybran� losowo liczb� ca�kowit� z przedzia�u od 1 do p_WartMaks.
  FUNCTION LosowaMaks(p_WartMaks IN NUMBER) RETURN NUMBER;

  -- To samo co funkcja LosowaMaks, ale z interfejsem proceduralnym.
  PROCEDURE WezLosowaMaks(p_LiczbaLosowa OUT NUMBER, p_WartMaks IN NUMBER);
END Losowe;
/

CREATE OR REPLACE PACKAGE BODY Losowe AS

  /* Do obliczenia nast�pnej liczby. */
  z_Mnoznik  CONSTANT NUMBER := 22695477;
  z_Inkrementacja CONSTANT NUMBER := 1;

  /* Warto�� pocz�tkowa do generowania sekwencji losowej. */
  z_Ziarno        NUMBER := 1;

  PROCEDURE ZmienZiarno(p_NoweZiarno IN NUMBER) IS
  BEGIN
    z_Ziarno := p_NoweZiarno;
  END ZmienZiarno;

  FUNCTION Losowa RETURN NUMBER IS
  BEGIN
    z_Ziarno := MOD(z_Mnoznik * z_Ziarno + z_Inkrementacja,
                            (2 ** 32));
    RETURN BITAND(z_Ziarno/(2 ** 16), 32767);
  END Losowa;
  PROCEDURE WezLosowa(p_LiczbaLosowa OUT NUMBER) IS
  BEGIN
    -- Wywo�uje funkcj� Rand i zwraca warto��.
    p_LiczbaLosowa := Losowa;
  END WezLosowa;

  FUNCTION LosowaMaks(p_WartMaks IN NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN MOD(Losowa, p_WartMaks) + 1;
  END LosowaMaks;

  PROCEDURE WezLosowaMaks(p_LiczbaLosowa OUT NUMBER,
                                    p_WartMaks IN NUMBER) IS
  BEGIN
    -- Po prostu wywo�uje funkcj� LosowaMaks i zwraca warto��.
    p_LiczbaLosowa := LosowaMaks(p_WartMaks);
  END WezLosowaMaks;

BEGIN
  /* Zainicjowanie pakietu.  Zainicjowanie ziarna zgodnie 
     z bie��cym czasem w sekundach. */
  ZmienZiarno(TO_NUMBER(TO_CHAR(SYSDATE, 'SSSSS')));
END Losowe;
/
