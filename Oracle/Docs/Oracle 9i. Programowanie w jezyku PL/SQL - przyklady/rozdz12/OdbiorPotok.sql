REM OdbiorPotok.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje zastosowanie pakietu DBMS_PIPE do
REM odbierania wiadomoœci.

set serveroutput on

DECLARE
  z_NazwaPotoku VARCHAR2(30) := 'MojPotok';
  z_Status INTEGER;
  z_WartDaty DATE;
  z_WartLiczbowa NUMBER;
  z_CiagZnakow VARCHAR2(100);
BEGIN
  -- Najpierw zostanie odebrana wiadomoœæ. To wywo³anie bêdzie zablokowane
  -- do chwili, kiedy wiadomoœæ zostanie faktycznie przes³ana.
  z_Status := DBMS_PIPE.RECEIVE_MESSAGE(z_NazwaPotoku);
  IF z_Status != 0 THEN
    DBMS_OUTPUT.PUT_LINE('B³¹d ' || z_Status || 
                         ' podczas odbierania wiadomoœci');
  END IF;
  
  -- Teraz mo¿na rozpakowaæ czêœci wiadomoœci. Wykonuje siê to w takiej samej
  -- kolejnoœci, w jakiej by³y one wysy³ane.
  DBMS_PIPE.UNPACK_MESSAGE(z_WartDaty);
  DBMS_PIPE.UNPACK_MESSAGE(z_WartLiczbowa);
  DBMS_PIPE.UNPACK_MESSAGE(z_CiagZnakow);
  
  -- Wyœwietlenie otrzymanych wartoœci.
  DBMS_OUTPUT.PUT_LINE('Rozpakowano ' || z_WartDaty);
  DBMS_OUTPUT.PUT_LINE('Rozpakowano ' || z_WartLiczbowa);
  DBMS_OUTPUT.PUT_LINE('Rozpakowano ' || z_CiagZnakow);
END;
/

