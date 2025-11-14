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

-- Remove duplicates

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
    WHEN make LIKE ('%ercedes%') THEN 'Mercedes-Benz'
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
   
