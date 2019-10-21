CREATE PROCEDURE [dbo].[User_GetFiltred]
(
	@RoleIdTable [dbo].[TVPUserType] READONLY, -- must be declared as read only
	@DepartmentIdTable [dbo].[TVPUserType] READONLY -- must be declared as read only
)
AS
BEGIN

	DECLARE @RoleIsDempty INT = 1
	IF EXISTS ( SELECT 1 FROM @RoleIdTable )
		SET @RoleIsDempty = 0

	DECLARE @DepartmentIsDempty INT = 1
	IF EXISTS ( SELECT 1 FROM @RoleIdTable )
		SET @DepartmentIsDempty = 0


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
		r.[Name] AS [RoleName],
		r.[RoleNo],
		
		u.[DepartmentId],
		d.[DepartmentNo],
		d.[Name] AS [DepartmentName],

		u.[RegionId],
		s.[Name] AS [RegionName],
		s.[RegionNo] AS [RegionNo],

		u.[LocationId],
		l.[Name] AS [LocationName],
		l.[LocationNo]
		
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

EXEC [dbo].[User_GetFiltred] @TmpRoleIdTable, @TmpDepartmentIdTable

*/