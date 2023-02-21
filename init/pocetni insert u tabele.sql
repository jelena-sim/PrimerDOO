USE [Primer]
GO

INSERT INTO [dbo].[zaposleni]
           ([id]
           ,[ime]
           ,[prezime]
           ,[uloga])
     VALUES
           (1
           ,'Pera'
           ,'Simic'
		   ,'Zaposlen u prodaji'),
		   (2
		   ,'Ana'
		   ,'Jovic'
		   ,'Zaposlen u prodaji'),
		   (3
		   ,'Milan'
		   ,'Gajic'
		   ,'Zaposlen u marketingu'),
		   (4
		   ,'Nemanja'
		   ,'Savic'
		   ,'Menadzer prodaje'),
		   (5
		   ,'Tamara'
		   ,'Nikolic'
		   ,'Menadzer marketinga')
GO

INSERT INTO [dbo].[promocija]
           ([id]
           ,[datPocetka]
           ,[datKraja]
           ,[bonus])
     VALUES
           (1
           ,'2022-08-01'
           ,'2022-08-20'
           ,3),
		   (2
		   ,'2022-10-14'
		   ,'2022-11-14'
		   ,5)
GO

INSERT INTO [dbo].[popusti]
           ([id]
           ,[poeni]
           ,[procenat])
     VALUES
           (1
           ,10
           ,15)
GO

INSERT INTO [dbo].[artikal]
           ([id]
           ,[naziv]
           ,[poeni]
           ,[cena])
     VALUES
            (1
           ,'Patike'
           ,10
           ,7300.00),
		   (2
		   ,'Ranac'
		   ,4
		   ,3800.00),
		   (3
		   ,'Duks'
		   ,3
		   ,2500.00),
		   (4
		   ,'Majica'
		   ,2
		   ,1450.00)
GO

INSERT INTO [dbo].[klijent]
           ([id]
           ,[ime]
           ,[prezime]
           ,[adresa]
           ,[grad]
           ,[stanje])
     VALUES
           (1
           ,'Nikola'
           ,'Maksimovic'
           ,'Jurija Gagarina 3'
           ,'Beograd'
		   ,12),
		   (2
		   ,'Marko'
		   ,'Lazic'
		   ,'Karadjordjeva 12c'
		   ,'Beograd'
		   ,15),
		   (3
		   ,'Marija'
		   ,'Jovanovic'
		   ,'Svetog Save 8'
		   ,'Lazarevac'
		   ,5),
		   (4
		   ,'Miljana'
		   ,'Simic'
		   ,'Kneza Milosa 121'
		   ,'Jagodina'
		   ,0)
GO

INSERT INTO [dbo].[faktura]
           ([id]
           ,[idKlijenta]
           ,[idZaposlenog]
           ,[datum]
           ,[status]
           ,[idPromocije]
           ,[prodajniObjekat]
           ,[grad]
           ,[iznos]
           ,[poeni]
           ,[iznos_sa_popustom])
     VALUES
            (1
           ,3
           ,2
           ,'2022-10-16'
           ,NULL 
           ,2
		   ,'Tref'
		   ,'Beograd'
		   ,5400
		   ,5
		   ,4950),
		   (2
           ,3
           ,1
           ,'2022-08-20'
           ,NULL 
           ,1
		   ,'Djak'
		   ,'Beograd'
		   ,6300
		   ,7
		   ,NULL),
		   (3
           ,1
           ,2
           ,'2022-05-12'
           ,NULL 
           ,NULL
		   ,'Djak'
		   ,'Lazarevac'
		   ,7800
		   ,8
		   ,NULL),
		   (4
           ,2
           ,2
           ,'2022-10-18'
           ,NULL 
           ,2
		   ,'Intersport'
		   ,'Jagodina'
		   ,2300
		   ,2
		   ,2100)
GO


INSERT INTO [dbo].[artikalUFakturi]
           ([id]
           ,[idArtikla]
           ,[idFakture])
     VALUES
           (1
           ,2
           ,1),
		   (2
           ,3
           ,1),
		   (3
           ,4
           ,1),
		   (4
           ,4
           ,1),
		   (5
           ,1
           ,3),
		   (6
           ,4
           ,3),
		   (7
           ,2
           ,4),
		   (8
           ,3
           ,4),
		   (9
           ,3
           ,2)
GO





