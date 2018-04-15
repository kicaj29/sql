DECLARE         --this example uses a constructor
  v_accounting_project typ_ProjectList;
BEGIN
  v_accounting_project :=
    typ_ProjectList
      (typ_Project (1, 'Dsgn New Expense Rpt', 3250),
       typ_Project (2, 'Outsource Payroll', 12350),
       typ_Project (3, 'Audit Accounts Payable',1425));
   INSERT INTO department 
     VALUES(10, 'Accounting', 123, v_accounting_project);
--...
END;
/
