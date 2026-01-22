# SQL-DataWarehouse-Project

# 📊 End-to-End Data Warehouse Project 

## 📌 Project Overview

This project is a **complete end-to-end Data Warehouse implementation** built by following the **Bronze → Silver → Gold layered architecture**. The goal of the project is to design a **scalable, analytics-ready data warehouse** that transforms raw operational data into **business-friendly analytical models (Star Schema)**.

This project was implemented by learning from the **Data With Baraa** YouTube series, which provides a practical, industry-aligned approach to modern data engineering.

---

## 🎯 Objectives

* Build a real-world **data warehouse** using best practices
* Implement **Bronze, Silver, and Gold layers**
* Perform **data integration** from multiple source systems (CRM & ERP)
* Apply **data cleaning, transformation, and enrichment**
* Implement **data modeling** using **fact and dimension tables**
* Design an optimized **Star Schema** for analytics
* Enable **analytics and reporting-ready datasets** for BI and decision-making

---

## 🏗️ Architecture Overview

The project follows a **layered data architecture**:
<img width="1536" height="1024" alt="architecture" src="https://github.com/user-attachments/assets/420b0327-7f86-4f15-9265-7cf5603d4288" />



### 1️⃣ Bronze Layer (Raw Data)

* Stores raw data ingested from source systems
* No business logic applied
* Acts as a historical record of source data

**Sources:**

* CRM System
* ERP System

**Example Tables:**

* crm_sales_details
* crm_cust_info
* crm_prd_info
* erp_cust_az12
* erp_loc_a101
* erp_px_cat_g1v2

---

### 2️⃣ Silver Layer (Cleaned & Standardized Data)

* Data is cleaned, validated, and standardized
* Data quality issues are handled (nulls, formats, duplicates)
* Data from multiple sources is aligned

**Key Activities:**

* Data type corrections
* Date standardization
* Removing invalid records
* Applying business rules

---

### 3️⃣ Gold Layer (Business & Analytics Layer)

* Final **analytics-ready views**
* Designed using **Star Schema**
* Used directly by BI tools and analysts

**Gold Tables:**

* `gold.dim_customers`
* `gold.dim_products`
* `gold.fact_sales`

---

## ⭐ Star Schema Design

### 📌 Dimension Tables

#### 🧑 `gold.dim_customers`

* Stores customer demographic and geographic details
* One row per customer

#### 📦 `gold.dim_products`

* Stores product details and classifications
* One row per product

### 📌 Fact Table

#### 💰 `gold.fact_sales`

* Stores transactional sales data
* Grain: **One row per product per order**
* Linked to customer and product dimensions

---

## 🛠️ Tools & Technologies Used

* **SQL Server** (Relational Database & Views)
* **T-SQL** (Data Transformation & Business Logic)
* **Data Integration** (CRM & ERP source systems)
* **Data Modeling** (Fact & Dimension tables)
* **Star Schema Modeling**
* **ETL / ELT Concepts**
* **Data Warehousing Concepts**

---

## 📂 Project Structure

```
Data-Warehouse-Project/
│
├── bronze/
│   ├── crm_sales_details.sql
│   ├── crm_cust_info.sql
│   └── erp_tables.sql
│
├── silver/
│   ├── cleaned_crm_data.sql
│   └── cleaned_erp_data.sql
│
├── gold/
│   ├── dim_customers.sql
│   ├── dim_products.sql
│   └── fact_sales.sql
│
├── documentation/
│   └── architecture_diagram.png
│
└── README.md
```

---

## 📈 Key Learnings

* Practical implementation of **modern data warehouse architecture**
* Hands-on experience with **data integration** from multiple source systems
* Importance of **data quality, validation, and standardization**
* Designing scalable **fact and dimension tables**
* Applying **data modeling techniques** using **Star Schema**
* Writing **clean, maintainable, and production-ready SQL**
* Understanding **real-world data engineering and analytics workflows**

---

## 🚀 How to Use This Project

1. Execute Bronze layer scripts to ingest raw data
2. Run Silver layer scripts for cleaning and transformation
3. Create Gold layer views for analytics
4. Query Gold tables for reporting and insights

---

## 🙏 Credits & Acknowledgement

This project is inspired and learned from:

**Data With Baraa – YouTube Channel**
🎥 Playlist: End-to-End Data Warehouse Project

Special thanks to **Baraa** for creating such high-quality, practical data engineering content.

---

## 📬 Contact

If you are a recruiter, data engineer, or learner and want to discuss this project:

* 📧 Email: *[meshackyesudaspost@gmail.com](mailto:meshackyesudaspost@gmail.com)*
* 🔗 LinkedIn: *[https://www.youtube.com/watch?v=9GVqKuTVANE&list=PLNcg_FV9n7qaUWeyUkPfiVtMbKlrfMqA8](https://www.youtube.com/watch?v=9GVqKuTVANE&list=PLNcg_FV9n7qaUWeyUkPfiVtMbKlrfMqA8)*

---

⭐ *If you found this project useful, consider starring the repository!*
