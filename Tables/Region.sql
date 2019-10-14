CREATE TABLE [dbo].[Region]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [RegionNo] INT NOT NULL, 
    [Name] VARCHAR(200) NOT NULL,
	[Description] VARCHAR(max) NULL,
	CONSTRAINT [UK_Role_RegionNo] UNIQUE ([RegionNo])
)
