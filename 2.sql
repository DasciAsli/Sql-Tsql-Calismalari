use Northwind

--JOÝN ÝÞLEMLERÝ(Birden fazla tabloyu birleþtirip tek bir tablo elde etmemizi saðlarlar)

--Ýnner Join(Birden fazla tabloyu iliþkisel kolonlar yardýmýyla birleþtirip tek bir tablo haline getirir)
--Genel Mantýk
--Select * from Tablo1 inner join Tablo2 on Tablo1.Ýliskilikolon =Tablo2.Ýliskilikolon
--Tablolara alias tanýmlanabilir
--Select * from Tablo1 t1 inner join Tablo2 t2 on t1.Ýliskilikolon =t2.Ýliskilikolon

--Hangi personel hangi satýþlarý yapmýþtýr?
Select p.Adi,s.SatisID from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID

--Hangi ürün hangi kategoride?
Select u.UrunAdi,k.KategoriAdi from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID

--Beverages kategorisindeki ürünleri sýrala
Select u.UrunAdi from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID where k.KategoriAdi='Beverages'

--Beverages kategorisindeki urunlerin sayýsýný getir
Select COUNT(*) from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID where k.KategoriAdi='Beverages'

--Seafood kategorisindeki ürünlerin listesini getir
Select u.UrunAdi from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID where k.KategoriAdi='Seafood'

--Hangi satýþý hangi çalýþan yapmýþ
Select s.SatisID,p.Adi + ' ' + p.SoyAdi [Personel Bilgisi] from Satislar s inner join Personeller p on s.PersonelID=p.PersonelID

--Faks numarasý null olmayan tedarikçilerden alýnmýþ ürünler nelerdir?
Select u.UrunAdi,t.Faks from Urunler u inner join Tedarikciler t on u.TedarikciID=t.TedarikciID where T.Faks<>'NULL'

--2den fazla tabloyu inner join ile birleþtirme
--1997 yýlýndan sonra Nancynin satýþ yaptðý firmalarýn isimleri (1997 dahil)
Select P.Adi,S.SatisTarihi, M.SirketAdi from Satislar s inner join Personeller p on s.PersonelID=p.PersonelID inner join Musteriler m on s.MusteriID=m.MusteriID where p.Adi='Nancy' and YEAR(S.SatisTarihi)>=1997

--Limited olan tedarikçilerden alýnmýþ seafood kategorisindeki ürünlerimin toplam satýþ tutarý
Select SUM(u.HedefStokDuzeyi*u.BirimFiyati) from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID inner join Tedarikciler t on u.TedarikciID=t.TedarikciID where t.SirketAdi like '%Ltd.%' and k.KategoriAdi='Seafood'

--Ayný tabloyu iliþkisel olarak birleþtirme
--Personellerimin baðlý olarak çalýþtýðý kiþileri listele(Personeller,Personeller)
Select p1.Adi,p2.Adi from Personeller p1 inner join Personeller p2 on p1.BagliCalistigiKisi=p2.PersonelID

--Hangi personel(Ad,Soyad) toplam kaç adet satýþ yapmýþ.Satýþ adeti 100den fazla olan ve personel adý M ile baþlayanlarý getir
Select p.Adi +' ' + p.SoyAdi,COUNT(s.SatisID) from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID where p.Adi like 'M%' group by p.Adi +' ' + p.SoyAdi having COUNT(s.SatisID)>100

--Seafood kategorisindeki ürünlerin sayýsý
Select k.KategoriAdi,COUNT(u.UrunAdi)[Urun sayisi] from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID where k.KategoriAdi='Seafood' group by k.KategoriAdi

--Hangi personel toplam kaç adet satýþ yapmýþ
Select p.Adi,COUNT(s.SatisID) from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID group by p.Adi

--En çok satýþ yapan personel
Select top 1 p.Adi,COUNT(s.SatisID) from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID group by p.Adi order by COUNT(s.SatisID) desc

