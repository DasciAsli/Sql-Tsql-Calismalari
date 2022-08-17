use Northwind

--If yap�s�

declare @Is�m nvarchar(MAX)
Set @Is�m='Asli'
If @Is�m='Asli'
   Print 'Evet'
Else 
   Print 'Hay�r'

--Begin-End yap�s�(Scope)
Declare @sayi1 int = 3
Declare @sayi2 int = 5
If @sayi1 < @sayi2
  Begin
    Print 'Say�1 Say�2den k�c�kt�r'
	Select @sayi1 [Say� 1],@sayi2 [Say� 2]
  End
Else
  Begin
    Print 'Say�1 Say�2den b�c�kt�r'
	Select @sayi1 [Say� 1],@sayi2 [Say� 2]
  End

--M��terler tablosunda Amerikal� m��teri var m�?
declare @count int=0
Select @count = COUNT(*) from Musteriler where Ulke like 'USA'
If @count > 0
    Print CONVERT(nvarchar(MAX),@count) + ' adet Amerikal� m��teri bulunmaktad�r'
Else
    Print 'Amerikal� m��teri bulunmamaktad�r'


--Ad� Asl�  Soyad� Kaya olan bir personel varsa evet mesaj� yazd�rs�n yoksa personel eklesin
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

 --Else If yap�s�
 --Kontrol mekanizmas�n�n �ncelik s�ras� yukar�dan a�a��ya do�ru
declare @Adi nvarchar(MAX)='Gen�ay'
declare @Yas int =25
If @Adi='Mahmut'
  print 'Evet Mahmut'
Else If @Yas > 24
  print 'Yas� 24den buyuk'
Else
  print 'abc'

--Exists fonksiyonu(Herhangi bir sorgu neticesinde gelen tablonun bo� mu dolu mu oldu�unu ��renmemizi sa�layan bir fonksiyondur)
--Dolu ise true bo� ise false d�nd�r�r
If Exists (Select * from Personeller)
  Print 'Dolu'
Else
  Print 'Bo�'

--While D�ng�s�
--Genel Yap�s�
--While �art Komut

Declare @sayac int = 0
While @sayac < 100
 Begin
  Print @sayac
  Set @sayac = @sayac +1 
 End

 --Break komutu(Herhangi bir d�ng� i�inde break g�rd��� d�ng�den ��k�� sa�lanmaktad�r)

Declare @sayac2 int = 0
While @sayac2 < 100
 Begin
   Print @sayac2
   Set @sayac2 = @sayac2 +2
   If @sayac2 %5=0
     Break	
 End

 --Continue komutu(Derleyici taraf�ndan kar��la��ld��� zaman continue komutundan sonraki komutlar i�lenmemektedir)

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

--Ge�i�i Tablolar(Temporary Table)
--Bir sql server �zerinde farkl� lokasyonlarda birden fazla ki�inin �al��t��� durumlarda verilerin test ama�l� ge�i�i bir yerde tutulmas�,i�lenmesi amac�yla kullan�lan yap�lard�r.
--Bellekte ge�i�i olarak olu�urlar
--Select,Insert.Update,Delete i�lemleri yap�labilir,�li�ki kurulabilir.
--Sunucu kapat�ld���nda ya da oturum sahibi oturumu kapatt���nda bellekten silinirler.

Select * Into GeciciPersoneller from Personeller
--Bu �ekilde bir kullan�mda sadece primary key ve foreign key constraintler olu�turulmazlar
--Geri kalan her�ey birebir fiziksel olarak olu�turulur.
Select * from GeciciPersoneller

-- Bir Tabloyu # �fadesi �le Belle�e Ge�ici Olarak Kopyalama
--Ge�ici tablo �zerinde her t�rl� i�lemi yapabiliyoruz
--# ile olu�turulan tablo,o an Sql Serverda oturum a�m�� ki�inin sunucu belle�inde olu�ur
--Sadece oturum a�an �ah�s kullanabilir.
--E�er oturum a�an �ah�s Sql serverdan disconnect olursa bu tablo bellekten silinir.
Select * Into #GeciciPersoneller from Personeller
Select * from #GeciciPersoneller
Insert #GeciciPersoneller(Adi,SoyAdi) values ('Gencay','Y�ld�z')
Delete from #GeciciPersoneller where Adi='Gencay'

--Bir Tabloyu ## �fadesi �le Belle�e Ge�ici Olarak Kopyalama
--## ile olu�turulan tablo, o an  Sql Serverda oturum a�m�� ki�inin sunucu belle�inde olu�ur.
--Bu tabloyu oturum a�an �ah�s ve onun Sql Server�na d��ar�dan ula�an 3.�ah�slar kullanabilir.
--E�er oturum a�an �ah�s Sql serverdan disconnect olursa bu tablo bellekten silinir.
--Di�er b�t�n �zellikleri # ile olu�turulan tablo ile ayn�d�r.
Select * Into ##GeciciPersoneller from Personeller
Select * from ##GeciciPersoneller
Insert ##GeciciPersoneller(Adi,SoyAdi) values ('Gencay','Y�ld�z')
Delete from ##GeciciPersoneller where Adi='Gencay'

