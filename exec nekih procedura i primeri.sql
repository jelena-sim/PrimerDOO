exec unos_fakture @id=5, @idKlijenta=2,	@idZaposlenog=1, @datum='2022-10-15', @prodajniObjekat='Tref', @grad='Lazarevac'
exec unos_artikla_u_fakturu @id=10, @idArtikla=1, @idFakture=5
exec unos_artikla_u_fakturu @id=11, @idArtikla=4, @idFakture=5
exec unos_artikla_u_fakturu @id=12, @idArtikla=2, @idFakture=5
exec obracun_nakon_unosa @id=5

exec unos_fakture @id=6, @idKlijenta=4,	@idZaposlenog=2, @datum='2022-08-08', @prodajniObjekat='Djak', @grad='Jagodina'
exec unos_artikla_u_fakturu @id=13, @idArtikla=1, @idFakture=6
exec unos_artikla_u_fakturu @id=14, @idArtikla=2, @idFakture=6
exec obracun_nakon_unosa @id=6

exec unos_fakture @id=7, @idKlijenta=3,	@idZaposlenog=2, @datum='2022-01-20', @prodajniObjekat='Djak', @grad='Jagodina'
exec unos_artikla_u_fakturu @id=15, @idArtikla=4, @idFakture=7
exec obracun_nakon_unosa @id=7

select * from uvid_u_fakture
exec grupisano_po_gradu
exec unos_klijenta @id=5, @ime=Jelena,	@prezime=Maric, @adresa='Nikole Tesle 54', @grad='Beograd'
exec azuriranje_adrese @id=3, @adresa='Tosin Bunar 15'

select * from dbo.faktura
select * from dbo.klijent
select * from dbo.artikalUFakturi