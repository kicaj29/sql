REM PrzypisanieRekordu.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten bolk pokazuje prawid�owe i nieprawid�owe operacje przypisania rekord�w.

DECLARE
  TYPE t_Rek1Typ IS RECORD (
    Pole1 NUMBER,
    Pole2 VARCHAR2(5));
  TYPE t_Rek2Typ IS RECORD (
    Pole1 NUMBER,
    Pole2 VARCHAR2(5));
  z_Rek1 t_Rek1Typ;
  z_Rek2 t_Rek2Typ;
BEGIN
  /* Nawet je�eli rekordy z_Rek1 oraz z_Rek2 maja te same nazwy p�l
     i typy p�l, same typy rekord�w s� r�ne. Jest to nieprawid�owe 
     przypisanie wywo�uj�ce b��d PLS-382.*/
  z_Rek1 := z_Rek2;

  /* Jednak pola s� tego samego typu, zatem poni�sze przypisania s� prawid�owe. */
  z_Rek1.Pole1 := z_Rek2.Pole1;
  z_Rek2.Pole2 := z_Rek2.Pole2;
END;
/
