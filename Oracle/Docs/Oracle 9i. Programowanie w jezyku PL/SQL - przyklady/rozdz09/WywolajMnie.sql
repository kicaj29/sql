REM WywolajMnie.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt demonstruje notacj� pozycyjn� i imienn�
REM wywo�a� procedur.

CREATE OR REPLACE PROCEDURE WywolajMnie (
  p_ParametrA VARCHAR2,
  p_ParametrB NUMBER,
  p_ParametrC BOOLEAN,
  p_ParametrD DATE) AS
BEGIN
  NULL;
END WywolajMnie;
/

DECLARE
  z_Zmienna1 VARCHAR2(10);
  z_Zmienna2 NUMBER(7,6);
  z_Zmienna3 BOOLEAN;
  z_Zmienna4 DATE;
BEGIN
  WywolajMnie(z_Zmienna1, z_Zmienna2, z_Zmienna3, z_Zmienna4);
END;
/

DECLARE
  z_Zmienna1 VARCHAR2(10);
  z_Zmienna2 NUMBER(7,6);
  z_Zmienna3 BOOLEAN;
  z_Zmienna4 DATE;
BEGIN
  WywolajMnie(p_ParametrA => z_Zmienna1, 
         p_ParametrB => z_Zmienna2,
         p_ParametrC => z_Zmienna3,
         p_ParametrD => z_Zmienna4);
END;
/

DECLARE
  z_Zmienna1 VARCHAR2(10);
  z_Zmienna2 NUMBER(7,6);
  z_Zmienna3 BOOLEAN;
  z_Zmienna4 DATE;
BEGIN
  WywolajMnie(p_ParametrB => z_Zmienna2, 
         p_ParametrC => z_Zmienna3,
         p_ParametrD => z_Zmienna4,
         p_ParametrA => z_Zmienna1);
END;
/

DECLARE
  z_Zmienna1 VARCHAR2(10);
  z_Zmienna2 NUMBER(7,6);
  z_Zmienna3 BOOLEAN;
  z_Zmienna4 DATE;
BEGIN
  -- Pierwsze 2 parametry s� przekazywane przez pozycje, 
  -- nast�pne 2 s� przekazywane przez nazw�.
  WywolajMnie(z_Zmienna1, z_Zmienna2, 
         p_ParametrC => z_Zmienna3,
         p_ParametrD => z_Zmienna4);
END;
/
