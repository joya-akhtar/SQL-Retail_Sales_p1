create database sql_project_p1;

 create table retail_sales(
 transactions_id	int  Primary key,
 sale_date	date,
 sale_time	time,
 customer_id  int,	
 gender	   varchar(15),
 age	int,
 category	varchar(25),
 quantiy	int,
 price_per_unit	float,
 cogs	float,
 total_sale float
 );
select * from retail_sales;

select count(*)
from retail_sales;


select * from retail_sales
where transactions_id = 679;

-- Data Exploration

-- How many total sales we have?
 select count(*) from retail_sales;
 
 -- How many unique customers we have ?
 select count(distinct customer_id) 
 from retail_sales;

-- How many unique Category we have ?
 select count(distinct category ) from retail_sales;
 


-- Data Analysis & Business Key Problems with Answers.
-- My Analysis & Findings

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'

 select *
 from retail_sales 
 where sale_date ='2022-11-05';
 
 -- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
 

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy>=3
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
  
  -- 3. Write a SQL query to calculate the total sales (total_sale) for each category.
  
 SELECT 
    category,
    SUM(total_sale) as net_sale
    FROM retail_sales
 GROUP BY category ;


-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
 
 select round(avg (age),2) as avg_age
 from retail_sales
 where category='Beauty';

-- 5.Write a SQL query to find all transactions where the total_sale is greater than 1000.

select*
from retail_sales
where total_sale > 1000;

-- 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select count(transactions_id), gender ,category
from retail_sales
group by gender,category
order by count(transactions_id) desc;

-- 7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
 
 WITH monthly_sales AS (
    SELECT 
        YEAR(sale_date) AS sale_year,
        MONTH(sale_date) AS sale_month,
        ROUND(AVG(total_sale), 2) AS avg_sale,
        ROW_NUMBER() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rn
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT sale_year, sale_month, avg_sale
FROM monthly_sales
WHERE rn = 1
ORDER BY sale_year DESC;

-- 8.Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id ,sum(total_sale)
from retail_sales
group by customer_id
order by  sum(total_sale)
limit 5;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.
select count(distinct customer_id),category
from retail_sales
group by category;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)


select 
				CASE
						WHEN HOUR(sale_time) < 12 THEN 'Morning'
                        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
				ELSE 'Evening'
				END as 'Shift',
		count(*) as 'Orders'
from Retail_sales
group by 1;

-- End of Project
