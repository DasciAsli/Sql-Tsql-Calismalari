--TRIGGER (TETÝKLEYÝCÝLER)
--Bir iþlem yapýlýrken o iþlem yerine ya da o iþlemle beraber baþka bir iþlemin yapýlmasýný saðlayan baþka bir iþlemi tetikler.

--2 adet trigger vardýr

--**1)DML TRIGGER :** Bir tabloda Insert,Update,Delete iþlemleri gerçekleþtiðinde devreye giren yapýlardýr.
--Bu iþlemler sonucunda ve sürecinde devreye girerler

--**2)DDL TRIGGER :**Create ,Alter ve Drop iþlemleri sonucunda veya sürecinde devreye girecek olan yapýlardýr

--**DML TRIGGER**

--**Inserted Table**

--Eðer bir tabloda Insert iþlemi yapýlýyorsa arka planda iþlemler ilk önce RAM ’de oluþturulan inserted isimli bir tabloda yapýlýr.
--Eðer iþlemde bir problem yoksa inserted tablosundaki veriler fiziksel tabloya insert edilir .
--Ýþlem bittiðinde RAM’ de oluþturulan bu inserted tablosu silinir.

--**Deleted Table**

--Eðer bir tabloda Delete iþlemi yapýlýyorsa arka planda iþlemler ilk önce RAM ’de oluþturulan deleted isimli bir tabloda yapýlýr.
--Eðer iþlemde bir problem yoksa deleted tablosundaki veriler fiziksel tablodan silinir .
--Ýþlem bittiðinde RAM’ de oluþturulan bu deleted tablosu silinir.

--!!!Eðer bir tabloda update isimli bir iþlem yapýlýyorsa RAM’de updated isimli bir tablo oluþmaz.
--Sql Serverdaki update mantýðý önce silme sonra eklemedir.
--Eðer bir tabloda update iþlemi yapýlýyorsa arka planda RAM’de hem deleted hem de inserted tablolarý oluþturulur ve iþlemler bunlara göre yapýlýr.

--NOT :Update yaparken güncellenen kaydýn orjinali deleted tablosunda ,
--güncellendikten sonraki hali ise inserted tablosunda bulunmaktadýr.
--Çünkü güncelle demek kaydý önce silmek sonra eklemektir.

--Deleted ve inserted tablolarý ,ilgili sorgu sonucunda oluþtuklarý için o sorgunun kullanýldýðý
--kolonlara da sahip olurlar .Böylece deleted ve inserted tablolarýndan select sorgusu yapmak mümkündür.


--Trigger Tanýmlama
   
   Create Trigger OrnekTrigger
   On Personeller
   After Insert
   As
   Select * from Personeller


   Insert Personeller(Adi,SoyAdi) Values ('Gencay','Yýldýz')

--Yukarýdaki sorguda Personeller tablosuna OrnekTrigger adýnda bir trigger tanýmladýk
--Bu trigger Personeller tablosunda insert iþlemi yapýldýktan sonra devreye girecek
--ve bu iþlemle beraber altýndaki Select komutunu tetikleyecektir.



   --Ornek1
   --Tedarikçiler tablosundan bir veri silindiðinde tüm ürünlerin fiyatý otomatik olarak 10 artsýn

   Create Trigger triggerTedarikciler
   on Tedarikciler
   after delete
   as
   Update Urunler Set BirimFiyati = BirimFiyati + 10
   Select * from Urunler


   Delete from Tedarikciler where TedarikciID = 30

   --Ornek2
   --Tedarikçiler tablosunda bir veri güncellendiðinde,kategoriler tablosunda 'Meyve Kokteyli'
   --adýnda bir kategori oluþsun

   Create Trigger TedarikciGuncelleTrigger
   on Tedarikciler
   for Update
   As
     Insert Kategoriler(KategoriAdi) Values ('Meyve Kokteyli')
	 Select * from Kategoriler


	Update Tedarikciler Set SirketAdi ='Mayumis' where SirketAdi like 'M%s'


	--Ornek3
	--Personeller tablosundan bir kayýt silindiðinde silinen kaydýn adý,soyadý ve kim tarafýndan,
	--hangi saatte silindiði baþka bir tabloya kayýt edilsin.Bir nevi log tablosu misali ...

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

--MULTÝPLE ACTÝONS TRIGGER
--Bir trigger üzerinde birden fazla action barýndýrabilir.

	Create Trigger MultiTrigger
	on Personeller
	after delete , insert
	As
	print 'Merhaba'

	Insert Personeller(Adi,SoyAdi) Values ('Ayþe','Kaya')
	Delete from Personeller where PersonelID= 31

--**INSTEAD OF  TRIGGER**
--Þu ana kadar Insert,Update ve Delete iþlemleri yapýlýrken þu þu iþlemleri yap mantýðýyla çalýþtýk.(Yanýnda þunu yap)
--Instead of Triggerlar ise Insert,Update ve Delete iþlemleri yerine þu þu iþlemleri yap mantýðýyla çalýþýr.(Yerine þunu yap)

   --Ornek5
   --Personeller tablosunda  update gerçekleþtiði anda yapýlacak güncelleþtirme yerine
   --bir log tablosuna kimin hangi tarihte 
   --hangi personel üzerinde iþlem yapmak istediðini ekle
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
   --Personeller tablosunda adý 'Andrew' olan kaydýn silinmesini engelleyen 
   --ama diðerlerine izin veren trigger'ý yazalým

   Create Trigger AndrewTrigger
   on Personeller
   after Delete
   As
   Declare @Ad nvarchar(MAX)
   Select @Ad=Adi from deleted
   if @Ad= 'Andrew'
    Begin
	    print 'Bu kaydý silemezsiniz'
		rollback --Ypaýlan tüm iþlemleri geri alýr.Transaction konusunda iþlenecek.
	End


	Delete from Personeller where PersonelID=12
	
--**DDL TRIGGERLAR**
--Create,Alter ve Drop iþlemleri sonucunda veya sürecinde devreye girecek olan yapýlardýr.

Create Trigger DDL_Trigger
On Database
For drop_table,alter_table,create_function,create_procedure,drop_procedure --vs vs --
as
print 'Bu iþlem gerçekleþemez'
Rollback

Drop Table PersonelDeleteLog


--TRIGGER'I DEVRE DIÞI BIRAKMA
Disable Trigger AndrewTrigger on Personeller


--TRIGGER'I AKTÝFLEÞÝRME
Enable Trigger AndrewTrigger on Personeller