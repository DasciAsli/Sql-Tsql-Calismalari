
--DEFAULT VALUES ÝLE SADECE IDENTÝTY KOLONUNA VERÝ EKLEMEK
--Eðerki veritabanýnda görevi sadece diðer tablolar tarafýndan 
--referans alýnacaðý idleri üretecek ve barýndýracak olan bir tabloya ihtiyacýnýz varsa kullanýlýr. 

CREATE DATABASE ORNEKVERÝTABANI

Create Table OrnekTablo
(
  Id int primary key identity,
  Kolon1 nvarchar(MAX),
  Kolon2 nvarchar(MAX)
)

use ORNEKVERÝTABANI

Insert OrnekTablo
DEFAULT VALUES


--TOP KEYWORDÜ ÝLE UPDATE ÝÞLEMÝ
Select * from OrnekTablo

--OrnekTablo tablosundaki ilk 2 deðerin Kolon3 deðerini 5 arttýr
Update Top(2) OrnekTablo set Kolon3 = Kolon3 +5


--OrnekTablo tablosundaki ilk 2 veriyi sil 
Delete Top(2) OrnekTablo 


--ANSI_NULLS Komutu
--ANSI_NULLS komutu,where þartlarýnda kontrol edilen eþitlik
--yahut eþit deðillik durumlarýnda null deðerlerin dikkate alýnýp alýnmayacaðýný belirlememizi saðlar.
--'ON' deðeri verilirse Null deðerler dikkate alýnmaz.
--'OFF' deðeri verilirse Null deðerler dikkate alýnýr

SET ANSI_NULLS ON	
Select * from OrnekTablo where Kolon1 = Null

SET ANSI_NULLS OFF
Select * from OrnekTablo where Kolon1 = Null