CREATE PROCEDURE [dbo].[User_Update]
(
	@Id	INT,
	@RoleId INT,
	@DepartmentId INT,
	@RegionId INT,
	@LocationId INT,
    @Login VARCHAR(50), 
    @Password VARCHAR(200), 
    @Name VARCHAR(200), 
    @Surname VARCHAR(200), 
	@UserNo INT
)
AS
BEGIN
	UPDATE [dbo].[User] 
	SET
		[RoleId]= ISNULL(@RoleId, [RoleId]),
		[DepartmentId]= ISNULL(@DepartmentId, [DepartmentId]),
		[RegionId]= ISNULL(@RegionId, [RegionId]),
		[LocationId]= ISNULL(@LocationId, [LocationId]),
		[Login]= ISNULL(@Login, [Login]),
		[Password]= ISNULL(@Password, [Password]),
		[Name]= ISNULL(@Name, [Name]),
		[Surname]= ISNULL(@Surname, [Surname]),
		[UserNo] = ISNULL(@UserNo, [UserNo]),
		[ModifiationDate] = GETDATE()
	WHERE [Id] = @Id

	EXEC [dbo].[User_GetById] @Id
END
