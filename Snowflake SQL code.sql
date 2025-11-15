--------------------------------------------------------------------------------------
-- SELECT All columns and rows from Car Sales 
 SELECT * 
  FROM casestudy3.car.sales;

--------------------------------------------------------------------------------------
  --Check for NULLS 
  SELECT * 
  FROM casestudy3.car.sales
  WHERE MAKE IS NULL;

  ---------------------------------------------------------------------------------------------
  -- SELECT UNIQUE Make,Model,Body,Transmission,Vin and standardize text columns

  --Find the unique vehicle makes and models
SELECT INITCAP(Make) AS MAKE,
       INITCAP(Model) AS MODEL,
       INITCAP(Transmission) AS Transmission,
       COUNT(*) AS Count_makes
       
FROM casestudy3.car.sales
GROUP BY INITCAP(Make),INITCAP(Model), INITCAP(Transmission)
ORDER BY COUNT(*) DESC;

--Check all mercedes vehicles 
SELECT make,
       COUNT(make) AS Count_makes,
       model
FROM casestudy3.car.sales
WHERE make LIKE ('%ercedes%')
GROUP BY model,make
ORDER BY make ASC;

-- Check duplicates

SELECT Vin,
       make,
       model,
ROW_NUMBER() OVER(PARTITION BY VIN ORDER BY Make ASC)
AS Unique_Values
FROM casestudy3.car.sales;

--------------------------------------------------------------------------------------
--Use Case Function to combine same make brands 

SELECT DISTINCT Make,
                    --INITCAP(Model) AS model,
       COUNT(*) AS Count_makes,
  CASE 
    WHEN make ILIKE ('%Mercedes%') THEN 'Mercedes-Benz'
    WHEN make IN ('Landrover', 'Land Rover') THEN 'Land Rover'
    WHEN make IN ('Vw','Volkswagen') THEN 'Volkswagen'
    ELSE INITCAP(make) 
  END AS New_Make
FROM casestudy3.car.sales
GROUP BY make       --INITCAP(Model)
ORDER BY COUNT(*) DESC;

--------------------------------------------------------------------------------------
--Select Body,Interior, Color 
SELECT DISTINCT INITCAP(body) 
FROM casestudy3.car.sales;

--SELECT unique interior then clean 

SELECT COUNT(DISTINCT interior) 
       interior,
FROM casestudy3.car.sales
GROUP BY interior;

-- Replace placeholder dash characters with NULL to clean invalid interior values

SELECT DISTINCT interior,

  CASE 
     WHEN interior = '—' THEN NULL
     ELSE Interior
  END AS Interior    

FROM casestudy3.car.sales;

-- SELECT unique Colors then clean  
SELECT COUNT(DISTINCT color) AS color_count,
       color
FROM casestudy3.car.sales
GROUP BY color;

-- Replace placeholder dash characters with NULL to clean invalid interior values
SELECT DISTINCT  color,

  CASE 
     WHEN  color = '—' THEN NULL
     ELSE  color
  END AS  Color    

FROM casestudy3.car.sales;

--------------------------------------------------------------------------------------
-- Check how many units of each make were sold

SELECT MAKE, 
       COUNT(*) AS Units_Sold
FROM casestudy3.car.sales
GROUP BY MAKE
HAVING COUNT(*) > 1
ORDER BY COUNT(*) Desc;

--------------------------------------------------------------------------------------
--Look for missing odometer readings
 SELECT ODOMETER
  FROM casestudy3.car.sales
  ORDER BY ODOMETER asc;
  
--------------------------------------------------------------------------------------
-- Seperate the SALEDATE
SELECT Saledate
 FROM casestudy3.car.sales;
 
-- Convert to proper TIMESTAMP
SELECT
    TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS') AS converted_saledate
FROM casestudy3.car.sales;

-- Truncate to the minute (remove seconds)
    SELECT *
    DATE_TRUNC('minute', TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS')) AS truncated_minute
    FROM casestudy3.car.sales;


SELECT
    saledate,

    -- 1️⃣ Convert to proper TIMESTAMP
    TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS') AS ts_original,

    -- 2️⃣ Truncate to the minute (remove seconds)
    DATE_TRUNC('minute', TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS')) AS ts_truncated_minute,

    -- Extract only the date of the sale
    TO_DATE(TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS')) AS sale_date,

    -- Extract only the time of the sale
    TO_VARCHAR(TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'HH24:MI:SS') AS sale_time,

    -- Extract day of week and weekday name
    TO_VARCHAR(TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'DY') AS sale_day,
    

FROM casestudy3.car.sales;

--------------------------------------------------------------------------------------
-- Final code
---------------------------------------------------------------------------------------
--Final code 

SELECT Year, 
       INITCAP(Make) AS MAKE,
       INITCAP(Model) AS MODEL,
       INITCAP(body),
       Trim,
       INITCAP(Transmission) AS Transmission,
       ROW_NUMBER() OVER(PARTITION BY VIN ORDER BY Make ASC)
       AS row_count,
       state,
      
  CASE 
      WHEN make ILIKE ('%Mercedes%') THEN 'Mercedes-Benz'
      WHEN make IN ('Landrover', 'Land Rover') THEN 'Land Rover'
      WHEN make IN ('Vw','Volkswagen') THEN 'Volkswagen'
      ELSE INITCAP(make) 
  END AS Make,

  CASE 
      WHEN  color = '—' THEN NULL
      ELSE  color
  END AS  Color,

  CASE 
      WHEN interior = '—' THEN NULL
      ELSE Interior
  END AS Interior,
       condition,
       odometer,
       Seller,
       MMR,
       Sellingprice,
       COUNT(*) AS Units_Sold,
       
       TO_DATE(TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS')) AS sale_date,
       CAST(TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS') AS TIME) AS sale_time,        
       TO_VARCHAR(TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'DY') AS sale_day
       
FROM casestudy3.car.sales;


-------------------------------------------------------------------------------------------------------

WITH RankedSales AS (
    SELECT 
        Year, 
        INITCAP(Make) AS MAKE,
        INITCAP(Model) AS MODEL,
        INITCAP(body) AS Body,
        Trim,
        INITCAP(Transmission) AS Transmission,
        ROW_NUMBER() OVER(PARTITION BY VIN ORDER BY saledate ASC) AS row_count, 
        state,
    CASE 
        WHEN make ILIKE ('%Mercedes%') THEN 'Mercedes-Benz'
        WHEN make IN ('Landrover', 'Land Rover') THEN 'Land Rover'
        WHEN make IN ('Vw','Volkswagen') THEN 'Volkswagen'
        ELSE INITCAP(make) 
     END AS Standardized_Make,
     
     CASE 
         WHEN  color = '—' THEN NULL
         ELSE  color
     END AS Color,
     
     CASE 
         WHEN interior = '—' THEN NULL
         ELSE Interior
     END AS Interior,
        condition,
        odometer,
        Seller,
        MMR,
        Sellingprice,
        TO_DATE(TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS')) AS sale_date,
        CAST(TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS') AS TIME) AS sale_time,        
        TO_VARCHAR(TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'DY') AS sale_day
    FROM 
        casestudy3.car.sales 
)

SELECT 
    Year, 
    MAKE,
    MODEL,
    Body,
    Trim,
    Transmission,
    state,
    Standardized_Make,
    Color,
    Interior,
    condition,
    odometer,
    Seller,
    MMR,
    Sellingprice,
    sale_date,
    sale_time,
    sale_day
FROM RankedSales
WHERE row_count = 1 
ORDER BY sale_date DESC;


   
