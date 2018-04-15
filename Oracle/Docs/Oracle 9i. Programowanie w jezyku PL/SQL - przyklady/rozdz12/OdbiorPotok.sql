REM OdbiorPotok.sql
REM Rozdzia� 12., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje zastosowanie pakietu DBMS_PIPE do
REM odbierania wiadomo�ci.

set serveroutput on

DECLARE
  z_NazwaPotoku VARCHAR2(30) := 'MojPotok';
  z_Status INTEGER;
  z_WartDaty DATE;
  z_WartLiczbowa NUMBER;
  z_CiagZnakow VARCHAR2(100);
BEGIN
  -- Najpierw zostanie odebrana wiadomo��. To wywo�anie b�dzie zablokowane
  -- do chwili, kiedy wiadomo�� zostanie faktycznie przes�ana.
  z_Status := DBMS_PIPE.RECEIVE_MESSAGE(z_NazwaPotoku);
  IF z_Status != 0 THEN
    DBMS_OUTPUT.PUT_LINE('B��d ' || z_Status || 
                         ' podczas odbierania wiadomo�ci');
  END IF;
  
  -- Teraz mo�na rozpakowa� cz�ci wiadomo�ci. Wykonuje si� to w takiej samej
  -- kolejno�ci, w jakiej by�y one wysy�ane.
  DBMS_PIPE.UNPACK_MESSAGE(z_WartDaty);
  DBMS_PIPE.UNPACK_MESSAGE(z_WartLiczbowa);
  DBMS_PIPE.UNPACK_MESSAGE(z_CiagZnakow);
  
  -- Wy�wietlenie otrzymanych warto�ci.
  DBMS_OUTPUT.PUT_LINE('Rozpakowano ' || z_WartDaty);
  DBMS_OUTPUT.PUT_LINE('Rozpakowano ' || z_WartLiczbowa);
  DBMS_OUTPUT.PUT_LINE('Rozpakowano ' || z_CiagZnakow);
END;
/

