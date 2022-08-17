use Northwind

--JO�N ��LEMLER�(Birden fazla tabloyu birle�tirip tek bir tablo elde etmemizi sa�larlar)

--�nner Join(Birden fazla tabloyu ili�kisel kolonlar yard�m�yla birle�tirip tek bir tablo haline getirir)
--Genel Mant�k
--Select * from Tablo1 inner join Tablo2 on Tablo1.�liskilikolon =Tablo2.�liskilikolon
--Tablolara alias tan�mlanabilir
--Select * from Tablo1 t1 inner join Tablo2 t2 on t1.�liskilikolon =t2.�liskilikolon

--Hangi personel hangi sat��lar� yapm��t�r?
Select p.Adi,s.SatisID from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID

--Hangi �r�n hangi kategoride?
Select u.UrunAdi,k.KategoriAdi from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID

--Beverages kategorisindeki �r�nleri s�rala
Select u.UrunAdi from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID where k.KategoriAdi='Beverages'

--Beverages kategorisindeki urunlerin say�s�n� getir
Select COUNT(*) from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID where k.KategoriAdi='Beverages'

--Seafood kategorisindeki �r�nlerin listesini getir
Select u.UrunAdi from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID where k.KategoriAdi='Seafood'

--Hangi sat��� hangi �al��an yapm��
Select s.SatisID,p.Adi + ' ' + p.SoyAdi [Personel Bilgisi] from Satislar s inner join Personeller p on s.PersonelID=p.PersonelID

--Faks numaras� null olmayan tedarik�ilerden al�nm�� �r�nler nelerdir?
Select u.UrunAdi,t.Faks from Urunler u inner join Tedarikciler t on u.TedarikciID=t.TedarikciID where T.Faks<>'NULL'

--2den fazla tabloyu inner join ile birle�tirme
--1997 y�l�ndan sonra Nancynin sat�� yapt�� firmalar�n isimleri (1997 dahil)
Select P.Adi,S.SatisTarihi, M.SirketAdi from Satislar s inner join Personeller p on s.PersonelID=p.PersonelID inner join Musteriler m on s.MusteriID=m.MusteriID where p.Adi='Nancy' and YEAR(S.SatisTarihi)>=1997

--Limited olan tedarik�ilerden al�nm�� seafood kategorisindeki �r�nlerimin toplam sat�� tutar�
Select SUM(u.HedefStokDuzeyi*u.BirimFiyati) from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID inner join Tedarikciler t on u.TedarikciID=t.TedarikciID where t.SirketAdi like '%Ltd.%' and k.KategoriAdi='Seafood'

--Ayn� tabloyu ili�kisel olarak birle�tirme
--Personellerimin ba�l� olarak �al��t��� ki�ileri listele(Personeller,Personeller)
Select p1.Adi,p2.Adi from Personeller p1 inner join Personeller p2 on p1.BagliCalistigiKisi=p2.PersonelID

--Hangi personel(Ad,Soyad) toplam ka� adet sat�� yapm��.Sat�� adeti 100den fazla olan ve personel ad� M ile ba�layanlar� getir
Select p.Adi +' ' + p.SoyAdi,COUNT(s.SatisID) from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID where p.Adi like 'M%' group by p.Adi +' ' + p.SoyAdi having COUNT(s.SatisID)>100

--Seafood kategorisindeki �r�nlerin say�s�
Select k.KategoriAdi,COUNT(u.UrunAdi)[Urun sayisi] from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID where k.KategoriAdi='Seafood' group by k.KategoriAdi

--Hangi personel toplam ka� adet sat�� yapm��
Select p.Adi,COUNT(s.SatisID) from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID group by p.Adi

--En �ok sat�� yapan personel
Select top 1 p.Adi,COUNT(s.SatisID) from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID group by p.Adi order by COUNT(s.SatisID) desc

--Outer join(Left,Right,Full)
--�nner join ile sadece iki tablodaki e�le�en kay�tlar� getirebiliyorduk ancak e�le�meyen k�s�mlar� da getirebilmek i�in outer join kullan�yoruz
--Select * from Filmler f left join Oyuncular o on f.FilmId=o.FilmId

