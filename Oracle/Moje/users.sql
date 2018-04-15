--stworzenie u¿ytkownika i nadanie mu prawa logowania siê do bazy
grant connect to JKowalski
identified by JKowalski

--nadanie prawa do tworzenia nowych elementów
grant resource to JKowalski

--nadanie praw ADMINISTRATORA ( maj¹c te prawa mo¿na wykonaæ dwa powy¿sze polecenia )
grant dba to JKowalski

-------------------------------------------------------------------------------------------------------------------

--zmiana has³a
alter user hr IDENTIFIED by hr