--Purpose: demonstrate information about the shared pool
--Steps:   Run the script below. 
--         
--         The shared pool is made of a large number of small chunks of memory.      
--         
--         

CONNECT /as sysdba
PAUSE This query shows the chunks of memory in the shared pool (Press Enter).

SELECT  chunk_size, count(*) no_of_chunks
FROM
  (SELECT POWER(10, TRUNC(ln(ksmchsiz)/ln(10))) || ' to ' ||
         (POWER(10, TRUNC(ln(ksmchsiz)/ln(10))+1)-1) chunk_size
   FROM   x$ksmsp
   WHERE  ksmchcls <> 'perm')
GROUP BY chunk_size;
 

 
PAUSE Look at V$SGASTAT to view the amount of memory in use for PL/SQL code (Press Enter).

SELECT * 
FROM   v$sgastat
WHERE  name LIKE 'PL/SQL MPCODE';

CONNECT oe/oe
