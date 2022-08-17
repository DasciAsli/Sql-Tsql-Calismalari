
--WITH SCHEMABINDING KOMUTU

--E�er view��n kulland��� esas fiziksel tablolar�n kolon isimleri bir �ekilde de�i�tirilir, 
--kolonlar� silinir ya da tablo yap�s� bir �ekilde de�i�ikli�e u�rarsa view��n �al��mas� art�k m�mk�n olmayacakt�r.

--View��n kulland��� tablolar ve kolonlar bu tarz i�lemler yap�labilmesi ihtimaline kar�� koruma alt�na al�nabilir.
--Bu koruma WITH SCHEMABINDING komutu ile yap�labilir.

--With Schemabinding ile view Create ya da Alter edilirken,view��n kulland��� tablo,schema ad�yla birlikte verilmelidir.
--�rne�in dbo bir �ema ad�d�r.�emalar C#taki namespaceler gibi d���n�lebilir.

--With Schemabinding komutu da �As� keyword�nden �nce yaz�lmal�d�r.

Create Table SchemaBindingOrnegi
(
 Id int Primary Key Identity,
 Kolon1 nvarchar(MAX)
)

Create View SchemaBindingOrnegiView
With Schemabinding
As
Select Id,Kolon1 from dbo.SchemaBindingOrnegi


--SchemaBindingOrnegi adl� esas tabloda herhangi bir de�i�iklik yap�ld��� zaman
--SchemaBindingOrnegiView adl� View'�m�z bize haber verecektir.

Alter Table SchemaBindingOrnegi
Alter Column Kolon1 int



--WITH CHECK OPTION KOMUTU

--View i�erisindeki sorguda bulunan �arta uygun kay�tlar�n Insert edilmesine m�sade edilip
--uymayan kay�tlar�n m�sade edilmemesini sa�layan bir komuttur.

--With Check Option Komutu where �art�ndan sonra belirtilmelidir

Create View WithCheckOptionView
As
Select Adi,Soyadi from Personeller where Adi like 'a%'
With Check Option

Insert WithCheckOptionView Values ('Ahmet','Kayao�lu')

Insert WithCheckOptionView Values ('Veli','Kayao�lu')

Select * from WithCheckOptionView


--FUNCTIONS
--Tsql'de 2 tip fonksiyon vard�r.
--1)SCALAR FUNCTIONS : Geriye istedi�imiz tipte bir de�er d�nd�ren fonksiyon
--2)INLINE FUNCTIONS : Geriye tablo g�nderen fonksiyon
--Her 2 fonksiyon da fiziksel olarak veri taban�nda olu�turulmaktad�r.
--Create komutu ile olu�turulmaktad�r.

--SCALAR FUNCTIONS
--Scalar fonksiyona tan�mland�ktan sonra Programmability -> Functions ->Scalar values Functions kombinasyonundan ula��labilir.

Create Function Topla(@Sayi1 int,@Sayi2 int) Returns int 
As
     Begin 
	     return @Sayi1 +@Sayi2
     End

 --Fonksiyon Kullan�m�
 --Fonksiyon kullan�l�rken �emas�yla beraber �a�r�lmal�d�r.

 Select dbo.Topla(2,5)



 --INLINE FUNCTIONS
 --Geriye bir de�er de�il ,tablo g�nderen fonksiyonlard�r
 --Geriye tablo g�nderece�i i�in bu fonksiyonlar �al��t�r�l�rken sanki bir tablodan sorgu �al��t�r�l�r gibi �al��t�r�l�rlar.
 --Bu y�nleriyle view�a benzerler. View ile yap�lan i�lemler Inline functionla da yap�labilir.
 --Genellikle view ile benzer i�levler i�in View kullan�lmas� �nerilir.
 --Inline function olu�turulurken begin end yap�s� kullan�lmaz

 Create Function fc_Gonder(@Ad nvarchar(20),@Soyad nvarchar(20)) Returns Table
 As
   return Select Adi,SoyAdi from Personeller where Adi = @Ad and Soyadi = @Soyad



Select * from dbo.fc_Gonder('Nancy','Davolio')

--FONKS�YONLARDA WITH ENCRYPTION KOMUTU
--E�er ki yazm�� oldu�umuz fonksiyonlar�n kodlar�na 2. ve 3. �ah�slar�n eri�iminin engellenmesini istiyorsak bu komutu kullan�r�z.
--WITH ENCRYPTION i�leminden sonra fonksiyonu olu�turan ki�i de dahil kimse komutlar� g�remez.Geri d�n�� yoktur.
--Ancak fonksiyonu olu�turan �ahs�n komutlar�n yede�ini bulundurmas� gerekmektedir.
--Ya da 'With Encryption' olmaks�z�n fonksiyonu yeniden alterlamal�y�z.
--With Encryption 'As' keywordunden �nce kullan�lmal�d�r.

Create Function OrnekFonksiyon() Returns int
With Encryption
    Begin
	   return 3
	End


--FONKS�YONLAR �LE OTOMAT�K HESAPLANAB�L�R KOLONLAR(COMPUTED COLUMN)
--Herhangi bir kolonda fonksiyon kullan�larak otomatik hesaplanabilir kolonlar olu�turmak m�mk�nd�r.

Create Function Topla(@Sayi1 int,@Sayi2 int)Returns int
As
Begin
   return @Sayi1 + @Sayi2
End

Select UrunAdi,dbo.Topla(BirimFiyati,HedefStokDuzeyi) [Hesaplanm�� Kolon] from Urunler 

