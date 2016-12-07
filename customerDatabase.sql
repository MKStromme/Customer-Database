CREATE DATABASE IF NOT EXISTS store;

CREATE TABLE IF NOT EXISTS customer(C_ID int NOT NULL AUTO_INCREMENT,
	LName nvarchar(255), 
	FName nvarchar(255) NOT NUll, 
	PRIMARY KEY (C_ID));
	
CREATE TABLE IF NOT EXISTS item(I_ID int NOT NULL AUTO_INCREMENT,
	name nvarchar(255),
	description nvarchar(MAX),
	price decimal(n,2),
	PRIMARY KEY(I_ID));
	
CREATE TABLE IF NOT EXISTS customerOrder(O_ID int NOT NULL AUTO_INCREMENT,
	C_ID int NOT NULL,
	buyDate datetime,
	PRIMARY KEY(O_ID),
	FOREIGN KEY(C_ID) REFERENCES customer(C_ID));
	
CREATE TABLE IF NOT EXISTS itemAmount(O_ID int NOT NULL,
	I_ID int NOT NULL,
	amount int NOT NULL,
	PRIMARY KEY(O_ID,I_ID),
	FOREIGN KEY(O_ID) REFERENCES customerOrder(O_ID),
	FOREIGN KEY(I_ID) REFERENCES item(I_ID));
	

	
INSERT INTO customer(LName, FName) VALUES("kjørholt","sondre");
INSERT INTO customer(LName, FName) VALUES("kjørholt","marius");
INSERT INTO customer(LName, FName) VALUES("kjørholt","hanne");
INSERT INTO customer(LName, FName) VALUES("strømme","ola");
INSERT INTO customer(LName, FName) VALUES("strømme","marit");

INSERT INTO item(name, description, price) VALUES("screwdriver","It screws, screws","5.00");
INSERT INTO item(name, description, price) VALUES("hammer","It looks like a nail","1.30");

INSERT INTO customerOrder(C_ID,buyDate) VALUES((SELECT C_ID FROM customer WHERE FName = "marius"),NOW());

INSERT INTO itemAmount(O_ID, I_ID, amount) VALUES(
	(SELECT LAST(O_ID) FROM customerOrder),
	(SELECT I_ID FROM item WHERE name = "hammer"),
	"3");