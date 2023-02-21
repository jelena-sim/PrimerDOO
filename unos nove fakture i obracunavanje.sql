--1. Kao zaposleni u prodaji, zelim da imam mogucnost da unesem novu fakturu clana kluba 
--u sistem, kako bi se obracunali poeni.
--Nakon toga se popunjava vezna tabela artikalUFakturi, jer se pretpostavlja da jedna faktura moze imati vise artikala.

IF OBJECT_ID('unos_fakture') IS NOT NULL
	DROP PROCEDURE unos_fakture
GO
IF OBJECT_ID('unos_artikla_u_fakturu') IS NOT NULL
	DROP PROCEDURE unos_artikla_u_fakturu
GO
CREATE PROCEDURE unos_fakture @id INT, @idKlijenta INT,	@idZaposlenog INT, @datum DATE,
							  @prodajniObjekat NVARCHAR(20), @grad NVARCHAR(10)
AS
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
           (@id
           ,@idKlijenta
           ,@idZaposlenog
           ,@datum
           ,NULL
           ,NULL
           ,@prodajniObjekat
           ,@grad
           ,0
           ,0
		   ,0)
GO

CREATE PROCEDURE unos_artikla_u_fakturu @id INT, @idArtikla INT, @idFakture INT
AS
INSERT INTO [dbo].[artikalUFakturi]
           ([id]
           ,[idArtikla]
           ,[idFakture])
     VALUES
           (@id
           ,@idArtikla
           ,@idFakture)
GO

--2. Kao zaposleni u prodaji, zelim da imam mogucnost da izmenim unetu kupovinu u sistem 
--kako bih bio/la u mogucnosti da intervenisem na postojecoj fakturi.

IF OBJECT_ID('izmena_fakture') IS NOT NULL
	DROP PROCEDURE izmena_fakture
GO
CREATE PROCEDURE izmena_fakture @id INT, @idKlijenta INT,	@idZaposlenog INT,	@datum DATE, @status NVARCHAR(10),	@idPromocije INT,
							  @prodajniObjekat NVARCHAR(20), @grad NVARCHAR(10), @iznos FLOAT, @poeni INT, @iznos_sa_popustom FLOAT
AS
UPDATE [dbo].[faktura]
   SET [idKlijenta] = @idKlijenta
      ,[idZaposlenog] = @idZaposlenog
      ,[datum] = @datum
      ,[status] = @status
      ,[idPromocije] = @idPromocije
      ,[prodajniObjekat] = @prodajniObjekat
      ,[grad] = @grad
      ,[iznos] = @iznos
      ,[poeni] = @poeni
	  ,[iznos_sa_popustom]=@iznos_sa_popustom
 WHERE [id] = @id
 GO

--3. Kao zaposleni u prodaji, prilikom unosenja nove fakture, zelim da mi sistem obracuna
--poene po svakom artiklu u fakturi prema definisanim vrednostima za svaki artikal.

IF OBJECT_ID('obracun_poena') IS NOT NULL
	DROP PROCEDURE obracun_poena
GO
CREATE PROCEDURE obracun_poena @IDfakture INT
AS
WITH obracunaj_p AS (
SELECT f.id, SUM(a.poeni) AS poeni
FROM dbo.faktura f JOIN dbo.artikalUFakturi auf ON auf.idFakture=f.id
				   JOIN dbo.artikal a ON auf.idArtikla=a.id
WHERE f.id=@IDfakture
GROUP BY f.id
)
UPDATE dbo.faktura
SET dbo.faktura.poeni=(SELECT poeni FROM obracunaj_p)
WHERE dbo.faktura.id=@IDfakture
GO

--4. Kao zaposleni u prodaji, prilikom unosenja nove fakture, zelim da mi sistem automatski 
--doda bonus poene prema aktivnoj promociji u datom periodu.

IF OBJECT_ID('obracun_bonus_poena') IS NOT NULL
	DROP PROCEDURE obracun_bonus_poena
GO
CREATE PROCEDURE obracun_bonus_poena @IDfakture INT
AS
DECLARE @datum DATE;
SET @datum=(SELECT f.datum FROM dbo.faktura f WHERE f.id=@IDfakture);
DECLARE @IDpromocije INT;
SET @IDpromocije=(SELECT p.id FROM dbo.promocija p WHERE @datum BETWEEN p.datPocetka AND p.datKraja);
DECLARE @poeni INT;
SET @poeni=(SELECT f.poeni FROM dbo.faktura f WHERE f.id=@IDfakture);
DECLARE @bonus_poeni INT;
SET @bonus_poeni=(SELECT p.bonus FROM dbo.promocija p WHERE p.id=@IDpromocije);
IF @IDpromocije IS NOT NULL
BEGIN
UPDATE dbo.faktura
SET dbo.faktura.poeni=@poeni + @bonus_poeni, dbo.faktura.idPromocije=@IDpromocije
WHERE dbo.faktura.id=@IDfakture
END
GO

--5. Kao zaposleni u prodaji, zelim mogucnost da unetu fakturu, za koju su obracunati poeni, 
--postavim u status "nagradjena".

IF OBJECT_ID('postavi_status') IS NOT NULL
	DROP PROCEDURE postavi_status
GO
CREATE PROCEDURE postavi_status @IDfakture INT
AS
UPDATE dbo.faktura
SET dbo.faktura.status='nagradjena'
WHERE dbo.faktura.id=@IDfakture AND dbo.faktura.poeni>0
GO

--6. Kao zaposleni u prodaji, zelim da se obracunati poeni sa fakture dodaju na stanje racuna
--klijenta.
IF OBJECT_ID('dodaj_na_stanje') IS NOT NULL
	DROP PROCEDURE dodaj_na_stanje
GO
CREATE PROCEDURE dodaj_na_stanje @idFakture INT
AS
DECLARE @idKlijenta INT;
SET @idKlijenta=(SELECT k.id FROM dbo.faktura f JOIN dbo.klijent k ON f.idKlijenta=k.id WHERE f.id=@idFakture);
DECLARE @stanje INT;
SET @stanje=(SELECT k.stanje FROM dbo.klijent k WHERE k.id=@idKlijenta)
DECLARE @poeni INT;
SET @poeni=(SELECT f.poeni FROM dbo.faktura f WHERE f.id=@idFakture);
UPDATE dbo.klijent
SET dbo.klijent.stanje=@stanje+@poeni
WHERE dbo.klijent.id=@idKlijenta
GO

--Ukupna vrednost fakture.

IF OBJECT_ID('obracun_cena') IS NOT NULL
	DROP PROCEDURE obracun_cena
GO
CREATE PROCEDURE obracun_cena @IDfakture INT
AS
WITH obracunaj_c AS (
SELECT f.id, SUM(a.cena) AS ukupno
FROM dbo.faktura f JOIN dbo.artikalUFakturi auf ON auf.idFakture=f.id
				   JOIN dbo.artikal a ON auf.idArtikla=a.id
WHERE f.id=@IDfakture
GROUP BY f.id
)
UPDATE dbo.faktura
SET dbo.faktura.iznos=(SELECT ukupno FROM obracunaj_c)
WHERE dbo.faktura.id=@IDfakture