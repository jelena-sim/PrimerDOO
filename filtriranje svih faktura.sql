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