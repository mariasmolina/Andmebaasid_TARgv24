use TARgv24;
CREATE TABLE laps(
lapsID int primary key identity(1,1),
nimi varchar(10) not null,
pikkus smallint,
synniaasta smallint,
synnilinn varchar(20)
);
SELECT * FROM laps;

INSERT INTO laps(nimi, pikkus, synniaasta, synnilinn)
VALUES
('Kati', 156, 2001, 'Tallinn'),
('Mati', 166, 2005, 'Tartu'),
('Sati', 176, 2001, 'Tallinn'),
('Tati', 126, 2000, 'Tallinn'),
('Nuti', 125, 2003, 'Tartu');

--sorteerimine
SELECT nimi, pikkus
FROM laps  --tabelist 'laps'
ORDER by pikkus DESC;  --sorteerimine pikkuse järgi
--ASC (ei kirjuta), DESC (suurimast väikseni)

--sorteerimine mitme tingimuse järgi
SELECT nimi, pikkus
FROM laps
ORDER by pikkus DESC, nimi;

--võrdlus
--lapsed, mis on sündinud peale 2005
SELECT nimi, synniaasta
FROM laps
WHERE synniaasta >=2005 --tingimus lõpus
ORDER by nimi; --kui soovime koos sorteerimisega(lõpus)

--DISTINCT (näitab ainult 1 kordus)
SELECT DISTINCT synniaasta
FROM laps
WHERE synniaasta>2000;


--BETWEEN
--lapsed, mis on sündinud (2000 kuni 2005)
SELECT nimi, synniaasta
FROM laps
WHERE synniaasta >=2000 AND synniaasta <=2005

--sama tulemus, ilma matemaatika operaatoriteta (BETWEEN)
SELECT nimi, synniaasta
FROM laps
WHERE synniaasta BETWEEN 2000 AND 2005;


--LIKE (võrdlus)
--näita lapsed, kelle nimi algab 'K'
SELECT nimi
FROM laps
WHERE nimi LIKE 'K%' -- % kõik võimalikud sümbolid
--sisaldab K täht - '%K%'
SELECT nimi
FROM laps
WHERE nimi LIKE '%K%'
-- %K - sisaldab 'K' täht lõpus

--täpsem määratud tähtede arv '_' 
SELECT nimi
FROM laps
WHERE nimi LIKE '_a__'


--TINGIMUSE KOMBINEERIMINE
--OR (kõik võimalikud variandid)
SELECT nimi, synnilinn
FROM laps
WHERE nimi LIKE '%K%' 
OR synnilinn LIKE 'Tartu';
--AND
SELECT nimi, synnilinn
FROM laps
WHERE nimi LIKE '%K%' 
AND synnilinn LIKE 'Tartu';


--Agregaatfunktsioonid
-- SUM, AVG, MIN, MAX, COUNT
SELECT COUNT(nimi) AS lasteARV --uus veerg (ei salesta tabelisse)
FROM laps;

-- 'laste Arv' - kirjutame nii, kui soovime ruumi tekstis
SELECT AVG(pikkus) AS 'keskmine pikkus'
FROM laps;

--lisame tingimus
SELECT AVG(pikkus) AS 'keskmine pikkus'
FROM laps
WHERE synnilinn='Tallinn';

--näita keskmine pikkus linnade järgi (2 veergu)
-- GROUP by
SELECT AVG(pikkus) AS 'keskmine pikkus', synnilinn
FROM laps
GROUP by synnilinn

--näita laste arv, mis on sündinud konkreetselt synniaastal
SELECT synniaasta, COUNT(*) AS 'laste arv'
FROM laps
GROUP by synniaasta;


--HAVING - piirang juba grupeeritud andmete osas (lõpus)
--keskmine pikkus, iga synniaasta järgi
SELECT synniaasta, AVG(pikkus) AS keskmine
FROM laps
GROUP by synniaasta
HAVING AVG(pikkus)>150; --tingimus

SELECT synniaasta, AVG(pikkus) AS keskmine
FROM laps
WHERE NOT synniaasta=2001
GROUP by synniaasta;


------------------------------------
--seotud tabel (nt 2 tabelid seotud
CREATE TABLE loom(
loomID int PRIMARY KEY identity(1,1),
loomNimi varchar(50),
lapsID int,
FOREIGN KEY (lapsID) REFERENCES laps(lapsID)
);

INSERT INTO loom(loomNimi, lapsID)
VALUES('kass Kott', 1),
('koer Bobik',1),
('koer Tuzik',2),
('koer Bobik',1),
('kass Murzik',3),
('kilpkonn Mura',3),
('kass Feli',3);

SELECT * FROM loom;

--select seotud tabelite põhjal
SELECT * FROM loom, laps; -- ei näita õiged andmed

-- näitab õigesti (keeruline vaade)
-- INNER JOIN
SELECT * FROM loom
INNER JOIN laps
ON loom.lapsID=laps.lapsID;

--näitab õigesti (lihtne vaade)
SELECT * FROM loom, laps
WHERE loom.lapsID=laps.lapsID;

--anname hüüdnimi (psevdonim)
SELECT l.loomNimi, la.nimi, la.synniaasta 
FROM loom l, laps la
WHERE l.lapsID=la.lapsID;
