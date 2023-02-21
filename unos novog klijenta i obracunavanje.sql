IF OBJECT_ID('unos_klijenta') IS NOT NULL
	DROP PROCEDURE unos_klijenta
GO
CREATE PROCEDURE unos_klijenta @id INT, @ime NVARCHAR(10),	@prezime NVARCHAR(10), @adresa NVARCHAR(20), @grad NVARCHAR(10)
AS
INSERT INTO [dbo].[klijent]
           ([id]
           ,[ime]
           ,[prezime]
           ,[adresa]
           ,[grad]
		   ,[stanje])
     VALUES
           (@id
           ,@ime
           ,@prezime
           ,@adresa
           ,@grad
		   ,0)
GO

IF OBJECT_ID('azuriranje_adrese') IS NOT NULL
	DROP PROCEDURE azuriranje_adrese
GO
CREATE PROCEDURE azuriranje_adrese @id INT, @adresa NVARCHAR(20)
AS
UPDATE dbo.klijent
SET dbo.klijent.adresa=@adresa
WHERE dbo.klijent.id=@id
GO

IF OBJECT_ID('obracun_popusta') IS NOT NULL
	DROP PROCEDURE obracun_popusta
GO
CREATE PROCEDURE obracun_popusta @idFakture INT
AS
DECLARE @idKlijenta INT;
SET @idKlijenta=(SELECT k.id FROM dbo.faktura f JOIN dbo.klijent k ON f.idKlijenta=k.id WHERE f.id=@idFakture);
DECLARE @stanje INT;
SET @stanje=(SELECT k.stanje FROM dbo.klijent k WHERE k.id=@idKlijenta);
DECLARE @poeni_za_popust INT;
SET @poeni_za_popust=(SELECT p.poeni FROM dbo.popusti p);
DECLARE @poeni_sa_fakture INT;
SET @poeni_sa_fakture=(SELECT f.poeni FROM dbo.faktura f WHERE f.id=@idFakture);
DECLARE @procenat FLOAT;
SET @procenat=(SELECT p.procenat FROM dbo.popusti p);
IF @stanje>@poeni_za_popust
BEGIN 
UPDATE dbo.klijent
SET dbo.klijent.stanje=@stanje-@poeni_za_popust
WHERE dbo.klijent.id=@idKlijenta;
UPDATE dbo.faktura
SET dbo.faktura.iznos_sa_popustom=dbo.faktura.iznos*(1-0.01*@procenat)
WHERE dbo.faktura.id=@idFakture
END