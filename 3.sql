use Northwind

--Truncate komutu(Veritaban�ndaki herhangi bir tablonun i�indeki verileri temizleyip identity kolonunu s�f�rlamam�z� sa�lar)
--Proje publish edilmeden �nce test i�in kulland���m�z verileri temizlemek i�in truncate kullan�l�r.Bu sayede identityleri de temizlenmi� oluruz
Truncate table OrnekPersoneller

--@@Identity komutu(Veritaban� i�inde yap�lan en son insert i�leminin identity de�erini getirir)
Insert Personeller (Adi,SoyAdi) values ('Leil','Lowndis')
Select @@IDENTITY

--@Rowcount komutu(Yapt���m�z sorgu sonucu ka� adet eleman�n etkilendi�ini bulmaya yarar)
Delete from Personeller where Adi='Leil'
Select @@ROWCOUNT

--Dbcc Checkident fonksiyonu ile identity kolonuna m�dahale etme(Herhangi bir tabloya ekleme yapt���m�zda identity de�erini istedi�imiz de�erden devam ettirebilmek i�in kullan�l�r)
--Kullan�ld��� tablonun yap�s�n� bozdu�u i�in �ok kullan�lmas� tavsiye edilen bir komut de�ildir
Dbcc checkident (Personeller,reseed,20)
Insert Personeller (Adi,SoyAdi) values ('Leil','Lowndis')

--Null kontrol mekanizmalar�
--!!!�nemli.Raporlama yaparken null de�erleri rapora katt���m�z zaman farkl� sonu�lar elde edebiliriz.Null de�erler g�z�n�nde bulundurulmal�d�r!!!

--1.Case-When-Then-Else-End kal�b� ile null kontrol�)
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

--4.NullIf Fonksiyonu(Fonksiyona verilen kolon,ikinci parametre verilen de�ere e�itse o kolonu Null olarak getirir)
--Hedef stok d�zeyi 0 olmayan �r�nlerin ortalamas� ka�t�r?
Select AVG(NullIf(HedefStokDuzeyi,0)) from Urunler 

--Tsql ile Veritaban�ndaki Tablolar� Listeleme
Select * from sys.tables

--Tsql bir tablonun primary key olup olmad���n� kontrol etme
--Geriye 1 de�erini d�nd�r�yorsa tablonun i�inde primary key var demektir
Select OBJECTPROPERTY(OBJECT_ID('Personeller'),'TableHasPrimaryKey')

--DATA DEF�N�T�ON LANGUAGE
--DDL komutlar� veritaban� nesneleri yaratmam�z�, bu nesneler �zerinde de�i�iklik yapmam�z� ve bu nesneleri silmemizi sa�layan komutlard�r.(Create-Alter-Drop)

--Create komutu(Veritaban� nesnesi yaratmam�z� sa�lar(database,table,view,trigger vb.))
--Genel Yap�s�
--Create [Nesne][Nesnenin Ad�]

--Create ile database olu�turma
--Bu �ekilde bir kullan�m varsay�lan ayarlarda veritaban� olu�turacakt�r
Create Database OrnekVeritabani

--Ayarlar� belirlemek i�in bu yap� kullan�lmal�
--Name:Olu�turulacak veritaban�n�n fiziksel ismini belirler
--Filename:Olu�turulacak veritaban�n�n fiziksel dizinini tutar.
--Size : Veritaban�n�n ba�lang�� boyutunun mb cinsinden ayar�
--Filegrowth : Veritaban�n�n boyutu, ba�lang�� boyutunu ge�ti�i durumda boyutun ne kadar artmas� gerekti�ini mb cinsinden belirtmemizi sa�lar
Create Database OrnekVeritabani
On
(
  Name='GG',
  Filename='D:\GG.mdf',
  Size = 5,
  Filegrowth = 3
)

--Create ile Log Dosyas� ile birlikte veritaban� olu�turma
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

--Create ile Tablo Olu�turma
Use OrnekVeritabani
Create Table OrnekTablo
(
   Kolon1 int,
   Kolon2 nvarchar(MAX),
   Kolon3 money
)

--E�er kolon isimlerinde bo�luk varsa
Create Table OrnekTablo2
(
   [Kolon 1] int,
   [Kolon 2] nvarchar(MAX),
   [Kolon 3] money
)

--Kolonun primary key ve identity olmas� i�in 
Create Table OrnekTablo3
(
   Id int Primary Key Identity(1,1),
   [Kolon 2] nvarchar(MAX),
   [Kolon 3] money
)

--Alter komutu(Create ile olu�turulan herhangi bir veritaban� �zerinde de�i�iklik yapmam�z� sa�lar)
--Genel Yap�
--Alter[Nesne][Nesnenin Adi]
--(Yap�ya g�re i�lemler)

--Alter ile database g�ncelleme
Alter Database OrnekVeritabani
Modify File
(
  Name='GG',
  Size = 20
)

--Alter ile olan bir tabloya kolon ekleme
Alter Table OrnekTablo
Add Kolon4 nvarchar(MAX)

--Alter ile tablodaki kolonu g�ncelleme
Alter Table OrnekTablo
Alter Column Kolon4 int

--Alter ile tablodaki kolonu silme
Alter Table OrnekTablo
Drop Column Kolon4