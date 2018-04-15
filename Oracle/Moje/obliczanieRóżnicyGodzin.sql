select ltrim(to_char(trunc( to_number (to_char((sum(godziny_do-godziny_od)
)*24+0.00000001)) ),999)) ||  ltrim(to_char((to_number
(to_char((sum(godziny_do-godziny_od) )*24+0.00000001)) - trunc( to_number
(to_char((sum(godziny_do-godziny_od) )*24+0.00000001)) ))*60/100, .99)) as
SUM_GODZ from sosadm.SW_PERS_HARMON h where h.ID_PERS_HARM = :idPersHarmon