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