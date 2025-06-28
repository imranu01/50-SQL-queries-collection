# SQL Queries for Orders Data Analysis

# Table Creation:
## "Create a table named 'orders_data' with columns for order details including order_id (string), order_date (date), ship_date (date), customer_name (string), region (string), city (string), category (string), product_id (string), sales (float), quantity (float), and profit (float)."

sql
CREATE TABLE [dbo].[orders_data](
   [order_id] [nvarchar](20) NULL,
   [order_date] [date] NULL,
   [ship_date] [date] NULL,
   [customer_name] [nvarchar](30) NULL,
   [region] [nvarchar](10) NULL,
   [city] [nvarchar](20) NULL,
   [category] [nvarchar](20) NULL,
   [product_id] [nvarchar](50) NULL,
   [sales] [float] NULL,
   [quantity] [float] NULL,
   [profit] [float] NULL
);


# Basic Retrieval:
## "Retrieve all records from the 'orders_data' table."

sql
select * from orders_data;


## "Retrieve all records from the 'returns_data' table."

sql
select * from returns_data;

# Specific Columns:
## "Fetch the order_id, order_date, and sales columns from the 'orders_data' table."

sql
  select order_id,order_date,sales from orders_data;


# Top-N with Sorting:
## "Get the top 10 orders with the highest sales and profit, showing order_id, order_date, sales, and profit."

sql
select top 10 order_id,order_date,sales,profit from orders_data;

# Multi-Column Sorting:
## "Retrieve all orders sorted by order_date (newest first), quantity (highest first), and sales (highest first)."

sql
select * from orders_data order by order_date desc,quantity desc,sales desc;

# Top Profitable Orders:
## "List the top 5 highest sales records from 'orders_data'."

sql
select top 5 * from orders_data order by sales desc;

# Derived Column:
## "Calculate the profit-to-sales ratio for all orders and sort by this ratio (highest first)."

sql
select *, profit/sales as ratio from orders_data order by ratio desc;

# Filtering (Exact Match):
## "Find all orders from the 'Central' region."

sql
select * from orders_data where region='central';

# Filtering with Aggregation:
## "Show the top 10 orders where quantity sold is greater than 3, sorted by quantity (highest first)."

sql
select top 10 * from orders_data where quantity>3 order by quantity desc;

# Date Filtering:
## "Retrieve orders placed after June 9, 2018, sorted by order_date."

sql
select * from orders_data where order_date>'2018-06-09' order by order_date;

# Multiple Conditions (AND):
## "Find all orders from the 'Central' region in the 'Furniture' category."

sql
select * from orders_data where region ='Central' and category = 'furniture';

# Combined Conditions:
## "List orders from the 'Central' region in the 'Technology' category with quantity sold greater than 3."

sql
select * from orders_data where region='Central' and category='technology' and quantity>3;

# Complex Conditions (OR + AND):
## "Find orders either from the 'Central' region OR in the 'Technology' category with quantity > 3."

sql
select * from orders_data where region ='central' or category='technology' and quantity>3;

# Range Filtering:
## "Retrieve orders where quantity sold is between 3 and 5 (inclusive), sorted by quantity (highest first)."

sql
select * from orders_data where quantity>=3 and quantity<=5 order by quantity desc;

# Alternative Range Syntax:
## "List orders with quantity sold between 3 and 5 using the BETWEEN keyword."

sql
select * from orders_data where quantity between 3 and 5;

# IN Operator:
## "Find orders where quantity sold is either 3 or 5."

sql
select * from orders_data where quantity in (3,5);



# Pattern Matching (Prefix):
## "Find customers whose names start with 'A'."

sql
select * from orders_data where customer_name like 'A%';


# Pattern Matching (Suffix):
## "Find customers whose names end with 'n'."

sql
select * from orders_data where customer_name like '%n';

# Pattern Matching (Single Wildcard):
## "Find customers where the second character is 'e'."

sql
select * from orders_data where customer_name like '_e%';

# Advanced Pattern Matching:
## "Find customers where the second character is either 'a' or 'e'."

sql
select * from orders_data where customer_name like '_[ae]%';

# Aggregate Function (SUM):
## "Calculate the total sales across all orders."

sql
select sum(sales) as total_sales from orders_data;

# Aggregate Function (MAX):
## "Find the highest sales value in the dataset."

sql
select max(sales) maxsales from orders_data;

# Aggregate Function (MIN):
## "Find the lowest sales value in the dataset."

sql
select min(sales) as minSales from orders_data;

# Aggregate Function (COUNT):
## "Count the total number of records in 'orders_data'."

sql
select COUNT(*) as total_no_record from orders_data;

# Manual Average Calculation:
## "Calculate average sales by dividing total sales by record count."

sql
select sum(sales)/COUNT(*) as avg_sales from orders_data;


# Built-in Average:
##  "Calculate the average sales using the AVG function."

sql
select AVG(sales) from orders_data;

# Null Handling:
## "Find orders where the city value is missing (NULL)."

sql
select * from orders_data where city is null;


# NOT IN Operator:
## "List orders where quantity sold is neither 3 nor 5."

sql
select * from orders_data where quantity not in(3,5);

# Distinct Values:
## "List all unique regions in the dataset."

sql
select distinct region from orders_data;

# Count Distinct:
## "Count the number of unique cities and categories in the dataset."

sql
select count(distinct city), count(distinct category) from orders_data;


# Grouping Data:
## "Calculate total profit for each customer."

sql
select customer_name, sum(profit) from orders_data group by customer_name;

# Multi-Column Grouping:
## "Calculate total sales and profit by region and city, sorted by region."

sql
select region,city, sum(sales) total_sales, sum(profit) as total_profit from orders_data group by region,city order by region;

# Inner Join (Total Returned Sales):
## "Calculate the total sales value of returned items."

sql
select sum(sales) from orders_data inner join returns_data on orders_data.order_id=returns_data.order_id;

# Grouped Join (Category-wise Returns):
## "Calculate total returned sales by product category."

sql
select category, SUM(sales) from orders_data inner join returns_data on orders_data.order_id=returns_data.order_id group by category;
# Filtered Join:
## "Find all returned orders where the reason was 'wrong items' and the city was 'Troy'."

sql
select * from orders_data inner join returns_data on orders_data.order_id=returns_data.order_id where return_reason='wrong items' and city ='troy';

# Specific Order Join:
## *"Retrieve details for order ID 'CA-2020-111682' along with its return reason (if any)."*

sql
select * from orders_data inner join returns_data on orders_data.order_id=returns_data.order_id where orders_data.order_id= 'CA-2020-111682';

# Left Join (All Orders + Returns):
##"List all orders along with their return reasons (if returned)."

sql
select * from orders_data o left join returns_data r on o.order_id=r.order_id;

# Anti-Join (Non-Returned Orders):
## "Find all orders that were never returned."

sql
select * from orders_data o left join returns_data r on o.order_id=r.order_id where return_reason is null;

# Alternative Anti-Join:
## "Retrieve only order details (excluding return columns) for orders that were not returned."

sql
select o.* from orders_data o left join returns_data r on o.order_id=r.order_id where r.return_reason is null;

# Quick Preview:
"Show the first 3 records from 'orders_data'."

sql




# Total sales calculation
sql
SELECT SUM(sales) AS total_sales FROM orders_data;
# Maximum sales value
