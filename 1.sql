--Veritabaný seçmek için Use kullanýlýr
Use Northwind

--Print komutu (Verdiðimiz herhnagi bir deðeri mesaj olarak geri döndüren komuttur)
Print 'Asli'

--Select komutu(Verdiðimiz herhangi bir deðeri tablo olarak geri döndüren komuttur)
Select 3
Select 'Asli'
Select 'Asli',28

--Personeller tablosundaki tüm kolonlarý getir
Select * from Personeller

--Personeller tablosundaki Adi,Soyadi kolonlarýndaki verileri getir
Select Adi,SoyAdi from Personeller

--Alias(Kolon ismi) atama
Select 3 as Deger
Select Adi Ýsimler,SoyAdi Soyisimler from Personeller
Select 1453 [Ýstanbulun Fethi]

--Alias atamalarýnda ve tablo isimlerini çaðýrýrken bu ikisinin içerisinde boþluk varsa parantez kullanýlmalýdýr
Select * from [Satis Detaylari]

--Kolonlarý birleþtirme
Select Adi + ' ' + SoyAdi [Personel Bilgileri] from Personeller

--Farklý tipte kolonlarý birleþtirme
Select Adi + ' ' + CONVERT(nvarchar, IseBaslamaTarihi) from Personeller

--Select sorgularýnda (Where) þartý yazmak
--Personeller tablosunda þehri London olan verileri getir
Select * from Personeller where Sehir ='London'

--Personeller tablosunda baglý çalýþtýðý kiþi sayýsý 5'ten küçük olanlarý listele
Select * from Personeller where BagliCalistigiKisi < 5

--Personeller tablosunda sehri London ve ülkesi UK olanlarý listele
Select * from Personeller where Sehir='London' and Ulke='UK'

--Personeller tablosunda UnvanEki 'Mr' olanlarý veya Þehri 'Seattle' olan tüm personelleri listele
Select * from Personeller where UnvanEki='Mr.' or Sehir='Seattle'

--Personeller tablosunda Adi 'Robert' Soyadi 'King' olan personelin tüm bilgilerini çek
Select * from Personeller where Adi='Robert' and SoyAdi='King'

--Personeller tablosunda Personel id'si 5 olan personeli getir
Select * from Personeller where PersonelID=5

--Personeller tablosunda Personel id'si 5ten büyük olan tüm personelleri getir
Select * from Personeller where PersonelID >5

--Fonksiyonsonuçlarýný þart olarak kullanmak
--Personeller tablosunda 1993 yýlýnda iþe baþlayan personellerin tüm bilgilerini getir
Select * from Personeller where YEAR(IseBaslamaTarihi) = 1993

--Personeller tablosunda 1992 yýlýndan sonra iþe baþlayan personel bilgilerini getir
Select * from Personeller where YEAR(IseBaslamaTarihi) > 1992

--Personeller tablosunda doðum günü ayýn 29u olmayan personelleri listele
Select * from Personeller where DAY(DogumTarihi) <> 29

--Personeller tablosunda dogum yýlý 1950 ile 1965 yýllarý arasýnda olan personelleri listele
Select * from Personeller where YEAR(DogumTarihi) > 1950 and YEAR(DogumTarihi) < 1965

--Personeller tablosundan London ,Tacoma ve Kirkland þehirlerinde yaþayan personellerin adlarýný listele
Select Adi from Personeller where Sehir='London' or Sehir='Tacoma' or Sehir='Kirkland'

--Between komutu
--Personeller tablosunda dogum yýlý 1950 ile 1965 yýllarý arasýnda olan personelleri listele
Select * from Personeller where YEAR(DogumTarihi) between 1950 and 1965

--In komutu
--Personeller tablosundan London ,Tacoma ve Kirkland þehirlerinde yaþayan personellerin adlarýný listele
Select Adi from Personeller where Sehir In('London','Tacoma','Kirkland')

--Like ile kolonlar içerisindeki verilere belirli þartlar koyma
--% Operatörü
--Personeller tablosundan isminin baþ harfi j olan personellerin adýný ve soyadýný yazdýr
Select Adi,SoyAdi from Personeller where Adi like 'j%'

