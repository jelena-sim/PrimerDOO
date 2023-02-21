IF OBJECT_ID('uvid_u_fakture_zaposlenog') IS NOT NULL
	DROP PROCEDURE uvid_u_fakture_zaposlenog
GO
CREATE PROCEDURE uvid_u_fakture_zaposlenog @ID INT
AS
SELECT *
FROM dbo.faktura
WHERE dbo.faktura.idZaposlenog=@ID 