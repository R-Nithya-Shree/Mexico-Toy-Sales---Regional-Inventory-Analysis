# SECTION=1 - DATABASE CREATION
CREATE DATABASE MexicoToys; 

###################################################################################################################################
# SECTION-2 - DATA INGESTION
# PROBLEM - sales table contains 500+K  rows but only 1000 rows were imported from import wizard. 
# SOLUTION - truncate the sales table and load data separately by placing sales csv file in directory defined by below query.

# Truncating Sales csv file
TRUNCATE TABLE sales;

# To find the local path to load the file
SHOW VARIABLES LIKE "secure_file_priv";

# Loading the data manually using the path returned from above query.
LOAD DATA INFILE "path/to/your/file.csv" INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

# To check if every rows are loaded into table
SELECT COUNT(*) FROM sales;

###################################################################################################################################
# SECTION-3 - DATA CLEANING OR TRANSFORMATION
# By default, MySQL Workbench will be in safe update mode. update may throw an error if not turned off.
SET sql_safe_updates=0; # To turn off the safe mode

# For caculations, currency should be in Integer or Decimals. To convert text to number,remove symbols by replace it by space.
UPDATE 
	products SET product_cost=REPLACE(product_cost,'$',' '),
	product_price=REPLACE(product_price,'$',' ');

SET sql_safe_updates=1; # To turn on safe mode

# Converting Text into decimals
ALTER TABLE products
MODIFY COLUMN product_price DECIMAL(10,2),
MODIFY COLUMN product_cost DECIMAL(10,2);

###################################################################################################################################
# SECTION-4 - DATA ANALYSIS
# Finding total profit by product id and product name from high profit to low profit
SELECT 
	products.Product_Category,
    sales.Product_ID,
    SUM((product_price-product_cost)*units) AS total_profit, 
    SUM(product_price*units) AS total_revenue
FROM sales
JOIN products
ON sales.product_ID=products.product_ID
GROUP BY product_ID,product_category
ORDER BY total_profit DESC;

#finding average daily sales and stocks left on each day
SELECT 
	SUM(units)/COUNT(distinct date)  AS Avg_daily_sale, date,
	FLOOR(stock_on_hand/(SUM(units)/COUNT(DISTINCT date))) AS days_of_stocks_left,
    stock_on_hand,
    store_name,
    product_name
FROM sales
JOIN inventory ON inventory.product_id=sales.product_id AND inventory.store_id=sales.store_id
JOIN stores ON stores.store_id=inventory.store_id
JOIN products ON products.product_id=inventory.product_id
GROUP BY stock_on_hand,product_name,store_name, date
ORDER BY days_of_stocks_left ASC;

#finding the total loss in revenue by product name and price
SELECT 
	product_name,
    product_price,
    (SUM(units)/COUNT(DISTINCT date))*product_price AS revenue_lost
FROM sales
JOIN products ON sales.product_id=products.product_id
GROUP BY product_name,product_price;

###################################################################################################################################
#SECTION-5 - Creating Sematic Layer of analysed data 
#creating a new table view for PowerBI dashboard
CREATE VIEW master_sales_analytics AS SELECT
	units,
    date,
    store_name,
    store_city,
    product_category,
    product_price as unit_price,
    product_price*units AS revenue,
	(product_price-product_cost)*units as profit,
    ((product_price-product_cost)/product_price)*100 AS profit_margin,
	sales.Product_ID,
    Product_Name,
    sales.Store_ID,
    Stock_On_Hand
FROM sales
JOIN stores ON stores.store_id=sales.store_id
JOIN products ON products.product_id=sales.product_id
LEFT JOIN inventory ON inventory.Product_ID=sales.Product_ID AND inventory.Store_ID=sales.Store_ID;

SELECT * FROM master_sales_analytics; # To check whether view created correctly or not





