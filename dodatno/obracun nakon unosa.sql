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
EXEC dodaj_na_stanje @idFakture=@id
EXEC obracun_cena @idFakture=@id
EXEC obracun_popusta @idFakture=@id
END

