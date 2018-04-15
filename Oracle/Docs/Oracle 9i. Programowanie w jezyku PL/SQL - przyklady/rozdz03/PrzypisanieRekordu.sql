REM PrzypisanieRekordu.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten bolk pokazuje prawid³owe i nieprawid³owe operacje przypisania rekordów.

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
  /* Nawet je¿eli rekordy z_Rek1 oraz z_Rek2 maja te same nazwy pól
     i typy pól, same typy rekordów s¹ ró¿ne. Jest to nieprawid³owe 
     przypisanie wywo³uj¹ce b³¹d PLS-382.*/
  z_Rek1 := z_Rek2;

  /* Jednak pola s¹ tego samego typu, zatem poni¿sze przypisania s¹ prawid³owe. */
  z_Rek1.Pole1 := z_Rek2.Pole1;
  z_Rek2.Pole2 := z_Rek2.Pole2;
END;
/
