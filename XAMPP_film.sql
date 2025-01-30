CREATE TABLE film(
filmID int PRIMARY KEY AUTO_INCREMENT,
filmNimetus varchar(30) not null,
aasta int,
eelarveHind decimal(7,1)
);

INSERT INTO film(filmNimetus, aasta, eelarveHind)
VALUES('Riply', 2024, 22000.5),
('Babygirl', 2024, 555555.5),
('Barbie', 2023, 10000.7);

ALTER TABLE film ADD zanrID int;

ALTER TABLE film ADD CONSTRAINT fk_zanr
FOREIGN KEY (zanrID) REFERENCES zanr(zanrID);

UPDATE film SET zanrID=2 WHERE filmID=3
