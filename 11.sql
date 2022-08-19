
--Temporal Tables(System-Versioned Table - Zamansal Tablolar)
--Do�ru bir raporlama ve takip mekanizmas� olu�turabilmek �ok �nemlidir.
--Takip s�recini y�netecek olan bu mekanizma hem raporlama hem de projenin ya�am d�ng�s�nde yap�lan her ad�m� kayda alarak yap�lan t�m i�lemleri gerekti�i takdirde sorumlulara listeyebilir.
--Bu sistem projenin hem yaz�l�m� hem de veritaban� olmak �zere ortak bir organizasyonla ger�ekle�mesi gerekir.

--DML i�lemlerini raporlamam�z� sa�lar.
--Tablolar�m�zda bulunan kay�tlar�n zaman i�indeki de�i�ikliklerini yani update i�lemini,
--bunun d���nda tablo �zerinde yanl��l�kla yap�lan update ve delete sorgular�n�n geri getirilmesini sa�lar.
--Bir verinin belirli bir zaman ya da zaman aral���nda izlenebilmesini sa�lar.

--Bir verinin zamansal takibi
--3 farkl� duruma g�re yap�lmaktad�r.
--1)Veri ilk kaydedildi�inde(Insert)
--2)Veri ilk g�ncellendi�inde(Update)
--3)Verinin sonraki g�ncellemelerinde(Update)


--Temporal Tables �zelli�ini Kullan�rken Nelere Dikkat Etmeliyiz?

--*Temporal tables ile raporlama ve takip mekanizmas� olu�turaca��m�z tablolarda 
--Primary Key tan�mlanm�� bir kolon olmas� gerekmektedir.Bu �ekilde ya�am d�ng�s�nde hangi verinin
--de�i�ime u�rad���n� bu primary Key ile ay�rt edebilece�iz.

--*Takibi sa�layaca��m�z ve kayd�n� tutaca��m�z tablomuzun  i�erisinde bir ba�lang��(StartDate)
--bir de biti�(EndDate) niteli�inde iki adet "datetime2" tipinden kolonlar�n bulunmas� gerekmektedir.

--*Linked Server �zerinde Temporal Tables kullan�lmamaktad�r.

--*History tablomuzda constraint yap�lar�n�n hi�birini uygulayamay�z.

--*E�er bir tabloda Temporal Table aktifse o tabloda Truncate i�lemi ger�ekle�tiremiyoruz.

--*History tablosunda direkt olarak DML i�lemleri ger�ekle�tiremiyoruz.

--*Temporal Tables �zelli�inin bulundu�u bir tabloda Computed Column(Hesaplanm�� Kolon) tan�mlayam�yoruz.


--Temporal Tables Olu�turma
Create Table DersKayitlari
(

-----------1.K�s�m---------
DersId int primary key identity(1,1),
Ders nvarchar(MAX),
Onay bit,
-----------1.K�s�m---------


-----------2.K�s�m---------
StartDate datetime2 generated always as row start not null,
EndDate datetime2 generated always as row end not null,
-----------2.K�s�m---------


-----------3.K�s�m---------
Period for system_time(StartDate,EndDate)
-----------3.K�s�m---------
)

-----------4.K�s�m---------
With(System_versioning = on (History_table = dbo.DersKayitlariLog))
--E�er History_Table �zelli�i ile History tablosuna isim vermezsek rastgele bir isimde olu�ur
-----------4.K�s�m---------


--VAR OLAN TABLOYU TEMPORAL TABLES OLARAK AYARLAMA
Create Table UrunKayitlari
(
  Id int primary key identity(1,1),
  Urun nvarchar(MAX),
  Onay bit
)

Insert UrunKayitlari Values('Bilgisayar',1),('Telefon',1),('Tablet',0)

--E�er bu tabloyu temporal yapmak istiyorsak dikkat!!!
--Tablo i�erisinde veri var m�? Yok mu?E�er varsa 
--yeni eklenecek olan 'StarDate' ve 'EndDate' kolonlar�
--bo� kalmayacaklar� i�in varsay�lan de�erlerin belirtilmesi gerekmektedir.
--E�er veri yoksa bu i�lemi d���nmemize gerek olmayacakt�r.

--E�er veri yoksa
Alter Table UrunKayitlari
Add
StartDate datetime2 generated always as row start not null,
EndDate datetime2 generated always as row end not null,
Period for system_time(StartDate,EndDate)

--E�er veri varsa
Alter Table UrunKayitlari
Add
StartDate datetime2 generated always as row start not null
Default Cast('1900-01-01 00:00:00.0000000' as datetime2),
EndDate datetime2 generated always as row end not null
Default Cast('9999-12-31 23:59:59.9999999' as datetime2),
Period for system_time(StartDate,EndDate)

--�eklinde periyodik kay�t kolonlar�m�z� ekleyebiliriz.

--Kolonlar eklendikten sonra ilgili tablo a�a��daki gibi temporal hale getirilir.
Alter Table UrunKayitlari
Set(System_versioning = on (History_table = dbo.UrunKayitlariLog))

