CREATE PROCEDURE [dbo].[User_Insert]
(
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
	INSERT INTO [dbo].[User] 
	(
		[RoleId],
		[DepartmentId],
		[RegionId],
		[LocationId],
		[Login],
		[Password],
		[Name],
		[Surname],
		[UserNo]
	)
	SELECT
		@RoleId,
		@DepartmentId,
		@RegionId,
		@LocationId,
		@Login,
		@Password,
		@Name,
		@Surname,
		@UserNo

	EXEC [dbo].[User_GetById] @@IDENTITY
		
END
