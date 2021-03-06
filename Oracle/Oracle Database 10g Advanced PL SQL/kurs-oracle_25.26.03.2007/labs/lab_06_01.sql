CONNECT /AS sysdba

CREATE USER sr153 IDENTIFIED BY oracle
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP
 QUOTA UNLIMITED ON USERS;

CREATE USER sr154 IDENTIFIED BY oracle
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP
 QUOTA UNLIMITED ON USERS;

CREATE USER sr155 IDENTIFIED BY oracle
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP
 QUOTA UNLIMITED ON USERS;

CREATE USER sr156 IDENTIFIED BY oracle
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP
 QUOTA UNLIMITED ON USERS;

CREATE USER sr158 IDENTIFIED BY oracle
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP
 QUOTA UNLIMITED ON USERS;

CREATE USER sr159 IDENTIFIED BY oracle
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP
 QUOTA UNLIMITED ON USERS;

CREATE USER sr160 IDENTIFIED BY oracle
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP
 QUOTA UNLIMITED ON USERS;

CREATE USER sr161 IDENTIFIED BY oracle
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP
 QUOTA UNLIMITED ON USERS;

CREATE USER sr163 IDENTIFIED BY oracle
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP
 QUOTA UNLIMITED ON USERS;

GRANT create session
    , alter session 
TO sr153, sr154, sr155, sr156, sr158, sr159, 
   sr160, sr161, sr163;

GRANT SELECT, INSERT, UPDATE, DELETE ON
  oe.orders TO sr153, sr154, sr155, sr156, sr158,  
                  sr159, sr160, sr161, sr163;

GRANT SELECT, INSERT, UPDATE, DELETE ON
  oe.order_items TO sr153, sr154, sr155, sr156, sr158,  
                  sr159, sr160, sr161, sr163;

CREATE PUBLIC SYNONYM orders FOR oe.orders;


CREATE PUBLIC SYNONYM orders FOR oe.order_items;


CONNECT oe/oe


