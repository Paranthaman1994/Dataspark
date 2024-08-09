use dataspark;
select * from orders;

-- Total Sales by Year
SELECT YEAR(order_date) AS Year, 
       SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2))) AS Total_Sales
FROM orders
GROUP BY YEAR(order_date)
ORDER BY Year;

-- Top 100 Best-Selling Products
SELECT product_name, 
       SUM(quantity) AS Total_Quantity_Sold
FROM orders
GROUP BY product_name
ORDER BY Total_Quantity_Sold DESC
LIMIT 100;

-- Sales by Country
SELECT country_x, 
       SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2))) AS Total_Sales
FROM orders
GROUP BY country_x
ORDER BY Total_Sales DESC;

-- Average Order Value by Customer
SELECT customerkey, 
       round(AVG(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2))))AS Average_Order_Value
FROM orders
GROUP BY customerkey
ORDER BY Average_Order_Value DESC;

-- Sales Performance by Category
SELECT category, 
       SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2))) AS Total_Sales
FROM orders
GROUP BY category
ORDER BY Total_Sales DESC;

-- Monthly Sales Trend for the Last Year
SELECT YEAR(order_date) AS Year, 
       MONTH(order_date) AS Month, 
       SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2))) AS Total_Sales
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY Year, Month;

-- Top 5 Brand by Sales
SELECT brand, 
       SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2))) AS Total_Sales
FROM orders
GROUP BY brand
ORDER BY Total_Sales DESC
LIMIT 5;

-- Sales by Currency
SELECT currency_code, 
       SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2))) AS Total_Sales
FROM orders
GROUP BY currency_code
ORDER BY Total_Sales DESC;

-- Sales by Store Channel (Online vs Physical Stores)
SELECT CASE 
           WHEN storekey = 0 THEN 'Online'
           ELSE 'Physical Store'
       END AS Store_Channel, 
       SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2))) AS Total_Sales
FROM orders
GROUP BY Store_Channel
ORDER BY Total_Sales DESC;

-- Product Performance by Color
SELECT color, 
       SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2))) AS Total_Sales
FROM orders
GROUP BY color
ORDER BY Total_Sales DESC;

-- Total Number of Product per Customer
SELECT customerkey, 
       COUNT(DISTINCT order_number) AS Total_Orders
FROM orders
GROUP BY customerkey
ORDER BY Total_Orders DESC;

-- Average Unit Price by Product
SELECT product_name, 
       round(AVG(CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2))),2) AS Average_Unit_Price
FROM orders
GROUP BY product_name
ORDER BY Average_Unit_Price DESC;

-- Total Quantity Sold by State
SELECT state_x, 
       SUM(quantity) AS Total_Quantity_Sold
FROM orders
GROUP BY state_x
ORDER BY Total_Quantity_Sold DESC;

-- Number of Products Sold per Order
SELECT order_number, 
       COUNT(DISTINCT productkey) AS Number_of_Products
FROM orders
GROUP BY order_number
ORDER BY Number_of_Products DESC;

-- Top 10 Customers by Total Sales
SELECT customerkey, 
       SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2))) AS Total_Sales
FROM orders
GROUP BY customerkey
ORDER BY Total_Sales DESC
LIMIT 10;

-- Sales by Subcategory
SELECT subcategory, 
       SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2))) AS Total_Sales
FROM orders
GROUP BY subcategory
ORDER BY Total_Sales DESC;

-- Average Quantity Sold per Order
SELECT order_number, 
       round(AVG(quantity)) AS Average_Quantity
FROM orders
GROUP BY order_number
ORDER BY Average_Quantity DESC;

--  Sales Growth Rate Year-over-Year

SELECT YEAR(order_date) AS Year, 
       SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2))) AS Total_Sales,
       LAG(SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2)))) OVER (ORDER BY YEAR(order_date)) AS Previous_Year_Sales,
       (SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2))) - LAG(SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2)))) OVER (ORDER BY YEAR(order_date))) / LAG(SUM(quantity * CAST(REPLACE(unit_price_usd, '$', '') AS DECIMAL(10, 2)))) OVER (ORDER BY YEAR(order_date)) * 100 AS Growth_Rate
FROM orders
GROUP BY YEAR(order_date)
ORDER BY Year;

-- Most Popular Product by Country
SELECT country_x, 
       product_name, 
       SUM(quantity) AS Total_Quantity_Sold
FROM orders
GROUP BY country_x, product_name
ORDER BY country_x, Total_Quantity_Sold DESC;















