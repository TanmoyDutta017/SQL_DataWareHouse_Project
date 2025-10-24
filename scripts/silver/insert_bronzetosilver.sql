-- silver Table DATA insert

CREATE OR ALTER Procedure Silver_Insert AS

BEGIN

PRINT 'Siver Table Data Insert : silver.crm_cust_info'
TRUNCATE TABLE  silver.crm_cust_info
INSERT INTO  silver.crm_cust_info(
       [cst_id]
      ,[cst_key]
      ,[cst_firstname]
      ,[cst_lastname]
      ,[cst_marital_status]
      ,[cst_gndr]
      ,[cst_create_date]
      )
SELECT
       [cst_id]
      ,[cst_key]
      ,TRIM([cst_firstname]) AS cst_firstname
      ,trim([cst_lastname]) AS cst_lastname
      ,CASE WHEN upper(trim(cst_marital_status)) = 'M' THEN 'Married'  
            WHEN upper(trim(cst_marital_status)) = 'S' THEN 'Single'
       ELSE 'n/a' END AS cst_marital_status
      ,CASE WHEN upper(trim(cst_gndr)) = 'M' THEN 'Male'
           WHEN upper(trim(cst_gndr)) = 'F' THEN 'Female'
           ELSE 'n/a' END AS cst_gndr
      ,[cst_create_date]
FROM(
SELECT
*,
ROW_NUMBER() OVER (Partition by cst_id order by cst_create_date DESC) AS Flag_last
FROM bronze.crm_cust_info)t
WHERE Flag_last = 1 AND cst_id IS NOT NULL


-- silver table 2 data insert

PRINT 'Siver Table Data Insert : silver.crm_prd_info'
TRUNCATE TABLE  silver.crm_prd_info
INSERT INTO silver.crm_prd_info 
       ([prd_id]
      ,[cat_id]
      ,[prd_key]
      ,[prd_nm]
      ,[prd_cost]
      ,[prd_line]
      ,[prd_start_dt]
      ,[prd_end_dt])
SELECT  [prd_id]
      ,REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id
      ,SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key
      ,[prd_nm]
      ,COALESCE([prd_cost],0) AS prd_cost
      ,CASE WHEN upper(trim(prd_line)) = 'M' THEN 'Mounting'
      WHEN upper(trim(prd_line)) = 'R' THEN 'Road'
      WHEN upper(trim(prd_line)) = 'T' THEN 'Touring'
      WHEN upper(trim(prd_line)) = 'S' THEN 'Other Sales'
      ELSE 'n/a' END AS prd_line
,CAST(prd_start_dt AS Date) AS prd_start_dt
,CAST(DATEADD(Day,-1,LEAD(prd_start_dt) OVER(partition by prd_key Order by prd_start_dt)) AS date) AS prd_end_dt
  FROM [datawarehouse].[bronze].[crm_prd_info]



-- silver table 3 data insert

PRINT 'Siver Table Data Insert : silver.crm_sales_details'
TRUNCATE TABLE  silver.crm_sales_details
INSERT INTO silver.crm_sales_details (
       [sls_ord_num]
      ,[sls_prd_key]
      ,[sls_cust_id]
      ,[sls_order_dt]
      ,[sls_ship_dt]
      ,[sls_due_dt]
      ,[sls_sales]
      ,[sls_quantity]
      ,[sls_price])
SELECT  [sls_ord_num]
      ,[sls_prd_key]
      ,[sls_cust_id]
      ,CASE WHEN sls_order_dt <=0 OR len(sls_order_dt) <>8 THEN NULL
      ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
      END sls_order_dt
      ,CASE WHEN sls_ship_dt <=0 OR len(sls_ship_dt) <>8 THEN NULL
      ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
      END AS sls_ship_dt
      ,CASE WHEN sls_due_dt <=0 OR len(sls_due_dt) <>8 THEN NULL
      ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
      END  AS sls_due_dt
      ,CASE WHEN sls_sales IS NULL OR sls_sales <> sls_quantity * ABS(sls_price) THEN sls_quantity * ABS(sls_price)
ELSE sls_sales END AS sls_sales
      ,[sls_quantity]
      ,CASE WHEN sls_price <= 0 OR sls_price IS NULL THEN sls_sales/NULLIF(sls_quantity,0) ELSE sls_price END AS sls_price
  FROM [datawarehouse].[bronze].[crm_sales_details]


-- Silver Table 4 Insert data
PRINT 'Siver Table Data Insert : silver.erp_CUST_AZ12'
TRUNCATE TABLE  silver.erp_CUST_AZ12
INSERT INTO silver.erp_CUST_AZ12(
CID,
BDATE,
GEN)
SELECT 
CASE WHEN CID LIKE '%NAS%' THEN substring(CID,4,lEN(CID)) 
ELSE CID END AS CID
,CASE WHEN BDATE > GETDATE() THEN NULL
ELSE BDATE END AS BDATE
,CASE WHEN upper(trim(GEN)) IN ('Male','M') THEN 'Male'
     WHEN upper(trim(GEN)) IN ('Female','F') THEN 'Female'
     ELSE 'n/a' END AS GEN
  FROM [datawarehouse].[bronze].[erp_CUST_AZ12]



-- Silver Table 5 insert Data
PRINT 'Siver Table Data Insert : silver.erp_LOC_A101'
TRUNCATE TABLE  silver.erp_LOC_A101
INSERT INTO silver.erp_LOC_A101(
CID,
CNTRY)
SELECT  REPLACE([CID],'-','') AS CID
      ,CASE WHEN trim(CNTRY) = 'DE' THEN 'Germany'
      WHEN trim(CNTRY) IN ('US','USA') THEN 'United States'
      WHEN trim(CNTRY) = '' OR TRIM(CNTRY) IS NULL THEN 'n/a'
      ELSE TRIM(CNTRY) END AS CNTRY
  FROM [datawarehouse].[bronze].[erp_LOC_A101]


-- Silver Table 6 insert data
PRINT 'Siver Table Data Insert : silver.erp_PX_CAT_G1V2'
TRUNCATE TABLE  silver.erp_PX_CAT_G1V2
INSERT INTO silver.erp_PX_CAT_G1V2
(ID,
CAT,
SUBCAT,
MAINTENANCE)
SELECT [ID]
      ,[CAT]
      ,[SUBCAT]
      ,[MAINTENANCE]
  FROM [datawarehouse].[bronze].[erp_PX_CAT_G1V2]

  END
  

  EXEC Silver_Insert
