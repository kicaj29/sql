CONNECT /as sysdba


CREATE USER am145 IDENTIFIED BY oracle
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP
 QUOTA UNLIMITED ON USERS;

CREATE USER am147 IDENTIFIED BY oracle
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP
 QUOTA UNLIMITED ON USERS;

CREATE USER am148 IDENTIFIED BY oracle
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP
 QUOTA UNLIMITED ON USERS;

CREATE USER am149 IDENTIFIED BY oracle
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP
 QUOTA UNLIMITED ON USERS;

GRANT create session
    , alter session 
TO am145, am147, am148, am149;

GRANT SELECT, INSERT, UPDATE, DELETE ON
  oe.customers TO AM145, am147, am148, am149;

CREATE PUBLIC SYNONYM customers FOR oe.customers;
