--TRANSACTION


--Birden �ok i�lemin bir arada yap�ld��� durumlarda e�er par�ay� olu�turan 
--i�lemlerden herhangi birinde sorun olursa t�m i�lemi iptal ettirmeye yarar.

--�rne�in kredi kart� ile al��veri� i�lemlerinde transaction i�lemi vard�r.
--Siz marketten �r�n al�rken sizin hesab�n�zdan para d���lecek ,marketin hesab�na aktar�lacakt�r.
--Bu i�lemde hata olmamas� gerekir ve bundan dolay� bu i�lem bir transaction blo�unda ger�ekle�tirilmelidir.
--Bu esnada herhangi bir sorun olursa b�t�n i�lemler transaction taraf�ndan iptal edilebilecektir.

--Begin Tran ya da Begin Transaction : Transaction i�lemini ba�lat�r.

--Commit Tran :Transaction i�lemini ba�ar�yla sona erdirir. ��lemler ger�ekle�tirilir.

--Rollback Tran : Transaction i�lemini iptal eder.��lemleri geri al�r.

--Commit Tran yerine sadece Commit yaz�labilir.

--Rollback Tran yerine sadece Rollback yaz�labilir.

--Normalde default olarak her�ey Begin Tran ile ba�lay�p , Commit Tran ile biter .
--!!Biz bu yap�lar� kullanmasak bile.


--TRANSACTION TANIMLAMA
--PROTOTIP

--Begin Tran [Transaction Ad�]
--��lemler

Insert Bolge Values (5,'�orum')--Varsay�lan olarak Transaction kontrol�nde olan bir i�lemdir.
--Netice olarak yine varsay�lan olarak Commit Tran ile bitmektedir.

Begin Tran
Insert Bolge Values (5,'�orum')
Commit Tran

--Transctiona isim vermek zorunda de�iliz.

--Ornek
--PersonelIdsi 11den b�y�k olan elemanlar� silerken 
--e�er birden fazla kay�t silinecekse i�lem iptal edilsin.
--1 kay�t silinecekse i�lem yap�ls�n.
Begin Tran Kontrol
Declare @i int
Delete from Personeller where PersonelID > 11
Set @i=@@ROWCOUNT
If @i = 1
Begin 
   print 'Kay�t Silindi'
   Commit 
End
Else
Begin
  print '��lemler geri al�nd�'
  Rollback
End



--Tsql en son primary key id'yi bulmak
Select IDENT_CURRENT('Personeller')

--@@Identity,Scope_Identity() ve Identity_Current() Komutlar�

--@@Identity
--A��lm�� olan ba�lant�da(connection) tablo yahut sorgunun �al��t��� scope'a bak�lmaks�z�n son �retilen identity de�erini verir
--Trigger kullan�lan sorgularda yanl�� sonu� alma ihtimalinden dolay� kullan�lmas� tavsiye edilmez.
 
 --Scope_Identity()
 --A��lm�� olan ba�lant�da ve sorgunun �al��t��� scope'ta son �retilen identity de�erini d�nd�r�r
 --Trigger kullan�lan sorgularda @@Identity yerine bu fonksiyonun kullan�lmas� tavsiye edilir.

 --Identity_Current('TabloAdi')
--Ba�lant� ve sorgunun �al��t�r�ld��� scope'a bakmaks�z�n parametre olarak verilen tabloda �retilen sonuncu identity de�erini d�nd�r�r.