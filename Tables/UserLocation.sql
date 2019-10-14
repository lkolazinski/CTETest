CREATE TABLE [dbo].[UserLocation]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [UserId] INT NOT NULL, 
    [LocationId] INT NOT NULL, 
    CONSTRAINT [FK_UserLocation_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User]([Id]),
	CONSTRAINT [FK_UserLocation_Location] FOREIGN KEY ([LocationId]) REFERENCES [dbo].[Location]([Id]) 
)

GO

CREATE UNIQUE INDEX [IX_UserLocation_UserIdLocationId] ON [dbo].[UserLocation] ([UserId], [LocationId])
