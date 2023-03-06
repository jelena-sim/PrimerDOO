IF OBJECT_ID('artikalUFakturi') IS NOT NULL DROP TABLE artikalUFakturi
IF OBJECT_ID('faktura') IS NOT NULL DROP TABLE faktura
IF OBJECT_ID('klijent') IS NOT NULL DROP TABLE klijent
IF OBJECT_ID('artikal') IS NOT NULL DROP TABLE artikal
IF OBJECT_ID('promocija') IS NOT NULL DROP TABLE promocija
IF OBJECT_ID('zaposleni') IS NOT NULL DROP TABLE zaposleni
IF OBJECT_ID('popusti') IS NOT NULL DROP TABLE popusti

CREATE TABLE klijent
(
	id INT NOT NULL PRIMARY KEY,
	ime NVARCHAR(10),
	prezime NVARCHAR(10),
	adresa NVARCHAR(20),
	grad NVARCHAR(10),
	stanje INT
)

CREATE TABLE zaposleni
(
	id INT NOT NULL PRIMARY KEY,
	ime NVARCHAR(10),
	prezime NVARCHAR(10),
	uloga NVARCHAR(30)
)

CREATE TABLE promocija
(
	id INT NOT NULL PRIMARY KEY,
	datPocetka DATE,
	datKraja DATE,
	bonus INT
)

CREATE TABLE popusti
(
	id INT NOT NULL PRIMARY KEY,
	poeni INT,
	procenat FLOAT
)

CREATE TABLE faktura
(
	id INT NOT NULL PRIMARY KEY,
	idKlijenta INT,
	idZaposlenog INT,
	datum DATE,
	status NVARCHAR(10),
	idPromocije INT,
	prodajniObjekat NVARCHAR(20),
	grad NVARCHAR(10),
	iznos FLOAT,
	poeni INT,
	iznos_sa_popustom FLOAT,
	constraint fkIdKlijenta foreign key (idKlijenta) references klijent(id),
	constraint fkIdZaposlenog foreign key (idZaposlenog) references zaposleni(id),
	constraint fkIdPromocije foreign key (idPromocije) references promocija(id)
)

CREATE TABLE artikal
(
	id INT NOT NULL PRIMARY KEY,
	naziv NVARCHAR(20),
	poeni INT,
	cena FLOAT
)

CREATE TABLE artikalUFakturi
(
	id INT NOT NULL PRIMARY KEY,
	idArtikla INT,
	idFakture INT,
	constraint fkIdArtikla foreign key (idArtikla) references artikal(id),
	constraint fkIdFakture foreign key (idFakture) references faktura(id)
)

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
CREATE PROCEDURE obracun_poena @IDfakture INT = NULL
AS
IF (@IDfakture IS NOT NULL)
BEGIN
UPDATE dbo.faktura
SET dbo.faktura.poeni=(SELECT SUM(a.poeni) AS poeni
					   FROM dbo.faktura f JOIN dbo.artikalUFakturi auf ON auf.idFakture=f.id
										  JOIN dbo.artikal a ON auf.idArtikla=a.id
					   WHERE f.id=@IDfakture)
WHERE dbo.faktura.id=@IDfakture
END
ELSE
BEGIN
WITH obracunaj_p AS (
SELECT f.id, SUM(a.poeni) AS poeni
FROM dbo.faktura f JOIN dbo.artikalUFakturi auf ON auf.idFakture=f.id
				   JOIN dbo.artikal a ON auf.idArtikla=a.id
WHERE f.poeni=0
GROUP BY f.id
)
UPDATE dbo.faktura
SET dbo.faktura.poeni=(SELECT poeni FROM obracunaj_p WHERE id=dbo.faktura.id)
WHERE dbo.faktura.poeni=0
END
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
GO
--7. Kao zaposleni u prodaji zelim da imam mogucnost da unesem novog clana kluba u sistem.

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

--8. Kao zaposleni u prodaji zelim da imam mogucnost da azuriram adresne podatke za 
--klijenta u sistemu.

IF OBJECT_ID('azuriranje_adrese') IS NOT NULL
	DROP PROCEDURE azuriranje_adrese
GO
CREATE PROCEDURE azuriranje_adrese @id INT, @adresa NVARCHAR(20)
AS
UPDATE dbo.klijent
SET dbo.klijent.adresa=@adresa
WHERE dbo.klijent.id=@id
GO

