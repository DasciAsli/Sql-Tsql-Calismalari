use Northwind

--Truncate komutu(Veritabanýndaki herhangi bir tablonun içindeki verileri temizleyip identity kolonunu sýfýrlamamýzý saðlar)
--Proje publish edilmeden önce test için kullandýðýmýz verileri temizlemek için truncate kullanýlýr.Bu sayede identityleri de temizlenmiþ oluruz
Truncate table OrnekPersoneller

--@@Identity komutu(Veritabaný içinde yapýlan en son insert iþleminin identity deðerini getirir)
Insert Personeller (Adi,SoyAdi) values ('Leil','Lowndis')
Select @@IDENTITY

--@Rowcount komutu(Yaptýðýmýz sorgu sonucu kaç adet elemanýn etkilendiðini bulmaya yarar)
Delete from Personeller where Adi='Leil'
Select @@ROWCOUNT

--Dbcc Checkident fonksiyonu ile identity kolonuna müdahale etme(Herhangi bir tabloya ekleme yaptýðýmýzda identity deðerini istediðimiz deðerden devam ettirebilmek için kullanýlýr)
--Kullanýldýðý tablonun yapýsýný bozduðu için çok kullanýlmasý tavsiye edilen bir komut deðildir
Dbcc checkident (Personeller,reseed,20)
Insert Personeller (Adi,SoyAdi) values ('Leil','Lowndis')

--Null kontrol mekanizmalarý
--!!!Önemli.Raporlama yaparken null deðerleri rapora kattýðýmýz zaman farklý sonuçlar elde edebiliriz.Null deðerler gözönünde bulundurulmalýdýr!!!

--1.Case-When-Then-Else-End kalýbý ile null kontrolü)
Select MusteriAdi,
Case
  when Bolge Is Null Then 'Bolge Bilinmiyor'
  else Bolge
End
from Musteriler

--2.Coalesce Fonksiyonu
Select MusteriAdi, Coalesce(Bolge,'Bolge Bilinmiyor') from Musteriler

--3.IsNull Fonksiyonu
Select MusteriAdi, IsNull(Bolge,'Bolge Bilinmiyor') from Musteriler

--4.NullIf Fonksiyonu(Fonksiyona verilen kolon,ikinci parametre verilen deðere eþitse o kolonu Null olarak getirir)
--Hedef stok düzeyi 0 olmayan ürünlerin ortalamasý kaçtýr?
Select AVG(NullIf(HedefStokDuzeyi,0)) from Urunler 

--Tsql ile Veritabanýndaki Tablolarý Listeleme
Select * from sys.tables

--Tsql bir tablonun primary key olup olmadýðýný kontrol etme
--Geriye 1 deðerini döndürüyorsa tablonun içinde primary key var demektir
Select OBJECTPROPERTY(OBJECT_ID('Personeller'),'TableHasPrimaryKey')

--DATA DEFÝNÝTÝON LANGUAGE
--DDL komutlarý veritabaný nesneleri yaratmamýzý, bu nesneler üzerinde deðiþiklik yapmamýzý ve bu nesneleri silmemizi saðlayan komutlardýr.(Create-Alter-Drop)

--Create komutu(Veritabaný nesnesi yaratmamýzý saðlar(database,table,view,trigger vb.))
--Genel Yapýsý
--Create [Nesne][Nesnenin Adý]

--Create ile database oluþturma
--Bu þekilde bir kullaným varsayýlan ayarlarda veritabaný oluþturacaktýr
Create Database OrnekVeritabani

--Ayarlarý belirlemek için bu yapý kullanýlmalý
--Name:Oluþturulacak veritabanýnýn fiziksel ismini belirler
--Filename:Oluþturulacak veritabanýnýn fiziksel dizinini tutar.
--Size : Veritabanýnýn baþlangýç boyutunun mb cinsinden ayarý
--Filegrowth : Veritabanýnýn boyutu, baþlangýç boyutunu geçtiði durumda boyutun ne kadar artmasý gerektiðini mb cinsinden belirtmemizi saðlar
Create Database OrnekVeritabani
On
(
  Name='GG',
  Filename='D:\GG.mdf',
  Size = 5,
  Filegrowth = 3
)

--Create ile Log Dosyasý ile birlikte veritabaný oluþturma
Create Database OrnekVeritabani
On
(
  Name='GG',
  Filename='D:\GG.mdf',
  Size = 5,
  Filegrowth = 3
)
Log
On
(
  Name='GG',
  Filename='D:\GG.mdf',
  Size = 5,
  Filegrowth = 3
)

--Create ile Tablo Oluþturma
Use OrnekVeritabani
Create Table OrnekTablo
(
   Kolon1 int,
   Kolon2 nvarchar(MAX),
   Kolon3 money
)

--Eðer kolon isimlerinde boþluk varsa
Create Table OrnekTablo2
(
   [Kolon 1] int,
   [Kolon 2] nvarchar(MAX),
   [Kolon 3] money
)

--Kolonun primary key ve identity olmasý için 
Create Table OrnekTablo3
(
   Id int Primary Key Identity(1,1),
   [Kolon 2] nvarchar(MAX),
   [Kolon 3] money
)

--Alter komutu(Create ile oluþturulan herhangi bir veritabaný üzerinde deðiþiklik yapmamýzý saðlar)
--Genel Yapý
--Alter[Nesne][Nesnenin Adi]
--(Yapýya göre iþlemler)

--Alter ile database güncelleme
Alter Database OrnekVeritabani
Modify File
(
  Name='GG',
  Size = 20
)

--Alter ile olan bir tabloya kolon ekleme
Alter Table OrnekTablo
Add Kolon4 nvarchar(MAX)

--Alter ile tablodaki kolonu güncelleme
Alter Table OrnekTablo
Alter Column Kolon4 int

--Alter ile tablodaki kolonu silme
Alter Table OrnekTablo
Drop Column Kolon4