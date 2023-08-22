select *
from pizza..pizza_sales

-- Total Revenue
select sum(ps.total_price) as "Total Revenue" 
from pizza..pizza_sales as ps

-- Total Order
select count (distinct ps.order_id) as "Total Order" 
from pizza..pizza_sales as ps

-- Average Order Value
select round(sum(ps.total_price) / count (distinct ps.order_id),2) as "Average Order Value"
from pizza..pizza_sales as ps

-- Total Pizzas Sold
select sum(ps.quantity) as "Total Pizzas Sold" 
from pizza..pizza_sales as ps

-- Average Pizza by Order
select cast(sum(ps.quantity) as decimal(10,2)) / cast(count (distinct ps.order_id) as decimal(10,2)) as "Average Pizza by Order" 
from pizza..pizza_sales as ps

-- Hourly Trend for Total Pizzas Sold
select  datepart(hour, ps.order_time) as "Order Hour",
		sum(ps.quantity) as "Total Quantity"
from pizza..pizza_sales as ps
group by datepart(hour, ps.order_time)
order by datepart(hour, ps.order_time)

-- Weekly Trend for Total Orders
select  datepart(iso_week, ps.order_date) as "Week Number",
		year(ps.order_date) as "Year",
		count (distinct ps.order_id) as "Total Order" 
from pizza..pizza_sales as ps
group by datepart(iso_week, ps.order_date), year(ps.order_date)
order by datepart(iso_week, ps.order_date), year(ps.order_date)

-- Percentage of Sales by Pizza Category
select  ps.pizza_category,
		round(sum(ps.total_price) * 100 / (select sum(ps.total_price) from pizza..pizza_sales as ps),2) as "Percentage of Sales by Pizza Category"
from pizza..pizza_sales as ps
group by ps.pizza_category

-- Percentage of Sales by Pizza Size
select  ps.pizza_size,
		round(sum(ps.total_price) * 100 / (select sum(ps.total_price) from pizza..pizza_sales as ps),2) as "Percentage of Sales by Pizza Size"
from pizza..pizza_sales as ps
group by ps.pizza_size

-- Total Pizzas Sold by Pizza Category
select  ps.pizza_category, 
		sum(ps.quantity) as "Total Quantity"
from pizza..pizza_sales as ps
group by ps.pizza_category

--  Top 5 Pizzas by Revenue
select  top 5 ps.pizza_name,
		sum(ps.total_price) as "Total Revenue" 
from pizza..pizza_sales as ps
group by ps.pizza_name
order by sum(ps.total_price) desc

-- Bottom 5 Pizzas by Revenue
select  top 5 ps.pizza_name,
		sum(ps.total_price) as "Total Revenue" 
from pizza..pizza_sales as ps
group by ps.pizza_name
order by sum(ps.total_price) asc

-- Top 5 Pizzas by Quantity
select  top 5 ps.pizza_name,
		sum(ps.quantity) as "Total Pizzas Sold" 
from pizza..pizza_sales as ps
group by ps.pizza_name
order by sum(ps.quantity) desc

-- Bottom 5 Pizzas by Quantity
select  top 5 ps.pizza_name,
		sum(ps.quantity) as "Total Pizzas Sold" 
from pizza..pizza_sales as ps
group by ps.pizza_name
order by sum(ps.quantity) asc

-- Top 5 Pizzas by Total Orders
select  top 5 ps.pizza_name,
		count (distinct ps.order_id) as "Total Order" 
from pizza..pizza_sales as ps
group by ps.pizza_name
order by "Total Order"  desc

-- Bottom 5 Pizzas by Total Orders
select  top 5 ps.pizza_name,
		count (distinct ps.order_id) as "Total Order" 
from pizza..pizza_sales as ps
group by ps.pizza_name
order by "Total Order"  asc