--Outer join(Left,Right,Full)
--Ýnner join ile sadece iki tablodaki eþleþen kayýtlarý getirebiliyorduk ancak eþleþmeyen kýsýmlarý da getirebilmek için outer join kullanýyoruz
--Select * from Filmler f left join Oyuncular o on f.FilmId=o.FilmId

--DML(Data Manipulation Language) Komutlarý(Select(seçme),Insert(ekleme),Update(güncelleme),Delete(silme))
--Insert [TabloAdý](Kolonlar) values (Deðerler)
Insert Personeller(Adi,SoyAdi) values ('Ozan','Kaya')

--Personeller tablosuna yeni bir kayýt eklemek istiyorsan (Kolonlar kýsmýný yazmadan Deðerler kýsmýný tablodaki tüm kolonlarý dolduracak þekilde doldurman gerekir)

--Birden fazla veriyi pratik bir þekilde eklemek için
Insert Personeller(Adi,SoyAdi) values ('Hilmi','X'),('Necati','Y'),('Rýfký','Z')

--Insert komutu ile select sorgusu sonucunda gelen verileri farklý tabloya kaydetme
--Insert OrnekPersoneller1 Select Adi,Soyadi from Personeller

--Select sorgusu sonucu dönen verilerifarklý bir tablo oluþturarak kaydetme
Select Adi,SoyAdi into OrnekPersoneller from Personeller
--(Bu yöntem ile primary ve foreign keyler oluþturulamaz)

--Update
--Update[TabloAdi] Set[Kolon Adi] = Deðer

--OrnekPersoneller tablosundaki kayýtlarýn hepsinin adýný Mehmet yap
Update OrnekPersoneller Set Adi='Mehmet'

--OrnekPersoneller tablosundaki adý Mehmet olan degerleri 'Nancy' olarak güncelle
Update OrnekPersoneller Set Adi='Nancy' where Adi='Mehmet'

--Update sorgusunda join yapýlarýný kullanarak birden fazla tabloda güncelleme yapmak
Update Urunler Set UrunAdi = k.KategoriAdi from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID

--Update sorgusunda subquery(altsorgu-Sorgunun içinde sorgu olmasý durumu) ile güncelleme yapmak
--Urunler tablosundaki urunlerin adlarýný personel tablosundaki id'si 3 olan personelin adý yap
Update Urunler Set UrunAdi = (Select Adi from Personeller where PersonelID=3)

--Update sorgusunda Top keywordü ile güncelleme yapmak
--Urunler tablosundaki ilk 30 ürünün adýný X yap
Update Top(30) Urunler Set UrunAdi='X'

--Delete
--Delete from [TabloAdi]
Delete from OrnekPersoneller

--OrnekPersoneller tablosundaki soyadý Kaya olan kaydý sil
Delete from OrnekPersoneller where SoyAdi='Kaya'

---!!!!!!ÖNEMLÝ/Update ve Delete sorgularýnda þart yazmak önemlidir!!!!!!

--Union komutu(Birden fazla select sorgusu sonucunu tek seferde alt alta göstermemizi saðlar)
Select Adi,SoyAdi from Personeller
Union
Select MusteriAdi,MusteriUnvani from Musteriler

--Dikkat edilmesi gerekenler
--Joinler yan yana birleþtirirken unionlar alt alta birleþtirme yapar.Joinlerde belirli bir(iliþkisel) kolon üzerinden birleþtirme yapýlýrken unionda böyle bir durum yoktur
--Union sorgusunun sonucunda oluþan tablonun kolon isimleri üstteki sorgunun kolon isimleri ile aynýdýr
--Üstteki sorgudan kaç adet kolon çekildiyse alttaki sorgudan da o kadar kolon çekilmelidir.
--Üstteki sorgudan çekilen kolonlarýn tipleri ile alttaki sorgudan çekilen kolonlarýn tipleri ayný olmak zorundadýr
--Union tekrarlý kayýtlarý getirmez

--Union All
--Tekrarlý kayýtlarý getirmek için Union All kullanýlýr
Select Adi,SoyAdi from Personeller
Union All 
Select Adi,SoyAdi from Personeller

