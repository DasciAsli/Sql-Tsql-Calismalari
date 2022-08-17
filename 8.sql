--TRIGGER (TET�KLEY�C�LER)
--Bir i�lem yap�l�rken o i�lem yerine ya da o i�lemle beraber ba�ka bir i�lemin yap�lmas�n� sa�layan ba�ka bir i�lemi tetikler.

--2 adet trigger vard�r

--**1)DML TRIGGER :** Bir tabloda Insert,Update,Delete i�lemleri ger�ekle�ti�inde devreye giren yap�lard�r.
--Bu i�lemler sonucunda ve s�recinde devreye girerler

--**2)DDL TRIGGER :**Create ,Alter ve Drop i�lemleri sonucunda veya s�recinde devreye girecek olan yap�lard�r

--**DML TRIGGER**

--**Inserted Table**

--E�er bir tabloda Insert i�lemi yap�l�yorsa arka planda i�lemler ilk �nce RAM �de olu�turulan inserted isimli bir tabloda yap�l�r.
--E�er i�lemde bir problem yoksa inserted tablosundaki veriler fiziksel tabloya insert edilir .
--��lem bitti�inde RAM� de olu�turulan bu inserted tablosu silinir.

--**Deleted Table**

--E�er bir tabloda Delete i�lemi yap�l�yorsa arka planda i�lemler ilk �nce RAM �de olu�turulan deleted isimli bir tabloda yap�l�r.
--E�er i�lemde bir problem yoksa deleted tablosundaki veriler fiziksel tablodan silinir .
--��lem bitti�inde RAM� de olu�turulan bu deleted tablosu silinir.

--!!!E�er bir tabloda update isimli bir i�lem yap�l�yorsa RAM�de updated isimli bir tablo olu�maz.
--Sql Serverdaki update mant��� �nce silme sonra eklemedir.
--E�er bir tabloda update i�lemi yap�l�yorsa arka planda RAM�de hem deleted hem de inserted tablolar� olu�turulur ve i�lemler bunlara g�re yap�l�r.

--NOT :Update yaparken g�ncellenen kayd�n orjinali deleted tablosunda ,
--g�ncellendikten sonraki hali ise inserted tablosunda bulunmaktad�r.
--��nk� g�ncelle demek kayd� �nce silmek sonra eklemektir.

--Deleted ve inserted tablolar� ,ilgili sorgu sonucunda olu�tuklar� i�in o sorgunun kullan�ld���
--kolonlara da sahip olurlar .B�ylece deleted ve inserted tablolar�ndan select sorgusu yapmak m�mk�nd�r.


--Trigger Tan�mlama
   
   Create Trigger OrnekTrigger
   On Personeller
   After Insert
   As
   Select * from Personeller


   Insert Personeller(Adi,SoyAdi) Values ('Gencay','Y�ld�z')

--Yukar�daki sorguda Personeller tablosuna OrnekTrigger ad�nda bir trigger tan�mlad�k
--Bu trigger Personeller tablosunda insert i�lemi yap�ld�ktan sonra devreye girecek
--ve bu i�lemle beraber alt�ndaki Select komutunu tetikleyecektir.



   --Ornek1
   --Tedarik�iler tablosundan bir veri silindi�inde t�m �r�nlerin fiyat� otomatik olarak 10 arts�n

   Create Trigger triggerTedarikciler
   on Tedarikciler
   after delete
   as
   Update Urunler Set BirimFiyati = BirimFiyati + 10
   Select * from Urunler


   Delete from Tedarikciler where TedarikciID = 30

   --Ornek2
   --Tedarik�iler tablosunda bir veri g�ncellendi�inde,kategoriler tablosunda 'Meyve Kokteyli'
   --ad�nda bir kategori olu�sun

   Create Trigger TedarikciGuncelleTrigger
   on Tedarikciler
   for Update
   As
     Insert Kategoriler(KategoriAdi) Values ('Meyve Kokteyli')
	 Select * from Kategoriler


	Update Tedarikciler Set SirketAdi ='Mayumis' where SirketAdi like 'M%s'


	--Ornek3
	--Personeller tablosundan bir kay�t silindi�inde silinen kayd�n ad�,soyad� ve kim taraf�ndan,
	--hangi saatte silindi�i ba�ka bir tabloya kay�t edilsin.Bir nevi log tablosu misali ...

	Create Table PersonelDeleteLog
	(
	  Id int Primary Key identity(1,1),
	  Ad nvarchar(MAX),
	  Soyad nvarchar(MAX),
	  SilenKisi nvarchar(MAX),
	  Saat datetime
	)

	Create Trigger triggerPerson
	on Personeller
	after Delete
	As
	  Declare @Adi nvarchar(MAX),@Soyadi nvarchar(MAX)
	  Select @Adi = Adi,@Soyadi = SoyAdi from deleted
	  Insert PersonelDeleteLog Values (@Adi,@Soyadi,SUSER_NAME(),GETDATE())
	  Select * from PersonelDeleteLog


	 Delete from Personeller where PersonelID = (Select TOP 1 PersonelID from Personeller Order By PersonelID  desc)

