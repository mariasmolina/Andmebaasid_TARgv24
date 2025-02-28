--- Kasutaja loomine

Create database kasutajaTAR;
use kasutajaTAR;

--Security-->Login-->New Login

Create table test(
id int primary key,
nimetus varchar(10))

--Õiguste määramine
--GRANT 'tegevus' ON 'tabelinimi' TO 'kasutajanimi';
GRANT INSERT, SELECT ON test TO opilaneMaria;

--Õiguste keelamine
DENY DELETE ON test TO opilaneMaria;
