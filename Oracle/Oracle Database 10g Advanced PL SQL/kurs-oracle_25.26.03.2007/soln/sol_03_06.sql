SET SERVEROUT ON

EXECUTE credit_card_pkg.display_card_info(120)

EXECUTE credit_card_pkg.update_card_info(120, 'Visa', 11111111)

SELECT credit_cards 
FROM   customers 
WHERE  customer_id = 120;

EXECUTE credit_card_pkg.display_card_info(120)

EXECUTE credit_card_pkg.update_card_info(120, 'MC', 2323232323)

EXECUTE credit_card_pkg.update_card_info (120, 'DC', 4444444)

EXECUTE credit_card_pkg.display_card_info(120)