--With Rollup(Group by ile gruplanmýþ veri kümesinde ara toplam alýnmasýný saðlar)
--Satýþlarda toplam kaç adet ürün satýlmýþ?
Select SatisID,UrunID,SUM(Miktar)[Urun Miktarý] from [Satis Detaylari] group by SatisID,UrunID with rollup

--Having þartýyla beraber with rollup kullanýmý
--Satýþlarda toplam kaç adet ürün satýlmýþ?(100den fazla olanlarý getir)
Select SatisID,UrunID,SUM(Miktar)[Urun Miktarý] from [Satis Detaylari] group by SatisID,UrunID with rollup having SUM(Miktar) >100

--With Cube(Group by ile gruplanmýþ veri kümesinde teker teker toplam alýnmasýný saðlar)
--Satýþlarda toplam kaç adet ürün satýlmýþ?Urunýdye göre sýralar ve sonunda toplar
Select SatisID,UrunID,SUM(Miktar)[Urun Miktarý] from [Satis Detaylari] group by SatisID,UrunID with cube

--Sorgularda Þart Kalýplarý(Case-When-Else-End)
--Personellerin ad ve soyadlarýnýn yanýnda;Unvan eki 'Mr' veya 'Mrs' olarak yazsýn
Select Adi,SoyAdi,
Case
When UnvanEki ='Mrs.' or UnvanEki='Ms.' Then 'Kadýn'
When UnvanEki ='Mr.' Then 'Erkek'
Else UnvanEki
End
from Personeller

--Eðer ürünün birim fiyatý 0-50 arasý ise 'Çin Malý',50-100 arasý ise 'Ucuz',100-200 arasý ise 'Normal',200den fazla ise 'Pahalý' yazsýn
Select BirimFiyati,
Case
When BirimFiyati Between 0 and 50 Then 'Çin Malý'
When BirimFiyati Between 50 and 100 Then 'Ucuz'
When BirimFiyati Between 100 and 200 Then 'Normal'
When BirimFiyati > 200 Then 'Pahalý'
Else 'Belirsiz'
End 
from Urunler

--With Ties
--Satis Detaylari sayfasindaki ilk 6 komutu getir
Select top 6 * from [Satis Detaylari]

--Satis Detaylari sayfasindaki ilk 6 komutu getir ama 6.satýrla ayný satýs ýd'deki de getir
Select top 6 with ties * from [Satis Detaylari] order by SatisID

--With Komutu(Anlýk olarak kullanýp iþimizi hallettiðimiz veritabanýnda herhangi bir deðiþikliðe sebep olmayan komuttur ,kaydedilmez.Kompleks sorgularda kullanýlýr)


--Aþaðýdaki sorguda 2 adet tabloyu birleþtirdik 
Select * from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID


--Varsayalýmki üçüncü tabloyu da birleþtirmek istiyoruz ancak sorgu kompleks bir hale dönüþmeye baþlýyor
--Sorgunun okunabilirliðini artýrmak için 
With PersonelSatis(id,adi,soyadi,satisid)
as
(
Select p.PersonelID,Adi,SoyAdi,SatisID from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID
)
Select * from PersonelSatis
--PersonelSatis adýnda ilgili parametreleri kolon olarak barýndýran bir tablo oluþturduk gibi düþünebilirsin.


--Subquery(Ýçiçe sorgular-Herhangi bir sorgunun çýktýsý baþka bir sorgunun girdisi olabilir)
--Burada dikkat edilmesi gereken nokta sub olan sorgunun yani içteki sorgunun döneceði deðerin sadece 1 adet olmasý gerektiðidir
--Adi Nancy olan personelin satýslarýný getir
Select SatisID,SatisTarihi from Satislar where PersonelID = (Select PersonelID from Personeller where Adi='Nancy')

--BulkInsert(Harici bir kaynaktan tablomuza veri ekleme)
--Kisiler tablosuna belirttiðimiz yoldaki dosyanýn içindeki verileri aktarýr.Burada dosyanýn içindeki veriler tabloya uygun olmalýdýr.
Bulk Insert Kisiler
From 'D:\Kisiler.txt'
With
(
   FieldTerminator = '\t',
   RowTerminator ='\n'
)