--9. Kao zaposleni u prodaji, zelim da ukoliko je klijent na fakturi utrosio potreban broj poena 
--kako bi ostvario popust, umanjim stanje poena na racunu klijenta. Faktura na kojoj je 
--korisnik ostvario popust, takodje se boduje za procentualno umanjeni iznos svakog artikla.

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
IF @stanje>=@poeni_za_popust
BEGIN 
UPDATE dbo.klijent
SET dbo.klijent.stanje=@stanje-@poeni_za_popust
WHERE dbo.klijent.id=@idKlijenta;
UPDATE dbo.faktura
SET dbo.faktura.iznos_sa_popustom=dbo.faktura.iznos*(1-0.01*@procenat)
WHERE dbo.faktura.id=@idFakture
END
ELSE
BEGIN
UPDATE dbo.faktura
SET dbo.faktura.iznos_sa_popustom=dbo.faktura.iznos
WHERE dbo.faktura.id=@idFakture
END
GO

--Nakon unosa fakture, obracunavaju se i upisuju vrednosti za odredjena polja u tabelama faktura i klijent.

IF OBJECT_ID('obracun_nakon_unosa') IS NOT NULL
	DROP PROCEDURE obracun_nakon_unosa
GO
CREATE PROCEDURE obracun_nakon_unosa @id INT
AS
BEGIN
EXEC obracun_poena @IDfakture=@id
EXEC obracun_bonus_poena @IDfakture=@id
EXEC postavi_status @IDfakture=@id
EXEC dodaj_na_stanje @IDfakture=@id
EXEC obracun_cena @IDfakture=@id
EXEC obracun_popusta @IDfakture=@id
END
GO

--10. Kao zaposleni u prodaji zelim da imam uvid u sve fakture koje sam uneo/la u sistem.
--15. Kao menadzer prodaje zelim da imam mogucnost da filtriram fakture po:--d. Zaposlenom koji je uneo fakture

IF OBJECT_ID('uvid_u_fakture_zaposlenog') IS NOT NULL
	DROP PROCEDURE uvid_u_fakture_zaposlenog
GO
CREATE PROCEDURE uvid_u_fakture_zaposlenog @ID INT
AS
SELECT *
FROM dbo.faktura
WHERE dbo.faktura.idZaposlenog=@ID
GO

--11. Kao zaposleni u prodaji zelim da listu svojih fakture filtriram po:
--a. Klijentu
--b. Gradu
--c. Periodu unosenja fakture
--d. Prodajnom objektu

IF OBJECT_ID('filter_po_klijentu') IS NOT NULL
	DROP PROCEDURE filter_po_klijentu
GO
CREATE PROCEDURE filter_po_klijentu @IDzaposlenog INT, @IDklijenta INT
AS
SELECT *
FROM dbo.faktura
WHERE dbo.faktura.idZaposlenog=@IDzaposlenog AND dbo.faktura.idKlijenta=@IDklijenta
GO

IF OBJECT_ID('filter_po_gradu') IS NOT NULL
	DROP PROCEDURE filter_po_gradu
GO
CREATE PROCEDURE filter_po_gradu @IDzaposlenog INT, @grad NVARCHAR(10)
AS
SELECT *
FROM dbo.faktura
WHERE dbo.faktura.idZaposlenog=@IDzaposlenog AND dbo.faktura.grad=@grad
GO

IF OBJECT_ID('filter_po_periodu') IS NOT NULL
	DROP PROCEDURE filter_po_periodu
GO
CREATE PROCEDURE filter_po_periodu @IDzaposlenog INT, @od DATE, @do DATE
AS
SELECT *
FROM dbo.faktura
WHERE dbo.faktura.idZaposlenog=@IDzaposlenog AND dbo.faktura.datum BETWEEN @od AND @do
GO

IF OBJECT_ID('filter_po_objektu') IS NOT NULL
	DROP PROCEDURE filter_po_objektu
GO
CREATE PROCEDURE filter_po_objektu @IDzaposlenog INT, @prodajniObjekat NVARCHAR(20)
AS
SELECT *
FROM dbo.faktura
WHERE dbo.faktura.idZaposlenog=@IDzaposlenog AND dbo.faktura.prodajniObjekat=@prodajniObjekat
GO

--12. Kao zaposleni u marketingu zelim da imam mogucnost da za svaki artikal odredim broj 
--poena koji se dobija pri kupovini.

IF OBJECT_ID('odredi_poene') IS NOT NULL
	DROP PROCEDURE odredi_poene
GO
CREATE PROCEDURE odredi_poene @id INT, @poeni INT
AS
UPDATE dbo.artikal
SET dbo.artikal.poeni=@poeni
WHERE dbo.artikal.id=@id
GO

--13. Kao zaposleni u marketingu zelim da imam mogucnost da odredim bonus poene koji se 
--dobijaju za svaku kupovinu u zadatom periodu.

IF OBJECT_ID('odredi_bonus_poene') IS NOT NULL
	DROP PROCEDURE odredi_bonus_poene
GO
CREATE PROCEDURE odredi_bonus_poene @IDpromocije INT, @bonus INT
AS
UPDATE dbo.promocija
SET dbo.promocija.bonus=@bonus
WHERE dbo.promocija.id=@IDpromocije
GO

