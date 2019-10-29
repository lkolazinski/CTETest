CREATE PROCEDURE [dbo].[Role_Update]
(
	@Id INT,
    @Name VARCHAR(50),
    @RoleNo INT,
    @Description VARCHAR(200)
)
AS
BEGIN
	UPDATE [dbo].[Role]
	SET
		[Name] = ISNULL(@Name, [Name]),
		[RoleNo] = ISNULL(@RoleNo, [RoleNo]),
		[Description] = ISNULL(@Description, [Description])
	WHERE [Id] = @Id
	
	EXEC [dbo].[Role_GetById] @Id
END