--DML(Data Manipulation Language) Komutlar�(Select(se�me),Insert(ekleme),Update(g�ncelleme),Delete(silme))
--Insert [TabloAd�](Kolonlar) values (De�erler)
Insert Personeller(Adi,SoyAdi) values ('Ozan','Kaya')

--Personeller tablosuna yeni bir kay�t eklemek istiyorsan (Kolonlar k�sm�n� yazmadan De�erler k�sm�n� tablodaki t�m kolonlar� dolduracak �ekilde doldurman gerekir)

--Birden fazla veriyi pratik bir �ekilde eklemek i�in
Insert Personeller(Adi,SoyAdi) values ('Hilmi','X'),('Necati','Y'),('R�fk�','Z')

--Insert komutu ile select sorgusu sonucunda gelen verileri farkl� tabloya kaydetme
--Insert OrnekPersoneller1 Select Adi,Soyadi from Personeller

--Select sorgusu sonucu d�nen verilerifarkl� bir tablo olu�turarak kaydetme
Select Adi,SoyAdi into OrnekPersoneller from Personeller
--(Bu y�ntem ile primary ve foreign keyler olu�turulamaz)

--Update
--Update[TabloAdi] Set[Kolon Adi] = De�er

--OrnekPersoneller tablosundaki kay�tlar�n hepsinin ad�n� Mehmet yap
Update OrnekPersoneller Set Adi='Mehmet'

--OrnekPersoneller tablosundaki ad� Mehmet olan degerleri 'Nancy' olarak g�ncelle
Update OrnekPersoneller Set Adi='Nancy' where Adi='Mehmet'

--Update sorgusunda join yap�lar�n� kullanarak birden fazla tabloda g�ncelleme yapmak
Update Urunler Set UrunAdi = k.KategoriAdi from Urunler u inner join Kategoriler k on u.KategoriID=k.KategoriID

--Update sorgusunda subquery(altsorgu-Sorgunun i�inde sorgu olmas� durumu) ile g�ncelleme yapmak
--Urunler tablosundaki urunlerin adlar�n� personel tablosundaki id'si 3 olan personelin ad� yap
Update Urunler Set UrunAdi = (Select Adi from Personeller where PersonelID=3)

--Update sorgusunda Top keyword� ile g�ncelleme yapmak
--Urunler tablosundaki ilk 30 �r�n�n ad�n� X yap
Update Top(30) Urunler Set UrunAdi='X'

--Delete
--Delete from [TabloAdi]
Delete from OrnekPersoneller

--OrnekPersoneller tablosundaki soyad� Kaya olan kayd� sil
Delete from OrnekPersoneller where SoyAdi='Kaya'

---!!!!!!�NEML�/Update ve Delete sorgular�nda �art yazmak �nemlidir!!!!!!

--Union komutu(Birden fazla select sorgusu sonucunu tek seferde alt alta g�stermemizi sa�lar)
Select Adi,SoyAdi from Personeller
Union
Select MusteriAdi,MusteriUnvani from Musteriler

--Dikkat edilmesi gerekenler
--Joinler yan yana birle�tirirken unionlar alt alta birle�tirme yapar.Joinlerde belirli bir(ili�kisel) kolon �zerinden birle�tirme yap�l�rken unionda b�yle bir durum yoktur
--Union sorgusunun sonucunda olu�an tablonun kolon isimleri �stteki sorgunun kolon isimleri ile ayn�d�r
--�stteki sorgudan ka� adet kolon �ekildiyse alttaki sorgudan da o kadar kolon �ekilmelidir.
--�stteki sorgudan �ekilen kolonlar�n tipleri ile alttaki sorgudan �ekilen kolonlar�n tipleri ayn� olmak zorundad�r
--Union tekrarl� kay�tlar� getirmez

--Union All
--Tekrarl� kay�tlar� getirmek i�in Union All kullan�l�r
Select Adi,SoyAdi from Personeller
Union All 
Select Adi,SoyAdi from Personeller

