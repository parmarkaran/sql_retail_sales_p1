-- CREATE TABLE
CREATE TABLE retail_sales(
		transactions_id		INT PRIMARY KEY,
		sale_date			DATE,
		sale_time			TIME,
		customer_id 		INT,
		gender				VARCHAR(10),
		age					INT,
		category			VARCHAR(15),
		quantiy				INT,
		price_per_unit		FLOAT,
		cogs				FLOAT,
		total_sale			FLOAT
	);

	
SELECT COUNT(*) FROM RETAIL_SALES;

-- 
SELECT * FROM retail_sales
WHERE transactionS_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

DELETE FROM retail_sales
WHERE
	transactionS_id IS NULL
	OR
	sale_time IS NULL
	OR 
	SALE_DATE IS NULL
	OR
	GENDER IS NULL
	OR
	CATEGORY IS NULL
	OR 
	QUANTIY IS NULL
	OR 
	COGS IS NULL
	OR 
	TOTAL_SALE IS NULL
	;

-- HOW MANY SALES DO WE HAVE
SELECT COUNT(*) AS TOTAL_SALES FROM RETAIL_SALES;

--  HOW MANY UNIQUE CUSTOMERS DO WE HAVE?
SELECT COUNT (DISTINCT customer_id) AS total_customers FROM retail_sales;

-- how many categories do we have ?
SELECT COUNT (DISTINCT category) AS total_catagories FROM retail_sales;

-- DATA ANALYSIS PROBLEMS

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05':
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05'
;

/* 2. Write a SQL query to retrieve all transactions where the category 
   is 'Clothing' and the quantity sold is more than 4 in the 
   month of Nov-2022: */
SELECT * FROM retail_sales
WHERE
	category = 'Clothing'
  AND
  	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' 
  AND 
  	QUANTIY >= 4
--GROUP BY 1

/*3. Write a SQL query to calculate the total sales (total_sale) 
for each category.*/

SELECT category, SUM(total_sale), COUNT(*) AS total_numbers FROM retail_sales
GROUP BY 1

/*4. **Write a SQL query to find the average age of customers who 
purchased items from the 'Beauty' category */

SELECT ROUND(AVG(age), 2)
FROM   retail_sales
WHERE  category = 'Beauty'

/*5. Write a SQL query to find all transactions where the total_sale
is greater than 1000 */

SELECT *
FROM   retail_sales
WHERE  total_sale >= 1000
GROUP BY 1

/*6. Write a SQL query to find the total number of transactions
(transaction_id) made by each gender in each category*/

SELECT  category,
		gender,
		COUNT(*)	
FROM    retail_sales
GROUP BY 
	    category,
		gender
ORDER BY 1

/*7. Write a SQL query to calculate the average sale for each month.
Find out best selling month in each year*/
SELECT * FROM
(
SELECT 
		EXTRACT (YEAR FROM sale_date) as year,
		EXTRACT (MONTH FROM sale_date) as month,
		AVG(total_sale) as AVG_SALES,
		RANK() OVER (PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
FROM 	retail_sales
GROUP BY 1,2) as t1
WHERE rank = 1

/*8. Write a SQL query to find the top 5 customers based on the
highest total sales*/

SELECT customer_id,
	   SUM(total_sale) as total_sale
FROM retail_sales
GROUP BY 1
ORDER BY 2
LIMIT 5

/*9. Write a SQL query to find the number of unique customers who
purchased items from each category.*/

SELECT COUNT(DISTINCT customer_id) as id,
	   category
FROM retail_sales
GROUP BY category

/*10. Write a SQL query to create each shift and number of orders 
(Example Morning <12, Afternoon Between 12 & 17, Evening >17)*/

WITH hourly_sale as 
(
SELECT *,
	CASE
		WHEN EXTRACT (HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as SHIFT
FROM RETAIL_SALES
)
SELECT 
	shift,
	COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift

--END OF PROJECT


