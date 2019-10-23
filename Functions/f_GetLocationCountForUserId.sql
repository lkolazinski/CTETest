CREATE FUNCTION [dbo].[f_GetLocationCountForUserId]
(
	@UserId INT
)
RETURNS INT
AS
BEGIN
	DECLARE @Count INT = 0

	SELECT @Count = COUNT(*) 
	FROM [dbo].[UserLocation] ul
	INNER JOIN [dbo].[Location] l ON l.[Id] = ul.[LocationId]
		--AND (@RegionId IS NULL OR l.[RegionId] = @RegionId)
	WHERE ul.[UserId] = @UserId

	RETURN @Count
END
