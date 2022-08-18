
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


--DYNAMIC DATA MASKING(VERÝ MASKELEME)
--Veritabanýmýzda iliþkisel tablolarýmýzda tuttuðumuz verileri tararken gösterilmesi istenen dýþýndaki verilerin maskelenmesi iþlemidir.
--Veriyi maskelemekten kastýmýz verinin orjinal halini yani fiziksel yapýsýný deðiþtirmeden kullanýcýya
--bir kýsmýný göstermek ya da gizlemektir.

--Örneðin bir alýþveriþ sitesinde kayýtlý kullanýcýnýn her bilgisine herkesin ulaþmasýný istemeyiz.
--Böyle durumlarda kullanýcýnýn özelini teþkil edecek bilgiler yetkisi olmayan kullanýcýlara gösterilmemelidir.
--Burada yetkisi olmayan kullanýcýya karþý yapýlmýþ kýsýtlama aslýnda verilerin yokluðu anlamýna gelmiyor
--Bilgiler var ama gizlenmektedirler.

--Normalde bu yetkilendirme iþlemi view ile yapýlýyordu ancak bu zahmetli bir yol olduðu için 
--Sql Server 2016 ile Dynamic Data Masking özelliði geldi ve bizi bu zahmetten kurtarmýþ oldu.

--3 parametre ile çalýþmaktadýr.
--1)Default Parametresi
--2)Email Parametresi
--3)Partial Parametresi


--1)Default Parametresi
--Metinsel : XXXX
--Sayýsal  : 0000
--Tarihsel :01.01.2000 00:00:00.0000000
--Binary   : 0 -> ASCII


--2)Email Parametresi
--geny@gencayyildiz.com : 'gxxx@xxx.com'


--3)Partial Parametresi
--Partial(3,H,2)  
--Burada ilk 3 karakterin izlenmeyeceðini
--maskelemede h karakterinin kullanacaðýný 
--son 2 karakterin de izlenmeyeceðini belirtir.


Create Table Ogrenciler
(
   OgrenciId int Primary Key identity,
   Adi nvarchar(MAX) Masked With (Function = 'default()') Null,
   Soyadi nvarchar(MAX) Masked With (Function = 'default()') Null,
   Memleketi nvarchar(MAX) Masked With (Function = 'default()') Null,
   Email nvarchar(MAX) Masked With (Function = 'email()') Null,
   Hakkinda nvarchar(MAX) Masked With (Function = 'partial(3,"H",2)') Null,

)

Insert Ogrenciler Values ('Gençay','Yýldýz','Artvin','gency@gencayyildiz.com','Türk milletine caným feda olsun')
Insert Ogrenciler Values ('Ayþe','Yýldýrým','Artvin','aysey@ayseyyildirim.com','Bütün kýzlar toplandýk')


Select * from Ogrenciler

--Þu anda yetkili kullanýcý olduðumuz için tüm bilgiler maskelenmeden geldi.

--Yapýlmasý gereken ilk iþlem bir kullanýcý oluþturmak 
--ve o kullanýcýnýn ogrenciler tablosunda sadece 
--select iþlemini yapmasýna izin verecek bir yetkilendirmesi olmasýdýr.

Create User YetkiliUser without Login --YetkiliUser isminde bir kullanýcý oluþturdu.
Go
Grant Select on Ogrenciler to YetkiliUser
--YetkiliUser isimli kullanýcýya ogrenciler tablosunda select yetkisi verdik

Execute As User = 'YetkiliUser' --YetkiliUser isimli kullanýcýdayken
Select * from Ogrenciler


--ALTER ÝLE KOLONA DYNAMIC DATA MASKING UYGULAMA
Alter Table Ogrenciler
Add EkKolon nvarchar(MAX) Masked With (Function = 'partial(3,"XXX",0)')


--ALTER ÝLE DYNAMIC DATA MASKING KOLONUNDA DEÐÝÞÝKLÝK YAPMAK
Alter Table Ogrenciler
Alter Column EkKolon Add Masked With (Function = 'partial(2,"AA",4)')

--DYNAMIC DATA MASKING KALDIRMA
Alter Table Ogrenciler
Alter Column Email Drop Masked

--KULLANICIYA GÖRE DYNAMIC DATA MASKING ÖZELLÝÐÝNÝ PASÝFLEÞTÝRME
Grant Unmask to YetkiliUser

Execute As User = 'YetkiliUser'
Select * from Ogrenciler
