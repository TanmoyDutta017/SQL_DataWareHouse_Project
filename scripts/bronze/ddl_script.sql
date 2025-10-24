/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/



DROP TABLE IF EXISTS bronze.crm_cust_info;
GO
CREATE TABLE bronze.crm_cust_info (
cst_id INT,
cst_key VARCHAR(25),
cst_firstname VARCHAR(25),
cst_lastname VARCHAR(25),
cst_marital_status VARCHAR(10),
cst_gndr VARCHAR(10),
cst_create_date DATE)

DROP TABLE IF EXISTS bronze.crm_prd_info;
GO
CREATE TABLE bronze.crm_prd_info (
prd_id INT,
prd_key VARCHAR(25),
prd_nm VARCHAR(40),
prd_cost INT,
prd_line VARCHAR(10),
prd_start_dt DATE,
prd_end_dt DATE)

DROP TABLE IF EXISTS bronze.crm_sales_details;
GO
CREATE TABLE bronze.crm_sales_details (
sls_ord_num VARCHAR(10),
sls_prd_key	VARCHAR(10),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt	INT,
sls_sales	INT,
sls_quantity INT,
sls_price INT)

DROP TABLE IF EXISTS bronze.erp_CUST_AZ12;
GO
CREATE TABLE bronze.erp_CUST_AZ12(
CID	VARCHAR(20),
BDATE DATE,
GEN VARCHAR(10) );

DROP TABLE IF EXISTS bronze.erp_LOC_A101;
GO
CREATE TABLE bronze.erp_LOC_A101(
CID VARCHAR(20),
CNTRY VARCHAR(20));

DROP TABLE IF EXISTS bronze.erp_PX_CAT_G1V2;
GO
CREATE TABLE bronze.erp_PX_CAT_G1V2(
ID VARCHAR(10),
CAT VARCHAR(20),
SUBCAT VARCHAR(20),
MAINTENANCE VARCHAR(10) )
