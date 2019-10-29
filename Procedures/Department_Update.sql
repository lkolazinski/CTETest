CREATE PROCEDURE [dbo].[Department_Update]
(
	@Id	INT,
	@DepartmentNo INT,
    @Name VARCHAR(50),
    @Description VARCHAR(200)
)
AS
BEGIN
	UPDATE [dbo].[Department]
	SET
		[DepartmentNo] = ISNULL(@DepartmentNo, [DepartmentNo]),
		[Name] = ISNULL(@Name, [Name]),
		[Description] = ISNULL(@Description, [Description])
	WHERE [Id] = @Id

	EXEC [dbo].[Department_GetById] @Id
END