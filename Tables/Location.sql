CREATE TABLE [dbo].[Location]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [LocationNo] INT NOT NULL, 
    [Name] VARCHAR(200) NOT NULL, 
	[RegionId] INT NOT NULL,
    [Telephone] VARCHAR(200) NULL, 
    [Email] VARCHAR(200) NULL, 
    [Address1] VARCHAR(200) NOT NULL, 
    [Address2] VARCHAR(200) NULL, 
    [CreationDate] DATETIME NOT NULL DEFAULT getdate(), 
    [ModificationDate] DATETIME NULL, 
    CONSTRAINT [FK_Location_Region] FOREIGN KEY ([RegionId]) REFERENCES [Region]([Id]),
	CONSTRAINT [UK_Location_LocationNo] UNIQUE ([LocationNo])
)
