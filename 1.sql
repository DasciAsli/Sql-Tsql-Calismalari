--Veritaban� se�mek i�in Use kullan�l�r
Use Northwind

--Print komutu (Verdi�imiz herhnagi bir de�eri mesaj olarak geri d�nd�ren komuttur)
Print 'Asli'

--Select komutu(Verdi�imiz herhangi bir de�eri tablo olarak geri d�nd�ren komuttur)
Select 3
Select 'Asli'
Select 'Asli',28

--Personeller tablosundaki t�m kolonlar� getir
Select * from Personeller

--Personeller tablosundaki Adi,Soyadi kolonlar�ndaki verileri getir
Select Adi,SoyAdi from Personeller

--Alias(Kolon ismi) atama
Select 3 as Deger
Select Adi �simler,SoyAdi Soyisimler from Personeller
Select 1453 [�stanbulun Fethi]

--Alias atamalar�nda ve tablo isimlerini �a��r�rken bu ikisinin i�erisinde bo�luk varsa parantez kullan�lmal�d�r
Select * from [Satis Detaylari]

--Kolonlar� birle�tirme
Select Adi + ' ' + SoyAdi [Personel Bilgileri] from Personeller

--Farkl� tipte kolonlar� birle�tirme
Select Adi + ' ' + CONVERT(nvarchar, IseBaslamaTarihi) from Personeller

--Select sorgular�nda (Where) �art� yazmak
--Personeller tablosunda �ehri London olan verileri getir
Select * from Personeller where Sehir ='London'

--Personeller tablosunda bagl� �al��t��� ki�i say�s� 5'ten k���k olanlar� listele
Select * from Personeller where BagliCalistigiKisi < 5

--Personeller tablosunda sehri London ve �lkesi UK olanlar� listele
Select * from Personeller where Sehir='London' and Ulke='UK'

--Personeller tablosunda UnvanEki 'Mr' olanlar� veya �ehri 'Seattle' olan t�m personelleri listele
Select * from Personeller where UnvanEki='Mr.' or Sehir='Seattle'

--Personeller tablosunda Adi 'Robert' Soyadi 'King' olan personelin t�m bilgilerini �ek
Select * from Personeller where Adi='Robert' and SoyAdi='King'

--Personeller tablosunda Personel id'si 5 olan personeli getir
Select * from Personeller where PersonelID=5

--Personeller tablosunda Personel id'si 5ten b�y�k olan t�m personelleri getir
Select * from Personeller where PersonelID >5

--Fonksiyonsonu�lar�n� �art olarak kullanmak
--Personeller tablosunda 1993 y�l�nda i�e ba�layan personellerin t�m bilgilerini getir
Select * from Personeller where YEAR(IseBaslamaTarihi) = 1993

--Personeller tablosunda 1992 y�l�ndan sonra i�e ba�layan personel bilgilerini getir
Select * from Personeller where YEAR(IseBaslamaTarihi) > 1992

--Personeller tablosunda do�um g�n� ay�n 29u olmayan personelleri listele
Select * from Personeller where DAY(DogumTarihi) <> 29

--Personeller tablosunda dogum y�l� 1950 ile 1965 y�llar� aras�nda olan personelleri listele
Select * from Personeller where YEAR(DogumTarihi) > 1950 and YEAR(DogumTarihi) < 1965

--Personeller tablosundan London ,Tacoma ve Kirkland �ehirlerinde ya�ayan personellerin adlar�n� listele
Select Adi from Personeller where Sehir='London' or Sehir='Tacoma' or Sehir='Kirkland'

--Between komutu
--Personeller tablosunda dogum y�l� 1950 ile 1965 y�llar� aras�nda olan personelleri listele
Select * from Personeller where YEAR(DogumTarihi) between 1950 and 1965

--In komutu
--Personeller tablosundan London ,Tacoma ve Kirkland �ehirlerinde ya�ayan personellerin adlar�n� listele
Select Adi from Personeller where Sehir In('London','Tacoma','Kirkland')

--Like ile kolonlar i�erisindeki verilere belirli �artlar koyma
--% Operat�r�
--Personeller tablosundan isminin ba� harfi j olan personellerin ad�n� ve soyad�n� yazd�r
Select Adi,SoyAdi from Personeller where Adi like 'j%'

