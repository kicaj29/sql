CREATE TABLE [Schema1].[Versions]
(
	[Id] INT NOT NULL identity PRIMARY KEY, 
    [DacName] NVARCHAR(50) NOT NULL, 
    [DacVersion] NVARCHAR(50) NOT NULL, 
    [DateTimeUtc] DATETIME2 NOT NULL, 
    [Action] NVARCHAR(50) NOT NULL
)
