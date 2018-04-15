SELECT c.customer_id, c.cust_address.street_address,
       c.cust_address.city, c.cust_address.state_province,          
       c.cust_address.postal_code, c.cust_address.country_id
FROM   customers c
WHERE  customer_id = 1000;
