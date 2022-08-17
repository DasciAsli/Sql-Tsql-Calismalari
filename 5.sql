use Northwind

--If yapýsý

declare @Isým nvarchar(MAX)
Set @Isým='Asli'
If @Isým='Asli'
   Print 'Evet'
Else 
   Print 'Hayýr'

--Begin-End yapýsý(Scope)
Declare @sayi1 int = 3
Declare @sayi2 int = 5
If @sayi1 < @sayi2
  Begin
    Print 'Sayý1 Sayý2den kücüktür'
	Select @sayi1 [Sayý 1],@sayi2 [Sayý 2]
  End
Else
  Begin
    Print 'Sayý1 Sayý2den bücüktür'
	Select @sayi1 [Sayý 1],@sayi2 [Sayý 2]
  End

--Müþterler tablosunda Amerikalý müþteri var mý?
declare @count int=0
Select @count = COUNT(*) from Musteriler where Ulke like 'USA'
If @count > 0
    Print CONVERT(nvarchar(MAX),@count) + ' adet Amerikalý müþteri bulunmaktadýr'
Else
    Print 'Amerikalý müþteri bulunmamaktadýr'


--Adý Aslý  Soyadý Kaya olan bir personel varsa evet mesajý yazdýrsýn yoksa personel eklesin
declare @count2 int = 0
declare @ad nvarchar(MAX)='Asli'
declare @soyad nvarchar(MAX) ='Kaya'
Select @count2=Count(*) from Personeller where Adi=@ad and SoyAdi=@soyad
If @count2>0
 Print 'Evet'
Else
 Begin
   Insert Personeller(Adi,SoyAdi) values (@ad,@soyad)
 End

 --Else If yapýsý
 --Kontrol mekanizmasýnýn öncelik sýrasý yukarýdan aþaðýya doðru
declare @Adi nvarchar(MAX)='Gençay'
declare @Yas int =25
If @Adi='Mahmut'
  print 'Evet Mahmut'
Else If @Yas > 24
  print 'Yasý 24den buyuk'
Else
  print 'abc'

--Exists fonksiyonu(Herhangi bir sorgu neticesinde gelen tablonun boþ mu dolu mu olduðunu öðrenmemizi saðlayan bir fonksiyondur)
--Dolu ise true boþ ise false döndürür
If Exists (Select * from Personeller)
  Print 'Dolu'
Else
  Print 'Boþ'

--While Döngüsü
--Genel Yapýsý
--While Þart Komut

Declare @sayac int = 0
While @sayac < 100
 Begin
  Print @sayac
  Set @sayac = @sayac +1 
 End

 --Break komutu(Herhangi bir döngü içinde break gördüðü döngüden çýkýþ saðlanmaktadýr)

Declare @sayac2 int = 0
While @sayac2 < 100
 Begin
   Print @sayac2
   Set @sayac2 = @sayac2 +2
   If @sayac2 %5=0
     Break	
 End

 --Continue komutu(Derleyici tarafýndan karþýlaþýldýðý zaman continue komutundan sonraki komutlar iþlenmemektedir)

Declare @sayac3 int = 0
While @sayac3 < 100
 Begin
  If @sayac3 %5=0
     Begin
	   Set @sayac3=@sayac3+1
       Continue
	 End
   Print @sayac3
   Set @sayac3 = @sayac3 +1  
 End

--Geçiçi Tablolar(Temporary Table)
--Bir sql server üzerinde farklý lokasyonlarda birden fazla kiþinin çalýþtýðý durumlarda verilerin test amaçlý geçiçi bir yerde tutulmasý,iþlenmesi amacýyla kullanýlan yapýlardýr.
--Bellekte geçiçi olarak oluþurlar
--Select,Insert.Update,Delete iþlemleri yapýlabilir,Ýliþki kurulabilir.
--Sunucu kapatýldýðýnda ya da oturum sahibi oturumu kapattýðýnda bellekten silinirler.

Select * Into GeciciPersoneller from Personeller
--Bu þekilde bir kullanýmda sadece primary key ve foreign key constraintler oluþturulmazlar
--Geri kalan herþey birebir fiziksel olarak oluþturulur.
Select * from GeciciPersoneller

-- Bir Tabloyu # Ýfadesi Ýle Belleðe Geçici Olarak Kopyalama
--Geçici tablo üzerinde her türlü iþlemi yapabiliyoruz
--# ile oluþturulan tablo,o an Sql Serverda oturum açmýþ kiþinin sunucu belleðinde oluþur
--Sadece oturum açan þahýs kullanabilir.
--Eðer oturum açan þahýs Sql serverdan disconnect olursa bu tablo bellekten silinir.
Select * Into #GeciciPersoneller from Personeller
Select * from #GeciciPersoneller
Insert #GeciciPersoneller(Adi,SoyAdi) values ('Gencay','Yýldýz')
Delete from #GeciciPersoneller where Adi='Gencay'

--Bir Tabloyu ## Ýfadesi Ýle Belleðe Geçici Olarak Kopyalama
--## ile oluþturulan tablo, o an  Sql Serverda oturum açmýþ kiþinin sunucu belleðinde oluþur.
--Bu tabloyu oturum açan þahýs ve onun Sql Serverýna dýþarýdan ulaþan 3.þahýslar kullanabilir.
--Eðer oturum açan þahýs Sql serverdan disconnect olursa bu tablo bellekten silinir.
--Diðer bütün özellikleri # ile oluþturulan tablo ile aynýdýr.
Select * Into ##GeciciPersoneller from Personeller
Select * from ##GeciciPersoneller
Insert ##GeciciPersoneller(Adi,SoyAdi) values ('Gencay','Yýldýz')
Delete from ##GeciciPersoneller where Adi='Gencay'

