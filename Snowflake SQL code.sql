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
  -- SELECT UNIQUE Make,Model,Body,Transmission,Vin,Color,Interior and standardize text columns

  --Find the unique vehicle makes and models
SELECT INITCAP(Make) AS MAKE,
       --INITCAP(Model) AS MODEL,
       COUNT(*) AS Count_makes
       
FROM casestudy3.car.sales
GROUP BY INITCAP(Make)  --INITCAP(Model)
ORDER BY COUNT(*) DESC;

--Check all mercedes vehicles 
SELECT make,
       COUNT(make) AS Count_makes,
       model
FROM casestudy3.car.sales
WHERE make LIKE ('%ercedes%')
GROUP BY model,make
ORDER BY make ASC;

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
