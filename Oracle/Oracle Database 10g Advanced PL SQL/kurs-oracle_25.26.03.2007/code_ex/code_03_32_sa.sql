CREATE OR REPLACE TYPE billdate IS TABLE OF DATE;
/

ALTER TABLE POrder ADD
 (notice billdate , payments billdate)
    NESTED TABLE notice   STORE AS notice_store_tab
    NESTED TABLE payments STORE AS payments_store_tab;
/
UPDATE Porder
  SET notice   = billdate('15-JAN-02', '15-FEB-02', '15-MAR-02'),
      payments = billdate('15-FEB-02', '15-MAR-02', '15-JAN-02')
  WHERE ordid = 500;
