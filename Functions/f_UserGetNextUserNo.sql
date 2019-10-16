CREATE FUNCTION [dbo].[f_UserGetNextUserNo]
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

/* Test

SELECT * FROM  [dbo].[f_UserGetNextUserNo](100)

*/


--OPTION (MaxRecursion 0) 
--(
/*
	--DECLARE @RoleNo INT
DECLARE @NumberOfRows INT = 932769 

;WITH CTE (UserNo)
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
SELECT TOP (@NumberOfRows)
	c.[UserNo]
FROM CTE c
WHERE NOT EXISTS 
( 
	SELECT 1 FROM [dbo].[User] e WHERE e.[UserNo] = c.[UserNo]
)

*/
--)
