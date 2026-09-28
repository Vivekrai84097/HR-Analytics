# HR Analytics Dashboard

An end-to-end HR Analytics project focused on understanding workforce composition, employee status, salary, performance, and attrition patterns using **WPS/Excel, MySQL, and Power BI**.

## 📌 Business Objective

The objective of this project is to provide an interactive HR analytics dashboard that helps analyze:

* Overall workforce size and employee status
* Department-wise and city-wise workforce distribution
* Gender and age-group distribution
* Salary and performance indicators
* Employee attrition patterns
* Exit reasons
* Department and age-group attrition rates

The dashboard allows users to filter the analysis by key employee attributes and explore workforce and attrition patterns interactively.

## 🛠️ Tools & Technologies

* **WPS Spreadsheet / Excel** — Data cleaning and validation
* **MySQL** — Data storage, transformation, validation, and analysis
* **Power BI** — Data modeling, DAX calculations, visualization, and dashboard development

## 🔄 Project Workflow

**Raw HR Data → Data Cleaning & Validation → MySQL → SQL Analysis → Power BI Data Model → DAX → Interactive Dashboard → Business Insights**

## 📂 Dataset Overview

The project contains HR data covering:

* Employee information
* Attendance records
* Performance records
* Attrition information

The main employee dataset contains **600 employees** after data cleaning and duplicate removal.

## 🧹 Data Cleaning & Validation

The raw data was prepared before analysis by:

* Identifying and removing duplicate employee records
* Handling missing city values by assigning `Unknown`
* Standardizing column data types
* Formatting date and numeric fields
* Checking for NULL values
* Validating employee IDs and related records
* Checking attendance data for inconsistent values
* Validating employee and attrition records before analysis

## 🗄️ SQL Analysis

MySQL was used to perform data validation and business analysis.

Key analysis areas included:

* Employee workforce counts
* Active vs exited employees
* Department-wise employee analysis
* Department-wise attrition rate
* Exit reason analysis
* Age-group attrition analysis
* Workforce segmentation
* Identification of highest observed attrition department
* Identification of most common exit reason

SQL techniques used included:

* `SELECT`
* `WHERE`
* `GROUP BY`
* `ORDER BY`
* `COUNT()`
* Aggregate functions
* `JOIN`
* Window functions
* CASE expressions
* VIEW creation
* Analytical queries

## 📊 Power BI Dashboard

The Power BI report contains two interactive pages.

### Page 1 — HR Workforce Overview

**KPIs:**

* Total Employees
* Active Employees
* Exited Employees
* Attrition Rate
* Average Annual Salary
* Average Performance

**Charts:**

* Employee by Department
* Workforce by Gender
* Employees by City
* Employees by Age Group

**Slicers:**

* Department
* City
* Gender
* Status

### Page 2 — Exit & Attrition Analysis

**KPIs:**

* Attrition Rate
* Exited Employees
* Top Exit Reason
* Highest Attrition Department

**Charts:**

* Attrition by Department
* Exited Employees by Exit Reason
* Attrition Rate by Age Group
* Employee Status by Department

**Slicers:**

* Department
* Job Role
* Gender
* City

## 📸 Dashboard Screenshots

### Page 1 — HR Workforce Overview

![HR Workforce Overview](Screenshots/HR_Workforce_Overview.png)

### Page 2 — Exit & Attrition Analysis

![Exit & Attrition Analysis](Screenshots/Exit_Attrition_Analysis.png)

## 📈 Key Business Insights

Based on the analyzed dataset:

* Overall attrition rate was **4.17%**, with **25 exited employees out of 600 employees**.
* **Customer Support** had the highest observed attrition rate at **9.76%**.
* **Workload** was the most common recorded exit reason, accounting for **8 of the 25 exits**.
* The **25–34 age group** had the highest observed attrition rate at **4.68%**.

These findings describe patterns observed in the dataset and do not by themselves establish causal relationships.

## 🎯 Project Outcome

This project demonstrates the ability to take raw HR data through a complete analytics workflow—from data cleaning and SQL-based analysis to interactive Power BI reporting and business insight generation.

The dashboard provides HR-focused views that can be used to explore workforce composition and identify areas requiring further investigation.

## 👤 Author

**Vivek Rai**

MCA | Aspiring Data Analyst

**Skills:** Excel/WPS • SQL • Power BI • DAX • Data Cleaning • Data Analysis
