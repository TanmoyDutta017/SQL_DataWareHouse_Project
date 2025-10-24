/*
==================================================
Create Database and schemas
==================================================

Scripts Purpose:
     This script crates a new database named 'datawarehouse' after checking if it already exists.
     If the database exists then it is dropped and recreated. Additionally, the script set up three
     schemas withing database: 'bronze','silver','gold'

Warning:
     Running this script will drop the entire 'datawarehouse' database if exists.
     so before running this query ensure  you have proper backups of the data.

 */

USE master

IF EXISTS (SELECT 1 FROM  sys.databases WHERE name = 'datawarehouse')
BEGIN
     ALTER DATABASE datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
     DROP DATABASE datawarehouse;
 END;
 GO

 -- Create database
CREATE DATABASE datawarehouse;
GO
USE datawarehouse;
GO

--  Create Schemas

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
