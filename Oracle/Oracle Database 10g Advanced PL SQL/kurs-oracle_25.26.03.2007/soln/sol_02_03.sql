CREATE OR REPLACE PACKAGE mytypes
IS
  TYPE typ_warranty IS RECORD (month POSITIVE, year PLS_INTEGER);
  SUBTYPE warranty IS typ_warranty; -- based on RECORD type
END mytypes;
/
