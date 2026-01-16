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

CREATE OR ALTER PROCEDURE bronze.bronze_load 
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
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'file location'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR =',',
		TABLOCK--IMPROVE PERFORMANCE IT WILL LOCK THE WHOLE TABLE 
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + 'seconds ';
		PRINT'--------------------------------------'

		SET @start_time = GETDATE();
		TRUNCATE TABLE  bronze.crm_prd_info;
		BULK INSERT  bronze.crm_prd_info
		FROM 'file location'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + 'seconds ';
		PRINT'--------------------------------------'

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details ;
		BULK INSERT bronze.crm_sales_details 
		FROM 'file location'
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
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'file location'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + 'seconds ';
		PRINT'--------------------------------------'

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'file location'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + 'seconds ';
		PRINT'--------------------------------------'

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'file location'
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

