CREATE TABLE [dbo].[Department]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
	[DepartmentNo] INT NOT NULL, 
    [Name] VARCHAR(50) NOT NULL, 
    [Description] VARCHAR(200) NULL,
	CONSTRAINT [UK_Department_DepartmentNo] UNIQUE ([DepartmentNo])
)
