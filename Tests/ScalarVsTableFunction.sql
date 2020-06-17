select 
	[dbo].[f_GetLocationCountForUserId] (U.Id) AS LocationCount,
	U.Id,
	U.Name + ' ' +U.Surname
 from [dbo].[USER] U
 WHERE U.Id BETWEEN 100 AND 999999999
 ORDER BY 1 desc

 select 
	t.LocationCount,
	U.Id,
	U.Name + ' ' +U.Surname
 from [dbo].[USER] U
 CROSS APPLY [ft_GetLocationCountForUserId] (U.Id) t
 WHERE U.Id BETWEEN 100 AND 999999999
 ORDER BY 1 desc

 --17s
 SELECT 
	ul.[LocationId],
	l.[Name],
	dbo.[f_GetUsersCountForLocationId](ul.LocationId) AS [UsersCount]
FROM dbo.UserLocation ul
INNER JOIN dbo.[Location] l ON l.[Id] = ul.[LocationId]
WHERE ul.UserId BETWEEN 200 AND 300 AND ul.LocationId = 10


--1s
SELECT 
	ul.[LocationId],
	l.[Name],
	R.[UsersCount]
from dbo.UserLocation ul
INNER JOIN dbo.[Location] l ON l.[Id] = ul.[LocationId]
CROSS APPLY dbo.[ft_GetUsersCountForLocationId](ul.LocationId) R
WHERE ul.UserId BETWEEN 200 AND 300 AND ul.LocationId = 10



--0.2s 211416 reads
SELECT 
	R.[UsersCount]
from dbo.UserLocation ul
CROSS APPLY dbo.[ft_GetUsersCountForLocationId](ul.LocationId) R
WHERE ul.UserId BETWEEN 200 AND 999 AND ul.LocationId BETWEEN 1 AND 50

GO

--5.6s 2172 reads
SELECT 
	dbo.[f_GetUsersCountForLocationId](ul.LocationId) AS [UsersCount]
from dbo.UserLocation ul
WHERE ul.UserId BETWEEN 200 AND 999 AND ul.LocationId BETWEEN 1 AND 50