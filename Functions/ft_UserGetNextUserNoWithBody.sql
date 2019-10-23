CREATE FUNCTION [dbo].[ft_UserGetNextUserNoWithBody]
(
	 @NumberOfRows INT
)
RETURNS @ReturnTable TABLE ([UserNo] INT)
WITH SCHEMABINDING AS
BEGIN
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
	INSERT INTO @ReturnTable
	SELECT TOP (ISNULL(@NumberOfRows, 1))
		c.[UserNo]
	FROM CTE c
	WHERE NOT EXISTS 
	( 
		SELECT 1 FROM [dbo].[User] e WHERE e.[UserNo] = c.[UserNo]
	)
	OPTION (MAXRECURSION 0)
	RETURN
END

/*Test
--4s
SELECT * FROM [dbo].[f_UserGetNextUserNoWithBody] (99000)
option (maxrecursion 0 )

--9s
SELECT * FROM [dbo].[f_UserGetNextUserNo] (99000)
option (maxrecursion 0 )

*/