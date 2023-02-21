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