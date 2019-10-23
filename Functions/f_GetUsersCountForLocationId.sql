CREATE FUNCTION [dbo].[f_GetUsersCountForLocationId]
(
	@LocationId INT 
)
RETURNS INT
AS
BEGIN
	DECLARE @Count INT = 0
	SELECT @Count = COUNT(*) FROM [dbo].[UserLocation] WHERE [LocationId] = @LocationId
	RETURN @Count
END
