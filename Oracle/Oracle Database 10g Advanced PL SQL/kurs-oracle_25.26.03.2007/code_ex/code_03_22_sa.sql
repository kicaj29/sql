DECLARE
  i INTEGER;
  v_accounting_project typ_ProjectList;
BEGIN
  v_accounting_project := typ_ProjectList(
    typ_Project (1,'Dsgn New Expense Rpt', 3250),
    typ_Project (2, 'Outsource Payroll', 12350),
    typ_Project (3, 'Audit Accounts Payable',1425));
  i := v_accounting_project.FIRST ; 
  WHILE i IS NOT NULL LOOP
    IF v_accounting_project(i).cost > 10000 then
      DBMS_OUTPUT.PUT_LINE('Project too expensive: '
                      || v_accounting_project(i).title);
    END IF;
    i := v_accounting_project.NEXT (i); 
  END LOOP;
END;
/
