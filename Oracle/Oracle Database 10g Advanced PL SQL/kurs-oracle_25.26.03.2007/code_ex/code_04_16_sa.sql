--An error will occur after executing this code as c_tax.c doesn't exists.
CREATE FUNCTION tax_amt(x BINARY_INTEGER)
RETURN BINARY_INTEGER
AS LANGUAGE C
LIBRARY c_utility
NAME "c_tax";
/
