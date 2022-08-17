--STORED PROCEDURES

--Genel Özellikleri

--1)Normal sorgulardan daha hýzlý çalýþýrlar.
--Çünkü normal sorgular Execute edilirken ‘Execute Plan’ iþlemi yapýlýr.
--Bu iþlem sýrasýnda hangi tablodan veri çekilecek ,hangi kolonlardan veri gelecek, bunlar nerede vs gibi iþlemler yapýlýr.
--Bir sorgu her çalýþtýðýnda bu iþlemler aynen tekrar tekrar yapýlýr.
--Fakat sorgu stored procedure olarak çalýþtýrýlýrsa bu iþlem sadece bir kere yapýlýr ve o da ilk çalýþtýrma anýndadýr.
--Diðer çalýþtýrmalarda bu iþlemler yapýlmaz. Bundan dolayý hýz ve performansta artýþ saðlanýr. 
--2)Ýçerisinde select,insert,delete,update iþlemleri yapýlabilir.
--3)Ýç içe kullanýlabilir.
--4)Ýçlerinde fonksiyon oluþturulabilir.
--5)Sorgularýmýzýn dýþarýdan alacaðý deðerler parametre olarak stored procedure’le geçirilebildiðinden dolayý, sorgularýmýzýn SQL Injection yemelerini de önlemiþ oluruz.
--Bu yönleriyle daha güvenlidirler.
--6)Stored Procedure fiziksel bir veri tabaný nesnesidir. Haliyle create komutu ile oluþturulur.

--Prototip
--Create Proc ya da Procedure [Ýsim]
--(
--    varsa parametreler
--)As
--yazýlacak sorgular,kodlar,þartlar,fonksiyonlar,komutlar

Create Proc sp_Ornek
(
  @Id int --Aksi söylenmediði takdirde bu parametrenin yapýsý inputtur.
)As
Select * from Personeller Where PersonelID = @Id


--!! Procedure parametrelerini tanýmlarken parantez kullanmak zorunlu deðildir ama okunurluluðu arttýrmak için kullanmakta fayda vardýr.
--Store Procedureleri kullanýrken 'Exec' komutu eþliðinde çalýþtýrabilmekteyiz.

Exec sp_Ornek 3

--Geriye deðer döndüren stored procedure

Create Proc UrunGetir
(
  @Fiyat money
)As
Select * from Urunler Where BirimFiyati= @Fiyat
Return @@Rowcount

Exec UrunGetir 40
--Bu þekilde kullandýðýmýzda tablo þeklinde sonuç alýrýz.
--Yani geriye dönülen deðeri elde etmeksizin kullanýlabilir.Sýkýntý olmaz.


Declare @Sonuc int 
Exec @Sonuc =UrunGetir 40
Select @Sonuc
--Bu þekilde de geriye dönülen deðeri elde etmiþ ve kullanmýþ olduk

--OUTPUT ÝLE DEÐER DÖNDÜRME
Create Proc sp_Ornek3
(
   @Id int,
   @Adi nvarchar(MAX) Output,
   @Soyadi nvarchar(MAX) Output
)As
Select @Adi=Adi,@Soyadi=SoyAdi from Personeller where PersonelID= @Id

--Yukarýdaki stored procedurede 3 adet parametre tanýmlanmýþtýr.
--Bu 3 parametreden 2 tanesi output olarak tanýmlanmýþtýr.
--Yani Adi ve Soyadi parametreleri input cinsinden deðil output cinsindendir.
--Input parametre dýþardan deðer alýrken,output parametre içerdeki deðeri dýþarý gönderir.

Declare @Adi nvarchar(MAX),@Soyadi nvarchar(MAX)
Exec sp_Ornek3 3,@Adi Output,@Soyadi Output
Select @Adi +' '+ @Soyadi

--PARAMETRELERE VARSAYILAN DEÐER ATAMA

Create Proc sp_PersonelEkle2(
  @Ad varchar(50)='Ýsimsiz',
  @Soyad varchar(50)='Soyadsýz',
  @Sehir nvarchar(MAX) = 'Yok'
)As
Insert Personeller(Adi,SoyAdi,Sehir) Values (@Ad,@Soyad,@Sehir)


Exec sp_PersonelEkle2 'Gokhan','Aþker','Hatay'
--Burada varsayýlan deðerler devreye girmemektedir.

Select * from Personeller

Exec sp_PersonelEkle2
--Normalde bu þekilde parametrelere deðer göndermeksizin çalýþmamasý lazým
--ama varsayýlan deðerler tanýmda belirtildiði için devreye girmektedir.

Exec sp_PersonelEkle2 'Ibrahim'
--@Adi parametresi 'Ibrahim deðerini alýr diðer parametreler varsayýla olarak belirtilen deðerleri alýr.'

--EXEC KOMUTU
Exec('Select * from Personeller')
--Exec '' arasýna aldýðý komutlarý çalýþtýran bir komuttur
Select * from Personeller


--Yanlýþ kullaným
Exec('Declare @Sayac int = 0')
Exec('print @Sayac')
--2 Exec komutu birbirinden baðýmsýzdýr.Bu ikisi çalýþtýrýldýðýnda hata alýnýr.

--Doðru kullaným
Exec('Declare @Sayac int =0 print @Sayac')


--STORE PROCEDURE ÝÇERÝSÝNDE NESNE OLUÞTURMA

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