-- SQL RETAIL SALES ANALYSIS --> P1
Create DATABASE SQL_PROJECT1;
USE SQL_PROJECT1;
-- CREATE TABLE
DROP TABLE IF exists RETAIL_SALES;
CREATE table Retail_sales
(transactions_id INT primary key,
	sale_date date,	
    sale_time time,
	customer_id int,
	gender varchar(8),
    age int,
	category varchar(15),
	quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float
    );
    desc Retail_sales;
    select * from Retail_sales;
    
CREATE table Retail_sales1
(transactions_id INT primary key,
	sale_date date,	
    sale_time time,
	customer_id int,
	gender varchar(8),
    age int,
	category varchar(15),
	quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float
    );
select * from retail_sales 
order by transactions_id limit 500 offset 249;
select * from retail_sales;

select * from retail_sales
where transactions_id is null
or sale_date is null 
or sale_time is null
or customer_id is null
or gender is null
or age is null or 
category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;

-- DATA EXPLOARATION
-- 1. HOW MANY TOTAL SALE ARE THERE
SELECT COUNT(*) AS TOTAL_SALES FROM retail_sales;

-- HOW MANY UNIQUE CUSTOMERS ARE THERE?
SELECT COUNT(distinct CUSTOMER_ID) AS UNIQUE_CU FROM retail_sales;

-- HOW MANY CATEGORIES
SELECT DISTINCT CATEGORY FROM retail_sales;

-- what is average total_sale ?
SELECT round(AVG(total_sale),2) AS avg_sales_per_transaction
FROM retail_sales;

-- DATA ANALYSIS, BUSINESS KEY PROBLEM AND SOLUTION

-- 	Q1.Write a SQL query to retrieve all columns for sales made on '2016-12-22':
SELECT * FROM retail_saleS
WHERE SALE_DATE = '2016-12-22';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM retail_sales
WHERE category = 'CLOTHING'
AND quantiy >=4
AND YEAR(SALE_DATE) =2022
AND MONTH(SALE_DATE)=11; 

select category,
sum(quantiy) from retail_sales
where category='clothing'
group by 1;

-- Q3.Write a SQL query to calculate the total sales (total_sale) for each category.
select CATEGORY,
count(*) as total_orders,
SUM(TOTAL_SALE) AS Net_Sale
FROM retail_sales
GROUP BY 1;

-- Q4. Write a SQL query to find the average age of customers who purchased 
-- items from the 'Beauty' category.
SELECT 
CATEGORY,
ROUND(AVG(AGE),2)
 AS AVG_AGE
FROM retail_sales
WHERE CATEGORY ='BEAUTY';

-- Q5.Write a SQL query to find all transactions 
-- where the total_sale is greater than 1000.

SELECT * FROM retail_sales 
WHERE TOTAL_SALE >1000
ORDER BY TOTAL_SALE; 

-- Q6.Write a SQL query to find the total number of transactions (transaction_id)
--  made by each gender in each category.

SELECT
	gender,
    category,
	count(Transactions_id)from 
    retail_sales
    group by 1,2
    order by 2;
    
    -- Q7. Write a SQL query to calculate the average sale for each month. 
    -- Find out best selling month in each year
    SELECT 
extract( YEAR from SALE_DATE) as years,
   extract(MONTH from SALE_DATE) as months,
    Avg(total_sale) as avg_sale,
    rank() over(partition by extract( YEAR from SALE_DATE) order by
	Avg(total_sale)desc) as ranks
    from retail_sales
    group by 1,2;
    
    select category,
    year(sale_date) from retail_sales;
    
    -- Q8.Write a SQL query to find the top 5 customers based on the highest total sales
    SELECT DISTINCT customer_id,
    SUM(TOTAL_SALE) AS SALES
    FROM retail_sales
    GROUP BY 1
    ORDER BY 2 DESC LIMIT 5;
    
    -- Q9.Write a SQL query to find the number of unique customers who purchased items from each category.
    SELECT 
    CATEGORY,
    COUNT(DISTINCT  CUSTOMER_ID) AS UNIQUE_CUATOMERS
    FROM retail_sales
    GROUP BY 1;
    
    -- Q10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
    
    WITH HOURS_TABLE AS 
    (SELECT *,
    CASE 
    WHEN EXTRACT(HOUR FROM SALE_TIME) <12 THEN "MORNING"
    WHEN EXTRACT(HOUR FROM SALE_TIME) BETWEEN 12 AND 17 THEN "AFTERNOON"
    ELSE "EVENING"
    END AS Shift
    FROM retail_sales
    )
    SELECT 
    SHIFT,
    COUNT(transactions_id) AS Total_orders
    FROM HOURS_TABLE
    GROUP BY 1
    ;
    
    select * from retail_sales;
    
    -- Q11. Gender wise sales in each category
    select gender,
    CATEGORY,
    sum(total_sale) AS rEVENUE
    FROM retail_sales
    group by 1,2
    ORDER BY 2;
    
SELECT AVG(total_sale) AS avg_sales_per_transaction
FROM retail_sales;
    
-- Q12. Customer Purchase Frequency (Repeat Customers)
SELECT CUSTOMER_ID, 
COUNT(DISTINCT TRANSACTIONS_ID) AS NUM_TRANSACTIONS
FROM retail_sales
GROUP BY 1
HAVING  NUM_TRANSACTIONS >1
ORDER BY 2 DESC;

-- Q13. Total Sales by Age Group
SELECT 
CASE
WHEN AGE BETWEEN 18 AND 24 THEN "18-24"
WHEN AGE between 25 and 30 THEN "25-30"
WHEN AGE between 31 AND 35 THEN "31-35"
ELSE "ABOVE 35"
END AS AGE_GROUP,
SUM(TOTAL_SALE) AS TOTAL_SALE
 FROM retail_sales
 GROUP BY AGE_GROUP
 ORDER BY AGE_GROUP;
 
 -- Q14. . Total Sales per Hour (Sales Distribution by Time)
SELECT HOUR(SALE_TIME) AS HOURS,
SUM(TOTAL_SALE) AS TOTAL_SALES
FROM retail_sales
group by 1
ORDER BY 1;

-- Q15. TOTAL PROFIT CATEGORY WISE
SELECT CATEGORY,
ROUND(SUM(total_sale - cogs),2) AS TOTAL_PROFIT
FROM retail_sales
GROUP BY CATEGORY
ORDER BY 2 DESC;





SELECT HOUR(sale_time) AS sale_hour, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY sale_hour
ORDER BY sale_hour;

