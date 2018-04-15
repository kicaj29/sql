REM DBMS_LOB.sql
REM Rozdzia� 12., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt demonstruje zastosowanie pakietu DBMS_LOB. 

/* Odwraca znaki w danej typu CLOB wskazywanej przez identyfikator p_IdentWejsciowy,
 * w porcjach po p_RozmiarPorcji bajt�w jednorazowo.  Wynik zwracany jest jako
 * p_IdentWynikowy.  Na przyk�ad wywo�anie postaci
 *
 * OdwrocLOB('abcdefghijklmnopqrstuvwxyz', wynik, 4)
 *
 * spowoduje ustawienie danej wynik na 'yzuvwxqrstmnopijklefghabcd'.  Je�eli 
 * parametr p_RozmiarPorcji  nie dzieli parametru wej�ciowego na r�wne cz�ci,
 * wtedy ostatnia porcja wej�ciowej danej typu LOB, kt�ra stanie si� pierwsz�
 * porcj� wynikowej danej typu LOB, b�dzie mniejsza ni� p_RozmiarPorcji.  Je�eli 
 * p_RozmiarPorcji jest wi�kszy ni� rozmiar wej�ciowej danej typu LOB, w�wczas
 * wynikowa dana typu LOB b�dzie identyczna z wej�ciow� dan� typu LOB.
 */
CREATE OR REPLACE PROCEDURE OdwrocLOB(
  p_IdentWejsciowy IN CLOB,
  p_IdentWynikowy IN OUT CLOB,
  p_RozmiarPorcji IN NUMBER) AS

  z_PrzesuniecieWe    BINARY_INTEGER;
  z_PrzesuniecieWy    BINARY_INTEGER;
  z_RozmiarLOB        BINARY_INTEGER;
  z_BiezRozmPorcji    BINARY_INTEGER;
  w_RozmOdcinka       EXCEPTION;
  PRAGMA EXCEPTION_INIT(w_RozmOdcinka, -22926);
  
BEGIN
  -- Najpierw okre�la si� rozmiar wej�ciowej danej LOB.
  z_RozmiarLOB := DBMS_LOB.GETLENGTH(p_IdentWejsciowy);
  
  -- Obci�cie wynikowego obiektu LOB do rozmiaru wej�ciowego. Przechwycenie i 
  -- zignorowanie b��du ORA-22926, je�eli rozmiar wynikowego LOB jest mniejszy 
  -- ni� z_RozmiarLOB.
  BEGIN
    DBMS_LOB.TRIM(p_IdentWynikowy, z_RozmiarLOB);
  EXCEPTION
    WHEN w_RozmOdcinka THEN
      NULL;
  END;

  -- Ustawienie pocz�tkowych warto�ci przesuni��. Przesuni�cie wej�ciowe rozpoczyna si�
  -- od pocz�tku, wynikowe od ko�ca.
  z_PrzesuniecieWe := 1;
  z_PrzesuniecieWy := z_RozmiarLOB + 1;
  
  -- P�tla dla wej�ciowego obiektu LOB i zapisywanie ka�dej porcji do 
  -- wynikowego obiektu LOB.
  LOOP
    -- Zako�czenie p�tli, je�eli przetworzono wszystkie porcje, �wiadczy o tym
    -- fakt, i� z_PrzesuniecieWe przekroczy warto�� z_RozmiarLOB.
    EXIT WHEN z_PrzesuniecieWe > z_RozmiarLOB;
    
    -- Je�eli w wej�ciowym obiekcie LOB pozostanie co najmniej p_RozmiarPorcji bajt�w
    -- skopiowanie tej porcji. W innym przypadku skopiowanie tylu, ile pozosta�o.
    IF (z_RozmiarLOB - z_PrzesuniecieWe + 1) > p_RozmiarPorcji THEN
      z_BiezRozmPorcji := p_RozmiarPorcji;
    ELSE
      z_BiezRozmPorcji := z_RozmiarLOB - z_PrzesuniecieWe + 1;
    END IF;
    
    -- Zmniejszenie warto�ci przesuni�cia wyniku o rozmiar bie��cej porcji.
    z_PrzesuniecieWy := z_PrzesuniecieWy - z_BiezRozmPorcji;

    -- Skopiowanie bie��cej porcji.
    DBMS_LOB.COPY(p_IdentWynikowy,
                  p_IdentWejsciowy,
                  z_BiezRozmPorcji,
                  z_PrzesuniecieWy,
                  z_PrzesuniecieWe);
    
    -- Zwi�kszenie przesuni�cia wej�ciowego o rozmiar bie��cej porcji.
    z_PrzesuniecieWe := z_PrzesuniecieWe + z_BiezRozmPorcji;
  END LOOP;
END OdwrocLOB;
/

DROP TABLE lobdemo;

CREATE TABLE lobdemo (
   klucz NUMBER,
   kol_clob CLOB,
   kol_blob BLOB);

INSERT INTO lobdemo (klucz, kol_clob)
    VALUES (1, 'abcdefghijklmnopqrstuvwxyz');

INSERT INTO lobdemo (klucz, kol_clob)
   VALUES (2, EMPTY_CLOB());

INSERT INTO lobdemo (klucz, kol_clob)
   VALUES (3, EMPTY_CLOB());

INSERT INTO lobdemo (klucz, kol_clob)
   VALUES (4, EMPTY_CLOB());

INSERT INTO lobdemo (klucz, kol_clob)
   VALUES (5, EMPTY_CLOB());

INSERT INTO lobdemo (klucz, kol_clob)
   VALUES (6, EMPTY_CLOB());

COMMIT;

SELECT klucz, kol_clob
  FROM lobdemo
  WHERE klucz BETWEEN 1 AND 6
  ORDER BY klucz;

DECLARE
  z_Zrodlo CLOB;
  z_Przeznaczenie CLOB;
  z_Klucz NUMBER;
  CURSOR k_Przeznaczenie IS
     SELECT klucz, kol_clob
     FROM lobdemo
     WHERE klucz BETWEEN 2 and 6
     FOR UPDATE;
BEGIN
   SELECT kol_clob
     INTO z_Zrodlo
     FROM lobdemo
     WHERE klucz = 1;

  -- P�tla dla wierszy 2-6 i odwr�cenie wiersza 1
  -- w r�ny spos�b.
  OPEN k_Przeznaczenie;
  LOOP
     FETCH k_Przeznaczenie INTO z_Klucz, z_Przeznaczenie;
     EXIT WHEN k_Przeznaczenie%NOTFOUND;

     IF (z_Klucz = 2) THEN
        OdwrocLOB(z_Zrodlo, z_Przeznaczenie, 4);
     ELSIF (z_Klucz = 3) THEN
        OdwrocLOB(z_Zrodlo, z_Przeznaczenie, 2);
     ELSIF (z_Klucz = 4) THEN
        OdwrocLOB(z_Zrodlo, z_Przeznaczenie, 1);
     ELSIF (z_Klucz = 5) THEN
        OdwrocLOB(z_Zrodlo, z_Przeznaczenie, 10);
     ELSIF (z_Klucz = 6) THEN
        OdwrocLOB(z_Zrodlo, z_Przeznaczenie, 30);
     END IF;
  END LOOP;
  CLOSE k_Przeznaczenie;
  COMMIT;
END;
/

SELECT klucz, kol_clob
  FROM lobdemo
  WHERE klucz BETWEEN 1 AND 6
  ORDER BY klucz;