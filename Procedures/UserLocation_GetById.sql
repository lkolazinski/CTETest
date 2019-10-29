CREATE PROCEDURE [dbo].[UserLocation_GetById]
(
	@Id INT
)
AS
BEGIN
	SELECT
		d.[Id],
		d.[UserId],
		d.[LocationId]
	FROM [dbo].[UserLocation] d
	WHERE d.[Id] = @Id
END
