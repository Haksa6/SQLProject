PRAGMA foreign_keys = ON;

CREATE TABLE Employee(
  EmployeeID INTEGER NOT NULL,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  PRIMARY KEY("EmployeeID" AUTOINCREMENT)
  );


INSERT INTO Employee VALUES 
  (1001, 'Jake', 'DingDong'),
  (1002,	'hEYHEY',	'BigBoss'),
  (1003,	'Sal',	'Ami'),
  (1004,	'Mary',	'Juana'); 

CREATE TABLE Customer (
  CustomerID INTEGER NOT NULL,
  Email VARCHAR(50),
  Address VARCHAR(50),
  PhoneNumber INTEGER,
  PRIMARY KEY("CustomerID" AUTOINCREMENT)
);

INSERT INTO Customer VALUES 
  (2001,	'sadasdasd@123.com',	'StreetYo9',	12312399),
  (2002,	'abcd@bigbang.com',	'BigBallerStreet7',	9999000),
  (2003,	'bigman@lilman.com',	'StreetMan6',	666999000),
  (2004,	'helpme@dontatme.com',	'Cmoon1',	12341234),
  (2005,	'whyuhere@what.com',	'StreetBoys2',	8888777);


CREATE Table PizzaOrder (
  OrderID INTEGER NOT NULL,
  CustomerID INTEGER NOT NULL,
  EmployeeID INTEGER NOT NULL,
  Status BOOLEAN,
  PRIMARY KEY("OrderID" AUTOINCREMENT),
  FOREIGN KEY("CustomerID") REFERENCES Customer("CustomerID")
    ON DELETE CASCADE,
  FOREIGN KEY("EmployeeID") REFERENCES Employee("EmployeeID")
    ON DELETE CASCADE
);


INSERT INTO PizzaOrder VALUES 
  (3001,	2001,	1001,	TRUE),
  (3002,	2001,	1002,	TRUE),
  (3003,	2005,	1002,	TRUE),
  (3004,	2003,	1004,	FALSE),
  (3005,	2004,	1002,	TRUE),
  (3006,	2004,	1003,	FALSE);

CREATE TABLE Receipt(
  OrderID INTEGER NOT NULL,
  TotalPrice INTEGER,
  FOREIGN KEY("OrderID") REFERENCES PizzaOrder("OrderID")
);

INSERT INTO Receipt VALUES 
  (3001,	10),
  (3002,	15),
  (3003,	100),
  (3004,	20),
  (3005,	50);

CREATE TABLE Ingredient (
  IngredientID INTEGER NOT NULL,
  Price INTEGER,
  Name VARCHAR(50),
  PRIMARY KEY("IngredientID" AUTOINCREMENT)
);

INSERT INTO Ingredient VALUES
  (5001,  0.5, 'Tomato'),
  (5002,  1, 'Salami'),
  (5003,  2, 'Ham'),
  (5004,  0.2, 'Olive'),
  (5005,  0.1, 'Pepper'),
  (5006,  1, 'Cheese'),
  (5007,  0.4, 'Onion'),
  (5008,  3, 'Mushroom');

CREATE TABLE PizzaName (
  PizzaID INTEGER NOT NULL,
  Name VARCHAR(50),
  PRIMARY KEY("PizzaID")
);

INSERT INTO PizzaName VALUES 
  (4001, 'Neopolitan'),
  (4002, 'Chicago'),
  (4003, 'Sicilian'),
  (4004, 'Greek'),
  (4005, 'Detroit'),
  (4006, 'California'),
  (4007, 'Salami');


CREATE TABLE Pizza (
  PizzaID INTEGER NOT NULL,
  OrderID INTEGER NOT NULL,
  Price INTEGER,
  FOREIGN KEY("PizzaID") REFERENCES PizzaName("PizzaID")
  FOREIGN KEY("OrderID") REFERENCES PizzaOrder("OrderID")
);

INSERT INTO Pizza VALUES
  (4001, 3001, 7),
  (4002, 3001, 10),
  (4003, 3002, 8),
  (4004, 3003, 15),
  (4005, 3004, 5),
  (4006, 3005, 20),
  (4001, 3006, 7),
  (4007, 3006, 4);
  


CREATE TABLE PizzaNeeds (
  PizzaID INTEGER NOT NULL,
  IngredientID INTEGER NOT NULL,
  FOREIGN KEY("PizzaID") REFERENCES PizzaName("PizzaID")
    ON DELETE CASCADE,
	FOREIGN KEY("IngredientID") REFERENCES Ingredient("IngredientID")
    ON DELETE CASCADE
);

INSERT INTO PizzaNeeds VALUES 
  (4001, 5001),
  (4001, 5006),
  (4002, 5002),
  (4003, 5004),
  (4003, 5006),
  (4004, 5007),
  (4004, 5004),
  (4005, 5002),
  (4005, 5008),
  (4005, 5004),
  (4006, 5005),
  (4006, 5006),
  (4007, 5002),
  (4007, 5003);