--Personeller tablosundan isminin son harfi y olan personellerin ad�n� ve soyad�n� yazd�r
Select Adi,SoyAdi from Personeller where Adi like '%y'

--Personeller tablosundan isminin son �� harfi ert olan personeli getir
Select * from Personeller where Adi like '%ert'

--Personeller tablosundan isminin ilk harfi r ,son harfi t olan personeli getir
Select * from Personeller where Adi like 'r%t'

--Personeller tablosunda isminde an ge�en personelin ad�n� yazd�ral�m
Select Adi from Personeller where Adi like '%an%'

--Personeller tablosunda isminin ba� harfi n olan ve i�erisinde an ge�en personeli getir
Select * from Personeller where Adi like 'n%an%'

--Personeller tablosunda isminin ilk harfi a ikinci harfi farketmez ���nc� harfi d olan personeli getir
Select * from Personeller where Adi like 'a_d%'

--Personeller tablosunda isminin ilk harfi m ya da n ya da r olan personelleri getir
Select * from Personeller where Adi like '[nmr]%'

--Personeller tablosunda isminde a ya da i ge�en personelleri getir
Select * from Personeller where Adi like '%[ai]%'

--Personeller tablosunda ba� harfi a ile k aras�nda alfabetik s�raya g�re herhangi bir harf olan personellerin ad�n� getir
Select Adi from Personeller where Adi like '[a-k]%'

--Personeller tablosunda isminin ba� harfi a olmayan personelleri getir
Select * from Personeller where Adi like '[^a]%'

--Escape(Ka���) karakterleri
--Personeller tablosunda ismin ba� harfi _olan personeli getir
Select * from Personeller where Adi like '[_]%'
Select * from Personeller where Adi like '?_%' escape '?'

--Aggregate Fonksiyonlar�(Bir tablodaki t�m veriler �zerinde i�lem yapmam�z� sa�layan fonksiyonlard�r.Bu fonksiyonlar avg,max,min,count,sum fonksiyonlar�d�r)
--Personeller tablosundaki personellerin idlerinin ortalamas� nedir?
Select AVG(PersonelID) from Personeller

--Personeller tablosundaki personellerin idlerinden en b�y�k olan� nedir?
Select MAX(PersonelID) from Personeller

--Personeller tablosundaki personellerin idlerinden en k���k olan� nedir?
Select MIN(PersonelID) from Personeller

--Personeller tablosunda ka� adet personel vard�r?
Select COUNT(Adi) from Personeller

--Sati�lar tablosundaki nakliye �cretlerinin toplam� nedir?
Select SUM(NakliyeUcreti) from Satislar

--String Fonksiyonlar�
--LEFT(Soldan belirtilen say�da karakter getirir)
--Personeller tablosundaki personellerin adlar�n�n ilk 2 karakterini getir
Select LEFT(Adi,2) from Personeller

--RIGHT(Sa�dan belirtilen say�da karakter getirir)
--Personeller tablosundaki personellerin adlar�n�n son 3 karakterini getir
Select RIGHT(Adi,3) from Personeller

--UPPER(B�y�k harfe �evirir)
--Personel tablosundaki personellerin adlar�n� b�y�k harfe �evrilmi� �ekilde getir
Select UPPER(Adi) from Personeller

--LOWER(K���k harfe �evirir)
--Personel tablosundaki personellerin adlar�n� k���k harfe �evrilmi� �ekilde getir
Select LOWER(Adi) from Personeller

--SUBSTR�NG(Belirtilen indeksten itibaren belirtilen say�da karakter getirir)
--Personeller tablosundaki personellerin soyadlar�n� 3.karakterden ba�layarak 2 karakter getirecek �ekilde getir
Select SUBSTRING(SoyAdi,3,2) from Personeller

--LTR�M(Soldan bo�luklar� keser)
Select '        Asli'
Select LTRIM('       Asli')

--RTR�M(Sa�dan bo�luklar� keser)
Select 'Asli       '
Select LTRIM('Asli         ')

--REVERSE(Tersine �evirir)
--Personeller tablosundaki personellerin adlar�n� tersten yazd�r
Select REVERSE(Adi) from Personeller

