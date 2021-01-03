USE master
GO

IF(DB_ID('asm02') IS NOT NULL)
	DROP DATABASE asm02
GO

CREATE DATABASE asm02
GO

USE asm02
GO

CREATE TABLE Category(
	CategoryID int CONSTRAINT pk_catid PRIMARY KEY,
	CatName nvarchar(100)
)

CREATE TABLE Company(
	ComID int CONSTRAINT pk_company PRIMARY KEY,
	ComName nvarchar(100),
	Tel varchar(10),
	Addres nvarchar(100)
)

CREATE TABLE Product(
	ProductID int CONSTRAINT pk_productid PRIMARY KEY,
	ProductName nvarchar(100),
	ProductUnit varchar(10),
	ProductPrice money,
	ProductQuantity int,
	ProductDescription nvarchar(1000),
	CatID int,
	ComID int,
	CONSTRAINT fk_catid FOREIGN KEY (CatID) REFERENCES Category(CategoryID),
	CONSTRAINT fk_comid FOREIGN KEY (ComID) REFERENCES Company(ComID)
)


SELECT * FROM Category
SELECT * FROM Company
SELECT * FROM Product

--3
INSERT INTO Category(CategoryID,CatName)
VALUES  (1,'Computer'),
		(2,'TelePhone'),
		(3,'Printer')
		
INSERT INTO Company(ComID,ComName,Tel,Addres)
VALUES  ('123','Asus','983232','USA')

INSERT INTO Product(ProductID,ProductName,ProductUnit,ProductPrice,ProductQuantity,ProductDescription,CatID,ComID)
VALUES  ('1',N'Máy Tính T450',N'Chiếc',1000,10,N'Máy nhập cũ',1,123),
		('2',N'Điện Thoại Nokia5670',N'Chiếc',200,200,N'Điện thoại đang hot',2,123),
		('3',N'Máy In Samsung 450',N'Chiếc',100,10,N'Máy in đang loại bình',3,123)
--4
SELECT * FROM Company
SELECT * FROM Product

--5
SELECT * FROM Company ORDER BY ComName DESC

SELECT * FROM Product ORDER BY ProductPrice DESC

SELECT * FROM Company WHERE ComName = 'Asus'

SELECT * FROM Product WHERE ProductQuantity < 11

SELECT * FROM Product WHERE ComID = '123'

--6
SELECT COUNT(ComID) AS N'Số hãng sản phẩm mà cửa hàng có' FROM Company

SELECT COUNT(ProductID) AS N'Tổng Số Mặt Hàng' FROM Product

SELECT ComID, COUNT(ProductID) AS N'Tổng Số Loại SP' FROM Product GROUP BY ComID

SELECT SUM(ProductQuantity) AS N'Tổng số đầu SP' FROM Product
--7
ALTER TABLE Product
	ADD CONSTRAINT CHK_price CHECK(ProductPrice>0)

ALTER TABLE Company
	ADD CONSTRAINT CHK_tell CHECK(Tel = '0[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')

sp_depends Company
sp_depends Product
sp_depends Category