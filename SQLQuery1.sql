

select * from pizza_sales;



/* Total Revenue : The sum of the total price of all pizza orders.*/
select sum(total_price) from pizza_sales;


/*Average Order Value: The average amount spent per order; calculated by dividing the total revenue by the total number of orders. */
select sum(total_price) / count(Distinct(order_id)) as Average_Order_Value from pizza_sales;


/*Total Pizzas Sold: The sum of quantities of pizzas sold.*/
select sum(quantity) as Total_Pizzas_Sold from pizza_sales;



/*Total Orders: The total number of orders placed.*/
select count(distinct(order_id)) as Total_Orders from pizza_sales;



/*Average Pizzas Per Order: The average number of pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of orders.*/
SELECT CAST(CAST(SUM(quantity) AS DECIMAL (10,2)) / CAST(COUNT(DISTINCT(order_id)) AS DECIMAL (10,2)) AS DECIMAL (10,2)) AS Average_Pizzas_Per_Order FROM pizza_sales;


/*Daily Trend for Total Orders*/
SELECT DATENAME(DW, order_date) AS Order_day, COUNT(DISTINCT(order_id)) AS Total_Orders 
FROM pizza_sales
GROUP BY DATENAME(DW,order_date)
ORDER BY Total_Orders DESC;

/*Monthly Trend for Total Orders:*/
SELECT DATENAME(MONTH, order_date) AS Month_Name, COUNT(DISTINCT(order_id)) AS Total_Orders 
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC;



/*Sales by Pizza Category*/
SELECT pizza_category AS Pizza_Category, COUNT(DISTINCT(order_id)) AS Total_Sales
from pizza_sales
GROUP BY Pizza_Category
ORDER BY Total_Sales DESC;




/*Percentage of Sales By Pizza Category*/
SELECT pizza_category, sum(total_price) as Total_Sales,SUM(total_price) * 100/ (SELECT(SUM(total_price)) FROM pizza_sales WHERE MONTH(order_date) = 2) AS Percentage_Total_Sales
FROM pizza_sales 
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Sales DESC;

/*Percentage of Sales By Pizza Size*/
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as Total_Sales, CAST(sum(total_price)* 100/(SELECT sum(total_price) from pizza_sales) AS DECIMAL(10,2)) as Percentage_Sales_Size
from pizza_sales
GROUP BY pizza_size
order by Percentage_Sales_Size DESC



/*Percentage of Sales By Pizza Size AND	Quarter*/
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as Total_Sales, CAST(sum(total_price)* 100/(SELECT sum(total_price) from pizza_sales where datepart(quarter, order_date) = 1) AS DECIMAL(10,2))  as Percentage_Sales_Size
from pizza_sales
where datepart(quarter, order_date) = 1
GROUP BY pizza_size
order by Percentage_Sales_Size DESC


/* Top 5 Best Sellers by Revenue, Total Quantity and Total Orders*/
SELECT TOp 5 pizza_name , sum(total_price) as Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC



SELECT TOp 5 pizza_name , sum(quantity) as Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC



SELECT TOp 5 pizza_name , COUNT( DISTINCT order_id) as Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC



