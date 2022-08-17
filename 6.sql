
--WITH SCHEMABINDING KOMUTU

--Eðer view’ýn kullandýðý esas fiziksel tablolarýn kolon isimleri bir þekilde deðiþtirilir, 
--kolonlarý silinir ya da tablo yapýsý bir þekilde deðiþikliðe uðrarsa view’ýn çalýþmasý artýk mümkün olmayacaktýr.

--View’ýn kullandýðý tablolar ve kolonlar bu tarz iþlemler yapýlabilmesi ihtimaline karþý koruma altýna alýnabilir.
--Bu koruma WITH SCHEMABINDING komutu ile yapýlabilir.

--With Schemabinding ile view Create ya da Alter edilirken,view’ýn kullandýðý tablo,schema adýyla birlikte verilmelidir.
--Örneðin dbo bir þema adýdýr.Þemalar C#taki namespaceler gibi düþünülebilir.

--With Schemabinding komutu da ‘As’ keywordünden önce yazýlmalýdýr.

Create Table SchemaBindingOrnegi
(
 Id int Primary Key Identity,
 Kolon1 nvarchar(MAX)
)

Create View SchemaBindingOrnegiView
With Schemabinding
As
Select Id,Kolon1 from dbo.SchemaBindingOrnegi


--SchemaBindingOrnegi adlý esas tabloda herhangi bir deðiþiklik yapýldýðý zaman
--SchemaBindingOrnegiView adlý View'ýmýz bize haber verecektir.

Alter Table SchemaBindingOrnegi
Alter Column Kolon1 int



--WITH CHECK OPTION KOMUTU

--View içerisindeki sorguda bulunan þarta uygun kayýtlarýn Insert edilmesine müsade edilip
--uymayan kayýtlarýn müsade edilmemesini saðlayan bir komuttur.

--With Check Option Komutu where þartýndan sonra belirtilmelidir

Create View WithCheckOptionView
As
Select Adi,Soyadi from Personeller where Adi like 'a%'
With Check Option

Insert WithCheckOptionView Values ('Ahmet','Kayaoðlu')

Insert WithCheckOptionView Values ('Veli','Kayaoðlu')

Select * from WithCheckOptionView


--FUNCTIONS
--Tsql'de 2 tip fonksiyon vardýr.
--1)SCALAR FUNCTIONS : Geriye istediðimiz tipte bir deðer döndüren fonksiyon
--2)INLINE FUNCTIONS : Geriye tablo gönderen fonksiyon
--Her 2 fonksiyon da fiziksel olarak veri tabanýnda oluþturulmaktadýr.
--Create komutu ile oluþturulmaktadýr.

--SCALAR FUNCTIONS
--Scalar fonksiyona tanýmlandýktan sonra Programmability -> Functions ->Scalar values Functions kombinasyonundan ulaþýlabilir.

Create Function Topla(@Sayi1 int,@Sayi2 int) Returns int 
As
     Begin 
	     return @Sayi1 +@Sayi2
     End

 --Fonksiyon Kullanýmý
 --Fonksiyon kullanýlýrken þemasýyla beraber çaðrýlmalýdýr.

 Select dbo.Topla(2,5)



 --INLINE FUNCTIONS
 --Geriye bir deðer deðil ,tablo gönderen fonksiyonlardýr
 --Geriye tablo göndereceði için bu fonksiyonlar çalýþtýrýlýrken sanki bir tablodan sorgu çalýþtýrýlýr gibi çalýþtýrýlýrlar.
 --Bu yönleriyle view’a benzerler. View ile yapýlan iþlemler Inline functionla da yapýlabilir.
 --Genellikle view ile benzer iþlevler için View kullanýlmasý önerilir.
 --Inline function oluþturulurken begin end yapýsý kullanýlmaz

 Create Function fc_Gonder(@Ad nvarchar(20),@Soyad nvarchar(20)) Returns Table
 As
   return Select Adi,SoyAdi from Personeller where Adi = @Ad and Soyadi = @Soyad



Select * from dbo.fc_Gonder('Nancy','Davolio')

--FONKSÝYONLARDA WITH ENCRYPTION KOMUTU
--Eðer ki yazmýþ olduðumuz fonksiyonlarýn kodlarýna 2. ve 3. þahýslarýn eriþiminin engellenmesini istiyorsak bu komutu kullanýrýz.
--WITH ENCRYPTION iþleminden sonra fonksiyonu oluþturan kiþi de dahil kimse komutlarý göremez.Geri dönüþ yoktur.
--Ancak fonksiyonu oluþturan þahsýn komutlarýn yedeðini bulundurmasý gerekmektedir.
--Ya da 'With Encryption' olmaksýzýn fonksiyonu yeniden alterlamalýyýz.
--With Encryption 'As' keywordunden önce kullanýlmalýdýr.

Create Function OrnekFonksiyon() Returns int
With Encryption
    Begin
	   return 3
	End


--FONKSÝYONLAR ÝLE OTOMATÝK HESAPLANABÝLÝR KOLONLAR(COMPUTED COLUMN)
--Herhangi bir kolonda fonksiyon kullanýlarak otomatik hesaplanabilir kolonlar oluþturmak mümkündür.

Create Function Topla(@Sayi1 int,@Sayi2 int)Returns int
As
Begin
   return @Sayi1 + @Sayi2
End

Select UrunAdi,dbo.Topla(BirimFiyati,HedefStokDuzeyi) [Hesaplanmýþ Kolon] from Urunler 

