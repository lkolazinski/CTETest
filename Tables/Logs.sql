CREATE TABLE [dbo].[Logs]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Message] VARCHAR(MAX) NOT NULL, 
    [AdditionalMessage] VARCHAR(MAX) NULL, 
    [LogType] CHAR NOT NULL DEFAULT 'I', --I - Info, W - Warning, E - Exception
	[CreationDate] DATETIME NOT NULL DEFAULT getdate()
)
