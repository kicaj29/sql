--stworzenie u�ytkownika i nadanie mu prawa logowania si� do bazy
grant connect to JKowalski
identified by JKowalski

--nadanie prawa do tworzenia nowych element�w
grant resource to JKowalski

--nadanie praw ADMINISTRATORA ( maj�c te prawa mo�na wykona� dwa powy�sze polecenia )
grant dba to JKowalski

-------------------------------------------------------------------------------------------------------------------

--zmiana has�a
alter user hr IDENTIFIED by hr