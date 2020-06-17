CREATE PROCEDURE [dbo].[User_GetFiltredScalar]
(
	@RoleIdTable [dbo].[TVPUserType] READONLY, -- must be declared as read only
	@DepartmentIdTable [dbo].[TVPUserType] READONLY, -- must be declared as read only,
	@SortColumn VARCHAR(100) = NULL,
	@PageNumber INT = 1,
	@PageSize INT = 9999999
)
AS
BEGIN

	DECLARE @lSortColumn VARCHAR(100) = LOWER(ISNULL(@SortColumn, ''))

	DECLARE @RoleIsDempty INT = 1
	IF EXISTS ( SELECT 1 FROM @RoleIdTable )
		SET @RoleIsDempty = 0

	DECLARE @DepartmentIsDempty INT = 1
	IF EXISTS ( SELECT 1 FROM @DepartmentIdTable )
		SET @DepartmentIsDempty = 0

	DECLARE @KeysTable AS TABLE
	(
		[Id] INT PRIMARY KEY,
		[RowOrder] INT UNIQUE
	)
	
	;WITH Pom
	AS
	(
		SELECT
			u.[Id],
			ROW_NUMBER() OVER (ORDER BY 
				CASE WHEN @lSortColumn = 'login' THEN  u.[Login] END ASC,
				CASE WHEN @lSortColumn = '-login' THEN  u.[Login] END DESC,
				CASE WHEN @lSortColumn = 'userno' THEN  u.[UserNo] END ASC,
				CASE WHEN @lSortColumn = '-userno' THEN  u.[UserNo] END DESC,
				CASE WHEN @lSortColumn = 'name' THEN  u.[Name] END ASC,
				CASE WHEN @lSortColumn = '-name' THEN  u.[Name] END DESC,
				CASE WHEN @lSortColumn = 'surname' THEN  u.[Surname] END ASC,
				CASE WHEN @lSortColumn = '-surname' THEN  u.[Surname] END DESC,
				CASE WHEN @lSortColumn = 'creationdate' THEN  u.[CreationDate] END ASC,
				CASE WHEN @lSortColumn = '-creationdate' THEN  u.[CreationDate] END DESC,
				CASE WHEN @lSortColumn = 'modifiationdate' THEN  u.[ModifiationDate] END ASC,
				CASE WHEN @lSortColumn = '-modifiationdate' THEN  u.[ModifiationDate] END DESC,
				CASE WHEN @lSortColumn = 'roleid' THEN  u.[RoleId] END ASC,
				CASE WHEN @lSortColumn = '-roleid' THEN  u.[RoleId] END DESC,
				CASE WHEN @lSortColumn = 'departmentid' THEN  u.[DepartmentId] END ASC,
				CASE WHEN @lSortColumn = '-departmentid' THEN  u.[DepartmentId] END DESC,
				CASE WHEN @lSortColumn = 'regionid' THEN  u.[RegionId] END ASC,
				CASE WHEN @lSortColumn = '-regionid' THEN  u.[RegionId] END DESC,
				CASE WHEN @lSortColumn = 'locationid' THEN  u.[LocationId] END ASC,
				CASE WHEN @lSortColumn = '-locationid' THEN  u.[LocationId] END DESC
			) AS [RowOrder]
		FROM [dbo].[User] u
		LEFT JOIN @RoleIdTable t ON t.[UniqueId] = u.[RoleId]
		LEFT JOIN [dbo].[Role] r ON r.[Id] = t.[UniqueId]
		LEFT JOIN @DepartmentIdTable w ON w.[UniqueId] = u.[DepartmentId]
		LEFT JOIN [dbo].[Department] d ON d.[Id] = u.[DepartmentId]
		LEFT JOIN [dbo].[Region] s ON s.[Id] = u.[RegionId]
		LEFT JOIN [dbo].[Location] l ON l.[Id] = u.[LocationId]
		WHERE 
			(@RoleIsDempty = 1 OR t.[UniqueId] IS NOT NULL)
			OR
			(@DepartmentIsDempty = 1 OR w.[UniqueId] IS NOT NULL)
	)
	INSERT INTO @KeysTable([Id], [RowOrder])
	SELECT
		u.[Id],
		p.[RowOrder]
	FROM Pom p
	INNER JOIN [dbo].[User] u ON u.[Id] = p.[Id]
	ORDER BY p.[RowOrder] ASC
	OFFSET @PageSize * (@PageNumber - 1) ROWS
	FETCH NEXT @PageSize ROWS ONLY OPTION (RECOMPILE);

	SELECT
		u.[Id],
		u.[Login],
		u.[Name],
		NULL AS [Password],
		u.[Surname],
		u.[UserNo],
		u.[CreationDate],
		u.[ModifiationDate],
		
		u.[RoleId],
		u.[DepartmentId],
		u.[RegionId],
		u.[LocationId],
		
		p.[RowOrder]
	FROM @KeysTable p
	INNER JOIN [dbo].[User] u ON u.[Id] = p.[Id]
	ORDER BY p.[RowOrder] ASC

	SELECT
		d.[Id],
		d.[DepartmentNo],
		d.[Description],
		d.[Name],
		p.[RowOrder]
	FROM @KeysTable p
	INNER JOIN [dbo].[User] u ON u.[Id] = p.[Id]
	INNER JOIN [dbo].[Department] d ON d.[Id] = u.[DepartmentId]
	--ORDER BY p.[RowOrder] ASC

	SELECT
		d.[Id],
		d.[RoleNo],
		d.[CreationDate],
		d.[Description],
		d.[Name],
		p.[RowOrder]
	FROM @KeysTable p
	INNER JOIN [dbo].[User] u ON u.[Id] = p.[Id]
	INNER JOIN [dbo].[Role] d ON d.[Id] = u.[RoleId]
	--ORDER BY p.[RowOrder] ASC

	;WITH Pom
	AS
	(
		SELECT
			l.[Id],
			l.[LocationNo],
			l.[RegionId],
			l.[Address1],
			l.[Address2],
			l.[Name],
			l.[Province],
			l.[Site],
			l.[CreationDate],
			l.[ModificationDate],
			[dbo].[f_GetLocationCountForUserId](u.[Id]) AS [LocationCount]
		FROM @KeysTable p
		INNER JOIN [dbo].[User] u ON u.[Id] = p.[Id]
		INNER JOIN [dbo].[Location] l ON l.[Id] = u.[LocationId]
		--ORDER BY [LocationCount] ASC
	) 
	SELECT
	*
	FROM Pom
	ORDER BY [LocationCount] DESC


END


/* Test

DECLARE @TmpRoleIdTable [dbo].[TVPUserType] 
INSERT INTO @TmpRoleIdTable VALUES(1)
INSERT INTO @TmpRoleIdTable VALUES(2)
INSERT INTO @TmpRoleIdTable VALUES(3)
INSERT INTO @TmpRoleIdTable VALUES(4)
INSERT INTO @TmpRoleIdTable VALUES(5)

DECLARE @TmpDepartmentIdTable [dbo].[TVPUserType] 
INSERT INTO @TmpDepartmentIdTable VALUES(1)
INSERT INTO @TmpDepartmentIdTable VALUES(2)
INSERT INTO @TmpDepartmentIdTable VALUES(3)
INSERT INTO @TmpDepartmentIdTable VALUES(4)
INSERT INTO @TmpDepartmentIdTable VALUES(5)

EXEC [dbo].[User_GetFiltredScalar] @TmpRoleIdTable, @TmpDepartmentIdTable, 'name', 1, 200

*/