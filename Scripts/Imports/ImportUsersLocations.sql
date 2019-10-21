BEGIN TRY
	
	BEGIN TRANSACTION

	INSERT INTO [dbo].[UserLocation] ([UserId], [LocationId])
	SELECT
		u.[Id],
		l.[Id]
	FROM [dbo].[User] u
	INNER JOIN [dbo].[Location] l ON l.[Id] = u.[LocationId]

	INSERT INTO [dbo].[UserLocation] ([UserId], [LocationId])
	SELECT
		u.[Id],
		l.[Id]
	FROM [dbo].[User] u
	INNER JOIN [dbo].[Region] r ON r.[Id] = u.[RegionId]
	INNER JOIN [dbo].[Location] l ON l.[RegionId] = u.[RegionId]

	COMMIT TRANSACTION

END TRY  
BEGIN CATCH 
	INSERT INTO [dbo].[Logs] ([Message], [AdditionalMessage], [LogType])
	SELECT 
		'[UserLocation] Insert error :[' + ERROR_MESSAGE() + ']', 
		'Line:[' + CAST(ERROR_LINE() AS VARCHAR) + ']. Error number:[' + CAST(ERROR_NUMBER() AS VARCHAR) + '].', 
		'E'
END CATCH
GO
