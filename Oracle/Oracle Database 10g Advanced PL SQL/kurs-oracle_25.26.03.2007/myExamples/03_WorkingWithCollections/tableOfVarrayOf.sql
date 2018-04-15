DECLARE
 type typ_kolekcja is table of number;
 kolekcja typ_kolekcja;
begin
  --inicjalizacja kolekcji
  kolekcja := typ_kolekcja(1,2,55,22);
  DBMS_OUTPUT.PUT_LINE(to_char(kolekcja(1)));
  DBMS_OUTPUT.PUT_LINE(to_char(kolekcja(4)));
  kolekcja.extend;
  kolekcja.extend;
  kolekcja(5) := 555;
  DBMS_OUTPUT.PUT_LINE(to_char(kolekcja(5)));
  kolekcja(6) := 666;
  DBMS_OUTPUT.PUT_LINE(to_char(kolekcja(6)));
end; 


DECLARE
 type typ_kolekcja is varray(4) of number;
 kolekcja typ_kolekcja;
begin
  kolekcja := typ_kolekcja(1,2,3);
  DBMS_OUTPUT.PUT_LINE(to_char(kolekcja(1)));
  kolekcja.extend;
  --4 to wartoœæ max liczby elementów w kolekcji, nie mo¿na jej przekroczyæ!!!
  --kolekcja.extend;
  kolekcja(4) := 234234;  
  DBMS_OUTPUT.PUT_LINE(to_char(kolekcja(4)));   
  /*kolekcja(5) := 9934;
  DBMS_OUTPUT.PUT_LINE(to_char(kolekcja(5)));*/
end; 