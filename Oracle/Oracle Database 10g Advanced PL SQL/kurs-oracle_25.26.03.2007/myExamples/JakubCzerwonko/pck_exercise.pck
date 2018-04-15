create or replace package pck_exercise is

  -- Author  : KUBA
  -- Created : 2007-03-26 11:27:40
  -- Purpose : 
  
  -- Public type declarations
  -- type <TypeName> is <Datatype>;
  type rt_cust is ref cursor ;
--       return customers%rowtype;    
  
  
  -- Public constant declarations
  --<ConstantName> constant <Datatype> := <Value>;

  -- Public variable declarations
  --<VariableName> <Datatype>;

  -- Public function and procedure declarations
  function foo(cur rt_cust) return number;
  procedure test1;
  procedure test2(cur in out rt_cust);  
  function foo2(cur rt_cust) return typ_customers_nst pipelined;
  
  function foo_coll(ordid number) return typ_item_nst;
  function foo_pipelined(ordid number) return typ_item_nst pipelined;
end pck_exercise;
/
create or replace package body pck_exercise is

  -- Private type declarations
--  type <TypeName> is <Datatype>;
  
  -- Private constant declarations
--  <ConstantName> constant <Datatype> := <Value>;

  -- Private variable declarations
--  <VariableName> <Datatype>;

  -- Function and procedure implementations
  function foo(cur rt_cust) return number is
    --ilosc number :=0;
    rec_customers customers%rowtype;
  begin
    loop
        fetch cur into rec_customers;
        exit when cur%notfound;
    end loop;
    return cur%rowcount;
  end;

  procedure test1 is
    cur_cust rt_cust;            
    ilosc number := 0;
  begin
    open cur_cust for 
          select *
          from customers c where c.customer_id < 200;
      ilosc := foo(cur => cur_cust);      
    close cur_cust;
    dbms_output.put_line(ilosc);
  end;

  procedure test2(cur in out rt_cust) is
  begin
       open cur for 
          select *
          from customers c where c.customer_id < 200;
--    close cur;   -- trzeba zakomentowac bo inaczej nie zobaczymy na zewnastrz
  end;
  
  function foo2(cur rt_cust) return typ_customers_nst pipelined is 
     rec_customers customers%rowtype;
  begin
     loop
         fetch cur into rec_customers;
         exit when cur%notfound;
         pipe row (typ_customers(rec_customers.customer_id, rec_customers.cust_first_name));
     end loop;
     return;
  end;
  
  function foo_coll(ordid number) return typ_item_nst is
     v_item_list typ_item_nst;
  begin
     v_item_list :=
        typ_item_nst
            (
               typ_item(1,22.3),
               typ_item(2,232.3),
               typ_item(3,122.3),
               typ_item(4,11222.3)                              
            );
     return v_item_list;
  end;
    
  function foo_pipelined(ordid number) return typ_item_nst pipelined
   is    
  begin
     pipe row(typ_item(1,22.3));
     pipe row(typ_item(2,122.3));
     pipe row(typ_item(3,322.3));     
     pipe row(typ_item(4,522.3));
     pipe row(typ_item(5,0.3));
     pipe row(typ_item(6,23.3));               
     pipe row(typ_item(7,252.3));
     return;
  end;


  
begin
  -- Initialization
  null;
end pck_exercise;
/
