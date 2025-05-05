-- 📘 SQL Stress Level Data Cleaning Project
-- This script cleans and prepares the Stress_levels dataset for analysis.

-- ✅ 1. Rename Columns to Friendly Names
-- Makes columns easier to read and understand
EXEC sp_rename 'Stress_levels.id', 'ID';
EXEC sp_rename 'Stress_levels.first_name', 'First Name';
EXEC sp_rename 'Stress_levels.last_name', 'Last Name';
EXEC sp_rename 'Stress_levels.gender', 'Gender';
EXEC sp_rename 'Stress_levels.dob', 'Date of Birth';
EXEC sp_rename 'Stress_levels.test_date', 'Test Date';
EXEC sp_rename 'Stress_levels.test_time', 'Test Time';
EXEC sp_rename 'Stress_levels.stress_source', 'Stress Source';
EXEC sp_rename 'Stress_levels.physical_symptoms', 'Physical Symptoms';
EXEC sp_rename 'Stress_levels.emotional_symptoms', 'Emotional Symptoms';
EXEC sp_rename 'Stress_levels.coping_mechanism', 'Coping Mechanism';
EXEC sp_rename 'Stress_levels.stress_duration', 'Stress Duration (In Days)';
EXEC sp_rename 'Stress_levels.severity', 'Severity';
EXEC sp_rename 'Stress_levels.sleep_quality', 'Sleep Quality';
EXEC sp_rename 'Stress_levels.mood', 'Mood';
EXEC sp_rename 'Stress_levels.heart_rate', 'Heart Rate';
EXEC sp_rename 'Stress_levels.cortisol_level', 'Cortisol Level';
EXEC sp_rename 'Stress_levels.stress_level_score', 'Stress Level Score';

-- ✅ 2. Clean Gender Values
-- Replace short codes with full gender descriptions
UPDATE Stress_levels
SET Gender = CASE
    WHEN Gender = 'M' THEN 'Male'
    WHEN Gender = 'F' THEN 'Female'
END;

-- ✅ 3. Fix Typos in Data
-- Correct specific incorrect data entries
UPDATE Stress_levels
SET [Physical Symptoms] = 'Stomach Ache'
WHERE [Physical Symptoms] = 'Stomach Age';

-- ✅ 4. Remove Duplicate Records
-- Keep only the first instance of each duplicate row
WITH Duplicates AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY ID, [First Name], [Last Name], Gender, [Date of Birth], [Test Date],
        [Test Time], [Stress Source], [Physical Symptoms], [Emotional Symptoms], [Coping Mechanism],
        [Stress Duration (In Days)], [Severity], [Sleep Quality], [Mood], [Heart Rate],
        [Cortisol Level], [Stress Level Score] ORDER BY (SELECT NULL)) AS RowNum
    FROM Stress_levels
)
DELETE FROM Duplicates WHERE RowNum > 1;

-- ✅ 5. Fill Missing Stress Level Score for a Specific Record
-- Replace NULL value with the average score from all records
UPDATE Stress_levels
SET [Stress Level Score] = (SELECT AVG([Stress Level Score]) FROM Stress_levels)
WHERE ID = 'FSXMV4';

-- ✅ 6. Remove Null Rows
-- Delete records that have any NULL value in important columns
DELETE FROM Stress_levels
WHERE ID IS NULL OR [First Name] IS NULL OR [Last Name] IS NULL OR Gender IS NULL
    OR [Date of Birth] IS NULL OR [Test Date] IS NULL OR [Test Time] IS NULL
    OR [Stress Source] IS NULL OR [Physical Symptoms] IS NULL OR [Emotional Symptoms] IS NULL
    OR [Coping Mechanism] IS NULL OR [Stress Duration (In Days)] IS NULL
    OR [Severity] IS NULL OR [Sleep Quality] IS NULL OR [Mood] IS NULL
    OR [Heart Rate] IS NULL OR [Cortisol Level] IS NULL OR [Stress Level Score] IS NULL;

-- ✅ 7. Create a View with Full Name Column
-- Combine First and Last Name into a new column
CREATE VIEW [Stress Level] AS
SELECT ID,
    CONCAT([Last Name], ' ', [First Name]) AS [Full Name],
    Gender, [Date of Birth], [Test Date], [Test Time], [Stress Source], [Physical Symptoms],
    [Emotional Symptoms], [Coping Mechanism], [Stress Duration (In Days)], [Severity],
    [Sleep Quality], [Mood], [Heart Rate], [Cortisol Level], [Stress Level Score]
FROM Stress_levels;

-- ✅ 8. Update View with Age, Age Group, and Duration Category
-- Add calculated columns for analysis
ALTER VIEW [Stress Level] AS
SELECT ID,
    CONCAT([Last Name], ' ', [First Name]) AS [Full Name],
    Gender, [Date of Birth], [Test Date], [Test Time],
    -- Calculate precise age
    DATEDIFF(YEAR, [Date of Birth], [Test Date]) -
        CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, [Date of Birth], [Test Date]), [Date of Birth]) > [Test Date]
        THEN 1 ELSE 0 END AS Age,
    -- Group age into categories
    CASE 
        WHEN Age BETWEEN 17 AND 25 THEN '17 - 25'
        WHEN Age BETWEEN 26 AND 35 THEN '26 - 35'
        WHEN Age BETWEEN 36 AND 45 THEN '36 - 45'
        WHEN Age BETWEEN 46 AND 55 THEN '46 - 55'
        WHEN Age BETWEEN 56 AND 65 THEN '56 - 65'
        WHEN Age BETWEEN 66 AND 75 THEN '66 - 75'
        WHEN Age BETWEEN 76 AND 85 THEN '76 - 85'
    END AS [Age Group],
    [Stress Source], [Physical Symptoms], [Emotional Symptoms], [Coping Mechanism],
    [Stress Duration (In Days)],
    -- Categorize duration in months
    CASE 
        WHEN [Stress Duration (In Days)] <= 91 THEN '0 - 3 Months'
        WHEN [Stress Duration (In Days)] <= 182 THEN '4 - 6 Months'
        ELSE 'Beyond Months'
    END AS [Stress Duration (In Months)],
    [Severity], [Sleep Quality], [Mood], [Heart Rate], [Cortisol Level], [Stress Level Score]
FROM Stress_levels;

-- ✅ DONE: Cleaned and Transformed Stress Level Data Ready for Analysis
