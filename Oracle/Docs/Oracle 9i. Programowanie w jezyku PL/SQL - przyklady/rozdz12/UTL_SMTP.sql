REM UTL_SMTP.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok demonstruje zastosowanie pakietu UTL_SMTP. 

DECLARE
  z_AdresOd VARCHAR2(50) := 'Oracle';
  z_AdresDo VARCHAR2(50) := 'YOUR_EMAIL_ADDRESS';
  z_Wiadomosc VARCHAR2(200);
  
  -- Adres serwera SMTP. W systemach typu UNIX 'localhost'
  -- czêsto bêdzie poprawn¹ nazw¹.
  z_HostPoczty VARCHAR2(50) := 'localhost';
  z_PolaczeniePocztowe UTL_SMTP.Connection;
BEGIN
  -- Wiadomoœæ do wys³ania. Pola wiadomoœci (od, temat, etc.)
  -- powinny byæ oddzielone znakiem powrotu karetki, w wiêkszoœci systemów
  -- jest to znak CHR(10).
  z_Wiadomosc := 
    'Od:   ' || z_AdresOd || CHR(10) ||
    'Temat:  Pozdrowienia z PL/SQL!' || CHR(10) ||
    'Ta wiadomoœæ zosta³a przes³ana dziêki pakietowi UTL_SMTP.';

  -- Otwarcie po³¹czenia z serwerem.
  z_PolaczeniePocztowe:= UTL_SMTP.OPEN_CONNECTION(z_HostPoczty);
  
  -- Wykorzystanie komunikatów SMTP - wys³anie wiadomoœci email.
  UTL_SMTP.HELO(z_PolaczeniePocztowe, z_HostPoczty);
  UTL_SMTP.MAIL(z_PolaczeniePocztowe, z_AdresOd);
  UTL_SMTP.RCPT(z_PolaczeniePocztowe, z_AdresDo);
  UTL_SMTP.DATA(z_PolaczeniePocztowe, z_Wiadomosc);
  
  -- Zamkniêcie po³¹czenia.
  UTL_SMTP.QUIT(z_PolaczeniePocztowe);
END;
/
