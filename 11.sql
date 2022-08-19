
--Temporal Tables(System-Versioned Table - Zamansal Tablolar)
--Doðru bir raporlama ve takip mekanizmasý oluþturabilmek çok önemlidir.
--Takip sürecini yönetecek olan bu mekanizma hem raporlama hem de projenin yaþam döngüsünde yapýlan her adýmý kayda alarak yapýlan tüm iþlemleri gerektiði takdirde sorumlulara listeyebilir.
--Bu sistem projenin hem yazýlýmý hem de veritabaný olmak üzere ortak bir organizasyonla gerçekleþmesi gerekir.

--DML iþlemlerini raporlamamýzý saðlar.
--Tablolarýmýzda bulunan kayýtlarýn zaman içindeki deðiþikliklerini yani update iþlemini,
--bunun dýþýnda tablo üzerinde yanlýþlýkla yapýlan update ve delete sorgularýnýn geri getirilmesini saðlar.
--Bir verinin belirli bir zaman ya da zaman aralýðýnda izlenebilmesini saðlar.

--Bir verinin zamansal takibi
--3 farklý duruma göre yapýlmaktadýr.
--1)Veri ilk kaydedildiðinde(Insert)
--2)Veri ilk güncellendiðinde(Update)
--3)Verinin sonraki güncellemelerinde(Update)


--Temporal Tables Özelliðini Kullanýrken Nelere Dikkat Etmeliyiz?

--*Temporal tables ile raporlama ve takip mekanizmasý oluþturacaðýmýz tablolarda 
--Primary Key tanýmlanmýþ bir kolon olmasý gerekmektedir.Bu þekilde yaþam döngüsünde hangi verinin
--deðiþime uðradýðýný bu primary Key ile ayýrt edebileceðiz.

--*Takibi saðlayacaðýmýz ve kaydýný tutacaðýmýz tablomuzun  içerisinde bir baþlangýç(StartDate)
--bir de bitiþ(EndDate) niteliðinde iki adet "datetime2" tipinden kolonlarýn bulunmasý gerekmektedir.

--*Linked Server üzerinde Temporal Tables kullanýlmamaktadýr.

--*History tablomuzda constraint yapýlarýnýn hiçbirini uygulayamayýz.

--*Eðer bir tabloda Temporal Table aktifse o tabloda Truncate iþlemi gerçekleþtiremiyoruz.

--*History tablosunda direkt olarak DML iþlemleri gerçekleþtiremiyoruz.

--*Temporal Tables özelliðinin bulunduðu bir tabloda Computed Column(Hesaplanmýþ Kolon) tanýmlayamýyoruz.


--Temporal Tables Oluþturma
Create Table DersKayitlari
(

-----------1.Kýsým---------
DersId int primary key identity(1,1),
Ders nvarchar(MAX),
Onay bit,
-----------1.Kýsým---------


-----------2.Kýsým---------
StartDate datetime2 generated always as row start not null,
EndDate datetime2 generated always as row end not null,
-----------2.Kýsým---------


-----------3.Kýsým---------
Period for system_time(StartDate,EndDate)
-----------3.Kýsým---------
)

-----------4.Kýsým---------
With(System_versioning = on (History_table = dbo.DersKayitlariLog))
--Eðer History_Table özelliði ile History tablosuna isim vermezsek rastgele bir isimde oluþur
-----------4.Kýsým---------


--VAR OLAN TABLOYU TEMPORAL TABLES OLARAK AYARLAMA
Create Table UrunKayitlari
(
  Id int primary key identity(1,1),
  Urun nvarchar(MAX),
  Onay bit
)

Insert UrunKayitlari Values('Bilgisayar',1),('Telefon',1),('Tablet',0)

--Eðer bu tabloyu temporal yapmak istiyorsak dikkat!!!
--Tablo içerisinde veri var mý? Yok mu?Eðer varsa 
--yeni eklenecek olan 'StarDate' ve 'EndDate' kolonlarý
--boþ kalmayacaklarý için varsayýlan deðerlerin belirtilmesi gerekmektedir.
--Eðer veri yoksa bu iþlemi düþünmemize gerek olmayacaktýr.

--Eðer veri yoksa
Alter Table UrunKayitlari
Add
StartDate datetime2 generated always as row start not null,
EndDate datetime2 generated always as row end not null,
Period for system_time(StartDate,EndDate)

--Eðer veri varsa
Alter Table UrunKayitlari
Add
StartDate datetime2 generated always as row start not null
Default Cast('1900-01-01 00:00:00.0000000' as datetime2),
EndDate datetime2 generated always as row end not null
Default Cast('9999-12-31 23:59:59.9999999' as datetime2),
Period for system_time(StartDate,EndDate)

--Þeklinde periyodik kayýt kolonlarýmýzý ekleyebiliriz.

--Kolonlar eklendikten sonra ilgili tablo aþaðýdaki gibi temporal hale getirilir.
Alter Table UrunKayitlari
Set(System_versioning = on (History_table = dbo.UrunKayitlariLog))

