/*
===============================================================================
DDL Script: Create silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'silver' Tables
===============================================================================
*/



DROP TABLE IF EXISTS silver.crm_cust_info;
GO
CREATE TABLE silver.crm_cust_info (
cst_id INT,
cst_key VARCHAR(25),
cst_firstname VARCHAR(25),
cst_lastname VARCHAR(25),
cst_marital_status VARCHAR(10),
cst_gndr VARCHAR(10),
cst_create_date DATE,
create_date DATETIME DEFAULT GETDATE())

DROP TABLE IF EXISTS silver.crm_prd_info;
GO
CREATE TABLE silver.crm_prd_info (
prd_id INT,
cat_id VARCHAR(25),
prd_key VARCHAR(25),
prd_nm VARCHAR(40),
prd_cost INT,
prd_line VARCHAR(15),
prd_start_dt DATE,
prd_end_dt DATE,
create_date DATETIME DEFAULT GETDATE())

DROP TABLE IF EXISTS silver.crm_sales_details;
GO
CREATE TABLE silver.crm_sales_details (
sls_ord_num VARCHAR(10),
sls_prd_key	VARCHAR(10),
sls_cust_id INT,
sls_order_dt DATE,
sls_ship_dt DATE,
sls_due_dt	DATE,
sls_sales	INT,
sls_quantity INT,
sls_price INT,
create_date DATETIME DEFAULT GETDATE())

DROP TABLE IF EXISTS silver.erp_CUST_AZ12;
GO
CREATE TABLE silver.erp_CUST_AZ12(
CID	VARCHAR(20),
BDATE DATE,
GEN VARCHAR(10),
create_date DATETIME DEFAULT GETDATE() );

DROP TABLE IF EXISTS silver.erp_LOC_A101;
GO
CREATE TABLE silver.erp_LOC_A101(
CID VARCHAR(20),
CNTRY VARCHAR(20),
create_date DATETIME DEFAULT GETDATE());

DROP TABLE IF EXISTS silver.erp_PX_CAT_G1V2;
GO
CREATE TABLE silver.erp_PX_CAT_G1V2(
ID VARCHAR(10),
CAT VARCHAR(20),
SUBCAT VARCHAR(20),
MAINTENANCE VARCHAR(10),
create_date DATETIME DEFAULT GETDATE() )
