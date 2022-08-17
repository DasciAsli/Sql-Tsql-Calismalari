use Northwind

--SP_RENAME komutu ile tablo ad� de�i�tirme
SP_RENAME 'OrnekPersoneller','OrnekPersonellerYeni'

--SP_RENAME komutu ile kolon ad� de�i�tirme
--OrnekPersonellerYeni tablosunda Ad kolonunun ad�n� 'Isim' olarak de�i�tir
SP_RENAME 'OrnekPersonellerYeni.Ad','Isim','Column'

--Drop Komutu(Create ile olu�turulmu� veritaban� nesnelerini silmemizi sa�lar)
--Genel Yap�
--Drop [Nesne][Nesne Ad�]

--OrnekPersonellerYeni tablosunu sil
Drop Table OrnekPersonellerYeni

--OrnekVeritabani veritaban�n� sil
Drop Database OrnekVeritabani

--Constraint(K�s�tlay�c�lar)
--Constraintler sayesinde tablolar �zerinde istedi�imiz �ekilde �artlar ve k�s�tlamalar yapabiliyoruz
--1 .Default Constraint
--2 .Check Constraint
--3 .Primary Key Constraint
--4 .Unique Constraint
--5 .Foreign Key Constraint

--1 .Default Constraint
--Default Constraint sayesinde kolona bir de�er girilmedi�i takdirde varsay�lan olarak ne girilmesi gerekti�ini belirtebiliyoruz

--Genel Yap�s�
--Add Constraint [Constraint Ad�] Default 'Varsay�lan de�er' For [Kolon Ad�]

Create Table OrnekTablo
(
  Id int Primary Key Identity(1,1),
  Kolon1 nvarchar(MAX),
  Kolon2 int

)


--Olu�turdu�umuz OrnekTablo isimli tabloya Kolon1 kolonuna varsay�lan olarak 'Bo�' gelmesi i�in Kolon1Constraint ad�nda bir Default Constraint ekliyoruz
Alter Table OrnekTablo
Add Constraint Kolon1Constraint Default 'Bo�' For Kolon1

--Olu�turdu�umuz OrnekTablo isimli tabloya Kolon2 kolonuna varsay�lan olarak '-1' gelmesi i�in Kolon2Constraint ad�nda bir Default Constraint ekliyoruz
Alter Table OrnekTablo
Add Constraint Kolon2Constraint Default '-1' For Kolon2

Insert OrnekTablo(Kolon2) values (0)
Insert OrnekTablo(Kolon1) values ('Ornek bir de�er')
Select * from OrnekTablo

--2 .Check Constraint
--Bir kolona girilecek olan verinin belirli bir �arta uygun olmas�n� zorunlu k�lar

--Genel Yap�s�
--Add Constraint [Constraint Ad�] Check (�art)

--!!!�nemli .Check Constraint olu�turulmadan �nce ilgili tabloda �arta ayk�r� de�erler varsa constraint olu�turulmayacakt�r !!!
--!!!Ancak �nceki kay�tlar� g�rmezden gelip yine de Check Constrainti uygulamak istiyorsak 'With Nocheck' komutu kullan�lmal�d�r!!!

Alter Table OrnekTablo
Add Constraint Kolon2Kontrol Check ((Kolon2*5) % 2 =0)

--With Nocheck komutu
--�uana kadar olan kay�tlar� g�rmezden gelip ,check constraint olu�turmay� sa�lar
Alter Table OrnekTablo
With Nocheck Add Constraint Kolon3Kontrol Check ((Kolon2 *5) % 2=0)

--3 .Primary Key Constraint
--Primary Constraint ile; o kolona eklenen primary key ile ,ba�ka tablolarda foreign key olu�turarak ili�ki kurmam�z m�mk�n olur.
--Bunun yan�nda	 o kolonun ta��d��� verinin tekil olaca�� da garanti edilmi� olur.Primary key constraint ile ayr�ca Clustered Index olu�turulmu� da olur.

--Genel Yap�s�
--Add Constraint [Constraint Ad�] Primary Key (Kolon Ad�)
--!!!�nemli.Primary Key Constraint kullan�lan kolon primary key �zelli�ine sahip olmamal�d�r
--!!!Bir tabloda bir tane primary key olaca�� i�in tabloda ba�ka bir primary key olmamal�d�r

Alter Table OrnekTablo
Add Constraint PrimaryId Primary Key (Id)

