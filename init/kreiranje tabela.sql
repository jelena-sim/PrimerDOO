IF OBJECT_ID('artikalUFakturi') IS NOT NULL DROP TABLE artikalUFakturi
IF OBJECT_ID('faktura') IS NOT NULL DROP TABLE faktura
IF OBJECT_ID('klijent') IS NOT NULL DROP TABLE klijent
IF OBJECT_ID('artikal') IS NOT NULL DROP TABLE artikal
IF OBJECT_ID('promocija') IS NOT NULL DROP TABLE promocija
IF OBJECT_ID('zaposleni') IS NOT NULL DROP TABLE zaposleni
IF OBJECT_ID('popusti') IS NOT NULL DROP TABLE popusti

CREATE TABLE klijent
(
	id INT NOT NULL PRIMARY KEY,
	ime NVARCHAR(10),
	prezime NVARCHAR(10),
	adresa NVARCHAR(20),
	grad NVARCHAR(10),
	stanje INT
)

CREATE TABLE zaposleni
(
	id INT NOT NULL PRIMARY KEY,
	ime NVARCHAR(10),
	prezime NVARCHAR(10),
	uloga NVARCHAR(30)
)

CREATE TABLE promocija
(
	id INT NOT NULL PRIMARY KEY,
	datPocetka DATE,
	datKraja DATE,
	bonus INT
)

CREATE TABLE popusti
(
	id INT NOT NULL PRIMARY KEY,
	poeni INT,
	procenat FLOAT
)

CREATE TABLE faktura
(
	id INT NOT NULL PRIMARY KEY,
	idKlijenta INT,
	idZaposlenog INT,
	datum DATE,
	status NVARCHAR(10),
	idPromocije INT,
	prodajniObjekat NVARCHAR(20),
	grad NVARCHAR(10),
	iznos FLOAT,
	poeni INT,
	iznos_sa_popustom FLOAT,
	constraint fkIdKlijenta foreign key (idKlijenta) references klijent(id),
	constraint fkIdZaposlenog foreign key (idZaposlenog) references zaposleni(id),
	constraint fkIdPromocije foreign key (idPromocije) references promocija(id)
)

CREATE TABLE artikal
(
	id INT NOT NULL PRIMARY KEY,
	naziv NVARCHAR(20),
	poeni INT,
	cena FLOAT
)

CREATE TABLE artikalUFakturi
(
	id INT NOT NULL PRIMARY KEY,
	idArtikla INT,
	idFakture INT,
	constraint fkIdArtikla foreign key (idArtikla) references artikal(id),
	constraint fkIdFakture foreign key (idFakture) references faktura(id)
)
