CREATE FUNCTION [dbo].[ft_GetUsersCountForLocationId]
(
	 @LocationId INT
)
RETURNS TABLE AS RETURN
(
	SELECT 
		COUNT(*) AS [UsersCount]
	FROM [dbo].[UserLocation] WHERE [LocationId] = @LocationId
)
