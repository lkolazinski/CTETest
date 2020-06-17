DECLARE @ID VARCHAR(10)

SELECT top 1 @ID = r.Id
FROM DBO.Role R
WHERE R.Name LIKE '%min%'


SELECT 
	U.Id
FROM DBO.[User] U
INNER JOIN DBO.[Role] R on r.[Id] = u.[RoleId]
WHERE U.UserNo = CAST(@ID AS INT)