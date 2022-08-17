use Northwind

--SP_RENAME komutu ile tablo adý deðiþtirme
SP_RENAME 'OrnekPersoneller','OrnekPersonellerYeni'

--SP_RENAME komutu ile kolon adý deðiþtirme
--OrnekPersonellerYeni tablosunda Ad kolonunun adýný 'Isim' olarak deðiþtir
SP_RENAME 'OrnekPersonellerYeni.Ad','Isim','Column'

--Drop Komutu(Create ile oluþturulmuþ veritabaný nesnelerini silmemizi saðlar)
--Genel Yapý
--Drop [Nesne][Nesne Adý]

--OrnekPersonellerYeni tablosunu sil
Drop Table OrnekPersonellerYeni

--OrnekVeritabani veritabanýný sil
Drop Database OrnekVeritabani

--Constraint(Kýsýtlayýcýlar)
--Constraintler sayesinde tablolar üzerinde istediðimiz þekilde þartlar ve kýsýtlamalar yapabiliyoruz
--1 .Default Constraint
--2 .Check Constraint
--3 .Primary Key Constraint
--4 .Unique Constraint
--5 .Foreign Key Constraint

--1 .Default Constraint
--Default Constraint sayesinde kolona bir deðer girilmediði takdirde varsayýlan olarak ne girilmesi gerektiðini belirtebiliyoruz

--Genel Yapýsý
--Add Constraint [Constraint Adý] Default 'Varsayýlan deðer' For [Kolon Adý]

Create Table OrnekTablo
(
  Id int Primary Key Identity(1,1),
  Kolon1 nvarchar(MAX),
  Kolon2 int

)


--Oluþturduðumuz OrnekTablo isimli tabloya Kolon1 kolonuna varsayýlan olarak 'Boþ' gelmesi için Kolon1Constraint adýnda bir Default Constraint ekliyoruz
Alter Table OrnekTablo
Add Constraint Kolon1Constraint Default 'Boþ' For Kolon1

--Oluþturduðumuz OrnekTablo isimli tabloya Kolon2 kolonuna varsayýlan olarak '-1' gelmesi için Kolon2Constraint adýnda bir Default Constraint ekliyoruz
Alter Table OrnekTablo
Add Constraint Kolon2Constraint Default '-1' For Kolon2

Insert OrnekTablo(Kolon2) values (0)
Insert OrnekTablo(Kolon1) values ('Ornek bir deðer')
Select * from OrnekTablo

--2 .Check Constraint
--Bir kolona girilecek olan verinin belirli bir þarta uygun olmasýný zorunlu kýlar

--Genel Yapýsý
--Add Constraint [Constraint Adý] Check (Þart)

--!!!Önemli .Check Constraint oluþturulmadan önce ilgili tabloda þarta aykýrý deðerler varsa constraint oluþturulmayacaktýr !!!
--!!!Ancak önceki kayýtlarý görmezden gelip yine de Check Constrainti uygulamak istiyorsak 'With Nocheck' komutu kullanýlmalýdýr!!!

Alter Table OrnekTablo
Add Constraint Kolon2Kontrol Check ((Kolon2*5) % 2 =0)

--With Nocheck komutu
--Þuana kadar olan kayýtlarý görmezden gelip ,check constraint oluþturmayý saðlar
Alter Table OrnekTablo
With Nocheck Add Constraint Kolon3Kontrol Check ((Kolon2 *5) % 2=0)

--3 .Primary Key Constraint
--Primary Constraint ile; o kolona eklenen primary key ile ,baþka tablolarda foreign key oluþturarak iliþki kurmamýz mümkün olur.
--Bunun yanýnda	 o kolonun taþýdýðý verinin tekil olacaðý da garanti edilmiþ olur.Primary key constraint ile ayrýca Clustered Index oluþturulmuþ da olur.

--Genel Yapýsý
--Add Constraint [Constraint Adý] Primary Key (Kolon Adý)
--!!!Önemli.Primary Key Constraint kullanýlan kolon primary key özelliðine sahip olmamalýdýr
--!!!Bir tabloda bir tane primary key olacaðý için tabloda baþka bir primary key olmamalýdýr

Alter Table OrnekTablo
Add Constraint PrimaryId Primary Key (Id)

--4 .Unique Constraint
--Belirttiðimiz kolondaki deðerlerin tekil olmasýný saðlar
--Primary Key constraintten farký  primary constraint ile o kolona eklenen primary key ile baþka tablolarda foreign key oluþturarak iliþki kurmamýz mümkün olurken, unique constraint sadece ilgili kolonu tekil olarak ayarlamakta. 

