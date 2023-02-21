IF OBJECT_ID('odredi_poene') IS NOT NULL
	DROP PROCEDURE odredi_poene
GO
CREATE PROCEDURE odredi_poene @id INT, @poeni INT
AS
UPDATE dbo.artikal
SET dbo.artikal.poeni=@poeni
WHERE dbo.artikal.id=@id
GO

IF OBJECT_ID('odredi_bonus_poene') IS NOT NULL
	DROP PROCEDURE odredi_bonus_poene
GO
CREATE PROCEDURE odredi_bonus_poene @IDpromocije INT, @bonus INT
AS
UPDATE dbo.promocija
SET dbo.promocija.bonus=@bonus
WHERE dbo.promocija.id=@IDpromocije