CREATE TABLE [dbo].[User]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
	[RoleId] INT NOT NULL,
	[DepartmentId] INT NULL,
    [Login] VARCHAR(50) NOT NULL, 
    [Password] VARCHAR(200) NOT NULL, 
    [Name] VARCHAR(200) NULL, 
    [Surname] VARCHAR(200) NOT NULL, 
	[UserNo] INT NOT NULL,
    [CreationDate] DATETIME NOT NULL DEFAULT getdate(), 
    [ModifiationDate] DATETIME NULL ,
	CONSTRAINT [UK_User_Login] UNIQUE ([Login]),
	CONSTRAINT [UK_User_UserNo] UNIQUE ([UserNo]),
	CONSTRAINT [FK_User_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role]([Id]),
	CONSTRAINT [FK_User_Department] FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[Department]([Id])
)
