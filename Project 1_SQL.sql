-- create table
DROP TABLE IF EXISTS retail_sales;
create table retail_sales
(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id	INT,
	gender	VARCHAR(15),
	age	INT,
	category VARCHAR(15),	
	quantiy	INT,
	price_per_unit FLOAT,	
	cogs	FLOAT,
	total_sale FLOAT
);

SELECT * FROM retail_sales
LIMIT 10

-----------DATA CLEANING--------------
--Pentru a numara cate linii sunt
SELECT 
	COUNT(*)
FROM retail_sales
LIMIT 10

--Verificare cate NULL apar
SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

--------SAU MAI RAPID--------
-- verifici daca apare NULL in valori
SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date is NULL
	OR
	gender is NULL
	OR
	category IS NULL
	OR
	quantiy is NULL
	OR
	cogs is NULL
	OR
	total_sale is NULL;

--delete rows cu null
DELETE FROM retail_sales
	WHERE 
	transactions_id IS NULL
	OR
	sale_date is NULL
	OR
	gender is NULL
	OR
	category IS NULL
	OR
	quantiy is NULL
	OR
	cogs is NULL
	OR
	total_sale is NULL;

------------DATA EXPLORATION-----------

--HOW MANY SALES WE HAVE?--
SELECT COUNT(*) as total_sale
FROM retail_sales
--HOW MANY  UNIQUE CUSTOMERS WE HAVE?--
SELECT COUNT(DISTINCT(customer_id)) as total_sale
FROM retail_sales

-------DAT ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS---------------
--Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select *
from retail_sales
where sale_date = '2022-11-05'
--Q2. Write a SQL query to retrieve all transactions where the category is "Clothing" and the quantity sold is more than 4 in the month of Nov-2022
SELECT 
	*
FROM retail_sales
WHERE
	category = 'Clothing'
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantiy >= 4

--Q3. Write a SQL query to calculate the total sales (total_sale) for each category
select 
	category,
	SUM(total_sale) as all_sales_calculated,
	COUNT(*) as total_orders
from retail_sales
group by category
	
----Q4. Writea SQL query to find the average age of customers who purchased items from the "Beauty" category
SELECT avg(age) as average_age
FROM retail_sales
where category = 'Beauty'

--Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT *
FROM retail_sales
where total_sale > 1000
--Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT 
	category,
	gender,
	count(*) as total_trans
from retail_sales
group by category, gender
order by category
--Q7. Write a SQL query to calculate the average sale for each month. Find out the best selling month in each year
select 
	year,
	month, 
	avg_total_sale 
from (

	select 
		EXTRACT(YEAR from sale_date) as year,
		EXTRACT(MONTH from sale_date) as month,
		avg(total_sale) as avg_total_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) order by avg(total_sale) desc)
	from retail_sales
	group by year, month
) as t1
where rank = 1

--Q8. Write a SQL query to find the top 5 customers based on the highest total sales
select 
	customer_id, 
	sum(total_sale) as total_sale
from retail_sales
group by customer_id
order by total_sale desc
limit 5

--Q9. Write a SQL query to find the number of unique customers who purchased items from each category
select 
	count(DISTINCT(customer_id)) as unique_customers, 
	category
from retail_sales
group by category
--Q10. Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12&17, evening >17)

WITH hourly_sale
as
(
select *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time)  BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift
from retail_sales
)
SELECT 
	shift,
	count(*) as total_orders
FROM hourly_sale
group by shift
