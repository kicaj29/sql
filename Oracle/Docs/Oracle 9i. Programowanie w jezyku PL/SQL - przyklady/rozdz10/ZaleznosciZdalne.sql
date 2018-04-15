REM ZaleznosciZdalne.sql
REM Rozdzia� 10., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt ilustruje zale�no�ci pomi�dzy obiektami
REM w r�nych bazach danych.

set serveroutput on

-- Utworzenie dw�ch procedur.  Procedura P1 zale�y od procedury P2.
CREATE OR REPLACE PROCEDURE P2 AS
  BEGIN
     DBMS_OUTPUT.PUT_LINE('Wewn�trz procedury P2!');
END P2;
/


CREATE OR REPLACE PROCEDURE P1 AS
 BEGIN
    DBMS_OUTPUT.PUT_LINE('Wewn�trz procedury P1!');
    P2;
END P1;
/

-- Sprawdzenie, czy obie procedury s� wa�ne.
SELECT object_name, object_type, status
    FROM user_objects
    WHERE object_name IN ('P1', 'P2');

-- Ponowna kompilacja procedury P2, co powoduje natychmiastow� utrat� wa�no�ci 
-- procedury P1.
 ALTER PROCEDURE P2 COMPILE;

-- Ponowne sformu�owanie zapytania dla sprawdzenia.
 SELECT object_name, object_type, status
     FROM user_objects
     WHERE object_name IN ('P1', 'P2');

-- Utworzenie ��cza do bazy danych wskazuj�cego na baz� bie��c�
-- W tym celu b�dzie trzeba zmodyfikowa� ci�g po��czenia oraz odpowiednio
-- dla naszego systemu skonfigurowa� program SQL*Net.
CREATE DATABASE LINK loopback
     USING 'ciag_polaczenia';

-- Modyfikacja procedury P1 tak, aby wywo�ywa�a procedur� P2 przez ��cze.
CREATE OR REPLACE PROCEDURE P1 AS
  BEGIN
     DBMS_OUTPUT.PUT_LINE('Wewn�trz procedury P1!');
     P2@petla_zwrotna;
END P1;
/

-- Sprawdzenie, czy obydwie procedury s� wa�ne.
SELECT object_name, object_type, status
    FROM user_objects
    WHERE object_name IN ('P1', 'P2');


-- Teraz, kiedy ponownie skompilujemy procedur� P2, procedura P1 nie utraci 
-- wa�no�ci natychmiast.
 ALTER PROCEDURE P2 COMPILE;

SELECT object_name, object_type, status
   FROM user_objects
   WHERE object_name IN ('P1', 'P2'); 


