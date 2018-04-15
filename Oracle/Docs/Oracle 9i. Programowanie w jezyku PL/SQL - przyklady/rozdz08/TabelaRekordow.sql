REM TabelaRekordow.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok demonstruje indeksowan� tabel� rekord�w.

DECLARE
  TYPE TabelaStudentow IS TABLE OF studenci%ROWTYPE
    INDEX BY BINARY_INTEGER;
  /* Ka�dy element zmiennej z_Studenci jest rekordem */
  z_Studenci TabelaStudentow;
BEGIN
  /* Pobranie rekordu o numerze id = 10 001 i zapisanie go w zmiennej
     z_Studenci(10001). */
  SELECT *
    INTO z_Studenci(10001)
    FROM studenci
    WHERE id = 10001;

  /* Bezpo�rednie przypisanie warto�ci do zmiennej z_Studenci(1). */
  z_Studenci(1).imie := 'Larry';
  z_Studenci(1).nazwisko := 'Lemon';
END;
/
