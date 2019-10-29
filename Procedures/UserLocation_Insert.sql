CREATE PROCEDURE [dbo].[UserLocation_Insert]
(
	@UserId INT,
	@LocationId INT
)
AS
BEGIN
	INSERT INTO [dbo].[UserLocation]
	(
		[UserId],
		[LocationId]
	)
	SELECT
		@UserId,
		@LocationId

	EXEC [dbo].[UserLocation_GetById] @@IDENTITY
END
