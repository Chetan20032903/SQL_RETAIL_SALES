select * from retail_sales;

select count(*)
from retail_sales;

select * from retail_sales
where ï»¿Transaction_id is null;

select * from retail_sales
where sale_date is null;

select * from retail_sales
where sale_time is null;

-- Data cleaning 
select * from retail_sales
where  ï»¿Transaction_id is null
or 
sale_date is null
or 
sale_time is null
or
gender is null
or
quantiy is null
or
cogs is null
or
total_sale is null
;

-- Data exploration 

-- How many sales do we have?
select count(*) as total_sale
from retail_sales;

-- How many unique customers do we have?
select count(distinct customer_id) as total_sale 
from retail_sales;

-- How many categories do we have?
select distinct category  as total_sale 
from retail_sales;

-- Data Analysis and Business key problems and answers.

-- 1. WAQTD retrive all columns for sales made on '2022-11-05'?

select * 
from retail_sales;

-- 2. WAQTD retrive all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of nov-2022?

select *
from retail_sales
where category = 'Clothing'
and sale_date between '2022-11-01' and '2022-11-30' and quantity >= 4;
;

-- 3. WAQTD calculate teh total sales for each category?
select 
	category,
    sum(total_sale) as net_sale,
    count(*)
from retail_sales
group by 1;

-- 4. WAQTD avg age of customers who purchased items from the 'beauty' category?
select 
	round(avg(age), 2) as avg_age
from retail_sales
where category = 'Beauty';

-- 5. WAQTD all transcations where the total_sale is greater than 1000?
select * from retail_sales
where total_sale > 1000;

-- 6. WAQTD total number of transactions made by eacg gender in each category?
select 
	category, gender, count(*) as total_trans
 from retail_sales
 group by category, gender
 order by 1;

-- 7. WAQTD calculate the avg sale for each month. Find out best selling month in each year?
SELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS sale_rank
    FROM retail_sales
    GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS t1;

-- 8. WAQTD top 5 customers based on the highest total_sale?
select 
	customer_id,
    sum(total_sale) as total_sales
 from retail_sales
 group by 1
 order by 2 desc
 limit 5;
  
-- 9. WAQTD unique customers who purchased items from eacg category?
select 
	count(distinct customer_id) as unique_customers,
    category
 from retail_sales
 group by  category
;

-- 10. WAQTD to create each shift and number of orders (eg morning <12, afternoon 12 & 17, evening > 17)?
with hourly_sale
as
(
SELECT *,
  CASE
    WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift
FROM retail_sales)
select
shift ,
	count(*) as total_orders
    from hourly_sale
    group by shift

-- END OF PROJECT --

























