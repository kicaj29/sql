REM RejestrujZmianyZS.sql
REM Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM W tym wyzwalaczu wykorzystano predykaty do zarejestrowania zmian
REM w tabeli zarejestrowani_studenci.

CREATE OR REPLACE TRIGGER RejestrujZmianyZS
  BEFORE INSERT OR DELETE OR UPDATE ON zarejestrowani_studenci
  FOR EACH ROW
DECLARE
  z_ZmianaTyp CHAR(1);
BEGIN
  /* Zastosujemy 'I' dla instrukcji INSERT, 'D' dla instrukcji DELETE, oraz 
     'U' dla instrukcji UPDATE. */
  IF INSERTING THEN
    z_ZmianaTyp := 'I';
  ELSIF UPDATING THEN
    z_ZmianaTyp := 'U';
  ELSE
    z_ZmianaTyp := 'D';
  END IF;

  /* Zapiszemy w tabeli ZS_Audyt wszystkie zmiany dokonane w tabeli
     zarejestrowani_studenci. Zastosujemy funkcjê SYSDATE do wygenerowania datownika, 
     oraz USER w celu uzyskania identyfikatora bie¿¹cego u¿ytkownika. */
  INSERT INTO ZS_Audyt
    (zmiana_typ, zmieniono_przez, data_czas,
     stary_student_id, stary_wydzial, stary_kurs, stara_ocena, 
     nowy_student_id, nowy_wydzial, nowy_kurs, nowa_ocena)
  VALUES
    (z_ZmianaTyp, USER, SYSDATE,
     :old.student_id, :old.wydzial, :old.kurs, :old.ocena,
     :new.student_id, :new.wydzial, :new.kurs, :new.ocena);
END RejestrujZmianyZS;
/
