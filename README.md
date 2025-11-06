# 🧹 Layoffs Data Cleaning (SQL Project)

This project focuses on cleaning a **global layoffs dataset** using **MySQL**.  
The goal was to transform messy raw data into a clean, analysis-ready format by removing duplicates, standardizing values, fixing date formats, and handling null entries.

---

## 📁 Project Structure

| File | Description |
|------|-------------|
| `layoffs_raw.csv` | Original raw dataset before cleaning |
| `layoffs_cleaned.csv` | Final cleaned dataset ready for analysis |
| `data_cleaning.sql` | Full SQL script containing all data cleaning steps |
| `README.md` | Project documentation |

---

## 🧠 Key Data Cleaning Steps

1. **Created staging tables** to work safely without affecting the original dataset.  
2. **Removed duplicates** using `ROW_NUMBER()` window function.  
3. **Standardized data** – fixed inconsistent country and industry names.  
4. **Converted date strings** into proper SQL `DATE` format.  
5. **Handled NULLs and blanks** by replacing or removing invalid records.  
6. **Dropped unnecessary columns** after cleaning.

---

## 🛠️ Tools & Technologies
- **MySQL Workbench** – Data cleaning and transformation  
- **CSV Files** – For dataset import/export  
- **Git & GitHub** – Version control and documentation

---

## ✅ Results
- The dataset is now **fully cleaned, standardized, and analysis-ready**.  
- Cleaned data can be used for:
  - Trend analysis  
  - Power BI or Tableau dashboards  
  - Further SQL analytics

---

## ✨ Author
**Divyansh Trivedi**  
📍 Data Analyst | SQL | Python | Power BI  
🔗 [GitHub Profile](https://github.com/divyansh-trivedi)