--Genel Yapýsý
--Add Constraint [Constraint Adý] Unique (Kolon Adý)
Alter Table OrnekTablo
Add Constraint OrnekTabloUnique Unique (Kolon2)

--5 .Foreign Key Constraint
--Tablolarýn kolonlarý arasýnda iliþki kurmamýzý saðlar.Bu iliþki neticesinde foreign key olan kolondaki karþýlýðýnýn boþa düþmemesi için
--primary key kolonu olan tablodan veri silinmesini,güncellemesini engeller.

--Genel Yapýsý
--Add Constraint [Constraint Adý] Foreign Key (Kolon Adý) References [2.Tablo Adý](2.Tablodaki Kolon Adý)

Create Table Ogrenciler
(
  OgrenciId int primary key Identity(1,1),
  DersId int,
  Adi nvarchar(MAX),
  Soyadi nvarchar(MAX)
)

Create Table Dersler
(
  DersId int primary key Identity(1,1),
  DersAdi nvarchar(MAX)
)

Alter Table Ogrenciler
Add Constraint ForeignKeyOgrenciDers Foreign Key (DersId) References Dersler(DersId)

--Þu durumda delete ve update iþlemlerinden iliþkili kolondaki veriler etkilenmez.
--Davranýþý deðiþtirmek için aþaðýdaki komutlar kullanýlýr.

--Cascade
--Ana tablodaki kayýt silindiðinde ya da güncellendiðinde,iliþkili kolondaki karþýlýðýnda otomatik olarak silinir ya da güncellenir.
Alter Table Ogrenciler
Add Constraint ForeignKeyOgrenciDers Foreign Key (DersId) References Dersler(DersId)
On Delete Cascade
On Update Cascade

--Set Null
--Ana tablodaki kayýt silindiðinde ya da güncellendiðinde ,iliþkili kolondaki karþýlýðýna 'Null' deðeri basýlýr.
Alter Table Ogrenciler
Add Constraint ForeignKeyOgrenciDers Foreign Key (DersId) References Dersler(DersId)
On Delete Set Null
On Update Set Null

--Set Default
--Ana tablodaki kayýt silindiðinde ya da güncellendiðinde ,iliþkili tablodaki karþýlýðýna o kolonun default deðeri basýlýr
--Bu default deðer dediðimiz deafult tipte bir constrainttir.Bunu kendimiz oluþturabiliriz
Alter Table Ogrenciler
Add Constraint DefaultOgrenciler Default -1 For DersId


Alter Table Ogrenciler
Add Constraint ForeignKeyOgrenciDers2 Foreign Key (DersId) References Dersler(DersId)
On Delete Set Default
On Update Set Default

--Dersler tablosunda -1 idli bir deðer yoksa bu komut hata verecektir.Yani default verdiðimiz deðere dikkat etmemiz gerekmekte!!!!

--Bu ayarlar verilmediði takdirde 'no action' özelliði geçerlidir.

--Deðiþkenler
--Declare keywordü ile deðiþken tanýmlanýr

--Genel Yapý
--Declare @DegiskenAdý DegiskenTipi

declare @x int
declare @y nvarchar
declare @z money

declare @x int ,@z nvarchar,@y bit

--Deðiþkene ilk deðeri atama
declare @Yas int = 3

--Tanýmlanmýþ deðiþkene deðer atama
declare @a int
Set @a=125

declare @tarih datetime
Set @tarih=GETDATE()

--Deðiþkenin deðerini okuma
declare @m int
set @m=3
select @m [Deðer]

--Sorgu sonucu gelen verileri deðiþkenle elde etme
Select Adi,SoyAdi from Personeller where PersonelID=1
--Yukarýdaki sorgu sonucu gelen ad ve soyad verilerini deðiþkenle elde etmek istiyorsak kolonlardaki verilerin tipleri ne ise o verileri temsil edecek deðiþkenlerin tipleri de benzer olmalýdýr

declare @adi nvarchar(MAX),@soyadi nvarchar(MAX)
Select @adi=Adi,@soyadi=SoyAdi from Personeller where PersonelID=1
Select @adi,@soyadi

--Batch kavramý - Go
--Eðer ki bir pencerede birden fazla iþlem yapýyorsak ve bu iþlemler birbirinden baðýmsýz ise bu iþlemlerin baðýmsýz olduðunu derleyiciye göstermek için kullanýlýr

Create Database OrnekDatabase
Go
use OrnekDatabase
Go
Create Table OrnekTablo
(
  Id int primary key identity(1,1),
  Kolon1 nvarchar(MAX),
  Kolon2 nvarchar(MAX) 
)