/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/


  IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[Schema1].[Versions]') AND type = N'U')
  BEGIN
	insert into [Schema1].[Versions] 
	([DacName], [DacVersion], [DateTimeUtc], [Action])
	values (N'$(SqlDacName)', N'$(SqlDacVersion)', GETUTCDATE(), N'PostDeploy');
	PRINT N'Inserted into Versions - PRE deployment';
  END;