CREATE PROCEDURE [dbo].[User_GetById]
(
	@Id INT
)
AS
BEGIN
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
		u.[LocationId]
	FROM [dbo].[User] u
	WHERE u.[Id] = @Id
END