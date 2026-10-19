CREATE TABLE coffee_sales (
    Transaction_ID VARCHAR(20) PRIMARY KEY,
    Order_Date DATE,
    Year INT,
    Month VARCHAR(20),
    Day VARCHAR(20),
    Order_Time TIME,
    Hour INT,
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    Unit_Price_RM DECIMAL(10,2),
    Payment_Method VARCHAR(30),
    Order_Type VARCHAR(30),
    Total_Amount_RM DECIMAL(10,2)
);


SELECT *
FROM coffee_sales
LIMIT 10;

-- Overall Sales Performance -- 
SELECT
    COUNT(*) AS Total_Transactions,
    SUM(Quantity) AS Total_Items_Sold,
    ROUND(SUM(Total_Amount_RM), 2) AS Total_Revenue_RM,
    ROUND(AVG(Total_Amount_RM), 2) AS Average_Order_Value_RM
FROM coffee_sales;

-- Which products generate the highest revenue? --  
SELECT
    Product_Name,
    SUM(Quantity) AS Total_Quantity_Sold,
    ROUND(SUM(Total_Amount_RM), 2) AS Total_Revenue_RM
FROM coffee_sales
GROUP BY Product_Name
ORDER BY Total_Revenue_RM DESC;

-- What are the coffee shop's busiest hours? -- 
SELECT
    Hour,
    COUNT(*) AS Total_Transactions,
    SUM(Quantity) AS Total_Items_Sold,
    ROUND(SUM(Total_Amount_RM), 2) AS Total_Revenue_RM
FROM coffee_sales
GROUP BY Hour
ORDER BY Total_Transactions DESC;

-- Which days generate the highest sales? --
SELECT
    Day,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Total_Amount_RM), 2) AS Total_Revenue_RM
FROM coffee_sales
GROUP BY Day
ORDER BY Total_Revenue_RM DESC;

-- What payment methods do customers prefer? --
SELECT
    Payment_Method,
    COUNT(*) AS Total_Transactions,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM coffee_sales),
        2
    ) AS Percentage
FROM coffee_sales
GROUP BY Payment_Method
ORDER BY Total_Transactions DESC;

-- Which product categories generate the highest revenue? --
SELECT
    Category,
    SUM(Quantity) AS Total_Items_Sold,
    ROUND(SUM(Total_Amount_RM), 2) AS Total_Revenue_RM,
    ROUND(
        SUM(Total_Amount_RM) * 100.0 /
        (SELECT SUM(Total_Amount_RM) FROM coffee_sales),
        2
    ) AS Revenue_Percentage
FROM coffee_sales
GROUP BY Category
ORDER BY Total_Revenue_RM DESC;

-- Which Order Type customer prefered the most? --
SELECT
    Order_Type,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Total_Amount_RM), 2) AS Total_Revenue_RM,
    ROUND(AVG(Total_Amount_RM), 2) AS Average_Order_Value_RM
FROM coffee_sales
GROUP BY Order_Type
ORDER BY Total_Revenue_RM DESC;


