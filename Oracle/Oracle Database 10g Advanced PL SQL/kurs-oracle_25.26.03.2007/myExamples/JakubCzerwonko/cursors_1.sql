
SELECT cust_first_name, CURSOR(SELECT customer_id FROM customers WHERE customer_id = a.customer_id) FROM customers a;


SELECT 'a', CURSOR(SELECT customer_id FROM customers) FROM dual;



BEGIN
  pck_exercise.test1;
END;
/


select Count(*)
          from customers c where c.customer_id < 200;



begin 
 open :cv_cust for select * from customers;
 open :cv_orders for select * from orders;
end;
/



SELECT c.cust_address.city FROM customers c
;