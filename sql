SELECT * 
FROM [dbo].[Online Sales Data]

-- CHECK FOR DUPLICATES

SELECT Transaction_ID, COUNT(*) number_of_duplicates
FROM [dbo].[Online Sales Data]
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;


SELECT DISTINCT *
FROM [dbo].[Online Sales Data];


-- NO DUPLICATES

-- CHECK IF PRODUCT_CATEGORY, REGION AND PAYMENT_METHOD HAVE MISSPELLINGS


SELECT Product_Category, COUNT(*) number_of_duplicates
FROM [dbo].[Online Sales Data]
GROUP BY Product_Category
HAVING COUNT(*) > 1;


SELECT Region, COUNT(*) number_of_duplicates
FROM [dbo].[Online Sales Data]
GROUP BY Region
HAVING COUNT(*) > 1;


SELECT Payment_Method, COUNT(*) number_of_duplicates
FROM [dbo].[Online Sales Data]
GROUP BY Payment_Method
HAVING COUNT(*) > 1;

-- TRIM WHITE SPACES IN PRODUCT_NAME COLUMN

UPDATE [dbo].[Online Sales Data]
SET Product_Name = TRIM(Product_Name);


SELECT * 
FROM [dbo].[Online Sales Data]


-- WHAT CATEGORY HAS THE MOST SOLD UNITS

SELECT Product_Category, SUM(Units_Sold) AS Units_Sold
from [dbo].[Online Sales Data]
Group by Product_Category
Order by Units_Sold desc


-- WHAT CATEGORY HAS THE MOST TOTAL REVENUE

SELECT Product_Category, ROUND(SUM(Total_Revenue), 2) AS Total_Ctgry_Revenue
from [dbo].[Online Sales Data]
Group by Product_Category
Order by Total_Ctgry_Revenue desc


-- AVERAGE UNITS SOLD per PRODUCT

SELECT Product_Name, AVG(Units_Sold) AS AverageUnitsSold
FROM [dbo].[Online Sales Data]
GROUP BY Product_Name
ORDER BY AverageUnitsSold DESC


-- TOTAL REVENUE BY REGION

SELECT REGION, ROUND(SUM(Total_Revenue),2) AS TotalRevenue
FROM [dbo].[Online Sales Data]
GROUP BY REGION
ORDER BY TotalRevenue DESC


-- TOP 10 PRODUCTS BY REVENUE

SELECT TOP 10 Product_Name, ROUND(SUM(Total_Revenue), 2) AS TotalRevenue
FROM [dbo].[Online Sales Data]
GROUP BY Product_Name
ORDER BY TotalRevenue DESC


-- MONTHLY REVENUE TREND

SELECT YEAR(Date) AS Year, MONTH(Date) AS Month,
    ROUND(SUM(Total_Revenue), 2) AS TotalRevenue
FROM [dbo].[Online Sales Data]
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month


-- MONTHLY REVENUE AND RUNNING TOTAL

WITH MonthlyRevenue AS (
    SELECT YEAR(Date) AS Year, MONTH(Date) AS Month,
        SUM(Total_Revenue) AS TotalRevenue
    FROM [dbo].[Online Sales Data]
    GROUP BY YEAR(Date), MONTH(Date)
)
SELECT Year, Month, TotalRevenue,
    SUM(TotalRevenue) OVER (ORDER BY Year, Month) AS RunningTotalRevenue
FROM MonthlyRevenue
ORDER BY Year, Month


-- PRODUCTS THAT HAVE HIGHER THAN AVERAGE REVENUE

SELECT Product_Name, Total_Revenue
FROM [dbo].[Online Sales Data]
WHERE Total_Revenue > (SELECT AVG(Total_Revenue) FROM [dbo].[Online Sales Data]);


