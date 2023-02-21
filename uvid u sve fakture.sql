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