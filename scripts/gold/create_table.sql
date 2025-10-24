/* Note: We can't create create or alter view inside a store procedure so we are not creating a procedure. */
/* After creaing bronze and silver layer we are finaly joining each table as per their usage , we have created 1 fact_table 
and 2 dim_table */


PRINT ' Creating gold.dim_customers';
GO
CREATE OR ALTER VIEW gold.dim_customers AS
SELECT
ROW_NUMBER() over(Order by cst_id) AS customer_key,
ci.cst_id AS customer_id,
ci.cst_key AS customer_number,
ci.cst_firstname AS first_name,
ci.cst_lastname As last_name,
la.CNTRY AS country,
CASE WHEN ci.cst_gndr <> 'n/a' THEN ci.cst_gndr
ELSE coalesce(ca.GEN,'n/a')
END AS  gender,
ci.cst_marital_status AS marital_status,
ca.BDATE AS birth_date,
ci.cst_create_date AS create_date,
ci.create_date AS add_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_CUST_AZ12 ca
ON ci.cst_key = ca.CID
LEFT JOIN silver.erp_LOC_A101 la
ON ci.cst_key = la.CID
GO
PRINT ' Creating gold.dim_products'
GO
CREATE OR ALTER VIEW gold.dim_products AS
SELECT
ROW_NUMBER() OVER(Order by pn.prd_start_dt,pn.prd_key) AS product_key,
pn.prd_id AS product_id,
pn.prd_key AS product_number,
pn.prd_nm AS product_name,
pn.cat_id AS category_id,
pc.CAT AS category_name,
pc.SUBCAT AS subcategory_name,
pc.MAINTENANCE  AS maintenance,
pn.prd_cost As product_cost,
pn.prd_line AS product_line,
pn.prd_start_dt AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_PX_CAT_G1V2 pc
ON pn.cat_id = pc.ID
WHERE prd_end_dt IS NULL -- filter out historical data
GO

PRINT ' Creating gold.fact_sales'
GO
CREATE OR ALTER VIEW gold.fact_sales AS
SELECT
sd.sls_ord_num AS order_number,
pr.product_key,
cu.customer_key,
sd.sls_prd_key AS product_number,
sd.sls_cust_id AS customer_id,
sd.sls_order_dt As order_date,
sd.sls_ship_dt As ship_date,
sd.sls_due_dt as due_date,
sd.sls_sales as sales,
sd.sls_quantity as quantity,
sd.sls_price as price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
ON sd.sls_cust_id = cu.customer_id
