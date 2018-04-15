CREATE OR REPLACE TYPE typ_billdate IS TABLE OF DATE;
/
DECLARE
  b1       BOOLEAN;
  notice   typ_billdate;
  payments typ_billdate;
BEGIN
  notice   := typ_billdate('15-JAN-02','15-FEB-02','15-MAR-02');
  payments := typ_billdate('15-FEB-02','15-MAR-02','15-JAN-02');
  b1       := notice = payments;
  IF b1 THEN 
    dbms_output.put_line('They are equal.');
  ELSE
    dbms_output.put_line('They are NOT equal.');
  END IF;
END;
/
