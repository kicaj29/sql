EXECUTE test_credit_update_info(125, 'AM EX', 123456789)

SELECT credit_cards FROM customers WHERE customer_id = 125;