--Personeller tablosundan isminin son harfi y olan personellerin adýný ve soyadýný yazdýr
Select Adi,SoyAdi from Personeller where Adi like '%y'

--Personeller tablosundan isminin son üç harfi ert olan personeli getir
Select * from Personeller where Adi like '%ert'

--Personeller tablosundan isminin ilk harfi r ,son harfi t olan personeli getir
Select * from Personeller where Adi like 'r%t'

--Personeller tablosunda isminde an geçen personelin adýný yazdýralým
Select Adi from Personeller where Adi like '%an%'

--Personeller tablosunda isminin baþ harfi n olan ve içerisinde an geçen personeli getir
Select * from Personeller where Adi like 'n%an%'

--Personeller tablosunda isminin ilk harfi a ikinci harfi farketmez üçüncü harfi d olan personeli getir
Select * from Personeller where Adi like 'a_d%'

--Personeller tablosunda isminin ilk harfi m ya da n ya da r olan personelleri getir
Select * from Personeller where Adi like '[nmr]%'

--Personeller tablosunda isminde a ya da i geçen personelleri getir
Select * from Personeller where Adi like '%[ai]%'

--Personeller tablosunda baþ harfi a ile k arasýnda alfabetik sýraya göre herhangi bir harf olan personellerin adýný getir
Select Adi from Personeller where Adi like '[a-k]%'

--Personeller tablosunda isminin baþ harfi a olmayan personelleri getir
Select * from Personeller where Adi like '[^a]%'

--Escape(Kaçýþ) karakterleri
--Personeller tablosunda ismin baþ harfi _olan personeli getir
Select * from Personeller where Adi like '[_]%'
Select * from Personeller where Adi like '?_%' escape '?'

--Aggregate Fonksiyonlarý(Bir tablodaki tüm veriler üzerinde iþlem yapmamýzý saðlayan fonksiyonlardýr.Bu fonksiyonlar avg,max,min,count,sum fonksiyonlarýdýr)
--Personeller tablosundaki personellerin idlerinin ortalamasý nedir?
Select AVG(PersonelID) from Personeller

--Personeller tablosundaki personellerin idlerinden en büyük olaný nedir?
Select MAX(PersonelID) from Personeller

--Personeller tablosundaki personellerin idlerinden en küçük olaný nedir?
Select MIN(PersonelID) from Personeller

--Personeller tablosunda kaç adet personel vardýr?
Select COUNT(Adi) from Personeller

--Satiþlar tablosundaki nakliye ücretlerinin toplamý nedir?
Select SUM(NakliyeUcreti) from Satislar

--String Fonksiyonlarý
--LEFT(Soldan belirtilen sayýda karakter getirir)
--Personeller tablosundaki personellerin adlarýnýn ilk 2 karakterini getir
Select LEFT(Adi,2) from Personeller

--RIGHT(Saðdan belirtilen sayýda karakter getirir)
--Personeller tablosundaki personellerin adlarýnýn son 3 karakterini getir
Select RIGHT(Adi,3) from Personeller

--UPPER(Büyük harfe çevirir)
--Personel tablosundaki personellerin adlarýný büyük harfe çevrilmiþ þekilde getir
Select UPPER(Adi) from Personeller

--LOWER(Küçük harfe çevirir)
--Personel tablosundaki personellerin adlarýný küçük harfe çevrilmiþ þekilde getir
Select LOWER(Adi) from Personeller

--SUBSTRÝNG(Belirtilen indeksten itibaren belirtilen sayýda karakter getirir)
--Personeller tablosundaki personellerin soyadlarýný 3.karakterden baþlayarak 2 karakter getirecek þekilde getir
Select SUBSTRING(SoyAdi,3,2) from Personeller

--LTRÝM(Soldan boþluklarý keser)
Select '        Asli'
Select LTRIM('       Asli')

--RTRÝM(Saðdan boþluklarý keser)
Select 'Asli       '
Select LTRIM('Asli         ')

--REVERSE(Tersine çevirir)
--Personeller tablosundaki personellerin adlarýný tersten yazdýr
Select REVERSE(Adi) from Personeller

