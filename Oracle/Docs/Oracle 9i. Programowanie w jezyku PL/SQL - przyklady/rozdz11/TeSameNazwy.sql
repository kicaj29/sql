REM TeSameNazwy.sql
REM Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Tens skrypt demonstruje wyzwalacze, procedury i tabele
REM o tych samych nazwach.

 --Poprawne, poniewa¿ wyzwalacze i tabele wykorzystuj¹ ró¿ne przestrzenie nazw
 CREATE OR REPLACE TRIGGER spec_stats
    BEFORE INSERT ON spec_stats
 BEGIN
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('Wyzwalacz uruchomiony!');
 END spec_stats;
/

 -- Niepoprawne, poniewa¿ procedury i tabele wykorzystuj¹ ró¿ne przestrzenie nazw
 CREATE OR REPLACE PROCEDURE spec_stats
 BEGIN
   INSERT INTO tabela_tymcz (kol_znak)
     VALUES ('Procedurê wywo³ano!');
 END spec_stats;
 /
