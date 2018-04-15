UPDATE Porder
  SET notice   = billdate('31-JAN-02', '28-FEB-02', '31-MAR-02'),
      payments = billdate('28-FEB-02', '31-MAR-02')
    WHERE ordid = 500;
