# Walmart Revenue Data Analysis
An end-to-end data analysis project on Walmart sales using Python, SQL (MySQL &amp; PostgreSQL), and Power BI. Includes data cleaning, feature engineering, complex SQL queries, and insightful dashboards to uncover trends, revenue patterns, and customer behavior for business decision-making.

---

# 🛒 Walmart Revenue and Trends – Power BI Data Analysis Project
![image](https://github.com/user-attachments/assets/1e59857a-dd97-42da-9e7b-266ed00dde41)


## 📌 Overview

This project is an **end-to-end data analysis solution** aimed at extracting valuable business insights from Walmart’s sales data. By integrating **Python** for data cleaning and feature engineering, **SQL (MySQL and PostgreSQL)** for querying, and **Power BI** for visualization, we deliver a robust data pipeline and dashboard that addresses key business questions.

It serves as an ideal case study for aspiring **Data Analysts** and professionals looking to improve skills in **data manipulation, SQL querying, dashboard reporting, and analytical problem-solving**.

![image](https://github.com/user-attachments/assets/50c98210-8ef2-4f95-810c-11e36317789c)


---

## ⚙️ Tools & Technologies

* **Languages**: Python (v3.8+), SQL
* **Databases**: MySQL, PostgreSQL
* **Libraries**: `pandas`, `numpy`, `sqlalchemy`, `mysql-connector-python`, `psycopg2`
* **Visualization**: Power BI
* **Environment**: Visual Studio Code
* **APIs**: Kaggle API for dataset download

---
## ✅ Requirements

* Python 3.8+
* MySQL and PostgreSQL setup
* Kaggle API access
* Required libraries installed : `pandas`, `numpy`, `sqlalchemy`, `mysql-connector-python`, `psycopg2`

---


## 📁 Project Workflow

### 1. Set Up the Environment

* Organized project structure using VS Code.
* Created dedicated folders for scripts, data, and notebooks.

### 2. Configure Kaggle API

* Retrieved `kaggle.json` API token from [Kaggle](https://www.kaggle.com/).
* Configured access via CLI to directly download datasets.

### 3. Download Walmart Sales Dataset

* Source: [Walmart Sales Dataset](https://www.kaggle.com/datasets/najir0123/walmart-10k-sales-datasets).
* Downloaded into `data/` directory for easy access.

### 4. Install Required Libraries & Load Data

```bash
pip install pandas numpy sqlalchemy mysql-connector-python psycopg2
```

* Data loaded into Pandas DataFrames for initial analysis.

### 5. Data Exploration

* Performed `.info()`, `.describe()`, and `.head()` checks.
* Identified data types, outliers, and missing values.

### 6. Data Cleaning

* Removed duplicates.
* Handled missing values using drop/fill techniques.
* Standardized date and currency formats.
* Converted appropriate columns to `datetime`, `float`, etc.

### 7. Feature Engineering

* Prepared dataset for SQL-based aggregations.

### 8. Load into MySQL & PostgreSQL

* Used `SQLAlchemy` to connect to both databases.
* Automated table creation and data insertion.
* Verified data via initial SQL checks.

### 9. SQL-Based Business Analysis
### Follow for SQL Business Queries : [Business SQL Queries](https://github.com/laxdippatel/walmart_revenue_and_trends/blob/main/Business_SQL_Quries.md)

Answered key questions like:

* Which branches and product categories generate the most revenue?
* What are the top-selling products and cities?
* Which time periods have peak sales?
* What are the trends in payment methods and ratings?

Each SQL script includes:

* Problem statement
* Query logic
* Observations and conclusions

### 10. Dashboard & Publishing

* Visualized insights in **Power BI**.
* Created dynamic reports highlighting:

  * Sales by branch and product type
  * Customer purchase behavior
  * Time-based sales patterns

---

## 📊 Results & Insights
![image](https://github.com/user-attachments/assets/5ac269d5-3332-4265-b241-d54a154b4134)


### 🔹 Sales Insights

* Branches with the highest revenue identified.
* Top-performing product categories and best-selling items revealed.

### 🔹 Profitability

* High-margin categories and cities analyzed for profitability.

### 🔹 Customer Behavior

* Peak shopping times, preferred payment modes, and customer satisfaction trends visualized.

---

## 🚀 Future Enhancements

Here are 3 potential future upgrades:

1. **Real-time Streaming Dashboard** – Integrate with APIs to track live sales metrics.
2. **Predictive Analytics** – Apply machine learning models for sales forecasting.
---

## 📁 Repository Structure

```
📦 Walmart-Revenue-Trends/
├── data/                       # Raw data files
├── notebooks/                 # Jupyter analysis files
├── scripts/                   # Python scripts for ETL and SQL loading
├── dashboards/                # Power BI .pbix files
├── sql/                       # SQL queries used for analysis
└── README.md                  # Project documentation (this file)
```