--REPLACE(Belirtilen ifadeyi belirtilen ifade ile de�i�tirir)
Select REPLACE('Benim ad�m Asli','Asli','Ashle')

--CHARINDEX(Belirtilen karakterin veri i�indeki s�ras�n� verir)
--Musteriler tablosundaki musteri ad�n� ve m�steri ad�ndan sonra gelen bo�luk karakterinin s�ras�n� yazd�r
Select MusteriAdi,CHARINDEX(' ',MusteriAdi) from Musteriler

--M�steriler tablosunun m�steri ad� kolunundan sadece adlar� �ekelim
Select LEFT(MusteriAdi,CHARINDEX(' ',MusteriAdi)) from Musteriler

--M�steriler tablosunun m�steri ad� kolunundan sadece soyadlar� �ekelim
Select RIGHT(MusteriAdi,CHARINDEX(' ',REVERSE(MusteriAdi))) from Musteriler

--SAYISAL FONKS�YONLAR
--PI Fonksiyonu
Select PI()

--SIN(Sinus al�r)
Select SIN(90)

--POWER(�st al�r)
--2 �ss� 3
Select POWER(2,3)

--ABS(Mutlak de�er al�r)
Select ABS(-10)

--RAND( 0-1 aras�nda rastgele say� �retir)
Select RAND()

--FLOOR(Yuvarlama yapar)
Select FLOOR(RAND()*100)

--Tarih Fonksiyonlar�
--GETDATE() Bug�n�n tarihini verir
Select GETDATE()

--DATEADD(Verilen tarihe verildi�i kadar g�n,ay, y�l ekler)
Select DATEADD(DAY,999,GETDATE())

--DATEDIFF(�ki tarih aras�ndaki g�n�,ay�,y�l� hesaplar)
Select DATEDIFF(DAY,'12.26.2021',GETDATE())

--DATEPART(Verilen tarihin haftan�n ay�n yada y�l�n ka��nc� g�n� oldu�unu hesaplar)
Select DATEPART(DAY,GETDATE())

--Top Komutu(Select sorgusu sonucu elde etti�imiz tablodan belirtti�imiz say� kadar veri getirir)
--Personeller tablosundaki verilerden ilk 3�n� getir
Select TOP 3 * from Personeller 

--Distinct Komutu(Bir kolondaki bener olan verileri teke indirmemizi sa�layan komuttur)
Select DISTINCT Sehir from Personeller

--GROUP BY
--E�er bir select sorgusunda bir normal kolon birde aggregate fonksiyonu kullan�l�yorsa group by kullanman�z gerekir
--Urunler tablosunda hangi kategoriden ka� adet �r�n var
Select KategoriID,COUNT(*) from Urunler group by KategoriID

--Group by i�leminde where �art� yazma
--Urunler tablosunda kategori idsi 5den b�y�k ka� adet �r�n var
Select KategoriID,COUNT(*) from Urunler where KategoriID>5 group by KategoriID
 
 --HAVING KOMUTU(Aggregate �zerinde �art uygulayacaksak kulland���m�z bir komuttur)
 --Urunler tablosunda kategori idsi 5den b�y�k ve say�s� 10dan fazla olan �r�n say�lar�
Select KategoriID,COUNT(*) from Urunler where KategoriID>5 group by KategoriID having COUNT(*)>10

--Tablolar� yanyana birle�tirme
Select * from Personeller,Satislar --(Herbir sat�ra e� gelecek yeni bir sat�r �retiyor �retemediklerine de null at�yor)

--Personeller ve Satislar tablolar�n� birle�tir ve Personel tablosundaki PersonelIdleri getir
Select Personeller.PersonelID from Personeller,Satislar

--Personeller ve Satislar tablolar�n� birle�tir ve Satis tablosundaki PersonelIdleri getir
Select s.PersonelID from Personeller p,Satislar s

--Personeller ve satislar tablolar�ndaki ayn� personelidye sahip olan verilerden Personel tablosundaki personelidleri ve satis tablosundan musteri idlerini getir
Select p.PersonelID ,s.MusteriID from Personeller p,Satislar s where p.PersonelID = s.PersonelID 