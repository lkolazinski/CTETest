CREATE PROCEDURE [dbo].[Role_Insert]
(
    @Name VARCHAR(50),
    @RoleNo INT,
    @Description VARCHAR(200)
)
AS
BEGIN
	INSERT INTO [dbo].[Role]
	(
		[Name],
		[RoleNo],
		[Description]
	)
	SELECT
		@Name,
		@RoleNo,
		@Description
	
	EXEC [dbo].[Role_GetById] @@IDENTITY
END
