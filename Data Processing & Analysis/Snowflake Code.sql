-- Final Code

WITH RankedSales AS (
    SELECT
        VIN,
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
     
        CASE 
         WHEN condition BETWEEN 40 AND 49 THEN 'Excellent'
         WHEN condition BETWEEN 30 AND 39 THEN 'Good'
         WHEN condition BETWEEN 20 AND 29 THEN 'Fair'
         WHEN condition BETWEEN 10 AND 19 THEN 'Poor'
         WHEN condition BETWEEN 1  AND 9  THEN 'Very Poor'
         ELSE 'Unknown'
     END AS condition_category,
     
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
    VIN,
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
    condition_category,
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
