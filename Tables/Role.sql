CREATE TABLE [dbo].[Role]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Name] VARCHAR(50) NOT NULL, 
    [RoleNo] INT NOT NULL, 
    [Description] VARCHAR(200) NULL, 
    [CreationDate] DATETIME NOT NULL DEFAULT GETDATE(), 
    CONSTRAINT [UK_Role_RoleNo] UNIQUE ([RoleNo])
)
