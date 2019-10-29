CREATE PROCEDURE [dbo].[Region_Update]
(
	@Id INT,
	@RegionNo INT,
	@DepartmentId INT,
    @Name VARCHAR(200),
	@Description VARCHAR(max)
)
AS
BEGIN
	UPDATE [dbo].[Region]
	SET
		[RegionNo] = ISNULL(@RegionNo, [RegionNo]),
		[DepartmentId] = ISNULL(@DepartmentId, [DepartmentId]),
		[Name] = ISNULL(@Name, [Name]),
		[Description] = ISNULL(@Description, [Description])
	WHERE [Id] = @Id
	
	EXEC [dbo].[Region_GetById] @Id
END