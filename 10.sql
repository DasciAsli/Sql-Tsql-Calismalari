
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