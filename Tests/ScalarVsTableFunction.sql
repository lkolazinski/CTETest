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