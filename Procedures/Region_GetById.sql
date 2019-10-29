CREATE PROCEDURE [dbo].[Region_GetById]
(
	@Id INT
)
AS
BEGIN
	SELECT
		u.[Id],
		u.[DepartmentId],
		u.[RegionNo],
		u.[Name],
		u.[Description]
	FROM [dbo].[Region] u
	WHERE u.[Id] = @Id
END
