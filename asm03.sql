USE master
GO

IF(DB_ID('asm03') IS NOT NULL)
	DROP DATABASE asm03
ELSE
	CREATE DATABASE asm03
GO

USE asm03
GO

CREATE TABLE Services(
	ServiceID int IDENTITY CONSTRAINT pk_serviceid PRIMARY KEY,
	ServiceName nvarchar(10),
	ServiceDescription nvarchar(100)
)

CREATE TABLE Customer(
	CusID int IDENTITY CONSTRAINT pk_cusid PRIMARY KEY (CusID),
	Names nvarchar(20) NOT NULL,
	ID varchar(20) UNIQUE,
	Addres nvarchar(100)
)

CREATE TABLE CusTel(
	CusID int CONSTRAINT fk_cusid FOREIGN KEY REFERENCES Customer(CusID),
	Tel varchar(10) NOT NULL,
	ServiceID int NOT NULL CONSTRAINT fk_serviceid FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID),
	StartDate date,
	EndDate date NULL,
	CONSTRAINT pk_custel PRIMARY KEY (Tel,ServiceID)
)

--3
INSERT INTO Services(ServiceName,ServiceDescription) VALUES('Tra Truoc','Tra Truoc'),('Tra Sau','Tra Sau')
INSERT INTO Customer(Names,ID,Addres) VALUES('Nguyen Van A',113456789,'Ha Noi'),('Nguyen Van B',111136789,'Ha Noi')
INSERT INTO CusTel(CusID,Tel,ServiceID,StartDate) VALUES(1,'0123456789',1,'2001-12-30')

--4
SELECT * FROM Services
SELECT * FROM Customer
SELECT * FROM CusTel
SELECT Custel.* FROM CusTel INNER JOIN Services ON CusTel.ServiceID = Services.ServiceID
SELECT * FROM CusTel INNER JOIN Services ON CusTel.ServiceID = Services.ServiceID
--5
-- SELECT CusTel.* FROM CusTel INNER JOIN Services INNER JOIN Customer ON CusTel.ServiceID = Services.ServiceID AND CusTel.CusID = Customer.CusID
SELECT * FROM CusTel WHERE CusID IN(SELECT CusID FROM CusTel WHERE Tel Like '0123456789') --a

SELECT * FROM Customer WHERE ID LIKE '111136789' --b

SELECT * FROM CusTel WHERE CusID IN(SELECT CusID FROM Customer WHERE ID Like '111136789') --c

SELECT * FROM CusTel Where StartDate LIKE '2001-12-30' --d

SELECT * FROM CusTel INNER JOIN Customer ON CusTel.CusID = Customer.CusID Where Custel.CusID IN(SELECT CusID FROM Customer WHERE Addres Like 'Ha Noi') --e

--6

SELECT COUNT(CusID) FROM Customer --a

SELECT COUNT(DISTINCT Tel) FROM CusTel --b

SELECT COUNT(DISTINCT Tel) FROM CusTel WHERE StartDate = '2001-12-30' --c

SELECT * FROM CusTel INNER JOIN Customer ON CusTel.CusID = Customer.CusID --d

--7

ALTER TABLE CusTel ALTER COLUMN StartDate date NOT NULL --a

ALTER TABLE CusTel
	ADD CONSTRAINT CHK_startdate CHECK(StartDate >= GETDATE()) --b

ALTER TABLE CusTel
	ADD CONSTRAINT CHK_tel CHECK(Tel LIKE '09[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') --c

ALTER TABLE CusTel
ADD RewardPoints INT --d