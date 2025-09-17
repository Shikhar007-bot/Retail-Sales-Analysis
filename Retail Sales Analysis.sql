-- created database Retail Sales 
CREATE DATABASE Retail_Sales_Analysis;
USE Retail_Sales_Analysis;

select * from DataSet;
-- created table Dataset
DROP TABLE IF EXISTS Dataset;
CREATE TABLE DataSet(
				 transaction_id INT PRIMARY KEY,
				 sale_date DATE, 
				 sale_time TIME, 
				 customer_id INT, 
				 gender VARCHAR(10), 
				 age INT NOT NULL, 
				 category VARCHAR(25), 
				 quantity INT,
				 price_per_units FLOAT,
				 cogs FLOAT,
				 total_sale FLOAT
			);
 
Select COUNT(*) from DataSet;

-- Data Cleaning (removing the null rows)
Select * from DataSet
WHERE 
	transaction_id IS NULL
	or 
    sale_date IS NULL
	or 
    sale_time IS NULL
	or 
    customer_id IS NULL
	or 
    gender IS NULL
	or 
    age IS NULL
    or 
    category IS NULL
	or 
    quantity IS NULL
	or 
    price_per_units IS NULL
	or 
    cogs IS NULL
	or 
    total_sale IS NULL;

-- delete the rows which are found null
SET SQL_SAFE_UPDATES = 0;
DELETE FROM DataSet WHERE 
	transaction_id IS NULL
	or 
    sale_date IS NULL
	or 
    sale_time IS NULL
	or 
    customer_id IS NULL
	or 
    gender IS NULL
	or 
    age IS NULL
    or 
    category IS NULL
	or 
    quantity IS NULL
	or 
    price_per_units IS NULL
	or 
    cogs IS NULL
	or 
    total_sale IS NULL;
			
-- Data Exploration

-- how many sales we have
select count(*) from DataSet;
-- how many unique customers we have
select count(distinct(customer_id)) from DataSet;
				
-- how many categories we have
select distinct(category) from DataSet;

-- DATA ANALYSIS OR BUSINESS KEY PROBLEMS AND ANSWERS
-- 1. write the query to retrieve all columns of sales made on 2022-11-05
		select * from DataSet where sale_date = '2022-11-05';
-- 2. write the query to retrieve all the columns with category 'clothing' and quantity sold is more than 10 in the nov
		select * from DataSet where category = 'Clothing' AND DATE_FORMAT(sale_date, '%m') = '11' AND quantity >= 1;
-- 3. Write query to find total sale for each category
		select category ,SUM(total_sale) from DataSet group by category; 
-- 4. Write the query to find average age of customer who purchased the category 'beauty'
		select category, Round(avg(age), 2) as Average_Age from DataSet where category='Beauty';
-- 5. Find all the transactions where total_sales is greater than 1000
		select * from DataSet where total_sale > 1000;
-- 6. write the sql query to find the total number of transactions (transaction_id) made by each gender in each category
		select category, gender, COUNT(transaction_id) from DataSet group by category, gender order by category; 
-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
		select year(sale_date), month(sale_date), ROUND(AVG(total_sale),2) from DataSet 
        group by year(sale_date), month(sale_date)
        order by year(sale_date);
                 
-- 8. Highest top 5 customers total sales 
		select customer_id, SUM(total_sale) from DataSet group by customer_id order by sum(total_sale) Desc LIMIT 5;
-- 9. Write the sql query to find the number of unique customer who purchased items from each category
		select category, count(distinct customer_id) from DataSet group by category; 
-- 10. Write a sql query for each shift and number of orders ( example: morning<= 12 , afternoon between 12 & 17, evening > 17 )
		With Hourly_sale
        AS 
        (
			select *,
				CASE 
					WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
					WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
					ELSE 'Evening'
					END as Shift
			from DataSet
		)
        select shift, COUNT(transaction_id) from Hourly_sale group by shift;
		
        
-- End of Project -- 