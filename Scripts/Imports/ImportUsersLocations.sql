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

	--DELETE FROM [dbo].[UserLocation] WHERE ID < 20000

	;WITH ByLocation
	AS
	(
		SELECT
			u.[Id] AS [UserId],
			l.[Id] AS [LocationId]
		FROM [dbo].[User] u
		INNER JOIN [dbo].[Location] l ON l.[Id] = u.[LocationId] 
	),
	ByRegion
	AS
	(
		SELECT
			u.[Id] AS [UserId],
			l.[Id] AS [LocationId]
		FROM [dbo].[User] u
		INNER JOIN [dbo].[Region] r ON r.[Id] = u.[RegionId]
		INNER JOIN [dbo].[Location] l ON l.[RegionId] = u.[RegionId]
	),
	ByDepartment
	AS
	(
		SELECT
			u.[Id] AS [UserId],
			l.[Id] AS [LocationId]
		FROM [dbo].[User] u
		INNER JOIN [dbo].[Department] d ON d.[Id] = u.[DepartmentId]
		INNER JOIN [dbo].[Region] r ON r.[DepartmentId] = d.[Id]
		INNER JOIN [dbo].[Location] l ON l.[RegionId] = r.[Id]
	),
	AllLocations
	AS
	(
		SELECT 
		*
		FROM ByLocation
		UNION
		SELECT 
		*
		FROM ByRegion
		UNION
		SELECT 
		*
		FROM ByDepartment
	)
	MERGE [dbo].[UserLocation] AS TARGET
	USING
	(
		SELECT 
		* 
		FROM AllLocations
	) AS SOURCE ([MyUserId], [MyLocationId])
	ON (TARGET.[UserId] = SOURCE.[MyUserId] AND TARGET.[LocationId] = SOURCE.[MyLocationId])
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE
	WHEN NOT MATCHED THEN
		INSERT ([UserId], [LocationId])
		VALUES (SOURCE.[MyUserId], SOURCE.[MyLocationId])
	OUTPUT deleted.*, $action, inserted.* ;

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