--With Rollup(Group by ile gruplanm�� veri k�mesinde ara toplam al�nmas�n� sa�lar)
--Sat��larda toplam ka� adet �r�n sat�lm��?
Select SatisID,UrunID,SUM(Miktar)[Urun Miktar�] from [Satis Detaylari] group by SatisID,UrunID with rollup

--Having �art�yla beraber with rollup kullan�m�
--Sat��larda toplam ka� adet �r�n sat�lm��?(100den fazla olanlar� getir)
Select SatisID,UrunID,SUM(Miktar)[Urun Miktar�] from [Satis Detaylari] group by SatisID,UrunID with rollup having SUM(Miktar) >100

--With Cube(Group by ile gruplanm�� veri k�mesinde teker teker toplam al�nmas�n� sa�lar)
--Sat��larda toplam ka� adet �r�n sat�lm��?Urun�dye g�re s�ralar ve sonunda toplar
Select SatisID,UrunID,SUM(Miktar)[Urun Miktar�] from [Satis Detaylari] group by SatisID,UrunID with cube

--Sorgularda �art Kal�plar�(Case-When-Else-End)
--Personellerin ad ve soyadlar�n�n yan�nda;Unvan eki 'Mr' veya 'Mrs' olarak yazs�n
Select Adi,SoyAdi,
Case
When UnvanEki ='Mrs.' or UnvanEki='Ms.' Then 'Kad�n'
When UnvanEki ='Mr.' Then 'Erkek'
Else UnvanEki
End
from Personeller

--E�er �r�n�n birim fiyat� 0-50 aras� ise '�in Mal�',50-100 aras� ise 'Ucuz',100-200 aras� ise 'Normal',200den fazla ise 'Pahal�' yazs�n
Select BirimFiyati,
Case
When BirimFiyati Between 0 and 50 Then '�in Mal�'
When BirimFiyati Between 50 and 100 Then 'Ucuz'
When BirimFiyati Between 100 and 200 Then 'Normal'
When BirimFiyati > 200 Then 'Pahal�'
Else 'Belirsiz'
End 
from Urunler

--With Ties
--Satis Detaylari sayfasindaki ilk 6 komutu getir
Select top 6 * from [Satis Detaylari]

--Satis Detaylari sayfasindaki ilk 6 komutu getir ama 6.sat�rla ayn� sat�s �d'deki de getir
Select top 6 with ties * from [Satis Detaylari] order by SatisID

--With Komutu(Anl�k olarak kullan�p i�imizi halletti�imiz veritaban�nda herhangi bir de�i�ikli�e sebep olmayan komuttur ,kaydedilmez.Kompleks sorgularda kullan�l�r)


--A�a��daki sorguda 2 adet tabloyu birle�tirdik 
Select * from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID


--Varsayal�mki ���nc� tabloyu da birle�tirmek istiyoruz ancak sorgu kompleks bir hale d�n��meye ba�l�yor
--Sorgunun okunabilirli�ini art�rmak i�in 
With PersonelSatis(id,adi,soyadi,satisid)
as
(
Select p.PersonelID,Adi,SoyAdi,SatisID from Personeller p inner join Satislar s on p.PersonelID=s.PersonelID
)
Select * from PersonelSatis
--PersonelSatis ad�nda ilgili parametreleri kolon olarak bar�nd�ran bir tablo olu�turduk gibi d���nebilirsin.


--Subquery(��i�e sorgular-Herhangi bir sorgunun ��kt�s� ba�ka bir sorgunun girdisi olabilir)
--Burada dikkat edilmesi gereken nokta sub olan sorgunun yani i�teki sorgunun d�nece�i de�erin sadece 1 adet olmas� gerekti�idir
--Adi Nancy olan personelin sat�slar�n� getir
Select SatisID,SatisTarihi from Satislar where PersonelID = (Select PersonelID from Personeller where Adi='Nancy')

--BulkInsert(Harici bir kaynaktan tablomuza veri ekleme)
--Kisiler tablosuna belirtti�imiz yoldaki dosyan�n i�indeki verileri aktar�r.Burada dosyan�n i�indeki veriler tabloya uygun olmal�d�r.
Bulk Insert Kisiler
From 'D:\Kisiler.txt'
With
(
   FieldTerminator = '\t',
   RowTerminator ='\n'
)
