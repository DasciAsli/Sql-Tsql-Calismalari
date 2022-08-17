--STORED PROCEDURES

--Genel �zellikleri

--1)Normal sorgulardan daha h�zl� �al���rlar.
--��nk� normal sorgular Execute edilirken �Execute Plan� i�lemi yap�l�r.
--Bu i�lem s�ras�nda hangi tablodan veri �ekilecek ,hangi kolonlardan veri gelecek, bunlar nerede vs gibi i�lemler yap�l�r.
--Bir sorgu her �al��t���nda bu i�lemler aynen tekrar tekrar yap�l�r.
--Fakat sorgu stored procedure olarak �al��t�r�l�rsa bu i�lem sadece bir kere yap�l�r ve o da ilk �al��t�rma an�ndad�r.
--Di�er �al��t�rmalarda bu i�lemler yap�lmaz. Bundan dolay� h�z ve performansta art�� sa�lan�r. 
--2)��erisinde select,insert,delete,update i�lemleri yap�labilir.
--3)�� i�e kullan�labilir.
--4)��lerinde fonksiyon olu�turulabilir.
--5)Sorgular�m�z�n d��ar�dan alaca�� de�erler parametre olarak stored procedure�le ge�irilebildi�inden dolay�, sorgular�m�z�n SQL Injection yemelerini de �nlemi� oluruz.
--Bu y�nleriyle daha g�venlidirler.
--6)Stored Procedure fiziksel bir veri taban� nesnesidir. Haliyle create komutu ile olu�turulur.

--Prototip
--Create Proc ya da Procedure [�sim]
--(
--    varsa parametreler
--)As
--yaz�lacak sorgular,kodlar,�artlar,fonksiyonlar,komutlar

Create Proc sp_Ornek
(
  @Id int --Aksi s�ylenmedi�i takdirde bu parametrenin yap�s� inputtur.
)As
Select * from Personeller Where PersonelID = @Id


--!! Procedure parametrelerini tan�mlarken parantez kullanmak zorunlu de�ildir ama okunurlulu�u artt�rmak i�in kullanmakta fayda vard�r.
--Store Procedureleri kullan�rken 'Exec' komutu e�li�inde �al��t�rabilmekteyiz.

Exec sp_Ornek 3

--Geriye de�er d�nd�ren stored procedure

Create Proc UrunGetir
(
  @Fiyat money
)As
Select * from Urunler Where BirimFiyati= @Fiyat
Return @@Rowcount

Exec UrunGetir 40
--Bu �ekilde kulland���m�zda tablo �eklinde sonu� al�r�z.
--Yani geriye d�n�len de�eri elde etmeksizin kullan�labilir.S�k�nt� olmaz.


Declare @Sonuc int 
Exec @Sonuc =UrunGetir 40
Select @Sonuc
--Bu �ekilde de geriye d�n�len de�eri elde etmi� ve kullanm�� olduk

--OUTPUT �LE DE�ER D�ND�RME
Create Proc sp_Ornek3
(
   @Id int,
   @Adi nvarchar(MAX) Output,
   @Soyadi nvarchar(MAX) Output
)As
Select @Adi=Adi,@Soyadi=SoyAdi from Personeller where PersonelID= @Id

--Yukar�daki stored procedurede 3 adet parametre tan�mlanm��t�r.
--Bu 3 parametreden 2 tanesi output olarak tan�mlanm��t�r.
--Yani Adi ve Soyadi parametreleri input cinsinden de�il output cinsindendir.
--Input parametre d��ardan de�er al�rken,output parametre i�erdeki de�eri d��ar� g�nderir.

Declare @Adi nvarchar(MAX),@Soyadi nvarchar(MAX)
Exec sp_Ornek3 3,@Adi Output,@Soyadi Output
Select @Adi +' '+ @Soyadi

--PARAMETRELERE VARSAYILAN DE�ER ATAMA

Create Proc sp_PersonelEkle2(
  @Ad varchar(50)='�simsiz',
  @Soyad varchar(50)='Soyads�z',
  @Sehir nvarchar(MAX) = 'Yok'
)As
Insert Personeller(Adi,SoyAdi,Sehir) Values (@Ad,@Soyad,@Sehir)


Exec sp_PersonelEkle2 'Gokhan','A�ker','Hatay'
--Burada varsay�lan de�erler devreye girmemektedir.

Select * from Personeller

Exec sp_PersonelEkle2
--Normalde bu �ekilde parametrelere de�er g�ndermeksizin �al��mamas� laz�m
--ama varsay�lan de�erler tan�mda belirtildi�i i�in devreye girmektedir.

Exec sp_PersonelEkle2 'Ibrahim'
--@Adi parametresi 'Ibrahim de�erini al�r di�er parametreler varsay�la olarak belirtilen de�erleri al�r.'

--EXEC KOMUTU
Exec('Select * from Personeller')
--Exec '' aras�na ald��� komutlar� �al��t�ran bir komuttur
Select * from Personeller


--Yanl�� kullan�m
Exec('Declare @Sayac int = 0')
Exec('print @Sayac')
--2 Exec komutu birbirinden ba��ms�zd�r.Bu ikisi �al��t�r�ld���nda hata al�n�r.

--Do�ru kullan�m
Exec('Declare @Sayac int =0 print @Sayac')


--STORE PROCEDURE ��ER�S�NDE NESNE OLU�TURMA

Create Proc sp_TabloOlustur
(
    @TabloAdi nvarchar(MAX),
	@Kolon1Adi  nvarchar(MAX),
	@Kolon1Ozellikleri nvarchar(MAX),
	@Kolon2Adi nvarchar(MAX),
	@Kolon2Ozellikleri nvarchar(MAX)
)As
Exec
(
   'Create Table ' + @TabloAdi +
   '(' 
   
          +@Kolon1Adi + ' '+ @Kolon1Ozellikleri + ',' 
		  +@Kolon2Adi + ' '+ @Kolon2Ozellikleri +
   ')'
)

Exec sp_TabloOlustur 'OrnekTablo','Id','int primary key identity(1,1)','Kolon2','nvarchar(MAX)'

Select * from OrnekTablo