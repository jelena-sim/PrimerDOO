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
