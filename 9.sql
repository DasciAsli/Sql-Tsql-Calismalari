--TRANSACTION


--Birden çok iþlemin bir arada yapýldýðý durumlarda eðer parçayý oluþturan 
--iþlemlerden herhangi birinde sorun olursa tüm iþlemi iptal ettirmeye yarar.

--Örneðin kredi kartý ile alýþveriþ iþlemlerinde transaction iþlemi vardýr.
--Siz marketten ürün alýrken sizin hesabýnýzdan para düþülecek ,marketin hesabýna aktarýlacaktýr.
--Bu iþlemde hata olmamasý gerekir ve bundan dolayý bu iþlem bir transaction bloðunda gerçekleþtirilmelidir.
--Bu esnada herhangi bir sorun olursa bütün iþlemler transaction tarafýndan iptal edilebilecektir.

--Begin Tran ya da Begin Transaction : Transaction iþlemini baþlatýr.

--Commit Tran :Transaction iþlemini baþarýyla sona erdirir. Ýþlemler gerçekleþtirilir.

--Rollback Tran : Transaction iþlemini iptal eder.Ýþlemleri geri alýr.

--Commit Tran yerine sadece Commit yazýlabilir.

--Rollback Tran yerine sadece Rollback yazýlabilir.

--Normalde default olarak herþey Begin Tran ile baþlayýp , Commit Tran ile biter .
--!!Biz bu yapýlarý kullanmasak bile.


--TRANSACTION TANIMLAMA
--PROTOTIP

--Begin Tran [Transaction Adý]
--Ýþlemler

Insert Bolge Values (5,'Çorum')--Varsayýlan olarak Transaction kontrolünde olan bir iþlemdir.
--Netice olarak yine varsayýlan olarak Commit Tran ile bitmektedir.

Begin Tran
Insert Bolge Values (5,'Çorum')
Commit Tran

--Transctiona isim vermek zorunda deðiliz.

--Ornek
--PersonelIdsi 11den büyük olan elemanlarý silerken 
--eðer birden fazla kayýt silinecekse iþlem iptal edilsin.
--1 kayýt silinecekse iþlem yapýlsýn.
Begin Tran Kontrol
Declare @i int
Delete from Personeller where PersonelID > 11
Set @i=@@ROWCOUNT
If @i = 1
Begin 
   print 'Kayýt Silindi'
   Commit 
End
Else
Begin
  print 'Ýþlemler geri alýndý'
  Rollback
End



--Tsql en son primary key id'yi bulmak
Select IDENT_CURRENT('Personeller')

--@@Identity,Scope_Identity() ve Identity_Current() Komutlarý

--@@Identity
--Açýlmýþ olan baðlantýda(connection) tablo yahut sorgunun çalýþtýðý scope'a bakýlmaksýzýn son üretilen identity deðerini verir
--Trigger kullanýlan sorgularda yanlýþ sonuç alma ihtimalinden dolayý kullanýlmasý tavsiye edilmez.
 
 --Scope_Identity()
 --Açýlmýþ olan baðlantýda ve sorgunun çalýþtýðý scope'ta son üretilen identity deðerini döndürür
 --Trigger kullanýlan sorgularda @@Identity yerine bu fonksiyonun kullanýlmasý tavsiye edilir.

 --Identity_Current('TabloAdi')
--Baðlantý ve sorgunun çalýþtýrýldýðý scope'a bakmaksýzýn parametre olarak verilen tabloda üretilen sonuncu identity deðerini döndürür.