
--DEFAULT VALUES �LE SADECE IDENT�TY KOLONUNA VER� EKLEMEK
--E�erki veritaban�nda g�revi sadece di�er tablolar taraf�ndan 
--referans al�naca�� idleri �retecek ve bar�nd�racak olan bir tabloya ihtiyac�n�z varsa kullan�l�r. 

CREATE DATABASE ORNEKVER�TABANI

Create Table OrnekTablo
(
  Id int primary key identity,
  Kolon1 nvarchar(MAX),
  Kolon2 nvarchar(MAX)
)

use ORNEKVER�TABANI

Insert OrnekTablo
DEFAULT VALUES


--TOP KEYWORD� �LE UPDATE ��LEM�
Select * from OrnekTablo

--OrnekTablo tablosundaki ilk 2 de�erin Kolon3 de�erini 5 artt�r
Update Top(2) OrnekTablo set Kolon3 = Kolon3 +5


--OrnekTablo tablosundaki ilk 2 veriyi sil 
Delete Top(2) OrnekTablo 


--ANSI_NULLS Komutu
--ANSI_NULLS komutu,where �artlar�nda kontrol edilen e�itlik
--yahut e�it de�illik durumlar�nda null de�erlerin dikkate al�n�p al�nmayaca��n� belirlememizi sa�lar.
--'ON' de�eri verilirse Null de�erler dikkate al�nmaz.
--'OFF' de�eri verilirse Null de�erler dikkate al�n�r

SET ANSI_NULLS ON	
Select * from OrnekTablo where Kolon1 = Null

SET ANSI_NULLS OFF
Select * from OrnekTablo where Kolon1 = Null


--DYNAMIC DATA MASKING(VER� MASKELEME)
--Veritaban�m�zda ili�kisel tablolar�m�zda tuttu�umuz verileri tararken g�sterilmesi istenen d���ndaki verilerin maskelenmesi i�lemidir.
--Veriyi maskelemekten kast�m�z verinin orjinal halini yani fiziksel yap�s�n� de�i�tirmeden kullan�c�ya
--bir k�sm�n� g�stermek ya da gizlemektir.

--�rne�in bir al��veri� sitesinde kay�tl� kullan�c�n�n her bilgisine herkesin ula�mas�n� istemeyiz.
--B�yle durumlarda kullan�c�n�n �zelini te�kil edecek bilgiler yetkisi olmayan kullan�c�lara g�sterilmemelidir.
--Burada yetkisi olmayan kullan�c�ya kar�� yap�lm�� k�s�tlama asl�nda verilerin yoklu�u anlam�na gelmiyor
--Bilgiler var ama gizlenmektedirler.

--Normalde bu yetkilendirme i�lemi view ile yap�l�yordu ancak bu zahmetli bir yol oldu�u i�in 
--Sql Server 2016 ile Dynamic Data Masking �zelli�i geldi ve bizi bu zahmetten kurtarm�� oldu.

--3 parametre ile �al��maktad�r.
--1)Default Parametresi
--2)Email Parametresi
--3)Partial Parametresi


--1)Default Parametresi
--Metinsel : XXXX
--Say�sal  : 0000
--Tarihsel :01.01.2000 00:00:00.0000000
--Binary   : 0 -> ASCII


--2)Email Parametresi
--geny@gencayyildiz.com : 'gxxx@xxx.com'


--3)Partial Parametresi
--Partial(3,H,2)  
--Burada ilk 3 karakterin izlenmeyece�ini
--maskelemede h karakterinin kullanaca��n� 
--son 2 karakterin de izlenmeyece�ini belirtir.


Create Table Ogrenciler
(
   OgrenciId int Primary Key identity,
   Adi nvarchar(MAX) Masked With (Function = 'default()') Null,
   Soyadi nvarchar(MAX) Masked With (Function = 'default()') Null,
   Memleketi nvarchar(MAX) Masked With (Function = 'default()') Null,
   Email nvarchar(MAX) Masked With (Function = 'email()') Null,
   Hakkinda nvarchar(MAX) Masked With (Function = 'partial(3,"H",2)') Null,

)

Insert Ogrenciler Values ('Gen�ay','Y�ld�z','Artvin','gency@gencayyildiz.com','T�rk milletine can�m feda olsun')
Insert Ogrenciler Values ('Ay�e','Y�ld�r�m','Artvin','aysey@ayseyyildirim.com','B�t�n k�zlar topland�k')


Select * from Ogrenciler

--�u anda yetkili kullan�c� oldu�umuz i�in t�m bilgiler maskelenmeden geldi.

--Yap�lmas� gereken ilk i�lem bir kullan�c� olu�turmak 
--ve o kullan�c�n�n ogrenciler tablosunda sadece 
--select i�lemini yapmas�na izin verecek bir yetkilendirmesi olmas�d�r.

Create User YetkiliUser without Login --YetkiliUser isminde bir kullan�c� olu�turdu.
Go
Grant Select on Ogrenciler to YetkiliUser
--YetkiliUser isimli kullan�c�ya ogrenciler tablosunda select yetkisi verdik

Execute As User = 'YetkiliUser' --YetkiliUser isimli kullan�c�dayken
Select * from Ogrenciler


--ALTER �LE KOLONA DYNAMIC DATA MASKING UYGULAMA
Alter Table Ogrenciler
Add EkKolon nvarchar(MAX) Masked With (Function = 'partial(3,"XXX",0)')


--ALTER �LE DYNAMIC DATA MASKING KOLONUNDA DE����KL�K YAPMAK
Alter Table Ogrenciler
Alter Column EkKolon Add Masked With (Function = 'partial(2,"AA",4)')

--DYNAMIC DATA MASKING KALDIRMA
Alter Table Ogrenciler
Alter Column Email Drop Masked

--KULLANICIYA G�RE DYNAMIC DATA MASKING �ZELL���N� PAS�FLE�T�RME
Grant Unmask to YetkiliUser

Execute As User = 'YetkiliUser'
Select * from Ogrenciler
