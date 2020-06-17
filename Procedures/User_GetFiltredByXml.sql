CREATE PROCEDURE [dbo].[User_GetFiltredByXml]
(
	--@DepartmentIdTable [dbo].[TVPUserType] READONLY, -- must be declared as read only,
	@RoleIdXml XML,
	@DepartmentIdXml XML,
	@SortColumn VARCHAR(100) = NULL,
	@PageNumber INT = 1,
	@PageSize INT = 9999999
)
AS
BEGIN

	DECLARE @lSortColumn VARCHAR(100) = LOWER(ISNULL(@SortColumn, ''))

	DECLARE @RoleIdTable AS TABLE
	(
		[UniqueId] INT PRIMARY KEY
	)

	INSERT INTO @RoleIdTable([UniqueId])
	SELECT DISTINCT
		'Id' = x.v.value('id[1]', 'Int')
	FROM @RoleIdXml.nodes('/root/row') x(v)

	DECLARE @RoleIsDempty INT = 1
	IF EXISTS ( SELECT 1 FROM @RoleIdTable )
		SET @RoleIsDempty = 0

	DECLARE @DepartmentIdTable AS TABLE
	(
		[UniqueId] INT PRIMARY KEY
	)

	INSERT INTO @DepartmentIdTable([UniqueId])
	SELECT DISTINCT
		'Id' = x.v.value('id[1]', 'Int')
	FROM @DepartmentIdXml.nodes('/root/row') x(v)

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
		l.[ModificationDate]		
	FROM @KeysTable p
	INNER JOIN [dbo].[User] u ON u.[Id] = p.[Id]
	INNER JOIN [dbo].[Location] l ON l.[Id] = u.[LocationId]
	--ORDER BY p.[RowOrder] ASC

END


/* Test 

-- 1
--Insert into RoleIdTable
DECLARE @RoleIdTable AS TABLE
(
	[Id] INT PRIMARY KEY
)


DECLARE @RoleIdXml XML = 
'<root>
	<row><id>1</id></row>
	<row><id>2</id></row>
	<row><id>3</id></row>
	<row><id>4</id></row>
	<row><id>4</id></row>
</root>'

INSERT INTO @RoleIdTable([Id])
SELECT DISTINCT
	'Id' = x.v.value('id[1]', 'Int')
FROM @RoleIdXml.nodes('/root/row') x(v)

--select * from @RoleIdTable
--

-- 2
--Insert into DepartmentIdTable
DECLARE @DepartmentIdTable AS TABLE
(
	[Id] INT PRIMARY KEY
)


DECLARE @DepartmentIdXml XML = 
'<root>
	<row><id>1</id></row>
	<row><id>2</id></row>
	<row><id>3</id></row>
	<row><id>4</id></row>
</root>'


INSERT INTO @DepartmentIdTable([Id])
SELECT DISTINCT
	'Id' = x.v.value('id[1]', 'Int')
FROM @DepartmentIdXml.nodes('/root/row') x(v)

--select * from @DepartmentIdTable

-- 3
DECLARE @RoleIdXml XML = 
'<root>
	<row><id>1</id></row>
	<row><id>2</id></row>
	<row><id>3</id></row>
	<row><id>4</id></row>
	<row><id>4</id></row>
</root>'

DECLARE @DepartmentIdXml XML = 
'<root>
	<row><id>1</id></row>
	<row><id>2</id></row>
	<row><id>3</id></row>
	<row><id>4</id></row>
	<row><id>4</id></row>
</root>'

EXEC [dbo].[User_GetFiltredByXml] @RoleIdXml, @DepartmentIdXml, 'name', 1, 200

*/