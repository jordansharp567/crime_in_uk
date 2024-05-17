-- VIEW EACH DATA TYPE
USE uk_crime;
SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'combined_file1';

USE uk_crime;
SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'combined_file2';

USE uk_crime;
SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'combined_file3';

USE uk_crime;
SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'combined_file4';

-----------------------------------------------------------
-- ALTER COLUMNS
-- For combined_file1
BEGIN TRANSACTION;
ALTER TABLE combined_file1
    ALTER COLUMN Year INT;
COMMIT;

-- For combined_file2
BEGIN TRANSACTION;
ALTER TABLE combined_file2
    ALTER COLUMN Longitude NUMERIC;
COMMIT;

BEGIN TRANSACTION;
ALTER TABLE combined_file2
    ALTER COLUMN Latitude NUMERIC;
COMMIT;

BEGIN TRANSACTION;
ALTER TABLE combined_file2
    ALTER COLUMN Year INT;
COMMIT;

-- For combined_file3
BEGIN TRANSACTION;
ALTER TABLE combined_file3
    ALTER COLUMN Year INT;
COMMIT;

-- For combined_file4
BEGIN TRANSACTION;
ALTER TABLE combined_file4
    ALTER COLUMN Longitude NUMERIC;
COMMIT;

BEGIN TRANSACTION;
ALTER TABLE combined_file4
    ALTER COLUMN Latitude NUMERIC;
COMMIT;

BEGIN TRANSACTION;
ALTER TABLE combined_file4
    ALTER COLUMN Year INT;
COMMIT;


-------------------------------------------------------
-- ALTERNATIVE VIEWS
CREATE VIEW YearCounts AS
SELECT Year, COUNT(*) AS Count
FROM combined_file1
GROUP BY Year;

CREATE VIEW MonthCounts AS
SELECT Month_Name, COUNT(*) AS Count
FROM combined_file1
GROUP BY Month_Name;

CREATE VIEW YearMonthCounts AS
SELECT Year, Month_Name, COUNT(*) AS Count
FROM combined_file1
GROUP BY Year, Month_Name;

-- CREATE VIEW CrimeTypeCounts AS
CREATE VIEW CrimeTypeCounts AS
SELECT [Crime type], COUNT(*) AS Count
FROM combined_file3
GROUP BY [Crime type];

-- CREATE VIEW CrimeTypeYearCounts AS
CREATE VIEW CrimeTypeYearCounts AS
SELECT Year, [Crime type], COUNT(*) AS Count
FROM combined_file3
GROUP BY Year, [Crime type];

-- CREATE VIEW CrimeTypeMonthCounts AS
CREATE VIEW CrimeTypeMonthCounts AS
SELECT Month_Name, [Crime type], COUNT(*) AS Count
FROM combined_file3
GROUP BY Month_Name, [Crime type];

-- CREATE VIEW CrimeTypeYearMonthCounts AS
CREATE VIEW CrimeTypeYearMonthCounts AS
SELECT Year, Month_Name, [Crime type], COUNT(*) AS Count
FROM combined_file3
GROUP BY Year, Month_Name, [Crime type];


------------------------------------------------------
-- For combined_file2, check Longitude column
SELECT Longitude
FROM combined_file2
WHERE TRY_CAST(Longitude AS NUMERIC) IS NULL AND Longitude IS NOT NULL;

-- For combined_file2, check Latitude column
SELECT Latitude
FROM combined_file2
WHERE TRY_CAST(Latitude AS NUMERIC) IS NULL AND Latitude IS NOT NULL;


-- For combined_file2, convert values containing 'e' to numeric in Longitude column
UPDATE combined_file2
SET Longitude = TRY_CAST(Longitude AS NUMERIC)
WHERE Longitude LIKE '%e%';

-- For combined_file2, convert values containing 'e' to numeric in Latitude column
UPDATE combined_file2
SET Latitude = TRY_CAST(Latitude AS NUMERIC)
WHERE Latitude LIKE '%e%';
---------------------------------------------------------------

-- For combined_file4, check Longitude column
SELECT Longitude
FROM combined_file4
WHERE TRY_CAST(Longitude AS NUMERIC) IS NULL AND Longitude IS NOT NULL;

-- For combined_file2, check Latitude column
SELECT Latitude
FROM combined_file4
WHERE TRY_CAST(Latitude AS NUMERIC) IS NULL AND Latitude IS NOT NULL;


-- For combined_file4, convert values containing 'e' to numeric in Longitude column
UPDATE combined_file4
SET Longitude = TRY_CAST(Longitude AS NUMERIC)
WHERE Longitude LIKE '%e%';

-- For combined_file4, convert values containing 'e' to numeric in Latitude column
UPDATE combined_file4
SET Latitude = TRY_CAST(Latitude AS NUMERIC)
WHERE Latitude LIKE '%e%';

----------------------------------------------------------