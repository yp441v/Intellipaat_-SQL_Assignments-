CREATE DATABASE SQL_Mandatory_Assignment_2

USE SQL_Mandatory_Assignment_2


SELECT * FROM Jomato


--1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick Chicken Bites’.

CREATE FUNCTION dbo.UpdateQuickBites(@restauranttype varchar(255))
RETURNS varchar(255)
AS
BEGIN
  DECLARE @updatedType varchar(255);

  IF @restaurantType = 'Quick Bites'
  BEGIN
    SET @updatedType = 'Quick Chicken Bites';
  END
  ELSE
  BEGIN
    SET @updatedType = @restauranttype;
  END

  RETURN @updatedType;
END;

---------------------To update -----------------------------
UPDATE dbo.Jomato
SET RestaurantType = dbo.UpdateQuickBites(RestaurantType);
------------------------To call the function----------------
Select dbo.UpdateQuickBites(RestaurantType) from Jomato


--2. Use the function to display the restaurant name and cuisine type which has the maximum number of rating.

SELECT  TOP (1) RestaurantName, CuisinesType, No_of_Rating
FROM  Jomato 
Order by No_of_Rating Desc

--3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
--start rating, ‘Good’ if it has above 3.5 and below 4 star rating, ‘Average’ if it is above 3
--and below 3.5 and ‘Bad’ if it is below 3 star rating and.

SELECT * FROM Jomato

ALTER TABLE Jomato
ADD RatingStatus VARCHAR(20);

UPDATE Jomato
SET RatingStatus = 
    CASE
        WHEN Rating > 4 THEN 'Excellent'
        WHEN Rating > 3.5 THEN 'Good'
        WHEN Rating > 3 THEN 'Average'
        ELSE 'Bad'
    END;


--4. Find the Ceil, floor and absolute values of the rating column and display the current
--date and separately display the year, month_name and day.

SELECT
rating,
CEILING(rating) AS ceil_rating,
FLOOR(rating) AS floor_rating,
ABS(rating) AS absolute_rating,
GETDATE() AS currentdate,
DATEPART(YY,GETDATE()) AS  CurrentYear,	
DATEPART(mm,GETDATE()) AS Currentmonth,
DATEPART(dd,GETDATE()) AS CurrentDay
FROM jomato


--5. Display the restaurant type and total average cost using rollup.

SELECT * FROM Jomato

SELECT RestaurantType, AVG(AverageCost) AS total_average_cost
FROM Jomato
GROUP BY ROLLUP(restauranttype)

