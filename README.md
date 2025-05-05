This project focuses on cleaning and transforming a dataset that contains information about individuals' stress levels. It includes fixing column names, correcting inconsistent data, removing duplicates and nulls, and creating new columns for better analysis.

---

## 📌 Objective

To clean and prepare the `Stress_levels` dataset for further analysis or visualization by applying SQL queries. The final output includes:
- Cleaned dataset with renamed columns
- Standardized values (e.g., gender)
- Removal of duplicates and nulls
- A final view with additional columns like **Full Name**, **Age**, **Age Group**, and **Stress Duration in Months**

---

## 🛠️ Tools Used

- **SQL Server**
- **T-SQL (Transact-SQL)**

---

## 🧼 Data Cleaning & Transformation Steps

### ✅ 1. Rename Columns
Changed technical column names like `first_name`, `dob` to more readable ones like `First Name`, `Date of Birth`.

### ✅ 2. Standardize Gender Values
Converted gender values from `'M'` and `'F'` to `'Male'` and `'Female'`.

### ✅ 3. Fix Typo in Data
Replaced wrong value `"Stomach Age"` with correct `"Stomach Ache"`.

### ✅ 4. Remove Duplicate Rows
Used `ROW_NUMBER()` to identify and delete exact duplicate entries.

### ✅ 5. Handle Missing Values
- Filled a missing stress level score for one employee using the dataset's average.
- Removed all rows containing `NULL` in any important column.

### ✅ 6. Create a Cleaned View
Created a SQL `VIEW` named `"Stress Level"` with selected and renamed fields, including a `Full Name` field.

### ✅ 7. Add Calculated Fields
Enhanced the view by adding:
- **Age** (based on date of birth and test date)
- **Age Group** (categorized age)
- **Stress Duration in Months** (based on day counts)

---

## 🧾 Sample Output (Columns in Final View)

| ID | Full Name | Gender | Date of Birth | Age | Age Group | Stress Duration (In Months) | Severity | ... |
|----|-----------|--------|----------------|-----|-----------|-----------------------------|----------|-----|

---

## 📊 Use Case

This cleaned dataset can be used for:
- Visualizing stress levels by age group
- Understanding physical and emotional symptoms
- Building dashboards with Power BI or Tableau

---

