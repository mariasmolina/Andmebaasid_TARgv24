CREATE DATABASE AndmebaasMariaSmolina;


USE AndmebaasMariaSmolina;
CREATE TABLE film(
filmID int PRIMARY KEY identity(1,1),
filmNimetus varchar(30) not null,
aasta int,
eelarveHind decimal(7,1)
);
SELECT * FROM film;

--tabeli kustutamine 
DROP TABLE film;

--andmete sisestamine tabelisse
INSERT INTO film(filmNimetus, aasta, eelarveHind)
VALUES('Riply', 2024, 22000.5),
('Babygirl', 2024, 555555.5),
('Barbie', 2023, 10000.7);
(' ', 2024, 22000.5);

--andmete kustutamine tabelist
DELETE FROM film WHERE filmID=5;


-----------------------------------
CREATE TABLE zanr(
zanrID int PRIMARY KEY identity(1,1),
zanrNimetus varchar(20) UNIQUE
)

INSERT INTO zanr(zanrNimetus)
VALUES('draama'),('detektiiv');
SELECT * FROM zanr;

--tabeli film struktuuri muutmine --> uue vergu lisamine
ALTER TABLE film ADD zanrID int;
SELECT * FROM film;

--tabeli film struktuuri muutmine -->
--FK lisamine mis on seotud tabeliga zanr (zanrID)
ALTER TABLE film ADD CONSTRAINT fk_zanr
FOREIGN KEY (zanrID) REFERENCES zanr(zanrID);

select * from film;
select * from zanr;
UPDATE film SET zanrID=2 WHERE filmID=3


------------------------------------
CREATE TABLE rezisoor(
rez_ID int PRIMARY KEY identity(1,1),
nimi varchar(20) UNIQUE,
synniaeg DATE,
riik varchar(25) not null
)

select * from rezisoor;

INSERT INTO rezisoor(nimi, synniaeg, riik)
VALUES('Smolina Maria', '1996-07-20', 'Estonia');

ALTER TABLE film ADD rez_ID int;

ALTER TABLE film ADD CONSTRAINT fk_rez
FOREIGN KEY (rez_ID) REFERENCES rezisoor(rez_ID);

UPDATE film SET rez_ID=2 WHERE filmID=2

CREATE TABLE kinokava(
kava_ID int PRIMARY KEY identity(1,1),
kuupaev DATE,
pileti_hind decimal(2,1),
saal int
);
---kustutamine
DROP TABLE kinokava;

INSERT INTO kinokava(kuupaev, pileti_hind, saal)
VALUES('2025-02-24', 6.9, 4);

ALTER TABLE kinokava ADD filmID int;

ALTER TABLE kinokava ADD CONSTRAINT fk_film
FOREIGN KEY (filmID) REFERENCES film(filmID);

UPDATE kinokava SET filmID=1 WHERE kava_ID=1

ALTER TABLE film DROP COLUMN kava_ID;


select * from film;
select * from rezisoor;
select * from kinokava;