--Uniqueidentifier Veri Tipi
--int,varchar vs gibi bir veri tipidir.
--Ald��� de�er rakamlar ve harflerden olu�an �ok b�y�k bir say�d�r.
--Bundan dolay� bu kolona ayn� de�erin birden fazla gelmesi neredeyse imkans�zd�r
--O y�zden tekil bir veri olu�turmak i�in kullan�l�r
Create Table OrnekTablo2
(
  Id int primary key identity,
  Kolon1 nvarchar(MAX),
  Kolon2 nvarchar(MAX),
  Kolon3 uniqueidentifier
)

--NEWID fonksiyonu(Anl�k olarak random bir �ekilde uniqueidentifier tipinde id olu�turmam�z� sa�lar)
Select NEWID()

--View yap�s�

--Kullan�m Amac�
--Genellikle karma��k sorgular�n tek bir sorgu �zerinden �al��t�r�labilmesidir.
--Bu ama�la raporlama i�lemlerinde kullan�labilirler
--Ayn� zamanda g�venlik ihtiyac� oldu�u durumlarda herhangi bir sorgunun 2.-3.�ah�slardan gizlenmesi amac�yla da kullan�l�rlar.

--Genel �zellikleri
--Herhangi bir sorgu sonucunu tablo olarak ele al�p,ondan sorgu �ekilebilmesini sa�lar
--Insert,Update,Delete yapabilirler.Bu i�lemleri fiziksel tabloya yans�t�rlar.**�nemli**
--View yap�lar� fiziksel olarak olu�turulan yap�lard�r.
--View yap�lar� normal sorgulardan daha yava� �al���rlar.

--Dikkat!!!
--Database elemanlar�n� Create komutuyla olu�turuyorduk,View yap�s� da bir database yap�s� oldu�u i�in Create komutu ile olu�turaca��z
Create View vw_Gotur
As
Select p.Adi + ' ' + p.SoyAdi [Adi Soyadi],k.KategoriAdi [Kategori Ad�],COUNT(s.SatisID) [Toplam Sat��] from Personeller p 
                            Inner Join Satislar s on p.PersonelID=s.PersonelID
                            Inner Join [Satis Detaylari] sd on s.SatisID=sd.SatisID
							Inner Join Urunler u on sd.UrunID=u.UrunID
							Inner Join Kategoriler k on k.KategoriID=u.KategoriID
group by p.Adi + ' ' + p.SoyAdi,k.KategoriAdi

Select * from vw_Gotur

--View olu�turulurken kolonlara verilen aliaslar View'den sorgu �ekilirken kullan�l�r
--Bir yandan da view'�n kulland��� ger�ek tablolar�n kolon isimleri,view i�inde alias tan�mlanarak gizlenmi� olur
--View i�inde 'order by' kullan�lmaz
--'Order by' view i�inde de�il,view �al���rken sorgu esnas�nda kullan�lmal�d�r

Select * from vw_Gotur order by [Toplam Sat��]

--View i�inde order by komutunu kullanmak istiyorsan�z top komutunu kullanmal�s�n�z
Create View vw_Gotur
As
Select top 100 p.Adi + ' ' + p.SoyAdi [Adi Soyadi],k.KategoriAdi [Kategori Ad�],COUNT(s.SatisID) [Toplam Sat��] from Personeller p 
                            Inner Join Satislar s on p.PersonelID=s.PersonelID
                            Inner Join [Satis Detaylari] sd on s.SatisID=sd.SatisID
							Inner Join Urunler u on sd.UrunID=u.UrunID
							Inner Join Kategoriler k on k.KategoriID=u.KategoriID
group by p.Adi + ' ' + p.SoyAdi,k.KategoriAdi Order By [Toplam Sat��]
--Bu durum tavsiye edilen bir durum de�ildir

Create View OrnekViewPersoneller
As
Select Adi,SoyAdi,Unvan from Personeller

Insert OrnekViewPersoneller values('Gencay','Y�ld�z','Yaz�l�m Veritaban� Uzman�')

-- With Encryption Komutu
--E�er yazd���m�z view'�n kaynak kodlar�n�,Object Explorer penceresinde 'Views' kategorisinde sa� t�klayarak Design modda a��pg�r�nt�lenmesini istemiyorsak
--'With Encryption' komutu ile View'i olu�turmal�y�z
--Dikkat !!!
--'With Encryption' i�leminden sonra view'i olu�turan ki�i de dahil komutlar� kimse g�remez.Geri d�n�� yoktur.Anck view� olu�turan �ahs�n komutlar�n yede�ini bulundurmas� gerekir.
--Ya da 'With Encryption' olmaks�z�n view yap�s�n� yeniden alterlamal�y�z
--Dikkat !!!
--Bir dikkat etmemiz gereken nokta da 'With Encryption' ifadesini 'as' keyword�nden �nce yazmal�y�z

Create View OrnekViewPersoneller
With Encryption
As 
Select Adi,SoyAdi from Personeller
--Bu i�lemi yapt�ktan sonra design modu kapat�lm��t�r