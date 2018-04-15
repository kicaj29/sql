COLUMN object_name format a16
COLUMN argument_name format a14
COLUMN in_out FORMAT a8
COLUMN data_type FORMAT a10

SELECT object_name, argument_name, in_out, position, data_type
FROM   all_arguments
WHERE  package_name = 'ORDERS_APP_PKG';