--4 .Unique Constraint
--Belirtti�imiz kolondaki de�erlerin tekil olmas�n� sa�lar
--Primary Key constraintten fark�  primary constraint ile o kolona eklenen primary key ile ba�ka tablolarda foreign key olu�turarak ili�ki kurmam�z m�mk�n olurken, unique constraint sadece ilgili kolonu tekil olarak ayarlamakta. 

--Genel Yap�s�
--Add Constraint [Constraint Ad�] Unique (Kolon Ad�)
Alter Table OrnekTablo
Add Constraint OrnekTabloUnique Unique (Kolon2)

--5 .Foreign Key Constraint
--Tablolar�n kolonlar� aras�nda ili�ki kurmam�z� sa�lar.Bu ili�ki neticesinde foreign key olan kolondaki kar��l���n�n bo�a d��memesi i�in
--primary key kolonu olan tablodan veri silinmesini,g�ncellemesini engeller.

--Genel Yap�s�
--Add Constraint [Constraint Ad�] Foreign Key (Kolon Ad�) References [2.Tablo Ad�](2.Tablodaki Kolon Ad�)

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

--�u durumda delete ve update i�lemlerinden ili�kili kolondaki veriler etkilenmez.
--Davran��� de�i�tirmek i�in a�a��daki komutlar kullan�l�r.

--Cascade
--Ana tablodaki kay�t silindi�inde ya da g�ncellendi�inde,ili�kili kolondaki kar��l���nda otomatik olarak silinir ya da g�ncellenir.
Alter Table Ogrenciler
Add Constraint ForeignKeyOgrenciDers Foreign Key (DersId) References Dersler(DersId)
On Delete Cascade
On Update Cascade

--Set Null
--Ana tablodaki kay�t silindi�inde ya da g�ncellendi�inde ,ili�kili kolondaki kar��l���na 'Null' de�eri bas�l�r.
Alter Table Ogrenciler
Add Constraint ForeignKeyOgrenciDers Foreign Key (DersId) References Dersler(DersId)
On Delete Set Null
On Update Set Null

--Set Default
--Ana tablodaki kay�t silindi�inde ya da g�ncellendi�inde ,ili�kili tablodaki kar��l���na o kolonun default de�eri bas�l�r
--Bu default de�er dedi�imiz deafult tipte bir constrainttir.Bunu kendimiz olu�turabiliriz
Alter Table Ogrenciler
Add Constraint DefaultOgrenciler Default -1 For DersId


Alter Table Ogrenciler
Add Constraint ForeignKeyOgrenciDers2 Foreign Key (DersId) References Dersler(DersId)
On Delete Set Default
On Update Set Default

--Dersler tablosunda -1 idli bir de�er yoksa bu komut hata verecektir.Yani default verdi�imiz de�ere dikkat etmemiz gerekmekte!!!!

--Bu ayarlar verilmedi�i takdirde 'no action' �zelli�i ge�erlidir.

--De�i�kenler
--Declare keyword� ile de�i�ken tan�mlan�r

--Genel Yap�
--Declare @DegiskenAd� DegiskenTipi

declare @x int
declare @y nvarchar
declare @z money

declare @x int ,@z nvarchar,@y bit

--De�i�kene ilk de�eri atama
declare @Yas int = 3

--Tan�mlanm�� de�i�kene de�er atama
declare @a int
Set @a=125

declare @tarih datetime
Set @tarih=GETDATE()

--De�i�kenin de�erini okuma
declare @m int
set @m=3
select @m [De�er]

--Sorgu sonucu gelen verileri de�i�kenle elde etme
Select Adi,SoyAdi from Personeller where PersonelID=1
--Yukar�daki sorgu sonucu gelen ad ve soyad verilerini de�i�kenle elde etmek istiyorsak kolonlardaki verilerin tipleri ne ise o verileri temsil edecek de�i�kenlerin tipleri de benzer olmal�d�r

declare @adi nvarchar(MAX),@soyadi nvarchar(MAX)
Select @adi=Adi,@soyadi=SoyAdi from Personeller where PersonelID=1
Select @adi,@soyadi

--Batch kavram� - Go
--E�er ki bir pencerede birden fazla i�lem yap�yorsak ve bu i�lemler birbirinden ba��ms�z ise bu i�lemlerin ba��ms�z oldu�unu derleyiciye g�stermek i�in kullan�l�r

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