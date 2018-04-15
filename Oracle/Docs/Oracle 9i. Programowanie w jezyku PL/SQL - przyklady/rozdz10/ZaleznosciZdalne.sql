REM ZaleznosciZdalne.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt ilustruje zale¿noœci pomiêdzy obiektami
REM w ró¿nych bazach danych.

set serveroutput on

-- Utworzenie dwóch procedur.  Procedura P1 zale¿y od procedury P2.
CREATE OR REPLACE PROCEDURE P2 AS
  BEGIN
     DBMS_OUTPUT.PUT_LINE('Wewn¹trz procedury P2!');
END P2;
/


CREATE OR REPLACE PROCEDURE P1 AS
 BEGIN
    DBMS_OUTPUT.PUT_LINE('Wewn¹trz procedury P1!');
    P2;
END P1;
/

-- Sprawdzenie, czy obie procedury s¹ wa¿ne.
SELECT object_name, object_type, status
    FROM user_objects
    WHERE object_name IN ('P1', 'P2');

-- Ponowna kompilacja procedury P2, co powoduje natychmiastow¹ utratê wa¿noœci 
-- procedury P1.
 ALTER PROCEDURE P2 COMPILE;

-- Ponowne sformu³owanie zapytania dla sprawdzenia.
 SELECT object_name, object_type, status
     FROM user_objects
     WHERE object_name IN ('P1', 'P2');

-- Utworzenie ³¹cza do bazy danych wskazuj¹cego na bazê bie¿¹c¹
-- W tym celu bêdzie trzeba zmodyfikowaæ ci¹g po³¹czenia oraz odpowiednio
-- dla naszego systemu skonfigurowaæ program SQL*Net.
CREATE DATABASE LINK loopback
     USING 'ciag_polaczenia';

-- Modyfikacja procedury P1 tak, aby wywo³ywa³a procedurê P2 przez ³¹cze.
CREATE OR REPLACE PROCEDURE P1 AS
  BEGIN
     DBMS_OUTPUT.PUT_LINE('Wewn¹trz procedury P1!');
     P2@petla_zwrotna;
END P1;
/

-- Sprawdzenie, czy obydwie procedury s¹ wa¿ne.
SELECT object_name, object_type, status
    FROM user_objects
    WHERE object_name IN ('P1', 'P2');


-- Teraz, kiedy ponownie skompilujemy procedurê P2, procedura P1 nie utraci 
-- wa¿noœci natychmiast.
 ALTER PROCEDURE P2 COMPILE;

SELECT object_name, object_type, status
   FROM user_objects
   WHERE object_name IN ('P1', 'P2'); 