--REPLACE(Belirtilen ifadeyi belirtilen ifade ile deðiþtirir)
Select REPLACE('Benim adým Asli','Asli','Ashle')

--CHARINDEX(Belirtilen karakterin veri içindeki sýrasýný verir)
--Musteriler tablosundaki musteri adýný ve müsteri adýndan sonra gelen boþluk karakterinin sýrasýný yazdýr
Select MusteriAdi,CHARINDEX(' ',MusteriAdi) from Musteriler

--Müsteriler tablosunun müsteri adý kolunundan sadece adlarý çekelim
Select LEFT(MusteriAdi,CHARINDEX(' ',MusteriAdi)) from Musteriler

--Müsteriler tablosunun müsteri adý kolunundan sadece soyadlarý çekelim
Select RIGHT(MusteriAdi,CHARINDEX(' ',REVERSE(MusteriAdi))) from Musteriler

--SAYISAL FONKSÝYONLAR
--PI Fonksiyonu
Select PI()

--SIN(Sinus alýr)
Select SIN(90)

--POWER(Üst alýr)
--2 üssü 3
Select POWER(2,3)

--ABS(Mutlak deðer alýr)
Select ABS(-10)

--RAND( 0-1 arasýnda rastgele sayý üretir)
Select RAND()

--FLOOR(Yuvarlama yapar)
Select FLOOR(RAND()*100)

--Tarih Fonksiyonlarý
--GETDATE() Bugünün tarihini verir
Select GETDATE()

--DATEADD(Verilen tarihe verildiði kadar gün,ay, yýl ekler)
Select DATEADD(DAY,999,GETDATE())

--DATEDIFF(Ýki tarih arasýndaki günü,ayý,yýlý hesaplar)
Select DATEDIFF(DAY,'12.26.2021',GETDATE())

--DATEPART(Verilen tarihin haftanýn ayýn yada yýlýn kaçýncý günü olduðunu hesaplar)
Select DATEPART(DAY,GETDATE())

--Top Komutu(Select sorgusu sonucu elde ettiðimiz tablodan belirttiðimiz sayý kadar veri getirir)
--Personeller tablosundaki verilerden ilk 3ünü getir
Select TOP 3 * from Personeller 

--Distinct Komutu(Bir kolondaki bener olan verileri teke indirmemizi saðlayan komuttur)
Select DISTINCT Sehir from Personeller

--GROUP BY
--Eðer bir select sorgusunda bir normal kolon birde aggregate fonksiyonu kullanýlýyorsa group by kullanmanýz gerekir
--Urunler tablosunda hangi kategoriden kaç adet ürün var
Select KategoriID,COUNT(*) from Urunler group by KategoriID

--Group by iþleminde where þartý yazma
--Urunler tablosunda kategori idsi 5den büyük kaç adet ürün var
Select KategoriID,COUNT(*) from Urunler where KategoriID>5 group by KategoriID
 
 --HAVING KOMUTU(Aggregate üzerinde þart uygulayacaksak kullandýðýmýz bir komuttur)
 --Urunler tablosunda kategori idsi 5den büyük ve sayýsý 10dan fazla olan ürün sayýlarý
Select KategoriID,COUNT(*) from Urunler where KategoriID>5 group by KategoriID having COUNT(*)>10

--Tablolarý yanyana birleþtirme
Select * from Personeller,Satislar --(Herbir satýra eþ gelecek yeni bir satýr üretiyor üretemediklerine de null atýyor)

--Personeller ve Satislar tablolarýný birleþtir ve Personel tablosundaki PersonelIdleri getir
Select Personeller.PersonelID from Personeller,Satislar

--Personeller ve Satislar tablolarýný birleþtir ve Satis tablosundaki PersonelIdleri getir
Select s.PersonelID from Personeller p,Satislar s

--Personeller ve satislar tablolarýndaki ayný personelidye sahip olan verilerden Personel tablosundaki personelidleri ve satis tablosundan musteri idlerini getir
Select p.PersonelID ,s.MusteriID from Personeller p,Satislar s where p.PersonelID = s.PersonelID 