--MULT�PLE ACT�ONS TRIGGER
--Bir trigger �zerinde birden fazla action bar�nd�rabilir.

	Create Trigger MultiTrigger
	on Personeller
	after delete , insert
	As
	print 'Merhaba'

	Insert Personeller(Adi,SoyAdi) Values ('Ay�e','Kaya')
	Delete from Personeller where PersonelID= 31

--**INSTEAD OF  TRIGGER**
--�u ana kadar Insert,Update ve Delete i�lemleri yap�l�rken �u �u i�lemleri yap mant���yla �al��t�k.(Yan�nda �unu yap)
--Instead of Triggerlar ise Insert,Update ve Delete i�lemleri yerine �u �u i�lemleri yap mant���yla �al���r.(Yerine �unu yap)

   --Ornek5
   --Personeller tablosunda  update ger�ekle�ti�i anda yap�lacak g�ncelle�tirme yerine
   --bir log tablosuna kimin hangi tarihte 
   --hangi personel �zerinde i�lem yapmak istedi�ini ekle
   Create Table PersonelUpdateLog
   (
     Id int Primary Key identity(1,1),
	 Ad nvarchar(MAX),
	 Soyad nvarchar(MAX),
	 IslemiYapan nvarchar(MAX),
	 Tarih datetime
   )

   Create Trigger PersonelUpdateLogTrigger
   on Personeller
   Instead of Update
   As
   Declare @Ad nvarchar(MAX),@Soyad nvarchar(MAX)
   Select @Ad=Adi,@Soyad=SoyAdi from deleted
   Insert PersonelUpdateLog Values (@Ad,@Soyad,SUSER_NAME(),GETDATE())
   Select * from PersonelUpdateLog


   Update Personeller Set SoyAdi='Kara' where PersonelID=11


   --Ornek6
   --Personeller tablosunda ad� 'Andrew' olan kayd�n silinmesini engelleyen 
   --ama di�erlerine izin veren trigger'� yazal�m

   Create Trigger AndrewTrigger
   on Personeller
   after Delete
   As
   Declare @Ad nvarchar(MAX)
   Select @Ad=Adi from deleted
   if @Ad= 'Andrew'
    Begin
	    print 'Bu kayd� silemezsiniz'
		rollback --Ypa�lan t�m i�lemleri geri al�r.Transaction konusunda i�lenecek.
	End


	Delete from Personeller where PersonelID=12
	
--**DDL TRIGGERLAR**
--Create,Alter ve Drop i�lemleri sonucunda veya s�recinde devreye girecek olan yap�lard�r.

Create Trigger DDL_Trigger
On Database
For drop_table,alter_table,create_function,create_procedure,drop_procedure --vs vs --
as
print 'Bu i�lem ger�ekle�emez'
Rollback

Drop Table PersonelDeleteLog


--TRIGGER'I DEVRE DI�I BIRAKMA
Disable Trigger AndrewTrigger on Personeller


--TRIGGER'I AKT�FLE��RME
Enable Trigger AndrewTrigger on Personeller