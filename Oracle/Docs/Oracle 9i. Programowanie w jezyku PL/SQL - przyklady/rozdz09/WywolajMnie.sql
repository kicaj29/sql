REM WywolajMnie.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt demonstruje notacjê pozycyjn¹ i imienn¹
REM wywo³añ procedur.

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
  -- Pierwsze 2 parametry s¹ przekazywane przez pozycje, 
  -- nastêpne 2 s¹ przekazywane przez nazwê.
  WywolajMnie(z_Zmienna1, z_Zmienna2, 
         p_ParametrC => z_Zmienna3,
         p_ParametrD => z_Zmienna4);
END;
/
