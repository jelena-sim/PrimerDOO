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