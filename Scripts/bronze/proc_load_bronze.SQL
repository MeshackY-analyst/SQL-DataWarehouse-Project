/*
================================================================================================
This Code is of Store Procedure and it Loads data into 'bronze' schema from external CSV files.
it performs actions such as 
  truncates the bronze table before loading data.
  Uses the 'Bulk Insert' command to laod data from csv files to bronze tables

Parameters :
  None.
this stored Procedure does not accept any parameters or return any values 

Usage Example:
  EXEC bronze.load_bronze;
  ===============================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS 
BEGIN
 DECLARE @start_time DATETIME , @end_time DATETIME;
  BEGIN TRY
		PRINT'=====================================================================================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT'=====================================================================================';

		PRINT '------------------------------------------------------------------------------------';
		PRINT'Loading CRM Tables';
		PRINT '------------------------------------------------------------------------------------';

	    SET @start_time = GETDATE();
		PRINT'>>Truncating table bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT'>>Inserting data into table bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\mesha\Desktop\WHR\data\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR =',',
		TABLOCK--IMPROVE PERFORMANCE IT WILL LOCK THE WHOLE TABLE 
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + ' seconds ';
		PRINT'--------------------------------------'

		SET @start_time = GETDATE();
		PRINT'>>Truncating table bronze.crm_prd_info'
		TRUNCATE TABLE  bronze.crm_prd_info;
		PRINT'>>Inserting data into table bronze.crm_prd_info'
		BULK INSERT  bronze.crm_prd_info
		FROM 'C:\Users\mesha\Desktop\WHR\data\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + 'seconds ';
		PRINT'--------------------------------------'

		SET @start_time = GETDATE();
		PRINT'>>Truncating table bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details ;
		PRINT'>>Inserting data into table bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details 
		FROM 'C:\Users\mesha\Desktop\WHR\data\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + 'seconds ';
		PRINT'--------------------------------------'

		PRINT '------------------------------------------------------------------------------------';
		PRINT'Loading ERP Tables';
		PRINT '------------------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT'>>Truncating table bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT'>>Inserting data into table bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\mesha\Desktop\WHR\data\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + 'seconds ';
		PRINT'--------------------------------------'

		PRINT'>>Truncating table bronze.erp_loc_a101'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT'>>Inserting data into table bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\mesha\Desktop\WHR\data\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + 'seconds ';
		PRINT'--------------------------------------'

		SET @start_time = GETDATE();
		PRINT'>>Truncating table bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT'>>Inserting data into table bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\mesha\Desktop\WHR\data\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR =',',
		TABLOCK
	    );
		SET @end_time = GETDATE();
		PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + 'seconds ';
		PRINT'--------------------------------------'
 END TRY
	BEGIN CATCH 
		PRINT '============================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message ' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);

		PRINT '============================================================';
	END CATCH 
END
