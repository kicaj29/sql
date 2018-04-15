-- use this code for explanation, not demonstration
DECLARE
  TYPE NumList IS TABLE OF NUMBER;
  nums NumList;         -- atomically null
BEGIN
  /* Assume execution continues despite the raised exceptions. */
  nums(1) := 1;         -- raises COLLECTION_IS_NULL
  nums := NumList(1,2); -- initialize table
  nums(NULL) := 3       -- raises VALUE_ERROR              
  nums(0) := 3;         -- raises SUBSCRIPT_OUTSIDE_LIMIT
  nums(3) := 3;         -- raises SUBSCRIPT_BEYOND_COUNT
  nums.DELETE(1);       -- delete element 1
  IF nums(1) = 1 THEN   -- raises NO_DATA_FOUND
...
