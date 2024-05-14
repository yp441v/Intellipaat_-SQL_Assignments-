Create Database SQL_Mandatory_Assignment_1
Use SQL_Mandatory_Assignment_1


CREATE TABLE Salesman (
SalesmanId INT,
Name VARCHAR(255),
Commission DECIMAL(10, 2),
City VARCHAR(255),
Age INT
);

INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
(101, 'Joe', 50, 'California', 17),
(102, 'Simon', 75, 'Texas', 25),
(103, 'Jessie', 105, 'Florida', 35),
(104, 'Danny', 100, 'Texas', 22),
(105, 'Lia', 65, 'New Jersey', 30);


CREATE TABLE Customer (
SalesmanId INT,
CustomerId INT,
CustomerName VARCHAR(255),
PurchaseAmount INT,
);

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
(101, 2345, 'Andrew', 550),
(103, 1575, 'Lucky', 4500),
(104, 2345, 'Andrew', 4000),
(107, 3747, 'Remona', 2700),
(110, 4004, 'Julia', 4545);


CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount money)


INSERT INTO Orders Values
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500)

SELECT * FROM Customer
SELECT * FROM Orders
SELECT * FROM Salesman


--1.Insert a new record in your Orders table.

INSERT INTO Orders (OrderId, CustomerId, SalesmanId, Orderdate, Amount)
VALUES (5004, 5678, 102, '2023-05-10', 1150);

--2. Add Primary key constraint for SalesmanId column in Salesman table. Add default
--constraint for City column in Salesman table. Add Foreign key constraint for SalesmanId
--column in Customer table. Add not null constraint in Customer_name column for the Customer table.
ALTER TABLE Salesman
ALTER COLUMN SalesmanId INT NOT NULL;

ALTER TABLE Salesman
ADD CONSTRAINT PK_Salesman_SalesmanId PRIMARY KEY (SalesmanId);
------
ALTER TABLE Salesman
ADD CONSTRAINT Default_Salesman_City DEFAULT 'NewYork' FOR City;
--------------
DELETE FROM Customer
WHERE SalesmanId = 110 or  SalesmanId = 107

ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_SalesmanId
FOREIGN KEY (SalesmanId) REFERENCES Salesman(SalesmanId);

---
ALTER TABLE Customer
ALTER COLUMN Customername VARCHAR(255) NOT NULL;

--3. Fetch the data where the Customer’s name is ending with ‘N’ 
--also get the purchase amount value greater than 500.

SELECT * FROM Salesman as S
INNER JOIN Customer as C on
S.SalesmanId= C.SalesmanId
WHERE Name LIKE '%N' AND PurchaseAmount > 500

--4. Using SET operators, retrieve the first result with unique SalesmanId values from two
--tables, and the other result containing SalesmanId with duplicates from two tables.

SELECT SalesmanId FROM Customer
UNION 
SELECT SalesmanId FROM Salesman


SELECT SalesmanId FROM Customer
UNION All
SELECT SalesmanId FROM Salesman

--5. Display the below columns which has the matching data 
--Orderdate, Salesman Name, Customer Name, Commission, and City 
--which has thrange of Purchase Amount between 500 to 1500.


SELECT O.Orderdate, S.Name AS SalesmanName, CustomerName, S.Commission, S.City, PurchaseAmount 
FROM Salesman as S
INNER JOIN Customer as C on
S.SalesmanId= C.SalesmanId
INNER JOIN Orders AS O ON
S.SalesmanId= O.SalesmanId
WHERE PurchaseAmount BETWEEN 500 AND 1500

--6. Using right join fetch all the results from Salesman and Orders table.

SELECT * FROM Salesman AS S
RIGHT JOIN Orders AS O ON
S.SalesmanId= O.SalesmanId