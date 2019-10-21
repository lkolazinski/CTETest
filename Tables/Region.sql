CREATE TABLE [dbo].[Region]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [RegionNo] INT NOT NULL, 
	[DepartmentId] INT NULL,
    [Name] VARCHAR(200) NOT NULL,
	[Description] VARCHAR(max) NULL,
	CONSTRAINT [UK_Region_RegionNo] UNIQUE ([RegionNo]),
	CONSTRAINT [FK_Region_Department] FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[Department]([Id])
)
GO

CREATE INDEX [IX_Region_Department] ON [dbo].[Region] ([DepartmentId] ASC)
GO
