BEGIN TRY
	
	BEGIN TRANSACTION

	INSERT INTO [dbo].[UserLocation] ([UserId], [LocationId])
	SELECT
		u.[Id],
		l.[Id]
	FROM [dbo].[User] u
	INNER JOIN [dbo].[Location] l ON l.[Id] = u.[LocationId]
	WHERE NOT EXISTS 
	(
		SELECT * FROM [UserLocation] e WHERE e.[UserId] = u.[Id] AND e.[LocationId] = l.[Id]
	)

	INSERT INTO [dbo].[UserLocation] ([UserId], [LocationId])
	SELECT
		u.[Id],
		l.[Id]
	FROM [dbo].[User] u
	INNER JOIN [dbo].[Region] r ON r.[Id] = u.[RegionId]
	INNER JOIN [dbo].[Location] l ON l.[RegionId] = u.[RegionId]
	WHERE NOT EXISTS 
	(
		SELECT * FROM [UserLocation] e WHERE e.[UserId] = u.[Id] AND e.[LocationId] = l.[Id]
	)

	INSERT INTO [dbo].[UserLocation] ([UserId], [LocationId])
	SELECT
		u.[Id],
		l.[Id]
	FROM [dbo].[User] u
	INNER JOIN [dbo].[Department] d ON d.[Id] = u.[DepartmentId]
	INNER JOIN [dbo].[Region] r ON r.[DepartmentId] = d.[Id]
	INNER JOIN [dbo].[Location] l ON l.[RegionId] = r.[Id]
	WHERE NOT EXISTS 
	(
		SELECT * FROM [UserLocation] e WHERE e.[UserId] = u.[Id] AND e.[LocationId] = l.[Id]
	)

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
