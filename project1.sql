drop table if exists Retail_sales;
create table Retail_sales
(
	transactions_id int primary key,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(10),
	age int,
	category varchar(15),
	quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float

);

select * from retail_sales;

select * from retail_sales
where transactions_id is null
	  or sale_date is null 
	  or sale_time is null
	  or customer_id is null
	  or gender is null
	  or category is null 
	  or quantiy is null 
	  or price_per_unit is null
	  or cogs is null
	  or total_sale is null

delete from retail_sales
where transactions_id is null
	  or sale_date is null 
	  or sale_time is null
	  or customer_id is null
	  or gender is null
	  or category is null 
	  or quantiy is null 
	  or price_per_unit is null
	  or cogs is null
	  or total_sale is null

-- Data Exploration

-- How many sales we have?
select count(*)as total_sales from retail_sales

-- how many unique customer we have?
select count(distinct customer_id)as total_customers from retail_sales 

-- how many category we have?
select distinct category from retail_sales 


-- ************Data Analysis & key answers******************

-- Ques1 -: Wrtie a sql query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales
where sale_date = '2022-11-05'

-- Ques2 -: Write a sql query to retrive all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of nov-2022

select * from retail_sales
where category = 'Clothing' and to_Char(sale_date ,'yyyy-mm') = '2022-11' and quantiy >=4


-- Ques3 -: Write a sql query to calculate the total sales (total sale) for each category?
select category , sum(total_sale) as totalsales from retail_sales
group by 1

-- Ques4 -: Write a sql query to find the average age of customer who purchased items from the 'Beauty ' category ?

select round(avg(age),2) from retail_sales
where category = 'Beauty'

-- Ques5 -: Write a sql Query to find all the transaction where the total sales is greater than 1000?

select * from retail_sales
where total_sale >1000

-- Ques6 -: write a sql to find the total number of transactions (transaction_id) made by each gender in each category ?

select category,gender, count(*) as total_transaction
from retail_Sales
group by category , gender
order by 1

-- Ques7 -: Write a sql query to calculate the average sale for each month . finf out the best selling month in each year?

select year , month , avg_sale from 
(
select extract (year from sale_date) as year ,
	extract (month from sale_date) as month ,
	avg(total_sale) as avg_sale,
	rank() over (partition by extract (year from sale_date) order by avg(total_sale)desc ) as rank
	from retail_sales
	group by 1,2
) as t1
where rank =1

-- Ques8 -: Write a sql query to find the top 5 customers based on the highest total sale?

select customer_id , sum(total_sale) as total_Sales 
from retail_Sales 
group by 1
order by 2 desc
limit 5


-- Ques9 - : Write a sql query to find the unique customers who purchased items form each category ?

select count(distinct customer_id) as unique_customers , category 
from retail_sales
group by category


-- Ques10 -: Write a sql query to create each shift and number of orders (example MOrning <=12 , Afternoon Between 12 & 17 , Evening >17 )?

with hourly_sale
as 
(
Select * ,
	case
		when extract (hour from sale_time) <12 then 'Morning'
		when extract (hour from sale_time) between 12 and 17 then ' afternoon'
		else 'Evening'
	end as shift 
from retail_Sales
)
select shift, count(*) as total_orders
from hourly_sale
group by shift


-- End of project ----