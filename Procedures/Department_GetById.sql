CREATE PROCEDURE [dbo].[Department_GetById]
(
	@Id INT
)
AS
BEGIN
	SELECT
		u.[Id],
		u.[DepartmentNo],
		u.[Name],
		u.[Description]
	FROM [dbo].[Department] u
	WHERE u.[Id] = @Id
END
