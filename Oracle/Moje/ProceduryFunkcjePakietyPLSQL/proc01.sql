Opis:

Zrealizowac to za pomoca funkcji uzytkownika w PLSQL. 
Do szablonow dac mozliwosc wpisania metaciagu <USER> pod interpretacje ktorego nalezy podpiac wywolanie funkcji uzytkownika (domyslnie zwracajacej pusty string).
Budowa funkcji: 
- owner CL_SERWIS
- pakiet PCK_K2000_KC_KO_local
- funkcji fGetLocalKodUmowy (komplet dostepnych paramatrow przy okreslaniu kodow umow)

Wywolanie:
select substr (....,0,24) from dual.

Uwaga: dla celow obslugi bledu Oracle on HP i Century nalezy wynik tej funkcji przepuscic 
przez tablice TEMPORARY (1 kolumnowa, bez frazy on commit preserve rows) -> insert into temporary select substr (.....,....) a nastepnie 
select * from temporary

-----------------------------------------------------------------------------------------------------------------------------------------------------------

create global temporary table TMP_PROC_FGETLOCALKODUMOWY_EXT
(
  DANE VARCHAR2(100)
)

PROCEDURE fGetLocalKodUmowy_Ext ( var_ROK in NUMBER,var_RODZAJ_WYDATKU in VARCHAR2,var_RODZAJ_SWIADCZ in VARCHAR2,  var_TYP_UMOWY in VARCHAR2, var_KOD_ZWRACANY out VARCHAR2) is
   var_ILOSC NUMBER;
   var_KOD   VARCHAR2(50);
   BEGIN
        SELECT KOD_NFZ2 INTO var_KOD FROM SYSADM.KC_SL_WYDATKI WHERE KOD = var_RODZAJ_WYDATKU;
        SELECT COUNT(*)+1 INTO var_ILOSC FROM SYSADM.KC_OFERTY_UMOWY u, SYSADM.KC_DAWCY k WHERE u.ROK = var_ROK AND u.RODZAJ_WYDATKU = var_RODZAJ_WYDATKU and u.kod_swiadcz = k.kod AND k.nazwa = var_rodzaj_swiadcz AND u.typ_umowy = var_typ_umowy;
        DELETE FROM sysadm.TMP_PROC_FGETLOCALKODUMOWY_EXT;
        INSERT INTO sysadm.TMP_PROC_FGETLOCALKODUMOWY_EXT SELECT substr(var_KOD || '/' || var_ILOSC,0,24) FROM DUAL;
        SELECT * INTO var_KOD_ZWRACANY FROM sysadm.TMP_PROC_FGETLOCALKODUMOWY_EXT;
        IF var_KOD = NULL THEN
             var_KOD_ZWRACANY := '';
        END IF;
   END;