--14. Kao menadzer prodaje zelim da imam uvid u sve fakture u sistemu.--17. Kao menadzer marketinga zelim da imam uvid u sve fakture u sistemu.

IF OBJECT_ID('uvid_u_fakture') IS NOT NULL
	DROP VIEW uvid_u_fakture
GO
CREATE VIEW uvid_u_fakture
AS
SELECT [idKlijenta]
      ,[idZaposlenog]
      ,[datum]
      ,[status]
      ,[idPromocije]
      ,[prodajniObjekat]
      ,[grad]
      ,[iznos]
      ,[poeni]
      ,[iznos_sa_popustom]
  FROM [dbo].[faktura]
GO

--15. Kao menadzer prodaje zelim da imam mogucnost da filtriram fakture po:
--a. Klijentu
--b. Gradu
--c. Periodu unosa fakture
--18. Kao menadzer marketinga fakture zelim da imam mogucnost da filtriram fakture po:
--a. Artiklu
--b. Periodu unosa fakture
--c. Gradu

IF OBJECT_ID('filter_svih_po_klijentu') IS NOT NULL
	DROP PROCEDURE filter_svih_po_klijentu
GO
CREATE PROCEDURE filter_svih_po_klijentu @IDklijenta INT
AS
SELECT *
FROM dbo.faktura
WHERE dbo.faktura.idKlijenta=@IDklijenta
GO

IF OBJECT_ID('filter_svih_po_gradu') IS NOT NULL
	DROP PROCEDURE filter_svih_po_gradu
GO
CREATE PROCEDURE filter_svih_po_gradu @grad NVARCHAR(10)
AS
SELECT *
FROM dbo.faktura
WHERE dbo.faktura.grad=@grad
GO

IF OBJECT_ID('filter_svih_po_periodu') IS NOT NULL
	DROP PROCEDURE filter_svih_po_periodu
GO
CREATE PROCEDURE filter_svih_po_periodu @od DATE, @do DATE
AS
SELECT *
FROM dbo.faktura
WHERE dbo.faktura.datum BETWEEN @od AND @do
GO

IF OBJECT_ID('filter_svih_po_artiklu') IS NOT NULL
	DROP PROCEDURE filter_svih_po_artiklu
GO
CREATE PROCEDURE filter_svih_po_artiklu @IDartikla INT
AS
SELECT *
FROM dbo.faktura f join dbo.artikalUFakturi auf on f.id=auf.idFakture
WHERE auf.idArtikla=@IDartikla
GO

--16. Kao menadzer prodaje zelim da imam izvestaj koji obuhvata sve fakture i koji prikazuje 
--ukupnu vrednost faktura i ukupnu vrednost obracunatih poena grupisanih po:
--a. Mesecu
--b. Gradu
--c. Zaposlenom koji je uneo fakturu
--d. Klijentu
--19. Kao menadzer marketinga zelim da imam izvestaj koji obuhvata sve i koji prikazuje 
--ukupnu vrednost faktura i ukupnu vrednost poena grupisanih po:
--a. Mesecu
--c. Gradu

IF OBJECT_ID('grupisano_po_mesecu') IS NOT NULL
	DROP PROCEDURE grupisano_po_mesecu
GO
CREATE PROCEDURE grupisano_po_mesecu
AS
SELECT MONTH(f.datum) as mesec, SUM(f.iznos) AS suma_iznosa, SUM(f.poeni) AS suma_poena
FROM dbo.faktura f 
GROUP BY MONTH(f.datum) 
GO

IF OBJECT_ID('grupisano_po_gradu') IS NOT NULL
	DROP PROCEDURE grupisano_po_gradu
GO
CREATE PROCEDURE grupisano_po_gradu
AS
SELECT f.grad, SUM(f.iznos) AS suma_iznosa, SUM(f.poeni) AS suma_poena
FROM dbo.faktura f 
GROUP BY f.grad 
GO

IF OBJECT_ID('grupisano_po_zaposlenom') IS NOT NULL
	DROP PROCEDURE grupisano_po_zaposlenom
GO
CREATE PROCEDURE grupisano_po_zaposlenom
AS
SELECT f.idZaposlenog, SUM(f.iznos) AS suma_iznosa, SUM(f.poeni) AS suma_poena
FROM dbo.faktura f 
GROUP BY f.idZaposlenog 
GO

IF OBJECT_ID('grupisano_po_klijentu') IS NOT NULL
	DROP PROCEDURE grupisano_po_klijentu
GO
CREATE PROCEDURE grupisano_po_klijentu
AS
SELECT f.idKlijenta, SUM(f.iznos) AS suma_iznosa, SUM(f.poeni) AS suma_poena
FROM dbo.faktura f 
GROUP BY f.idKlijenta 
GO