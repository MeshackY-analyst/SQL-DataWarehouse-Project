/*
====================================================================================================
DDL Script: Create Gold Views
====================================================================================================

Script Purpose:
This script creates views for the Gold layer in the data warehouse.
The Gold layer represents the final dimension and fact tables (Star Schema).

Each view performs transformations and combines data from the Silver layer
to produce a clean, enriched, and business-ready dataset.

Usage:
- These views can be queried directly for analytics and reporting.
====================================================================================================
*/


--GOLD LAYER SCRIPTING
CREATE VIEW gold.dim_customers AS
SELECT 
ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
		cl.cntry,
	ci.cst_firstname AS customer_fistname,
	ci.cst_lastname AS customer_lastname,
	ci.cst_marital_status AS customer_marital_status,
	CASE WHEN ci.cst_gndr!='N/A' THEN ci.cst_gndr ELSE 
	COALESCE(ca.gen,'N/A')
	END AS Gender,
	ca.bdate AS birthdate,
	ci.cst_create_date

FROM silver.crm_cust_info ci
LEFT JOIN 
silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid 
LEFT JOIN silver.erp_loc_a101 cl
ON ci.cst_key = cl.cid
------------------------------------------------------------------------------------------------
--PRODUCT
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
CREATE VIEW gold.dim_products AS
SELECT 
ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt,pn.prd_key) AS product_key,
	pn.prd_id AS product_id,
	pn.prd_key AS product_number,
	pn.prd_nm AS product_name,
	pc.id AS category_id,
	pc.cat AS category,
	pc.subcat AS subcategory,
	pc.maintenance,
	pn.prd_cost AS product_cost,
	pn.prd_line AS product_line,
	pn.prd_start_dt AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN 
 silver.erp_px_cat_g1v2 pc
 ON pn.prd_cat = pc.id
 WHERE prd_end_dt IS NULL--filtering all historical data 
 
 SELECT * FROM silver.crm_prd_info

 SELECT * FROM gold.dim_products

 ------------------------------------------------------------------------------------------------
--FACT TABLE 
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

CREATE VIEW gold.fact_sales AS
SELECT DISTINCT COUNT(*)(SELECT 
sd.sls_ord_num AS order_number ,
pr.product_key,
cu.customer_key,
sd.sls_order_dt AS order_date,
sd.sls_ship_dt AS shipping_date,
sd.sls_due_dt AS due_date,
sd.sls_sales AS sales_amount,
sd.sls_quantity AS quantity ,
sd.sls_price AS price
FROM silver.crm_sales_details sd
LEFT JOIN 
gold.dim_products pr 
ON sd.sls_prd_key = pr.product_number
LEFT JOIN 
gold.dim_customers cu
ON sd.sls_cust_id = cu.customer_id)
---------------------------------------------
SELECT * FROM 
gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
LEFT JOIN 
gold.dim_products p
ON p.product_key= f.product_key
WHERE c.customer_key IS NULL;
--------------------------------------------------------
---------------------------------------------
