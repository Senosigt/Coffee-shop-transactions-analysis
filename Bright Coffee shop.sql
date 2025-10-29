--test code
SELECT
  *
FROM
  "SALES"."RETAIL"."BRIGHT_COFFEE"
LIMIT
  10;
SELECT
*
FROM
"SALES"."RETAIL"."BRIGHT_COFFEE";
--Calculating revenue per unit price
SELECT 
Transaction_ID,
Transaction_qty * Unit_price
AS Revenue
FROM
"SALES"."RETAIL"."BRIGHT_COFFEE";
--With IDs we perform counts
--We count number of transactions over a period of time
SELECT
COUNT (DISTINCT Transaction_ID) AS Number_of_Transactions
FROM
"SALES"."RETAIL"."BRIGHT_COFFEE";
--We count number of shops we have
SELECT
COUNT(DISTINCT Store_ID) AS Number_of_Stores
FROM
"SALES"."RETAIL"."BRIGHT_COFFEE";
--To show names of different store locations
SELECT DISTINCT Store_Location,
Store_ID
FROM
"SALES"."RETAIL"."BRIGHT_COFFEE";
--Calculating Revenue by store location
SELECT Store_location,
SUM(Transaction_qty*Unit_Price) AS Revenue
FROM
"SALES"."RETAIL"."BRIGHT_COFFEE"
GROUP BY Store_location;
-- finding the best performing product
SELECT
Product_category,
SUM(Transaction_qty*Unit_Price) AS Revenue
FROM
"SALES"."RETAIL"."BRIGHT_COFFEE"
Group by Product_category
ORDER BY Revenue DESC
;
 --creating Time buckets
 --What time does the shop open
 SELECT MIN(Transaction_time) AS Opening_time
 FROM
 "SALES"."RETAIL"."BRIGHT_COFFEE"
 ;
 --What time does the shop CLOSE
 SELECT MAX(Transaction_time) AS Closing_time
 FROM
 "SALES"."RETAIL"."BRIGHT_COFFEE"
 ;
 --Check first date that the store was operating
 SELECT MIN(TRANSACTION_DATE) AS First_store_operating_date
 FROM
 "SALES"."RETAIL"."BRIGHT_COFFEE"
 ;
 --Last date that the store was operating
 SELECT MAX(TRANSACTION_DATE) AS Last_store_operating_date
 FROM
 "SALES"."RETAIL"."BRIGHT_COFFEE"
 ;
--to calculate revenue by day
SELECT Transaction_date,
DAYNAME(Transaction_date) AS Day_name
 FROM
 "SALES"."RETAIL"."BRIGHT_COFFEE"
 ;
 --to calculate revenue by month
 SELECT Transaction_date,
MONTHNAME(Transaction_date) AS Month_name
 FROM
 "SALES"."RETAIL"."BRIGHT_COFFEE"
 ;
--To classify or compare revenue by days of week and weekends
SELECT Transaction_date,
DAYNAME(Transaction_date) AS Day_name,
CASE WHEN Day_name IN('Sun','Sat') THEN 'Weekend'
ELSE 'Weekday'
END AS Day_classification
 FROM
 "SALES"."RETAIL"."BRIGHT_COFFEE"
 ;
----------------------------------------------------------------------------------------------------------------
 --Coffee shop Project query
 SELECT Transaction_date,
DAYNAME(Transaction_date) AS Day_name,
CASE 
WHEN Day_name IN('Sun','Sat') THEN 'Weekend'
ELSE 'Weekday'
END AS Day_classification,
MONTHNAME(Transaction_date) AS Month_name,
 CASE
 WHEN Transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN '01 Morning'
 WHEN Transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN '02 Afternoon'
 WHEN Transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN '03 Evening'
 WHEN Transaction_time >='20:00:00' THEN '04 Night'
 END AS Time_bucket,
 HOUR(Transaction_time) As Hour_of_day,
 COUNT (DISTINCT Transaction_ID) AS Number_of_Transactions,
 Product_category,
 PRODUCT_TYPE,
 Store_location,
 PRODUCT_DETAIL,
 SUM(Transaction_qty*Unit_Price) AS Revenue
 FROM
 "SALES"."RETAIL"."BRIGHT_COFFEE"
 GROUP BY ALL
 ;
