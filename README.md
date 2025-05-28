
## 📊 Project: Retail Sales Analysis – SQL

**Level**: Beginner  
**Database**: `retail_sales`  
**Technologies**: PostgreSQL (compatible with other SQL databases)

### 🧠 Project Objective

This project demonstrates the use of SQL for analyzing retail sales data through a series of practical steps:

1. Creating the database and importing data.
2. Cleaning and exploring the dataset.
3. Answering key business questions using SQL queries.
4. Extracting insights related to customer behavior and sales performance.

---

### 🗂 Project Structure

#### 1. ✅ Database Setup

- Create a table named `retail_sales` with the following columns:
  - `transactions_id`, `sale_date`, `sale_time`, `customer_id`, `gender`, `age`, `category`, `quantiy`, `price_per_unit`, `cogs`, `total_sale`
- Populate the table using the provided `.csv` file.

#### 2. 🧼 Data Cleaning

- Check for `NULL` values in all columns.
- Delete all rows with missing or incomplete data.

#### 3. 🔎 Data Exploration

- Total number of sales.
- Total number of unique customers.
- List of distinct product categories.

#### 4. 📌 Business Questions Answered

- Retrieve all sales made on `2022-11-05`
- Get all Clothing category sales in November with quantity > 4
- Calculate total sales and number of orders per category
- Find average age of customers in the "Beauty" category
- List transactions with total_sale > 1000
- Count of transactions per gender and category
- Best performing sales month in each year (based on average sales)
- Top 5 customers by total sales amount
- Unique customer count per product category
- Order distribution by time of day (Morning, Afternoon, Evening)

---

### 🧾 Sample SQL Queries

SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

SELECT category, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category;

SELECT shift, COUNT(*) AS total_orders
FROM (
  SELECT *,
         CASE
           WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
           WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
         END AS shift
  FROM retail_sales
) AS shifts
GROUP BY shift;

---

### 📈 Conclusions

This project provides a solid foundation in SQL for data analysis, simulating real-world business requirements. It is ideal for a junior data analyst portfolio and demonstrates:

- Proficiency with essential SQL commands
- Data cleaning and EDA
- Extracting actionable business insights from raw sales data
