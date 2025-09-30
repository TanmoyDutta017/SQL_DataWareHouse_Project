-- CREATE DATABASE AND SCHEMAS

/* THIS PROCESS MAKE SURE THAT IF WE ALREADY HAVE DATABASE CALLED 'DataWareHouse' then we are first going to drop this and then 
Create this from Scratch */


/* Please note running this script will drop the entire Database 'DatawareHouse' if its exists.
All data in the database will be permanantly deleted, so process this with caution and ensure you have a complete backups before running
this query.*/

IF EXISTS (  SELECT 1 FROM SYS.databases WHERE name = 'DataWareHouse')
BEGIN
ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE DataWareHouse;
END;
GO
--Create DataBase

CREATE DATABASE DataWareHouse;

GO

USE DataWareHouse;
GO 
-- Create Schema
CREATE SCHEMA Bronze;
GO 
CREATE SCHEMA Silver;
GO
CREATE SCHEMA Gold;
GO