--Uniqueidentifier Veri Tipi
--int,varchar vs gibi bir veri tipidir.
--Aldýðý deðer rakamlar ve harflerden oluþan çok büyük bir sayýdýr.
--Bundan dolayý bu kolona ayný deðerin birden fazla gelmesi neredeyse imkansýzdýr
--O yüzden tekil bir veri oluþturmak için kullanýlýr
Create Table OrnekTablo2
(
  Id int primary key identity,
  Kolon1 nvarchar(MAX),
  Kolon2 nvarchar(MAX),
  Kolon3 uniqueidentifier
)

--NEWID fonksiyonu(Anlýk olarak random bir þekilde uniqueidentifier tipinde id oluþturmamýzý saðlar)
Select NEWID()

--View yapýsý

--Kullaným Amacý
--Genellikle karmaþýk sorgularýn tek bir sorgu üzerinden çalýþtýrýlabilmesidir.
--Bu amaçla raporlama iþlemlerinde kullanýlabilirler
--Ayný zamanda güvenlik ihtiyacý olduðu durumlarda herhangi bir sorgunun 2.-3.þahýslardan gizlenmesi amacýyla da kullanýlýrlar.

--Genel Özellikleri
--Herhangi bir sorgu sonucunu tablo olarak ele alýp,ondan sorgu çekilebilmesini saðlar
--Insert,Update,Delete yapabilirler.Bu iþlemleri fiziksel tabloya yansýtýrlar.**Önemli**
--View yapýlarý fiziksel olarak oluþturulan yapýlardýr.
--View yapýlarý normal sorgulardan daha yavaþ çalýþýrlar.

--Dikkat!!!
--Database elemanlarýný Create komutuyla oluþturuyorduk,View yapýsý da bir database yapýsý olduðu için Create komutu ile oluþturacaðýz
Create View vw_Gotur
As
Select p.Adi + ' ' + p.SoyAdi [Adi Soyadi],k.KategoriAdi [Kategori Adý],COUNT(s.SatisID) [Toplam Satýþ] from Personeller p 
                            Inner Join Satislar s on p.PersonelID=s.PersonelID
                            Inner Join [Satis Detaylari] sd on s.SatisID=sd.SatisID
							Inner Join Urunler u on sd.UrunID=u.UrunID
							Inner Join Kategoriler k on k.KategoriID=u.KategoriID
group by p.Adi + ' ' + p.SoyAdi,k.KategoriAdi

Select * from vw_Gotur

--View oluþturulurken kolonlara verilen aliaslar View'den sorgu çekilirken kullanýlýr
--Bir yandan da view'ýn kullandýðý gerçek tablolarýn kolon isimleri,view içinde alias tanýmlanarak gizlenmiþ olur
--View içinde 'order by' kullanýlmaz
--'Order by' view içinde deðil,view çalýþýrken sorgu esnasýnda kullanýlmalýdýr

Select * from vw_Gotur order by [Toplam Satýþ]

--View içinde order by komutunu kullanmak istiyorsanýz top komutunu kullanmalýsýnýz
Create View vw_Gotur
As
Select top 100 p.Adi + ' ' + p.SoyAdi [Adi Soyadi],k.KategoriAdi [Kategori Adý],COUNT(s.SatisID) [Toplam Satýþ] from Personeller p 
                            Inner Join Satislar s on p.PersonelID=s.PersonelID
                            Inner Join [Satis Detaylari] sd on s.SatisID=sd.SatisID
							Inner Join Urunler u on sd.UrunID=u.UrunID
							Inner Join Kategoriler k on k.KategoriID=u.KategoriID
group by p.Adi + ' ' + p.SoyAdi,k.KategoriAdi Order By [Toplam Satýþ]
--Bu durum tavsiye edilen bir durum deðildir

Create View OrnekViewPersoneller
As
Select Adi,SoyAdi,Unvan from Personeller

Insert OrnekViewPersoneller values('Gencay','Yýldýz','Yazýlým Veritabaný Uzmaný')

-- With Encryption Komutu
--Eðer yazdýðýmýz view'ýn kaynak kodlarýný,Object Explorer penceresinde 'Views' kategorisinde sað týklayarak Design modda açýpgörüntülenmesini istemiyorsak
--'With Encryption' komutu ile View'i oluþturmalýyýz
--Dikkat !!!
--'With Encryption' iþleminden sonra view'i oluþturan kiþi de dahil komutlarý kimse göremez.Geri dönüþ yoktur.Anck viewý oluþturan þahsýn komutlarýn yedeðini bulundurmasý gerekir.
--Ya da 'With Encryption' olmaksýzýn view yapýsýný yeniden alterlamalýyýz
--Dikkat !!!
--Bir dikkat etmemiz gereken nokta da 'With Encryption' ifadesini 'as' keywordünden önce yazmalýyýz

Create View OrnekViewPersoneller
With Encryption
As 
Select Adi,SoyAdi from Personeller
--Bu iþlemi yaptýktan sonra design modu kapatýlmýþtýr