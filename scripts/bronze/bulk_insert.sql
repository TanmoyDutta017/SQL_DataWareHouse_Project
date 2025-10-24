/* Through belwo query we are creating a process where our data will be bulk inserted to 
our tables */


CREATE OR ALTER Procedure bronze_bulk_insert AS
BEGIN
BEGIN TRY
 DECLARE @Start_time DATETIME, @End_time DATETIME
PRINT '===================================================='
PRINT 'Loading the broze layer'
PRINT '===================================================='

PRINT '-------------------------------------------------------'
PRINT 'Loading CRM Table'
PRINT '-------------------------------------------------------'
	SET @Start_time = GETDATE()
    SET @Start_time = GETDATE()
		TRUNCATE TABLE bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\iamta\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		TRUNCATE TABLE bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\iamta\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		TRUNCATE TABLE bronze.crm_sales_details

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\iamta\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK);

	SET @End_time = GETDATE()

	
	PRINT '>>>>>>>>'
	PRINT 'Load time CRM: ' + CAST(DATEDIFF(second,@Start_time,@End_time) AS NVARCHAR) + ' Seconds'
	PRINT '>>>>>>>>'
PRINT '-------------------------------------------------------'
PRINT 'Loading ERP Table'
PRINT '-------------------------------------------------------'
   SET @Start_time = GETDATE()
		TRUNCATE TABLE bronze.erp_CUST_AZ12

		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'C:\Users\iamta\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK);

		TRUNCATE TABLE bronze.erp_LOC_A101

		BULK INSERT bronze.erp_LOC_A101
		FROM 'C:\Users\iamta\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK);

		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2

		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'C:\Users\iamta\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK);

 SET @End_time = GETDATE()
    
	PRINT '>>>>>>>>'
	PRINT 'Load time erp: ' + CAST(DATEDIFF(second,@Start_time,@End_time) AS NVARCHAR) + ' Seconds'
	PRINT '>>>>>>>>'
SET @End_time = GETDATE()


    PRINT '>>>>>>>>'
	PRINT 'Load time bronze: ' + CAST(DATEDIFF(second,@Start_time,@End_time) AS NVARCHAR) + ' Seconds'
	PRINT '>>>>>>>>'

END TRY
BEGIN CATCH
PRINT 'Error accured during loading bronze table'
PRINT 'Error message: ' + CAST(Error_message() AS NVARCHAR) 
END CATCH
END

EXEC bronze_bulk_insert
