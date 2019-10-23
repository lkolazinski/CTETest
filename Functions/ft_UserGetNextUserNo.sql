CREATE FUNCTION [dbo].[ft_UserGetNextUserNo]
(
	 @NumberOfRows INT
)
RETURNS TABLE AS RETURN
(
	WITH CTE (UserNo)
	AS
	(
		SELECT 
			MIN(r.[UserNo]) AS UserNo
		FROM [dbo].[User] r
		UNION ALL
		SELECT 
			c.[UserNo] + 1
		FROM CTE c
	)
	SELECT TOP (ISNULL(@NumberOfRows, 1))
		c.[UserNo]
	FROM CTE c
	WHERE NOT EXISTS 
	( 
		SELECT 1 FROM [dbo].[User] e WHERE e.[UserNo] = c.[UserNo]
	)
	--OPTION (MaxRecursion 0) 
)
