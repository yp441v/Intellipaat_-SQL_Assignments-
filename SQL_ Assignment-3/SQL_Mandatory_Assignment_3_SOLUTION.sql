CREATE DATABASE SQL_Mandatory_Assignment_3

USE  SQL_Mandatory_Assignment_3

SELECT * FROM Jomato


--1. Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.

CREATE PROCEDURE DisplayRestaurantsWithTableBooking
AS
BEGIN
    SELECT RestaurantName, RestaurantType, CuisinesType
    FROM dbo.Jomato
    WHERE TableBooking <> 0;
END;
--------Call Procedure ----- 
EXEC DisplayRestaurantsWithTableBooking;

--2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.

BEGIN TRANSACTION

UPDATE Jomato
SET CuisinesType =  'Cafeteria'
WHERE CuisinesType = 'Cafe'

-- Rollback the transaction (to undo the changes)
ROLLBACK 
--to commit the changes
COMMIT;

--3. Generate a row number column and find the top 5 areas with the highest rating of restaurants.

SELECT TOP 5 ROW_NUMBER() OVER (ORDER BY Rating DESC) AS RowNum, Area, Rating FROM Jomato   

---4. Use the while loop to display the 1 to 50.

DECLARE @Number INT = 1

WHILE @Number <= 50
BEGIN
    PRINT @Number
    SET @Number = @Number + 1
END

--5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.

CREATE VIEW TopRatingRestaurant AS
SELECT TOP 5 RestaurantName, Rating
FROM Jomato
ORDER BY Rating DESC
------- to call View -------
Select * from TopRatingRestaurant 

--6. Create a trigger that give an message whenever a new record is inserted.

CREATE TRIGGER SendEmailOnInsert
ON Jomato
AFTER INSERT
AS
BEGIN
    DECLARE @RestaurantName VARCHAR(255);
    DECLARE @Email VARCHAR(255);
    
    SELECT @RestaurantName = RestaurantName, @Email = 'yP441V@gmail.com'
    FROM inserted;

    -- code to send email using sql standard funcation sp_send_dbmail 
       EXEC msdb.dbo.sp_send_dbmail @recipients = @Email, @subject = 'New Record Inserted', 	   @body = 'A new record has been inserted for your restaurant';

END;
