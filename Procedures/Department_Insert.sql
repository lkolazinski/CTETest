CREATE PROCEDURE [dbo].[Department_Insert]
(
	@DepartmentNo INT,
    @Name VARCHAR(50),
    @Description VARCHAR(200)
)
AS
BEGIN
	INSERT INTO [dbo].[Department]
	(
		[DepartmentNo],
		[Name],
		[Description]
	)
	SELECT
		@DepartmentNo,
		@Name,
		@Description

	EXEC [dbo].[Department_GetById] @@IDENTITY
END
