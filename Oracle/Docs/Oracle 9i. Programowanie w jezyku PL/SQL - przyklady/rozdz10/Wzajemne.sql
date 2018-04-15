REM Wzajemne.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten przyk³ad demonstruje wzajemnie wykluczaj¹ce siêe podprogramy lokalne.

set serveroutput on

DECLARE
      z_WartTymcz BINARY_INTEGER := 5;
      -- Procedura lokalna A. Nale¿y zauwa¿yæ, ¿e kod A wywo³uje procedurê B.
      PROCEDURE A(p_Licznik IN OUT BINARY_INTEGER) IS
      BEGIN
        DBMS_OUTPUT.PUT_LINE('A(' || p_Licznik || ')');
        IF p_Licznik > 0 THEN
           B(p_Licznik);
           p_Licznik := p_Licznik - 1;
        END IF;
      END A;
      -- Procedura lokalna B. Nale¿y zauwa¿yæ, ¿e kod B wywo³uje procedurê A.
      PROCEDURE B(p_Licznik IN OUT BINARY_INTEGER) IS
      BEGIN
         DBMS_OUTPUT.PUT_LINE('B(' || p_Licznik || ')');
         p_Licznik := p_Licznik - 1;
         A(p_Licznik);
      END B;
    BEGIN
      B(z_WartTymcz);
    END;
/