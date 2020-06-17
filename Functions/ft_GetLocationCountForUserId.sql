CREATE FUNCTION [dbo].[ft_GetLocationCountForUserId]
(
	@UserId INT
)
RETURNS TABLE AS RETURN
(
	SELECT 
		COUNT(*) AS LocationCount
	FROM [dbo].[UserLocation] l
	WHERE l.[UserId] = @UserId
)


/*

 select 
	U.*,
	[dbo].[f_GetLocationCountForUserId] (U.Id)
 from [dbo].[USER] U
 WHERE U.Id = 6

*/