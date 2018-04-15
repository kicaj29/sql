REM UTL_SMTP.sql
REM Rozdzia� 12., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok demonstruje zastosowanie pakietu UTL_SMTP. 

DECLARE
  z_AdresOd VARCHAR2(50) := 'Oracle';
  z_AdresDo VARCHAR2(50) := 'YOUR_EMAIL_ADDRESS';
  z_Wiadomosc VARCHAR2(200);
  
  -- Adres serwera SMTP. W systemach typu UNIX 'localhost'
  -- cz�sto b�dzie poprawn� nazw�.
  z_HostPoczty VARCHAR2(50) := 'localhost';
  z_PolaczeniePocztowe UTL_SMTP.Connection;
BEGIN
  -- Wiadomo�� do wys�ania. Pola wiadomo�ci (od, temat, etc.)
  -- powinny by� oddzielone znakiem powrotu karetki, w wi�kszo�ci system�w
  -- jest to znak CHR(10).
  z_Wiadomosc := 
    'Od:   ' || z_AdresOd || CHR(10) ||
    'Temat:  Pozdrowienia z PL/SQL!' || CHR(10) ||
    'Ta wiadomo�� zosta�a przes�ana dzi�ki pakietowi UTL_SMTP.';

  -- Otwarcie po��czenia z serwerem.
  z_PolaczeniePocztowe:= UTL_SMTP.OPEN_CONNECTION(z_HostPoczty);
  
  -- Wykorzystanie komunikat�w SMTP - wys�anie wiadomo�ci email.
  UTL_SMTP.HELO(z_PolaczeniePocztowe, z_HostPoczty);
  UTL_SMTP.MAIL(z_PolaczeniePocztowe, z_AdresOd);
  UTL_SMTP.RCPT(z_PolaczeniePocztowe, z_AdresDo);
  UTL_SMTP.DATA(z_PolaczeniePocztowe, z_Wiadomosc);
  
  -- Zamkni�cie po��czenia.
  UTL_SMTP.QUIT(z_PolaczeniePocztowe);
END;
/
