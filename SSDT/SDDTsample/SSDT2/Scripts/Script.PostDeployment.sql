﻿/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

:r C:\GitHub\kicaj29\sql\SSDT\SDDTsample\SSDT1\Scripts\Script.PostDeployment.sql

:r ..\SSDT1\Scripts\Script.PostDeployment.sql

insert into [Schema1].[Versions] 
([DacName], [DacVersion], [DateTimeUtc], [Action])
values (N'$(SqlDacName)', N'$(SqlDacVersion)', GETUTCDATE(), N'PostDeploy');
PRINT N'Inserted into Versions - POST deployment';