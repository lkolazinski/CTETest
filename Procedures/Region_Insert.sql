CREATE PROCEDURE [dbo].[Region_Insert]
(
	@RegionNo INT,
	@DepartmentId INT,
    @Name VARCHAR(200),
	@Description VARCHAR(max)
)
AS
BEGIN
	INSERT INTO [dbo].[Region]
	(
		[RegionNo],
		[DepartmentId],
		[Name],
		[Description]
	)
	SELECT
		@RegionNo,
		@DepartmentId,
		@Name,
		@Description

	EXEC [dbo].[Region_GetById] @@IDENTITY
END
