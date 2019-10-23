/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

/* DROP ALL SQL OBJECTS
DROP FUNCTION dbo.[f_GetLocationCountForUserId]
DROP FUNCTION dbo.[f_GetUserCountForLocationId]
DROP FUNCTION dbo.[f_UserGetNextUserNoWithBody]
DROP FUNCTION dbo.[f_UserGetNextUserNo]
DROP PROCEDURE dbo.[User_GetFiltred]
DROP TABLE dbo.[UserLocation]
DROP TABLE dbo.[User]
DROP TABLE dbo.[Role]
DROP TABLE dbo.[Location]
DROP TABLE dbo.[Region]
DROP TABLE dbo.[Department]
DROP TABLE dbo.[Logs]
*/

--------------------------------------------------------------------------------------
BEGIN TRY
	PRINT '[Department]'

	IF NOT EXISTS (SELECT * FROM [dbo].[Department])
	INSERT INTO [dbo].[Department] ([DepartmentNo], [Name], [Description])
	SELECT
		ROW_NUMBER() OVER (ORDER BY Pom.[Name]) AS [DepartmentNo],
		Pom.[Name],
		Pom.[Description]
	FROM
	(
		SELECT 'Department1' AS [Name], 'Desc of Department1' AS [Description] UNION
		SELECT 'Department2' AS [Name], 'Desc of Department2' AS [Description] UNION
		SELECT 'Department3' AS [Name], 'Desc of Department3' AS [Description] UNION
		SELECT 'Department4' AS [Name], 'Desc of Department4' AS [Description] UNION
		SELECT 'Department5' AS [Name], 'Desc of Department5' AS [Description] UNION
		SELECT 'Department6' AS [Name], 'Desc of Department6' AS [Description] UNION
		SELECT 'Department7' AS [Name], 'Desc of Department7' AS [Description]
	) AS Pom

	INSERT INTO [dbo].[Logs] ([Message], [LogType])
	SELECT '[Department] rows inserted: [' + CAST(@@ROWCOUNT AS VARCHAR) + ']', 'I'
END TRY  
BEGIN CATCH 
	INSERT INTO [dbo].[Logs] ([Message], [AdditionalMessage], [LogType])
	SELECT 
		'[Department] Insert error :[' + ERROR_MESSAGE() + ']', 
		'Line:[' + CAST(ERROR_LINE() AS VARCHAR) + ']. Error number:[' + CAST(ERROR_NUMBER() AS VARCHAR) + '].', 
		'E'
END CATCH
GO
--------------------------------------------------------------------------------------
BEGIN TRY
	PRINT '[Region]'

	IF NOT EXISTS (SELECT * FROM [dbo].[Region])
	INSERT INTO [dbo].[Region] ([RegionNo], [Name], [DepartmentId], [Description])
	SELECT
		Pom2.[RegionNo],
		Pom2.[Name],
		d.[Id] AS [DepartmentId],
		Pom2.[Description]
	FROM
	(
		SELECT
			ROW_NUMBER() OVER (ORDER BY Pom.[Name]) AS [RegionNo],
			Pom.[Name],
			Pom.[Description]
		FROM
		(
			SELECT 'Region1' AS [Name], 'Desc of Region1' AS [Description] UNION
			SELECT 'Region2' AS [Name], 'Desc of Region2' AS [Description] UNION
			SELECT 'Region3' AS [Name], 'Desc of Region3' AS [Description] UNION
			SELECT 'Region4' AS [Name], 'Desc of Region4' AS [Description] UNION
			SELECT 'Region5' AS [Name], 'Desc of Region5' AS [Description] UNION
			SELECT 'Region6' AS [Name], 'Desc of Region6' AS [Description] UNION
			SELECT 'Region7' AS [Name], 'Desc of Region7' AS [Description]
		) AS Pom
	) AS Pom2
	INNER JOIN [dbo].[Department] d ON d.[DepartmentNo] = Pom2.[RegionNo]
	

	INSERT INTO [dbo].[Logs] ([Message], [LogType])
	SELECT '[Region] rows inserted: [' + CAST(@@ROWCOUNT AS VARCHAR) + ']', 'I'
END TRY  
BEGIN CATCH 
	INSERT INTO [dbo].[Logs] ([Message], [AdditionalMessage], [LogType])
	SELECT 
		'[Region] Insert error :[' + ERROR_MESSAGE() + ']', 
		'Line:[' + CAST(ERROR_LINE() AS VARCHAR) + ']. Error number:[' + CAST(ERROR_NUMBER() AS VARCHAR) + '].', 
		'E'
END CATCH
GO
--------------------------------------------------------------------------------------
BEGIN TRY
	PRINT '[Role]'

	IF NOT EXISTS (SELECT * FROM [dbo].[Role])
	INSERT INTO [dbo].[Role] ([RoleNo], [Name], [Description])
	SELECT
		ROW_NUMBER() OVER (ORDER BY Pom.[Name]) AS [RoleNo],
		Pom.[Name],
		Pom.[Description]
	FROM
	(
		SELECT 'Admin' AS [Name], 'Desc of Role1' AS [Description] UNION
		SELECT 'Role1' AS [Name], 'Desc of Role1' AS [Description] UNION
		SELECT 'Role2' AS [Name], 'Desc of Role2' AS [Description] UNION
		SELECT 'Role3' AS [Name], 'Desc of Role3' AS [Description] UNION
		SELECT 'Role4' AS [Name], 'Desc of Role4' AS [Description] UNION
		SELECT 'Role5' AS [Name], 'Desc of Role5' AS [Description] UNION
		SELECT 'Role6' AS [Name], 'Desc of Role6' AS [Description] UNION
		SELECT 'Role7' AS [Name], 'Desc of Role7' AS [Description]
	) AS Pom

	INSERT INTO [dbo].[Logs] ([Message], [LogType])
	SELECT '[Role] rows inserted: [' + CAST(@@ROWCOUNT AS VARCHAR) + ']', 'I'
END TRY  
BEGIN CATCH 
	INSERT INTO [dbo].[Logs] ([Message], [AdditionalMessage], [LogType])
	SELECT 
		'[Role] Insert error :[' + ERROR_MESSAGE() + ']', 
		'Line:[' + CAST(ERROR_LINE() AS VARCHAR) + ']. Error number:[' + CAST(ERROR_NUMBER() AS VARCHAR) + '].', 
		'E'
END CATCH
GO
--------------------------------------------------------------------------------------
BEGIN TRY
	PRINT '[Location]'

	IF NOT EXISTS (SELECT * FROM [dbo].[Location])
	BEGIN
		;WITH CTE ([Name], [Site], [Province], [Area], [Population], [Density])
		AS
		(
			SELECT 'Aleksandrów Kujawski', 'aleksandrowski', 'kujawsko-pomorskie', '723', '12220', '1690' UNION
			SELECT 'Aleksandrów Łódzki', 'zgierski', 'łódzkie', '1382', '21682', '1569' UNION
			SELECT 'Alwernia', 'chrzanowski', 'małopolskie', '888', '3370', '380' UNION
			SELECT 'Andrychów', 'wadowicki', 'małopolskie', '1033', '20260', '1961' UNION
			SELECT 'Annopol', 'kraśnicki', 'lubelskie', '773', '2528', '327' UNION
			SELECT 'Augustów', 'augustowski', 'podlaskie', '8090', '30242', '374' UNION
			SELECT 'Babimost', 'zielonogórski', 'lubuskie', '365', '3927', '1076' UNION
			SELECT 'Baborów', 'głubczycki', 'opolskie', '1186', '2920', '246' UNION
			SELECT 'Baranów Sandomierski', 'tarnobrzeski', 'podkarpackie', '915', '1463', '160' UNION
			SELECT 'Barcin', 'żniński', 'kujawsko-pomorskie', '370', '7468', '2018' UNION
			SELECT 'Barczewo', 'olsztyński', 'warmińsko-mazurskie', '458', '7535', '1645' UNION
			SELECT 'Bardo', 'ząbkowicki', 'dolnośląskie', '471', '2563', '544' UNION
			SELECT 'Barlinek', 'myśliborski', 'zachodniopomorskie', '1755', '13803', '786' UNION
			SELECT 'Bartoszyce', 'bartoszycki', 'warmińsko-mazurskie', '1179', '23609', '2002' UNION
			SELECT 'Barwice', 'szczecinecki', 'zachodniopomorskie', '752', '3723', '495' UNION
			SELECT 'Bełchatów', 'bełchatowski', 'łódzkie', '3464', '57432', '1658' UNION
			SELECT 'Bełżyce', 'lubelski', 'lubelskie', '2346', '6551', '279' UNION
			SELECT 'Będzin', 'będziński', 'śląskie', '3737', '56804', '1520' UNION
			SELECT 'Biała', 'prudnicki', 'opolskie', '1472', '2443', '166' UNION
			SELECT 'Biała Piska', 'piski', 'warmińsko-mazurskie', '324', '4030', '1244' UNION
			SELECT 'Biała Podlaska', 'Biała Podlaska[a]', 'lubelskie', '4940', '57352', '1161' UNION
			SELECT 'Biała Rawska', 'rawski', 'łódzkie', '953', '3197', '335' UNION
			SELECT 'Białobrzegi', 'białobrzeski', 'mazowieckie', '751', '6980', '929' UNION
			SELECT 'Białogard', 'białogardzki', 'zachodniopomorskie', '2573', '24339', '946' UNION
			SELECT 'Biały Bór', 'szczecinecki', 'zachodniopomorskie', '1282', '2199', '172' UNION
			SELECT 'Białystok', 'Białystok[a]', 'podlaskie', '10213', '297459', '2913' UNION
			SELECT 'Biecz', 'gorlicki', 'małopolskie', '1771', '4599', '260' UNION
			SELECT 'Bielawa', 'dzierżoniowski', 'dolnośląskie', '3621', '30055', '830' UNION
			SELECT 'Bielsk Podlaski', 'bielski', 'podlaskie', '2701', '25370', '939' UNION
			SELECT 'Bielsko-Biała', 'Bielsko-Biała[a]', 'śląskie', '12451', '171259', '1375' UNION
			SELECT 'Bieruń', 'bieruńsko-lędziński', 'śląskie', '4049', '19605', '484' UNION
			SELECT 'Bierutów', 'oleśnicki', 'dolnośląskie', '836', '4871', '583' UNION
			SELECT 'Bieżuń', 'żuromiński', 'mazowieckie', '1207', '1856', '154' UNION
			SELECT 'Biłgoraj', 'biłgorajski', 'lubelskie', '2110', '26391', '1251' UNION
			SELECT 'Biskupiec', 'olsztyński', 'warmińsko-mazurskie', '500', '10602', '2120' UNION
			SELECT 'Bisztynek', 'bartoszycki', 'warmińsko-mazurskie', '216', '2365', '1095' UNION
			SELECT 'Blachownia', 'częstochowski', 'śląskie', '3666', '9594', '262' UNION
			SELECT 'Błaszki', 'sieradzki', 'łódzkie', '162', '2122', '1310' UNION
			SELECT 'Błażowa', 'rzeszowski', 'podkarpackie', '423', '2151', '509' UNION
			SELECT 'Błonie', 'warszawski zachodni', 'mazowieckie', '909', '12327', '1356' UNION
			SELECT 'Bobolice', 'koszaliński', 'zachodniopomorskie', '477', '4018', '842' UNION
			SELECT 'Bobowa', 'gorlicki', 'małopolskie', '718', '3136', '437' UNION
			SELECT 'Bochnia', 'bocheński', 'małopolskie', '2987', '29922', '1002' UNION
			SELECT 'Bodzentyn', 'kielecki', 'świętokrzyskie', '865', '2240', '259' UNION
			SELECT 'Bogatynia', 'zgorzelecki', 'dolnośląskie', '5988', '17559', '293' UNION
			SELECT 'Boguchwała', 'rzeszowski', 'podkarpackie', '911', '6117', '671' UNION
			SELECT 'Boguszów-Gorce', 'wałbrzyski', 'dolnośląskie', '2702', '15444', '572' UNION
			SELECT 'Bojanowo', 'rawicki', 'wielkopolskie', '234', '2923', '1249' UNION
			SELECT 'Bolesławiec', 'bolesławiecki', 'dolnośląskie', '2357', '38935', '1652' UNION
			SELECT 'Bolków', 'jaworski', 'dolnośląskie', '768', '5001', '651' UNION
			SELECT 'Borek Wielkopolski', 'gostyński', 'wielkopolskie', '629', '2526', '402' UNION
			SELECT 'Borne Sulinowo', 'szczecinecki', 'zachodniopomorskie', '1815', '5090', '280' UNION
			SELECT 'Braniewo', 'braniewski', 'warmińsko-mazurskie', '1241', '17071', '1376' UNION
			SELECT 'Brańsk', 'bielski', 'podlaskie', '3243', '3774', '116' UNION
			SELECT 'Brodnica', 'brodnicki', 'kujawsko-pomorskie', '2315', '28774', '1243' UNION
			SELECT 'Brok', 'ostrowski', 'mazowieckie', '2806', '1940', '69' UNION
			SELECT 'Brusy', 'chojnicki', 'pomorskie', '520', '5232', '1006' UNION
			SELECT 'Brwinów', 'pruszkowski', 'mazowieckie', '1010', '13531', '1340' UNION
			SELECT 'Brzeg', 'brzeski', 'opolskie', '1461', '35930', '2459' UNION
			SELECT 'Brzeg Dolny', 'wołowski', 'dolnośląskie', '1720', '12492', '726' UNION
			SELECT 'Brzesko', 'brzeski', 'małopolskie', '1192', '16825', '1411' UNION
			SELECT 'Brzeszcze', 'oświęcimski', 'małopolskie', '1904', '11226', '590' UNION
			SELECT 'Brześć Kujawski', 'włocławski', 'kujawsko-pomorskie', '704', '4659', '662' UNION
			SELECT 'Brzeziny', 'brzeziński', 'łódzkie', '2158', '12547', '581' UNION
			SELECT 'Brzostek', 'dębicki', 'podkarpackie', '876', '2742', '313' UNION
			SELECT 'Brzozów', 'brzozowski', 'podkarpackie', '1146', '7455', '651' UNION
			SELECT 'Buk', 'poznański', 'wielkopolskie', '296', '6064', '2049' UNION
			SELECT 'Bukowno', 'olkuski', 'małopolskie', '6459', '10197', '158' UNION
			SELECT 'Busko-Zdrój', 'buski', 'świętokrzyskie', '1228', '15952', '1299' UNION
			SELECT 'Bychawa', 'lubelski', 'lubelskie', '669', '4942', '739' UNION
			SELECT 'Byczyna', 'kluczborski', 'opolskie', '579', '3609', '623' UNION
			SELECT 'Bydgoszcz', 'Bydgoszcz[a]', 'kujawsko-pomorskie', '17598', '350178', '1990' UNION
			SELECT 'Bystrzyca Kłodzka', 'kłodzki', 'dolnośląskie', '1074', '10189', '949' UNION
			SELECT 'Bytom', 'Bytom[a]', 'śląskie', '6944', '166795', '2402' UNION
			SELECT 'Bytom Odrzański', 'nowosolski', 'lubuskie', '230', '4331', '1883' UNION
			SELECT 'Bytów', 'bytowski', 'pomorskie', '872', '16954', '1944' UNION
			SELECT 'Cedynia', 'gryfiński', 'zachodniopomorskie', '167', '1573', '942' UNION
			SELECT 'Chełm', 'Chełm[a]', 'lubelskie', '3528', '62670', '1776' UNION
			SELECT 'Chełmek', 'oświęcimski', 'małopolskie', '827', '9061', '1096' UNION
			SELECT 'Chełmno', 'chełmiński', 'kujawsko-pomorskie', '1356', '19720', '1454' UNION
			SELECT 'Chełmża', 'toruński', 'kujawsko-pomorskie', '784', '14532', '1854' UNION
			SELECT 'Chęciny', 'kielecki', 'świętokrzyskie', '1413', '4445', '315' UNION
			SELECT 'Chmielnik', 'kielecki', 'świętokrzyskie', '780', '3703', '475' UNION
			SELECT 'Chocianów', 'polkowicki', 'dolnośląskie', '900', '7911', '879' UNION
			SELECT 'Chociwel', 'stargardzki', 'zachodniopomorskie', '367', '3209', '874' UNION
			SELECT 'Chocz', 'pleszewski', 'wielkopolskie', '688', '1777', '258' UNION
			SELECT 'Chodecz', 'włocławski', 'kujawsko-pomorskie', '139', '1899', '1366' UNION
			SELECT 'Chodzież', 'chodzieski', 'wielkopolskie', '1277', '18684', '1463' UNION
			SELECT 'Chojna', 'gryfiński', 'zachodniopomorskie', '1258', '7390', '587' UNION
			SELECT 'Chojnice', 'chojnicki', 'pomorskie', '2104', '39904', '1897' UNION
			SELECT 'Chojnów', 'legnicki', 'dolnośląskie', '532', '13426', '2524' UNION
			SELECT 'Choroszcz', 'białostocki', 'podlaskie', '1679', '5867', '349' UNION
			SELECT 'Chorzele', 'przasnyski', 'mazowieckie', '1751', '3078', '176' UNION
			SELECT 'Chorzów', 'Chorzów[a]', 'śląskie', '3324', '108434', '3262' UNION
			SELECT 'Choszczno', 'choszczeński', 'zachodniopomorskie', '958', '15248', '1592' UNION
			SELECT 'Chrzanów', 'chrzanowski', 'małopolskie', '3832', '36945', '964' UNION
			SELECT 'Ciechanowiec', 'wysokomazowiecki', 'podlaskie', '1953', '4639', '238' UNION
			SELECT 'Ciechanów', 'ciechanowski', 'mazowieckie', '3278', '44209', '1349' UNION
			SELECT 'Ciechocinek', 'aleksandrowski', 'kujawsko-pomorskie', '1526', '10596', '694' UNION
			SELECT 'Cieszanów', 'lubaczowski', 'podkarpackie', '1506', '1930', '128' UNION
			SELECT 'Cieszyn', 'cieszyński', 'śląskie', '2861', '34613', '1210' UNION
			SELECT 'Ciężkowice', 'tarnowski', 'małopolskie', '999', '2469', '247' UNION
			SELECT 'Cybinka', 'słubicki', 'lubuskie', '529', '2756', '521' UNION
			SELECT 'Czaplinek', 'drawski', 'zachodniopomorskie', '1362', '7124', '523' UNION
			SELECT 'Czarna Białostocka', 'białostocki', 'podlaskie', '1428', '9338', '654' UNION
			SELECT 'Czarna Woda', 'starogardzki', 'pomorskie', '994', '2805', '282' UNION
			SELECT 'Czarne', 'człuchowski', 'pomorskie', '4643', '5952', '128' UNION
			SELECT 'Czarnków', 'czarnkowsko-trzcianecki', 'wielkopolskie', '1017', '10735', '1056' UNION
			SELECT 'Czchów', 'brzeski', 'małopolskie', '1409', '2344', '166' UNION
			SELECT 'Czechowice-Dziedzice', 'bielski', 'śląskie', '3291', '35919', '1091' UNION
			SELECT 'Czeladź', 'będziński', 'śląskie', '1638', '31677', '1934' UNION
			SELECT 'Czempiń', 'kościański', 'wielkopolskie', '332', '5295', '1595' UNION
			SELECT 'Czerniejewo', 'gnieźnieński', 'wielkopolskie', '1019', '2663', '261' UNION
			SELECT 'Czersk', 'chojnicki', 'pomorskie', '973', '9912', '1019' UNION
			SELECT 'Czerwieńsk', 'zielonogórski', 'lubuskie', '936', '4063', '434' UNION
			SELECT 'Czerwionka-Leszczyny', 'rybnicki', 'śląskie', '3763', '28266', '751' UNION
			SELECT 'Częstochowa', 'Częstochowa[a]', 'śląskie', '15971', '222292', '1392' UNION
			SELECT 'Człopa', 'wałecki', 'zachodniopomorskie', '627', '2326', '371' UNION
			SELECT 'Człuchów', 'człuchowski', 'pomorskie', '1278', '13708', '1073' UNION
			SELECT 'Czyżew', 'wysokomazowiecki', 'podlaskie', '523', '2641', '505' UNION
			SELECT 'Ćmielów', 'ostrowiecki', 'świętokrzyskie', '1334', '3024', '227' UNION
			SELECT 'Daleszyce', 'kielecki', 'świętokrzyskie', '1550', '2907', '188' UNION
			SELECT 'Darłowo', 'sławieński', 'zachodniopomorskie', '2021', '13759', '681' UNION
			SELECT 'Dąbie', 'kolski', 'wielkopolskie', '880', '2002', '228' UNION
			SELECT 'Dąbrowa Białostocka', 'sokólski', 'podlaskie', '2264', '5553', '245' UNION
			SELECT 'Dąbrowa Górnicza', 'Dąbrowa Górnicza[a]', 'śląskie', '18873', '120259', '637' UNION
			SELECT 'Dąbrowa Tarnowska', 'dąbrowski', 'małopolskie', '2307', '11906', '516' UNION
			SELECT 'Debrzno', 'człuchowski', 'pomorskie', '751', '5102', '679' UNION
			SELECT 'Dębica', 'dębicki', 'podkarpackie', '3383', '45817', '1354' UNION
			SELECT 'Dęblin', 'rycki', 'lubelskie', '3833', '16149', '421' UNION
			SELECT 'Dębno', 'myśliborski', 'zachodniopomorskie', '1951', '13843', '710' UNION
			SELECT 'Dobczyce', 'myślenicki', 'małopolskie', '1297', '6434', '496' UNION
			SELECT 'Dobiegniew', 'strzelecko-drezdenecki', 'lubuskie', '569', '3088', '543' UNION
			SELECT 'Dobra', 'łobeski', 'zachodniopomorskie', '237', '2326', '981' UNION
			SELECT 'Dobra', 'turecki', 'wielkopolskie', '184', '1387', '754' UNION
			SELECT 'Dobre Miasto', 'olsztyński', 'warmińsko-mazurskie', '486', '10239', '2107' UNION
			SELECT 'Dobrodzień', 'oleski', 'opolskie', '1953', '3722', '191' UNION
			SELECT 'Dobrzany', 'stargardzki', 'zachodniopomorskie', '534', '2264', '424' UNION
			SELECT 'Dobrzyca', 'pleszewski', 'wielkopolskie', '1970', '3128', '159' UNION
			SELECT 'Dobrzyń nad Wisłą', 'lipnowski', 'kujawsko-pomorskie', '541', '2139', '395' UNION
			SELECT 'Dolsk', 'śremski', 'wielkopolskie', '620', '1560', '252' UNION
			SELECT 'Drawno', 'choszczeński', 'zachodniopomorskie', '503', '2290', '455' UNION
			SELECT 'Drawsko Pomorskie', 'drawski', 'zachodniopomorskie', '2233', '11657', '522' UNION
			SELECT 'Drezdenko', 'strzelecko-drezdenecki', 'lubuskie', '1072', '10182', '950' UNION
			SELECT 'Drobin', 'płocki', 'mazowieckie', '965', '2889', '299' UNION
			SELECT 'Drohiczyn', 'siemiatycki', 'podlaskie', '1569', '1987', '127' UNION
			SELECT 'Drzewica', 'opoczyński', 'łódzkie', '481', '3844', '799' UNION
			SELECT 'Dukla', 'krośnieński', 'podkarpackie', '548', '2083', '380' UNION
			SELECT 'Duszniki-Zdrój', 'kłodzki', 'dolnośląskie', '2228', '4629', '208' UNION
			SELECT 'Dynów', 'rzeszowski', 'podkarpackie', '2455', '6138', '250' UNION
			SELECT 'Działdowo', 'działdowski', 'warmińsko-mazurskie', '1147', '21275', '1855' UNION
			SELECT 'Działoszyce', 'pińczowski', 'świętokrzyskie', '192', '908', '473' UNION
			SELECT 'Działoszyn', 'pajęczański', 'łódzkie', '494', '5922', '1199' UNION
			SELECT 'Dzierzgoń', 'sztumski', 'pomorskie', '390', '5367', '1376' UNION
			SELECT 'Dzierżoniów', 'dzierżoniowski', 'dolnośląskie', '2007', '33344', '1661' UNION
			SELECT 'Dziwnów', 'kamieński', 'zachodniopomorskie', '652', '2698', '414' UNION
			SELECT 'Elbląg', 'Elbląg[a]', 'warmińsko-mazurskie', '7982', '120142', '1505' UNION
			SELECT 'Ełk', 'ełcki', 'warmińsko-mazurskie', '2105', '61928', '2942' UNION
			SELECT 'Frampol', 'biłgorajski', 'lubelskie', '467', '1437', '308' UNION
			SELECT 'Frombork', 'braniewski', 'warmińsko-mazurskie', '759', '2355', '310' UNION
			SELECT 'Garwolin', 'garwoliński', 'mazowieckie', '2208', '17494', '792' UNION
			SELECT 'Gąbin', 'płocki', 'mazowieckie', '2795', '4114', '147' UNION
			SELECT 'Gdańsk', 'Gdańsk[a]', 'pomorskie', '26196', '466631', '1781' UNION
			SELECT 'Gdynia', 'Gdynia[a]', 'pomorskie', '13514', '246309', '1823' UNION
			SELECT 'Giżycko', 'giżycki', 'warmińsko-mazurskie', '1372', '29396', '2143' UNION
			SELECT 'Glinojeck', 'ciechanowski', 'mazowieckie', '737', '3017', '409' UNION
			SELECT 'Gliwice', 'Gliwice[a]', 'śląskie', '13388', '179806', '1343' UNION
			SELECT 'Głogów', 'głogowski', 'dolnośląskie', '3511', '67615', '1926' UNION
			SELECT 'Głogów Małopolski', 'rzeszowski', 'podkarpackie', '1371', '6568', '479' UNION
			SELECT 'Głogówek', 'prudnicki', 'opolskie', '2206', '5604', '254' UNION
			SELECT 'Głowno', 'zgierski', 'łódzkie', '1984', '14291', '720' UNION
			SELECT 'Głubczyce', 'głubczycki', 'opolskie', '1254', '12596', '1004' UNION
			SELECT 'Głuchołazy', 'nyski', 'opolskie', '683', '13585', '1989' UNION
			SELECT 'Głuszyca', 'wałbrzyski', 'dolnośląskie', '1621', '6381', '394' UNION
			SELECT 'Gniew', 'tczewski', 'pomorskie', '604', '6761', '1119' UNION
			SELECT 'Gniewkowo', 'inowrocławski', 'kujawsko-pomorskie', '918', '7141', '778' UNION
			SELECT 'Gniezno', 'gnieźnieński', 'wielkopolskie', '4060', '68479', '1687' UNION
			SELECT 'Gogolin', 'krapkowicki', 'opolskie', '2035', '6661', '327' UNION
			SELECT 'Golczewo', 'kamieński', 'zachodniopomorskie', '742', '2673', '360' UNION
			SELECT 'Goleniów', 'goleniowski', 'zachodniopomorskie', '1178', '22403', '1902' UNION
			SELECT 'Golina', 'koniński', 'wielkopolskie', '352', '4503', '1279' UNION
			SELECT 'Golub-Dobrzyń', 'golubsko-dobrzyński', 'kujawsko-pomorskie', '750', '12630', '1684' UNION
			SELECT 'Gołańcz', 'wągrowiecki', 'wielkopolskie', '1264', '3336', '264' UNION
			SELECT 'Gołdap', 'gołdapski', 'warmińsko-mazurskie', '1720', '13735', '799' UNION
			SELECT 'Goniądz', 'moniecki', 'podlaskie', '428', '1813', '424' UNION
			SELECT 'Gorlice', 'gorlicki', 'małopolskie', '2353', '27597', '1173' UNION
			SELECT 'Gorzów Śląski', 'oleski', 'opolskie', '1854', '2452', '132' UNION
			SELECT 'Gorzów Wielkopolski', 'Gorzów Wielkopolski[a]', 'lubuskie', '8572', '123921', '1446' UNION
			SELECT 'Gostynin', 'gostyniński', 'mazowieckie', '3240', '18647', '576' UNION
			SELECT 'Gostyń', 'gostyński', 'wielkopolskie', '1109', '20192', '1821' UNION
			SELECT 'Gościno', 'kołobrzeski', 'zachodniopomorskie', '570', '2417', '424' UNION
			SELECT 'Gozdnica', 'żagański', 'lubuskie', '2392', '3061', '128' UNION
			SELECT 'Góra', 'górowski', 'dolnośląskie', '1365', '11859', '869' UNION
			SELECT 'Góra Kalwaria', 'piaseczyński', 'mazowieckie', '1367', '12009', '878' UNION
			SELECT 'Górowo Iławeckie', 'bartoszycki', 'warmińsko-mazurskie', '332', '3974', '1197' UNION
			SELECT 'Górzno', 'brodnicki', 'kujawsko-pomorskie', '343', '1370', '399' UNION
			SELECT 'Grabów nad Prosną', 'ostrzeszowski', 'wielkopolskie', '258', '1940', '752' UNION
			SELECT 'Grajewo', 'grajewski', 'podlaskie', '1894', '21935', '1158' UNION
			SELECT 'Grodków', 'brzeski', 'opolskie', '988', '8667', '877' UNION
			SELECT 'Grodzisk Mazowiecki', 'grodziski', 'mazowieckie', '1319', '31505', '2389' UNION
			SELECT 'Grodzisk Wielkopolski', 'grodziski', 'wielkopolskie', '1821', '14633', '804' UNION
			SELECT 'Grójec', 'grójecki', 'mazowieckie', '857', '16707', '1949' UNION
			SELECT 'Grudziądz', 'Grudziądz[a]', 'kujawsko-pomorskie', '5776', '95045', '1646' UNION
			SELECT 'Grybów', 'nowosądecki', 'małopolskie', '1695', '6038', '356' UNION
			SELECT 'Gryfice', 'gryficki', 'zachodniopomorskie', '1240', '16527', '1333' UNION
			SELECT 'Gryfino', 'gryfiński', 'zachodniopomorskie', '1181', '21274', '1801' UNION
			SELECT 'Gryfów Śląski', 'lwówecki', 'dolnośląskie', '663', '6641', '1002' UNION
			SELECT 'Gubin', 'krośnieński', 'lubuskie', '2068', '16687', '807' UNION
			SELECT 'Hajnówka', 'hajnowski', 'podlaskie', '2129', '20690', '972' UNION
			SELECT 'Halinów', 'miński', 'mazowieckie', '284', '3739', '1317' UNION
			SELECT 'Hel', 'pucki', 'pomorskie', '2295', '3285', '143' UNION
			SELECT 'Hrubieszów', 'hrubieszowski', 'lubelskie', '3303', '17735', '537' UNION
			SELECT 'Iława', 'iławski', 'warmińsko-mazurskie', '2188', '33250', '1520' UNION
			SELECT 'Iłowa', 'żagański', 'lubuskie', '918', '3912', '426' UNION
			SELECT 'Iłża', 'radomski', 'mazowieckie', '1583', '4775', '302' UNION
			SELECT 'Imielin', 'bieruńsko-lędziński', 'śląskie', '2799', '9153', '327' UNION
			SELECT 'Inowrocław', 'inowrocławski', 'kujawsko-pomorskie', '3042', '73114', '2403' UNION
			SELECT 'Ińsko', 'stargardzki', 'zachodniopomorskie', '748', '1929', '258' UNION
			SELECT 'Iwonicz-Zdrój', 'krośnieński', 'podkarpackie', '589', '1793', '304' UNION
			SELECT 'Izbica Kujawska', 'włocławski', 'kujawsko-pomorskie', '224', '2631', '1175' UNION
			SELECT 'Jabłonowo Pomorskie', 'brodnicki', 'kujawsko-pomorskie', '335', '3758', '1122' UNION
			SELECT 'Janikowo', 'inowrocławski', 'kujawsko-pomorskie', '951', '8758', '921' UNION
			SELECT 'Janowiec Wielkopolski', 'żniński', 'kujawsko-pomorskie', '304', '3966', '1305' UNION
			SELECT 'Janów Lubelski', 'janowski', 'lubelskie', '1480', '11940', '807' UNION
			SELECT 'Jaraczewo', 'jarociński', 'wielkopolskie', '1007', '1420', '141' UNION
			SELECT 'Jarocin', 'jarociński', 'wielkopolskie', '1638', '26256', '1603' UNION
			SELECT 'Jarosław', 'jarosławski', 'podkarpackie', '3461', '37690', '1089' UNION
			SELECT 'Jasień', 'żarski', 'lubuskie', '479', '4328', '904' UNION
			SELECT 'Jasło', 'jasielski', 'podkarpackie', '3652', '35192', '964' UNION
			SELECT 'Jastarnia', 'pucki', 'pomorskie', '506', '2710', '536' UNION
			SELECT 'Jastrowie', 'złotowski', 'wielkopolskie', '7230', '8598', '119' UNION
			SELECT 'Jastrzębie-Zdrój', 'Jastrzębie-Zdrój[a]', 'śląskie', '8533', '89128', '1045' UNION
			SELECT 'Jawor', 'jaworski', 'dolnośląskie', '1880', '23056', '1226' UNION
			SELECT 'Jaworzno', 'Jaworzno[a]', 'śląskie', '15259', '91563', '600' UNION
			SELECT 'Jaworzyna Śląska', 'świdnicki', 'dolnośląskie', '434', '5141', '1185' UNION
			SELECT 'Jedlicze', 'krośnieński', 'podkarpackie', '1060', '5759', '543' UNION
			SELECT 'Jedlina-Zdrój', 'wałbrzyski', 'dolnośląskie', '1745', '4851', '278' UNION
			SELECT 'Jedwabne', 'łomżyński', 'podlaskie', '454', '1632', '359' UNION
			SELECT 'Jelcz-Laskowice', 'oławski', 'dolnośląskie', '1706', '15792', '926' UNION
			SELECT 'Jelenia Góra', 'Jelenia Góra[a]', 'dolnośląskie', '10922', '79480', '728' UNION
			SELECT 'Jeziorany', 'olsztyński', 'warmińsko-mazurskie', '341', '3225', '946' UNION
			SELECT 'Jędrzejów', 'jędrzejowski', 'świętokrzyskie', '1137', '15149', '1332' UNION
			SELECT 'Jordanów', 'suski', 'małopolskie', '2103', '5373', '255' UNION
			SELECT 'Józefów', 'biłgorajski', 'lubelskie', '500', '2492', '498' UNION
			SELECT 'Józefów', 'otwocki', 'mazowieckie', '2391', '20605', '862' UNION
			SELECT 'Józefów nad Wisłą', 'opolski', 'lubelskie', '365', '923', '253' UNION
			SELECT 'Jutrosin', 'rawicki', 'wielkopolskie', '162', '1967', '1214' UNION
			SELECT 'Kalety', 'tarnogórski', 'śląskie', '7629', '8626', '113' UNION
			SELECT 'Kalisz', 'Kalisz[a]', 'wielkopolskie', '6942', '100975', '1455' UNION
			SELECT 'Kalisz Pomorski', 'drawski', 'zachodniopomorskie', '1196', '4377', '366' UNION
			SELECT 'Kalwaria Zebrzydowska', 'wadowicki', 'małopolskie', '550', '4515', '821' UNION
			SELECT 'Kałuszyn', 'miński', 'mazowieckie', '1230', '2890', '235' UNION
			SELECT 'Kamienna Góra', 'kamiennogórski', 'dolnośląskie', '1804', '19136', '1061' UNION
			SELECT 'Kamień Krajeński', 'sępoleński', 'kujawsko-pomorskie', '365', '2386', '654' UNION
			SELECT 'Kamień Pomorski', 'kamieński', 'zachodniopomorskie', '1074', '8846', '824' UNION
			SELECT 'Kamieńsk', 'radomszczański', 'łódzkie', '1199', '2782', '232' UNION
			SELECT 'Kańczuga', 'przeworski', 'podkarpackie', '760', '3171', '417' UNION
			SELECT 'Karczew', 'otwocki', 'mazowieckie', '2812', '9891', '352' UNION
			SELECT 'Kargowa', 'zielonogórski', 'lubuskie', '455', '3754', '825' UNION
			SELECT 'Karlino', 'białogardzki', 'zachodniopomorskie', '940', '5919', '630' UNION
			SELECT 'Karpacz', 'jeleniogórski', 'dolnośląskie', '3799', '4633', '122' UNION
			SELECT 'Kartuzy', 'kartuski', 'pomorskie', '735', '14557', '1981' UNION
			SELECT 'Katowice', 'Katowice[a]', 'śląskie', '16464', '294510', '1789' UNION
			SELECT 'Kazimierz Dolny', 'puławski', 'lubelskie', '3044', '2579', '85' UNION
			SELECT 'Kazimierza Wielka', 'kazimierski', 'świętokrzyskie', '533', '5579', '1047' UNION
			SELECT 'Kąty Wrocławskie', 'wrocławski', 'dolnośląskie', '861', '6948', '807' UNION
			SELECT 'Kcynia', 'nakielski', 'kujawsko-pomorskie', '684', '4670', '683' UNION
			SELECT 'Kędzierzyn-Koźle', 'kędzierzyńsko-kozielski', 'opolskie', '12371', '61062', '494' UNION
			SELECT 'Kępice', 'słupski', 'pomorskie', '611', '3606', '590' UNION
			SELECT 'Kępno', 'kępiński', 'wielkopolskie', '779', '14123', '1813' UNION
			SELECT 'Kętrzyn', 'kętrzyński', 'warmińsko-mazurskie', '1035', '27366', '2644' UNION
			SELECT 'Kęty', 'oświęcimski', 'małopolskie', '2305', '18744', '813' UNION
			SELECT 'Kielce', 'Kielce[a]', 'świętokrzyskie', '10965', '195774', '1785' UNION
			SELECT 'Kietrz', 'głubczycki', 'opolskie', '1874', '6034', '322' UNION
			SELECT 'Kisielice', 'iławski', 'warmińsko-mazurskie', '337', '2103', '624' UNION
			SELECT 'Kleczew', 'koniński', 'wielkopolskie', '780', '4186', '537' UNION
			SELECT 'Kleszczele', 'hajnowski', 'podlaskie', '4671', '1271', '27' UNION
			SELECT 'Kluczbork', 'kluczborski', 'opolskie', '1235', '23661', '1916' UNION
			SELECT 'Kłecko', 'gnieźnieński', 'wielkopolskie', '962', '2637', '274' UNION
			SELECT 'Kłobuck', 'kłobucki', 'śląskie', '4746', '12957', '273' UNION
			SELECT 'Kłodawa', 'kolski', 'wielkopolskie', '431', '6481', '1504' UNION
			SELECT 'Kłodzko', 'kłodzki', 'dolnośląskie', '2484', '26954', '1085' UNION
			SELECT 'Knurów', 'gliwicki', 'śląskie', '3395', '38402', '1131' UNION
			SELECT 'Knyszyn', 'moniecki', 'podlaskie', '2368', '2755', '116' UNION
			SELECT 'Kobylin', 'krotoszyński', 'wielkopolskie', '487', '3245', '666' UNION
			SELECT 'Kobyłka', 'wołomiński', 'mazowieckie', '1964', '23706', '1207' UNION
			SELECT 'Kock', 'lubartowski', 'lubelskie', '1678', '3315', '198' UNION
			SELECT 'Kolbuszowa', 'kolbuszowski', 'podkarpackie', '798', '9133', '1144' UNION
			SELECT 'Kolno', 'kolneński', 'podlaskie', '2507', '10261', '409' UNION
			SELECT 'Kolonowskie', 'strzelecki', 'opolskie', '5570', '3328', '60' UNION
			SELECT 'Koluszki', 'łódzki wschodni', 'łódzkie', '990', '13026', '1316' UNION
			SELECT 'Kołaczyce', 'jasielski', 'podkarpackie', '715', '1403', '196' UNION
			SELECT 'Koło', 'kolski', 'wielkopolskie', '1385', '21994', '1588' UNION
			SELECT 'Kołobrzeg', 'kołobrzeski', 'zachodniopomorskie', '2567', '46367', '1806' UNION
			SELECT 'Koniecpol', 'częstochowski', 'śląskie', '3692', '5950', '161' UNION
			SELECT 'Konin', 'Konin[a]', 'wielkopolskie', '8231', '74151', '901' UNION
			SELECT 'Konstancin-Jeziorna', 'piaseczyński', 'mazowieckie', '1774', '17086', '963' UNION
			SELECT 'Konstantynów Łódzki', 'pabianicki', 'łódzkie', '2725', '18096', '664' UNION
			SELECT 'Końskie', 'konecki', 'świętokrzyskie', '1770', '19330', '1092' UNION
			SELECT 'Koprzywnica', 'sandomierski', 'świętokrzyskie', '1790', '2488', '139' UNION
			SELECT 'Korfantów', 'nyski', 'opolskie', '1023', '1817', '178' UNION
			SELECT 'Koronowo', 'bydgoski', 'kujawsko-pomorskie', '2815', '11182', '397' UNION
			SELECT 'Korsze', 'kętrzyński', 'warmińsko-mazurskie', '403', '4259', '1057' UNION
			SELECT 'Kosów Lacki', 'sokołowski', 'mazowieckie', '1157', '2088', '180' UNION
			SELECT 'Kostrzyn', 'poznański', 'wielkopolskie', '798', '9677', '1213' UNION
			SELECT 'Kostrzyn nad Odrą', 'gorzowski', 'lubuskie', '4614', '17776', '385' UNION
			SELECT 'Koszalin', 'Koszalin[a]', 'zachodniopomorskie', '9834', '107321', '1091' UNION
			SELECT 'Koszyce', 'proszowicki', 'małopolskie', '325', '782', '241' UNION
			SELECT 'Kościan', 'kościański', 'wielkopolskie', '901', '23923', '2655' UNION
			SELECT 'Kościerzyna', 'kościerski', 'pomorskie', '1586', '23759', '1498' UNION
			SELECT 'Kowal', 'włocławski', 'kujawsko-pomorskie', '468', '3499', '748' UNION
			SELECT 'Kowalewo Pomorskie', 'golubsko-dobrzyński', 'kujawsko-pomorskie', '445', '4143', '931' UNION
			SELECT 'Kowary', 'jeleniogórski', 'dolnośląskie', '3739', '10957', '293' UNION
			SELECT 'Koziegłowy', 'myszkowski', 'śląskie', '2671', '2463', '92' UNION
			SELECT 'Kozienice', 'kozienicki', 'mazowieckie', '1045', '17331', '1658' UNION
			SELECT 'Koźmin Wielkopolski', 'krotoszyński', 'wielkopolskie', '589', '6536', '1110' UNION
			SELECT 'Kożuchów', 'nowosolski', 'lubuskie', '594', '9490', '1598' UNION
			SELECT 'Kórnik', 'poznański', 'wielkopolskie', '599', '7847', '1310' UNION
			SELECT 'Krajenka', 'złotowski', 'wielkopolskie', '376', '3638', '968' UNION
			SELECT 'Kraków', 'Kraków[a]', 'małopolskie', '32685', '771069', '2359' UNION
			SELECT 'Krapkowice', 'krapkowicki', 'opolskie', '2101', '16381', '780' UNION
			SELECT 'Krasnobród', 'zamojski', 'lubelskie', '699', '3094', '443' UNION
			SELECT 'Krasnystaw', 'krasnostawski', 'lubelskie', '4213', '18778', '446' UNION
			SELECT 'Kraśnik', 'kraśnicki', 'lubelskie', '2610', '34539', '1323' UNION
			SELECT 'Krobia', 'gostyński', 'wielkopolskie', '705', '4313', '612' UNION
			SELECT 'Krosno', 'Krosno[a]', 'podkarpackie', '4350', '46511', '1069' UNION
			SELECT 'Krosno Odrzańskie', 'krośnieński', 'lubuskie', '815', '11378', '1396' UNION
			SELECT 'Krośniewice', 'kutnowski', 'łódzkie', '418', '4375', '1047' UNION
			SELECT 'Krotoszyn', 'krotoszyński', 'wielkopolskie', '2254', '28969', '1285' UNION
			SELECT 'Kruszwica', 'inowrocławski', 'kujawsko-pomorskie', '664', '8818', '1328' UNION
			SELECT 'Krynica Morska', 'nowodworski', 'pomorskie', '11856', '1303', '11' UNION
			SELECT 'Krynica-Zdrój', 'nowosądecki', 'małopolskie', '3968', '10686', '269' UNION
			SELECT 'Krynki', 'sokólski', 'podlaskie', '383', '2415', '631' UNION
			SELECT 'Krzanowice', 'raciborski', 'śląskie', '308', '2158', '701' UNION
			SELECT 'Krzepice', 'kłobucki', 'śląskie', '2766', '4462', '161' UNION
			SELECT 'Krzeszowice', 'krakowski', 'małopolskie', '1697', '10051', '592' UNION
			SELECT 'Krzywiń', 'kościański', 'wielkopolskie', '227', '1714', '755' UNION
			SELECT 'Krzyż Wielkopolski', 'czarnkowsko-trzcianecki', 'wielkopolskie', '581', '6216', '1070' UNION
			SELECT 'Książ Wielkopolski', 'śremski', 'wielkopolskie', '196', '2726', '1391' UNION
			SELECT 'Kudowa-Zdrój', 'kłodzki', 'dolnośląskie', '3390', '9954', '294' UNION
			SELECT 'Kunów', 'ostrowiecki', 'świętokrzyskie', '726', '2979', '410' UNION
			SELECT 'Kutno', 'kutnowski', 'łódzkie', '3359', '44172', '1315' UNION
			SELECT 'Kuźnia Raciborska', 'raciborski', 'śląskie', '3149', '5386', '171' UNION
			SELECT 'Kwidzyn', 'kwidzyński', 'pomorskie', '2154', '38481', '1786' UNION
			SELECT 'Lądek-Zdrój', 'kłodzki', 'dolnośląskie', '2032', '5622', '277' UNION
			SELECT 'Legionowo', 'legionowski', 'mazowieckie', '1354', '54066', '3993' UNION
			SELECT 'Legnica', 'Legnica[a]', 'dolnośląskie', '5629', '99752', '1772' UNION
			SELECT 'Lesko', 'leski', 'podkarpackie', '1533', '5431', '354' UNION
			SELECT 'Leszno', 'Leszno[a]', 'wielkopolskie', '3186', '63952', '2007' UNION
			SELECT 'Leśna', 'lubański', 'dolnośląskie', '856', '4484', '524' UNION
			SELECT 'Leśnica', 'strzelecki', 'opolskie', '1450', '2585', '178' UNION
			SELECT 'Lewin Brzeski', 'brzeski', 'opolskie', '1164', '5743', '493' UNION
			SELECT 'Leżajsk', 'leżajski', 'podkarpackie', '2058', '13891', '675' UNION
			SELECT 'Lębork', 'lęborski', 'pomorskie', '1786', '35367', '1980' UNION
			SELECT 'Lędziny', 'bieruńsko-lędziński', 'śląskie', '3165', '16822', '532' UNION
			SELECT 'Libiąż', 'chrzanowski', 'małopolskie', '3585', '17084', '477' UNION
			SELECT 'Lidzbark', 'działdowski', 'warmińsko-mazurskie', '568', '7817', '1376' UNION
			SELECT 'Lidzbark Warmiński', 'lidzbarski', 'warmińsko-mazurskie', '1435', '15820', '1102' UNION
			SELECT 'Limanowa', 'limanowski', 'małopolskie', '1870', '15158', '811' UNION
			SELECT 'Lipiany', 'pyrzycki', 'zachodniopomorskie', '554', '3946', '712' UNION
			SELECT 'Lipno', 'lipnowski', 'kujawsko-pomorskie', '1099', '14478', '1317' UNION
			SELECT 'Lipsk', 'augustowski', 'podlaskie', '498', '2350', '472' UNION
			SELECT 'Lipsko', 'lipski', 'mazowieckie', '1570', '5544', '353' UNION
			SELECT 'Lubaczów', 'lubaczowski', 'podkarpackie', '2573', '12078', '469' UNION
			SELECT 'Lubań', 'lubański', 'dolnośląskie', '1612', '21168', '1313' UNION
			SELECT 'Lubartów', 'lubartowski', 'lubelskie', '1391', '21995', '1581' UNION
			SELECT 'Lubawa', 'iławski', 'warmińsko-mazurskie', '1684', '10381', '616' UNION
			SELECT 'Lubawka', 'kamiennogórski', 'dolnośląskie', '2244', '6063', '270' UNION
			SELECT 'Lubień Kujawski', 'włocławski', 'kujawsko-pomorskie', '231', '1397', '605' UNION
			SELECT 'Lubin', 'lubiński', 'dolnośląskie', '4077', '72581', '1780' UNION
			SELECT 'Lublin', 'Lublin[a]', 'lubelskie', '14747', '339682', '2303' UNION
			SELECT 'Lubliniec', 'lubliniecki', 'śląskie', '8936', '23818', '267' UNION
			SELECT 'Lubniewice', 'sulęciński', 'lubuskie', '1211', '2042', '169' UNION
			SELECT 'Lubomierz', 'lwówecki', 'dolnośląskie', '805', '1990', '247' UNION
			SELECT 'Luboń', 'poznański', 'wielkopolskie', '1351', '31783', '2353' UNION
			SELECT 'Lubowidz', 'żuromiński', 'mazowieckie', '527', '1697', '322' UNION
			SELECT 'Lubraniec', 'włocławski', 'kujawsko-pomorskie', '197', '3028', '1537' UNION
			SELECT 'Lubsko', 'żarski', 'lubuskie', '1251', '14000', '1119' UNION
			SELECT 'Lubycza Królewska', 'tomaszowski', 'lubelskie', '392', '2443', '623' UNION
			SELECT 'Lwówek', 'nowotomyski', 'wielkopolskie', '316', '2977', '942' UNION
			SELECT 'Lwówek Śląski', 'lwówecki', 'dolnośląskie', '1665', '8870', '533' UNION
			SELECT 'Łabiszyn', 'żniński', 'kujawsko-pomorskie', '289', '4501', '1557' UNION
			SELECT 'Łagów', 'kielecki', 'świętokrzyskie', '822', '1587', '193' UNION
			SELECT 'Łańcut', 'łańcucki', 'podkarpackie', '1942', '17738', '913' UNION
			SELECT 'Łapy', 'białostocki', 'podlaskie', '1214', '15643', '1289' UNION
			SELECT 'Łasin', 'grudziądzki', 'kujawsko-pomorskie', '479', '3298', '689' UNION
			SELECT 'Łask', 'łaski', 'łódzkie', '1567', '17344', '1107' UNION
			SELECT 'Łaskarzew', 'garwoliński', 'mazowieckie', '1535', '4860', '317' UNION
			SELECT 'Łaszczów', 'tomaszowski', 'lubelskie', '501', '2154', '430' UNION
			SELECT 'Łaziska Górne', 'mikołowski', 'śląskie', '2007', '22334', '1113' UNION
			SELECT 'Łazy', 'zawierciański', 'śląskie', '860', '6845', '796' UNION
			SELECT 'Łeba', 'lęborski', 'pomorskie', '1656', '3675', '222' UNION
			SELECT 'Łęczna', 'łęczyński', 'lubelskie', '1900', '19006', '1000' UNION
			SELECT 'Łęczyca', 'łęczycki', 'łódzkie', '895', '14094', '1575' UNION
			SELECT 'Łęknica', 'żarski', 'lubuskie', '1643', '2483', '151' UNION
			SELECT 'Łobez', 'łobeski', 'zachodniopomorskie', '1284', '10241', '798' UNION
			SELECT 'Łobżenica', 'pilski', 'wielkopolskie', '325', '2972', '914' UNION
			SELECT 'Łochów', 'węgrowski', 'mazowieckie', '1339', '6821', '509' UNION
			SELECT 'Łomianki', 'warszawski zachodni', 'mazowieckie', '840', '16977', '2021' UNION
			SELECT 'Łomża', 'Łomża[a]', 'podlaskie', '3267', '63000', '1928' UNION
			SELECT 'Łosice', 'łosicki', 'mazowieckie', '2374', '7071', '298' UNION
			SELECT 'Łowicz', 'łowicki', 'łódzkie', '2342', '28501', '1217' UNION
			SELECT 'Łódź', 'Łódź[a]', 'łódzkie', '29325', '685285', '2337' UNION
			SELECT 'Łuków', 'łukowski', 'lubelskie', '3575', '30025', '840' UNION
			SELECT 'Maków Mazowiecki', 'makowski', 'mazowieckie', '1028', '9787', '952' UNION
			SELECT 'Maków Podhalański', 'suski', 'małopolskie', '2012', '5853', '291' UNION
			SELECT 'Malbork', 'malborski', 'pomorskie', '1716', '38570', '2248' UNION
			SELECT 'Małogoszcz', 'jędrzejowski', 'świętokrzyskie', '968', '3769', '389' UNION
			SELECT 'Małomice', 'żagański', 'lubuskie', '537', '3489', '650' UNION
			SELECT 'Margonin', 'chodzieski', 'wielkopolskie', '515', '3019', '586' UNION
			SELECT 'Marki', 'wołomiński', 'mazowieckie', '2615', '33914', '1297' UNION
			SELECT 'Maszewo', 'goleniowski', 'zachodniopomorskie', '554', '3363', '607' UNION
			SELECT 'Miasteczko Śląskie', 'tarnogórski', 'śląskie', '6783', '7449', '110' UNION
			SELECT 'Miastko', 'bytowski', 'pomorskie', '568', '10473', '1844' UNION
			SELECT 'Michałowo', 'białostocki', 'podlaskie', '215', '3047', '1417' UNION
			SELECT 'Miechów', 'miechowski', 'małopolskie', '1549', '11652', '752' UNION
			SELECT 'Miejska Górka', 'rawicki', 'wielkopolskie', '314', '3244', '1033' UNION
			SELECT 'Mielec', 'mielecki', 'podkarpackie', '4689', '60478', '1290' UNION
			SELECT 'Mielno', 'koszaliński', 'zachodniopomorskie', '3345', '2952', '88' UNION
			SELECT 'Mieroszów', 'wałbrzyski', 'dolnośląskie', '1031', '4106', '398' UNION
			SELECT 'Mieszkowice', 'gryfiński', 'zachodniopomorskie', '525', '3645', '694' UNION
			SELECT 'Międzybórz', 'oleśnicki', 'dolnośląskie', '641', '2352', '367' UNION
			SELECT 'Międzychód', 'międzychodzki', 'wielkopolskie', '698', '10623', '1522' UNION
			SELECT 'Międzylesie', 'kłodzki', 'dolnośląskie', '1437', '2591', '180' UNION
			SELECT 'Międzyrzec Podlaski', 'bialski', 'lubelskie', '2003', '16796', '839' UNION
			SELECT 'Międzyrzecz', 'międzyrzecki', 'lubuskie', '1026', '18099', '1764' UNION
			SELECT 'Międzyzdroje', 'kamieński', 'zachodniopomorskie', '516', '5399', '1046' UNION
			SELECT 'Mikołajki', 'mrągowski', 'warmińsko-mazurskie', '932', '3838', '412' UNION
			SELECT 'Mikołów', 'mikołowski', 'śląskie', '7921', '40813', '515' UNION
			SELECT 'Mikstat', 'ostrzeszowski', 'wielkopolskie', '252', '1855', '736' UNION
			SELECT 'Milanówek', 'grodziski', 'mazowieckie', '1344', '16306', '1213' UNION
			SELECT 'Milicz', 'milicki', 'dolnośląskie', '1350', '11357', '841' UNION
			SELECT 'Miłakowo', 'ostródzki', 'warmińsko-mazurskie', '876', '2560', '292' UNION
			SELECT 'Miłomłyn', 'ostródzki', 'warmińsko-mazurskie', '1238', '2442', '197' UNION
			SELECT 'Miłosław', 'wrzesiński', 'wielkopolskie', '407', '3572', '878' UNION
			SELECT 'Mińsk Mazowiecki', 'miński', 'mazowieckie', '1318', '40799', '3096' UNION
			SELECT 'Mirosławiec', 'wałecki', 'zachodniopomorskie', '241', '3089', '1282' UNION
			SELECT 'Mirsk', 'lwówecki', 'dolnośląskie', '1466', '3902', '266' UNION
			SELECT 'Mława', 'mławski', 'mazowieckie', '3480', '31234', '898' UNION
			SELECT 'Młynary', 'elbląski', 'warmińsko-mazurskie', '276', '1780', '645' UNION
			SELECT 'Modliborzyce', 'janowski', 'lubelskie', '789', '1460', '185' UNION
			SELECT 'Mogielnica', 'grójecki', 'mazowieckie', '1298', '2260', '174' UNION
			SELECT 'Mogilno', 'mogileński', 'kujawsko-pomorskie', '832', '11880', '1428' UNION
			SELECT 'Mońki', 'moniecki', 'podlaskie', '766', '10010', '1307' UNION
			SELECT 'Morawica', 'kielecki', 'świętokrzyskie', '438', '1695', '387' UNION
			SELECT 'Morąg', 'ostródzki', 'warmińsko-mazurskie', '611', '13838', '2265' UNION
			SELECT 'Mordy', 'siedlecki', 'mazowieckie', '454', '1793', '395' UNION
			SELECT 'Moryń', 'gryfiński', 'zachodniopomorskie', '554', '1626', '294' UNION
			SELECT 'Mosina', 'poznański', 'wielkopolskie', '1350', '14015', '1038' UNION
			SELECT 'Mrągowo', 'mrągowski', 'warmińsko-mazurskie', '1481', '21708', '1466' UNION
			SELECT 'Mrocza', 'nakielski', 'kujawsko-pomorskie', '501', '4366', '871' UNION
			SELECT 'Mrozy', 'miński', 'mazowieckie', '773', '3552', '460' UNION
			SELECT 'Mszana Dolna', 'limanowski', 'małopolskie', '2710', '7948', '293' UNION
			SELECT 'Mszczonów', 'żyrardowski', 'mazowieckie', '856', '6386', '746' UNION
			SELECT 'Murowana Goślina', 'poznański', 'wielkopolskie', '862', '10396', '1206' UNION
			SELECT 'Muszyna', 'nowosądecki', 'małopolskie', '2443', '4831', '198' UNION
			SELECT 'Mysłowice', 'Mysłowice[a]', 'śląskie', '6562', '74586', '1137' UNION
			SELECT 'Myszków', 'myszkowski', 'śląskie', '7359', '31762', '432' UNION
			SELECT 'Myszyniec', 'ostrołęcki', 'mazowieckie', '1122', '3426', '305' UNION
			SELECT 'Myślenice', 'myślenicki', 'małopolskie', '3022', '18386', '608' UNION
			SELECT 'Myślibórz', 'myśliborski', 'zachodniopomorskie', '1504', '11235', '747' UNION
			SELECT 'Nakło nad Notecią', 'nakielski', 'kujawsko-pomorskie', '1082', '18353', '1696' UNION
			SELECT 'Nałęczów', 'puławski', 'lubelskie', '1382', '3768', '273' UNION
			SELECT 'Namysłów', 'namysłowski', 'opolskie', '2261', '16490', '729' UNION
			SELECT 'Narol', 'lubaczowski', 'podkarpackie', '1242', '2076', '167' UNION
			SELECT 'Nasielsk', 'nowodworski', 'mazowieckie', '1257', '7707', '613' UNION
			SELECT 'Nekla', 'wrzesiński', 'wielkopolskie', '1979', '3754', '190' UNION
			SELECT 'Nidzica', 'nidzicki', 'warmińsko-mazurskie', '686', '13820', '2015' UNION
			SELECT 'Niemcza', 'dzierżoniowski', 'dolnośląskie', '1981', '2974', '150' UNION
			SELECT 'Niemodlin', 'opolski', 'opolskie', '1311', '6359', '485' UNION
			SELECT 'Niepołomice', 'wielicki', 'małopolskie', '2740', '13001', '474' UNION
			SELECT 'Nieszawa', 'aleksandrowski', 'kujawsko-pomorskie', '979', '1886', '193' UNION
			SELECT 'Nisko', 'niżański', 'podkarpackie', '6096', '15359', '252' UNION
			SELECT 'Nowa Dęba', 'tarnobrzeski', 'podkarpackie', '1670', '11181', '670' UNION
			SELECT 'Nowa Ruda', 'kłodzki', 'dolnośląskie', '3705', '22246', '600' UNION
			SELECT 'Nowa Sarzyna', 'leżajski', 'podkarpackie', '915', '5880', '643' UNION
			SELECT 'Nowa Słupia', 'kielecki', 'świętokrzyskie', '1397', '1361', '97' UNION
			SELECT 'Nowa Sól', 'nowosolski', 'lubuskie', '2180', '38843', '1782' UNION
			SELECT 'Nowe', 'świecki', 'kujawsko-pomorskie', '357', '5864', '1643' UNION
			SELECT 'Nowe Brzesko', 'proszowicki', 'małopolskie', '726', '1683', '232' UNION
			SELECT 'Nowe Miasteczko', 'nowosolski', 'lubuskie', '329', '2770', '842' UNION
			SELECT 'Nowe Miasto Lubawskie', 'nowomiejski', 'warmińsko-mazurskie', '1137', '10925', '961' UNION
			SELECT 'Nowe Miasto nad Pilicą', 'grójecki', 'mazowieckie', '1125', '3789', '337' UNION
			SELECT 'Nowe Skalmierzyce', 'ostrowski', 'wielkopolskie', '158', '4770', '3019' UNION
			SELECT 'Nowe Warpno', 'policki', 'zachodniopomorskie', '2451', '1192', '49' UNION
			SELECT 'Nowogard', 'goleniowski', 'zachodniopomorskie', '1257', '16671', '1326' UNION
			SELECT 'Nowogrodziec', 'bolesławiecki', 'dolnośląskie', '1610', '4235', '263' UNION
			SELECT 'Nowogród', 'łomżyński', 'podlaskie', '2055', '2156', '105' UNION
			SELECT 'Nowogród Bobrzański', 'zielonogórski', 'lubuskie', '1463', '5188', '355' UNION
			SELECT 'Nowy Dwór Gdański', 'nowodworski', 'pomorskie', '507', '9917', '1956' UNION
			SELECT 'Nowy Dwór Mazowiecki', 'nowodworski', 'mazowieckie', '2821', '28647', '1015' UNION
			SELECT 'Nowy Korczyn', 'buski', 'świętokrzyskie', '752', '955', '127' UNION
			SELECT 'Nowy Sącz', 'Nowy Sącz[a]', 'małopolskie', '5758', '83896', '1457' UNION
			SELECT 'Nowy Staw', 'malborski', 'pomorskie', '467', '4283', '917' UNION
			SELECT 'Nowy Targ', 'nowotarski', 'małopolskie', '5107', '33373', '653' UNION
			SELECT 'Nowy Tomyśl', 'nowotomyski', 'wielkopolskie', '520', '14603', '2808' UNION
			SELECT 'Nowy Wiśnicz', 'bocheński', 'małopolskie', '497', '2745', '552' UNION
			SELECT 'Nysa', 'nyski', 'opolskie', '2751', '44044', '1601' UNION
			SELECT 'Oborniki', 'obornicki', 'wielkopolskie', '1408', '18179', '1291' UNION
			SELECT 'Oborniki Śląskie', 'trzebnicki', 'dolnośląskie', '1446', '9109', '630' UNION
			SELECT 'Obrzycko', 'szamotulski', 'wielkopolskie', '374', '2385', '638' UNION
			SELECT 'Odolanów', 'ostrowski', 'wielkopolskie', '476', '5130', '1078' UNION
			SELECT 'Ogrodzieniec', 'zawierciański', 'śląskie', '2856', '4296', '150' UNION
			SELECT 'Okonek', 'złotowski', 'wielkopolskie', '601', '3900', '649' UNION
			SELECT 'Olecko', 'olecki', 'warmińsko-mazurskie', '1154', '16477', '1428' UNION
			SELECT 'Olesno', 'oleski', 'opolskie', '1508', '9406', '624' UNION
			SELECT 'Oleszyce', 'lubaczowski', 'podkarpackie', '508', '2993', '589' UNION
			SELECT 'Oleśnica', 'oleśnicki', 'dolnośląskie', '2096', '37242', '1777' UNION
			SELECT 'Oleśnica', 'staszowski', 'świętokrzyskie', '1004', '1848', '184' UNION
			SELECT 'Olkusz', 'olkuski', 'małopolskie', '2565', '35608', '1388' UNION
			SELECT 'Olsztyn', 'Olsztyn[a]', 'warmińsko-mazurskie', '8833', '172362', '1951' UNION
			SELECT 'Olsztynek', 'olsztyński', 'warmińsko-mazurskie', '769', '7581', '986' UNION
			SELECT 'Olszyna', 'lubański', 'dolnośląskie', '2026', '4359', '215' UNION
			SELECT 'Oława', 'oławski', 'dolnośląskie', '2736', '32927', '1203' UNION
			SELECT 'Opalenica', 'nowotomyski', 'wielkopolskie', '642', '9596', '1495' UNION
			SELECT 'Opatowiec', 'kazimierski', 'świętokrzyskie', '547', '329', '60' UNION
			SELECT 'Opatów', 'opatowski', 'świętokrzyskie', '936', '6496', '694' UNION
			SELECT 'Opatówek', 'kaliski', 'wielkopolskie', '868', '3677', '424' UNION
			SELECT 'Opoczno', 'opoczyński', 'łódzkie', '2699', '21327', '790' UNION
			SELECT 'Opole', 'Opole[a]', 'opolskie', '14888', '128137', '861' UNION
			SELECT 'Opole Lubelskie', 'opolski', 'lubelskie', '1512', '8470', '560' UNION
			SELECT 'Orneta', 'lidzbarski', 'warmińsko-mazurskie', '963', '8817', '916' UNION
			SELECT 'Orzesze', 'mikołowski', 'śląskie', '8375', '20927', '250' UNION
			SELECT 'Orzysz', 'piski', 'warmińsko-mazurskie', '817', '5579', '683' UNION
			SELECT 'Osieczna', 'leszczyński', 'wielkopolskie', '476', '2347', '493' UNION
			SELECT 'Osiek', 'staszowski', 'świętokrzyskie', '1743', '2015', '116' UNION
			SELECT 'Ostrołęka', 'Ostrołęka[a]', 'mazowieckie', '3346', '52262', '1562' UNION
			SELECT 'Ostroróg', 'szamotulski', 'wielkopolskie', '125', '1920', '1536' UNION
			SELECT 'Ostrowiec Świętokrzyski', 'ostrowiecki', 'świętokrzyskie', '4643', '69051', '1487' UNION
			SELECT 'Ostróda', 'ostródzki', 'warmińsko-mazurskie', '1415', '32996', '2332' UNION
			SELECT 'Ostrów Lubelski', 'lubartowski', 'lubelskie', '2977', '2092', '70' UNION
			SELECT 'Ostrów Mazowiecka', 'ostrowski', 'mazowieckie', '2227', '22545', '1012' UNION
			SELECT 'Ostrów Wielkopolski', 'ostrowski', 'wielkopolskie', '4190', '72050', '1720' UNION
			SELECT 'Ostrzeszów', 'ostrzeszowski', 'wielkopolskie', '1213', '14176', '1169' UNION
			SELECT 'Ośno Lubuskie', 'słubicki', 'lubuskie', '801', '3949', '493' UNION
			SELECT 'Oświęcim', 'oświęcimski', 'małopolskie', '3000', '38300', '1277' UNION
			SELECT 'Otmuchów', 'nyski', 'opolskie', '4954', '6615', '134' UNION
			SELECT 'Otwock', 'otwocki', 'mazowieckie', '4731', '44880', '949' UNION
			SELECT 'Otyń', 'nowosolski', 'lubuskie', '786', '1601', '204' UNION
			SELECT 'Ozimek', 'opolski', 'opolskie', '325', '8725', '2685' UNION
			SELECT 'Ozorków', 'zgierski', 'łódzkie', '1546', '19456', '1258' UNION
			SELECT 'Ożarów', 'opatowski', 'świętokrzyskie', '779', '4599', '590' UNION
			SELECT 'Ożarów Mazowiecki', 'warszawski zachodni', 'mazowieckie', '813', '11576', '1424' UNION
			SELECT 'Pabianice', 'pabianicki', 'łódzkie', '3299', '65283', '1979' UNION
			SELECT 'Pacanów', 'buski', 'świętokrzyskie', '713', '1117', '157' UNION
			SELECT 'Paczków', 'nyski', 'opolskie', '660', '7530', '1141' UNION
			SELECT 'Pajęczno', 'pajęczański', 'łódzkie', '2023', '6781', '335' UNION
			SELECT 'Pakość', 'inowrocławski', 'kujawsko-pomorskie', '346', '5723', '1654' UNION
			SELECT 'Parczew', 'parczewski', 'lubelskie', '805', '10650', '1323' UNION
			SELECT 'Pasłęk', 'elbląski', 'warmińsko-mazurskie', '1063', '12211', '1149' UNION
			SELECT 'Pasym', 'szczycieński', 'warmińsko-mazurskie', '1518', '2517', '166' UNION
			SELECT 'Pelplin', 'tczewski', 'pomorskie', '442', '7818', '1769' UNION
			SELECT 'Pełczyce', 'choszczeński', 'zachodniopomorskie', '1307', '2589', '198' UNION
			SELECT 'Piaseczno', 'piaseczyński', 'mazowieckie', '1622', '48119', '2967' UNION
			SELECT 'Piaski', 'świdnicki', 'lubelskie', '844', '2556', '303' UNION
			SELECT 'Piastów', 'pruszkowski', 'mazowieckie', '576', '22657', '3934' UNION
			SELECT 'Piechowice', 'jeleniogórski', 'dolnośląskie', '4322', '6222', '144' UNION
			SELECT 'Piekary Śląskie', 'Piekary Śląskie[a]', 'śląskie', '3998', '55299', '1383' UNION
			SELECT 'Pieniężno', 'braniewski', 'warmińsko-mazurskie', '381', '2746', '721' UNION
			SELECT 'Pieńsk', 'zgorzelecki', 'dolnośląskie', '992', '5848', '590' UNION
			SELECT 'Pierzchnica', 'kielecki', 'świętokrzyskie', '693', '1152', '166' UNION
			SELECT 'Pieszyce', 'dzierżoniowski', 'dolnośląskie', '1772', '7136', '403' UNION
			SELECT 'Pilawa', 'garwoliński', 'mazowieckie', '666', '4589', '689' UNION
			SELECT 'Pilica', 'zawierciański', 'śląskie', '822', '1947', '237' UNION
			SELECT 'Pilzno', 'dębicki', 'podkarpackie', '1604', '4903', '306' UNION
			SELECT 'Piła', 'pilski', 'wielkopolskie', '10268', '73398', '715' UNION
			SELECT 'Piława Górna', 'dzierżoniowski', 'dolnośląskie', '2093', '6457', '309' UNION
			SELECT 'Pińczów', 'pińczowski', 'świętokrzyskie', '1433', '10844', '757' UNION
			SELECT 'Pionki', 'radomski', 'mazowieckie', '1840', '18427', '1001' UNION
			SELECT 'Piotrków Kujawski', 'radziejowski', 'kujawsko-pomorskie', '976', '4468', '458' UNION
			SELECT 'Piotrków Trybunalski', 'Piotrków Trybunalski[a]', 'łódzkie', '6724', '73670', '1096' UNION
			SELECT 'Pisz', 'piski', 'warmińsko-mazurskie', '1008', '19318', '1916' UNION
			SELECT 'Piwniczna-Zdrój', 'nowosądecki', 'małopolskie', '3830', '5882', '154' UNION
			SELECT 'Pleszew', 'pleszewski', 'wielkopolskie', '1338', '17356', '1297' UNION
			SELECT 'Płock', 'Płock[a]', 'mazowieckie', '8804', '120000', '1363' UNION
			SELECT 'Płońsk', 'płoński', 'mazowieckie', '1160', '22163', '1911' UNION
			SELECT 'Płoty', 'gryficki', 'zachodniopomorskie', '412', '3983', '967' UNION
			SELECT 'Pniewy', 'szamotulski', 'wielkopolskie', '932', '8060', '865' UNION
			SELECT 'Pobiedziska', 'poznański', 'wielkopolskie', '1024', '9181', '897' UNION
			SELECT 'Poddębice', 'poddębicki', 'łódzkie', '587', '7448', '1269' UNION
			SELECT 'Podkowa Leśna', 'grodziski', 'mazowieckie', '1013', '3854', '380' UNION
			SELECT 'Pogorzela', 'gostyński', 'wielkopolskie', '436', '2100', '482' UNION
			SELECT 'Polanica-Zdrój', 'kłodzki', 'dolnośląskie', '1722', '6357', '369' UNION
			SELECT 'Polanów', 'koszaliński', 'zachodniopomorskie', '737', '2918', '396' UNION
			SELECT 'Police', 'policki', 'zachodniopomorskie', '3731', '32685', '876' UNION
			SELECT 'Polkowice', 'polkowicki', 'dolnośląskie', '2374', '22487', '947' UNION
			SELECT 'Połaniec', 'staszowski', 'świętokrzyskie', '1741', '8120', '466' UNION
			SELECT 'Połczyn-Zdrój', 'świdwiński', 'zachodniopomorskie', '721', '8109', '1125' UNION
			SELECT 'Poniatowa', 'opolski', 'lubelskie', '1526', '9195', '603' UNION
			SELECT 'Poniec', 'gostyński', 'wielkopolskie', '348', '2851', '819' UNION
			SELECT 'Poręba', 'zawierciański', 'śląskie', '3999', '8568', '214' UNION
			SELECT 'Poznań', 'Poznań[a]', 'wielkopolskie', '26191', '536438', '2048' UNION
			SELECT 'Prabuty', 'kwidzyński', 'pomorskie', '729', '8696', '1193' UNION
			SELECT 'Praszka', 'oleski', 'opolskie', '935', '7704', '824' UNION
			SELECT 'Prochowice', 'legnicki', 'dolnośląskie', '985', '3620', '368' UNION
			SELECT 'Proszowice', 'proszowicki', 'małopolskie', '733', '6012', '820' UNION
			SELECT 'Prószków', 'opolski', 'opolskie', '1622', '2591', '160' UNION
			SELECT 'Pruchnik', 'jarosławski', 'podkarpackie', '1990', '3774', '190' UNION
			SELECT 'Prudnik', 'prudnicki', 'opolskie', '2050', '21138', '1031' UNION
			SELECT 'Prusice', 'trzebnicki', 'dolnośląskie', '1094', '2232', '204' UNION
			SELECT 'Pruszcz Gdański', 'gdański', 'pomorskie', '1647', '30878', '1875' UNION
			SELECT 'Pruszków', 'pruszkowski', 'mazowieckie', '1919', '61784', '3220' UNION
			SELECT 'Przasnysz', 'przasnyski', 'mazowieckie', '2516', '17309', '688' UNION
			SELECT 'Przecław', 'mielecki', 'podkarpackie', '1604', '1768', '110' UNION
			SELECT 'Przedbórz', 'radomszczański', 'łódzkie', '608', '3572', '588' UNION
			SELECT 'Przedecz', 'kolski', 'wielkopolskie', '298', '1670', '560' UNION
			SELECT 'Przemków', 'polkowicki', 'dolnośląskie', '617', '6149', '997' UNION
			SELECT 'Przemyśl', 'Przemyśl[a]', 'podkarpackie', '4617', '61251', '1327' UNION
			SELECT 'Przeworsk', 'przeworski', 'podkarpackie', '2213', '15376', '695' UNION
			SELECT 'Przysucha', 'przysuski', 'mazowieckie', '702', '5854', '834' UNION
			SELECT 'Pszczyna', 'pszczyński', 'śląskie', '2249', '25829', '1148' UNION
			SELECT 'Pszów', 'wodzisławski', 'śląskie', '2044', '13994', '685' UNION
			SELECT 'Puck', 'pucki', 'pomorskie', '479', '11241', '2347' UNION
			SELECT 'Puławy', 'puławski', 'lubelskie', '5049', '47774', '946' UNION
			SELECT 'Pułtusk', 'pułtuski', 'mazowieckie', '2307', '19431', '842' UNION
			SELECT 'Puszczykowo', 'poznański', 'wielkopolskie', '1639', '9698', '592' UNION
			SELECT 'Pyrzyce', 'pyrzycki', 'zachodniopomorskie', '3879', '12617', '325' UNION
			SELECT 'Pyskowice', 'gliwicki', 'śląskie', '3089', '18456', '597' UNION
			SELECT 'Pyzdry', 'wrzesiński', 'wielkopolskie', '1216', '3145', '259' UNION
			SELECT 'Rabka-Zdrój', 'nowotarski', 'małopolskie', '3631', '12780', '352' UNION
			SELECT 'Raciąż', 'płoński', 'mazowieckie', '840', '4420', '526' UNION
			SELECT 'Racibórz', 'raciborski', 'śląskie', '7501', '54882', '732' UNION
			SELECT 'Radków', 'kłodzki', 'dolnośląskie', '1503', '2418', '161' UNION
			SELECT 'Radlin', 'wodzisławski', 'śląskie', '1253', '17806', '1421' UNION
			SELECT 'Radłów', 'tarnowski', 'małopolskie', '1683', '2767', '164' UNION
			SELECT 'Radom', 'Radom[a]', 'mazowieckie', '11180', '213029', '1905' UNION
			SELECT 'Radomsko', 'radomszczański', 'łódzkie', '5143', '46087', '896' UNION
			SELECT 'Radomyśl Wielki', 'mielecki', 'podkarpackie', '879', '3196', '364' UNION
			SELECT 'Radoszyce', 'konecki', 'świętokrzyskie', '1717', '3167', '184' UNION
			SELECT 'Radymno', 'jarosławski', 'podkarpackie', '1362', '5314', '390' UNION
			SELECT 'Radziejów', 'radziejowski', 'kujawsko-pomorskie', '569', '5602', '985' UNION
			SELECT 'Radzionków', 'tarnogórski', 'śląskie', '1320', '16818', '1274' UNION
			SELECT 'Radzymin', 'wołomiński', 'mazowieckie', '2339', '12876', '550' UNION
			SELECT 'Radzyń Chełmiński', 'grudziądzki', 'kujawsko-pomorskie', '178', '1864', '1047' UNION
			SELECT 'Radzyń Podlaski', 'radzyński', 'lubelskie', '1931', '15731', '815' UNION
			SELECT 'Rajgród', 'grajewski', 'podlaskie', '3528', '1585', '45' UNION
			SELECT 'Rakoniewice', 'grodziski', 'wielkopolskie', '337', '3599', '1068' UNION
			SELECT 'Raszków', 'ostrowski', 'wielkopolskie', '205', '2099', '1024' UNION
			SELECT 'Rawa Mazowiecka', 'rawski', 'łódzkie', '1430', '17408', '1217' UNION
			SELECT 'Rawicz', 'rawicki', 'wielkopolskie', '774', '20337', '2628' UNION
			SELECT 'Recz', 'choszczeński', 'zachodniopomorskie', '1240', '2914', '235' UNION
			SELECT 'Reda', 'wejherowski', 'pomorskie', '3346', '25810', '771' UNION
			SELECT 'Rejowiec', 'chełmski', 'lubelskie', '650', '2070', '318' UNION
			SELECT 'Rejowiec Fabryczny', 'chełmski', 'lubelskie', '1428', '4417', '309' UNION
			SELECT 'Resko', 'łobeski', 'zachodniopomorskie', '449', '4231', '942' UNION
			SELECT 'Reszel', 'kętrzyński', 'warmińsko-mazurskie', '382', '4571', '1197' UNION
			SELECT 'Rogoźno', 'obornicki', 'wielkopolskie', '1124', '11148', '992' UNION
			SELECT 'Ropczyce', 'ropczycko-sędziszowski', 'podkarpackie', '4710', '15856', '337' UNION
			SELECT 'Różan', 'makowski', 'mazowieckie', '666', '2727', '409' UNION
			SELECT 'Ruciane-Nida', 'piski', 'warmińsko-mazurskie', '1707', '4474', '262' UNION
			SELECT 'Ruda Śląska', 'Ruda Śląska[a]', 'śląskie', '7773', '138000', '1775' UNION
			SELECT 'Rudnik nad Sanem', 'niżański', 'podkarpackie', '3660', '6726', '184' UNION
			SELECT 'Rumia', 'wejherowski', 'pomorskie', '3010', '49031', '1629' UNION
			SELECT 'Rybnik', 'Rybnik[a]', 'śląskie', '14836', '138696', '935' UNION
			SELECT 'Rychwał', 'koniński', 'wielkopolskie', '970', '2391', '246' UNION
			SELECT 'Rydułtowy', 'wodzisławski', 'śląskie', '1495', '21637', '1447' UNION
			SELECT 'Rydzyna', 'leszczyński', 'wielkopolskie', '220', '2867', '1303' UNION
			SELECT 'Ryglice', 'tarnowski', 'małopolskie', '2515', '2831', '113' UNION
			SELECT 'Ryki', 'rycki', 'lubelskie', '2722', '9667', '355' UNION
			SELECT 'Rymanów', 'krośnieński', 'podkarpackie', '1239', '3819', '308' UNION
			SELECT 'Ryn', 'giżycki', 'warmińsko-mazurskie', '414', '2851', '689' UNION
			SELECT 'Rypin', 'rypiński', 'kujawsko-pomorskie', '1096', '16354', '1492' UNION
			SELECT 'Rzepin', 'słubicki', 'lubuskie', '1142', '6564', '575' UNION
			SELECT 'Rzeszów', 'Rzeszów[a]', 'podkarpackie', '12661', '193883', '1531' UNION
			SELECT 'Rzgów', 'łódzki wschodni', 'łódzkie', '1677', '3401', '203' UNION
			SELECT 'Sandomierz', 'sandomierski', 'świętokrzyskie', '2869', '23644', '824' UNION
			SELECT 'Sanniki', 'gostyniński', 'mazowieckie', '1176', '1983', '169' UNION
			SELECT 'Sanok', 'sanocki', 'podkarpackie', '3808', '37577', '987' UNION
			SELECT 'Sejny', 'sejneński', 'podlaskie', '449', '5344', '1190' UNION
			SELECT 'Serock', 'legionowski', 'mazowieckie', '1343', '4416', '329' UNION
			SELECT 'Sędziszów', 'jędrzejowski', 'świętokrzyskie', '792', '6484', '819' UNION
			SELECT 'Sędziszów Małopolski', 'ropczycko-sędziszowski', 'podkarpackie', '3699', '12276', '332' UNION
			SELECT 'Sępopol', 'bartoszycki', 'warmińsko-mazurskie', '463', '1964', '424' UNION
			SELECT 'Sępólno Krajeńskie', 'sępoleński', 'kujawsko-pomorskie', '655', '9118', '1392' UNION
			SELECT 'Sianów', 'koszaliński', 'zachodniopomorskie', '1588', '6664', '420' UNION
			SELECT 'Siechnice', 'wrocławski', 'dolnośląskie', '1563', '7892', '505' UNION
			SELECT 'Siedlce', 'Siedlce[a]', 'mazowieckie', '3186', '77872', '2444' UNION
			SELECT 'Siedliszcze', 'chełmski', 'lubelskie', '1316', '1412', '107' UNION
			SELECT 'Siemianowice Śląskie', 'Siemianowice Śląskie[a]', 'śląskie', '2550', '67154', '2633' UNION
			SELECT 'Siemiatycze', 'siemiatycki', 'podlaskie', '3625', '14505', '400' UNION
			SELECT 'Sieniawa', 'przeworski', 'podkarpackie', '674', '2140', '318' UNION
			SELECT 'Sieradz', 'sieradzki', 'łódzkie', '5122', '42267', '825' UNION
			SELECT 'Sieraków', 'międzychodzki', 'wielkopolskie', '1408', '6056', '430' UNION
			SELECT 'Sierpc', 'sierpecki', 'mazowieckie', '1859', '18014', '969' UNION
			SELECT 'Siewierz', 'będziński', 'śląskie', '3866', '5592', '145' UNION
			SELECT 'Skalbmierz', 'kazimierski', 'świętokrzyskie', '713', '1289', '181' UNION
			SELECT 'Skała', 'krakowski', 'małopolskie', '297', '3803', '1280' UNION
			SELECT 'Skarszewy', 'starogardzki', 'pomorskie', '1079', '7023', '651' UNION
			SELECT 'Skaryszew', 'radomski', 'mazowieckie', '2749', '4376', '159' UNION
			SELECT 'Skarżysko-Kamienna', 'skarżyski', 'świętokrzyskie', '6439', '45358', '704' UNION
			SELECT 'Skawina', 'krakowski', 'małopolskie', '2050', '24362', '1188' UNION
			SELECT 'Skępe', 'lipnowski', 'kujawsko-pomorskie', '748', '3603', '482' UNION
			SELECT 'Skierniewice', 'Skierniewice[a]', 'łódzkie', '3460', '48178', '1392' UNION
			SELECT 'Skoczów', 'cieszyński', 'śląskie', '985', '14469', '1469' UNION
			SELECT 'Skoki', 'wągrowiecki', 'wielkopolskie', '1120', '4346', '388' UNION
			SELECT 'Skórcz', 'starogardzki', 'pomorskie', '363', '3611', '995' UNION
			SELECT 'Skwierzyna', 'międzyrzecki', 'lubuskie', '3589', '9698', '270' UNION
			SELECT 'Sława', 'wschowski', 'lubuskie', '1490', '4316', '290' UNION
			SELECT 'Sławków', 'będziński', 'śląskie', '3667', '7043', '192' UNION
			SELECT 'Sławno', 'sławieński', 'zachodniopomorskie', '1583', '12528', '791' UNION
			SELECT 'Słomniki', 'krakowski', 'małopolskie', '343', '4348', '1268' UNION
			SELECT 'Słubice', 'słubicki', 'lubuskie', '1921', '16773', '873' UNION
			SELECT 'Słupca', 'słupecki', 'wielkopolskie', '1030', '13773', '1337' UNION
			SELECT 'Słupsk', 'Słupsk[a]', 'pomorskie', '4315', '91007', '2109' UNION
			SELECT 'Sobótka', 'wrocławski', 'dolnośląskie', '3220', '6957', '216' UNION
			SELECT 'Sochaczew', 'sochaczewski', 'mazowieckie', '2619', '36462', '1392' UNION
			SELECT 'Sokołów Małopolski', 'rzeszowski', 'podkarpackie', '1554', '4165', '268' UNION
			SELECT 'Sokołów Podlaski', 'sokołowski', 'mazowieckie', '1751', '18939', '1082' UNION
			SELECT 'Sokółka', 'sokólski', 'podlaskie', '1859', '18210', '980' UNION
			SELECT 'Solec Kujawski', 'bydgoski', 'kujawsko-pomorskie', '1868', '15641', '837' UNION
			SELECT 'Sompolno', 'koniński', 'wielkopolskie', '621', '3552', '572' UNION
			SELECT 'Sopot', 'Sopot[a]', 'pomorskie', '1728', '36046', '2086' UNION
			SELECT 'Sosnowiec', 'Sosnowiec[a]', 'śląskie', '9106', '202036', '2219' UNION
			SELECT 'Sośnicowice', 'gliwicki', 'śląskie', '1167', '1906', '163' UNION
			SELECT 'Stalowa Wola', 'stalowowolski', 'podkarpackie', '8252', '61182', '741' UNION
			SELECT 'Starachowice', 'starachowicki', 'świętokrzyskie', '3182', '48965', '1539' UNION
			SELECT 'Stargard', 'stargardzki', 'zachodniopomorskie', '4808', '67938', '1413' UNION
			SELECT 'Starogard Gdański', 'starogardzki', 'pomorskie', '2528', '47776', '1890' UNION
			SELECT 'Stary Sącz', 'nowosądecki', 'małopolskie', '1500', '9048', '603' UNION
			SELECT 'Staszów', 'staszowski', 'świętokrzyskie', '2688', '14810', '551' UNION
			SELECT 'Stawiski', 'kolneński', 'podlaskie', '1324', '2195', '166' UNION
			SELECT 'Stawiszyn', 'kaliski', 'wielkopolskie', '99', '1526', '1541' UNION
			SELECT 'Stąporków', 'konecki', 'świętokrzyskie', '1094', '5679', '519' UNION
			SELECT 'Stepnica', 'goleniowski', 'zachodniopomorskie', '340', '2471', '727' UNION
			SELECT 'Stęszew', 'poznański', 'wielkopolskie', '569', '5931', '1042' UNION
			SELECT 'Stoczek Łukowski', 'łukowski', 'lubelskie', '915', '2536', '277' UNION
			SELECT 'Stopnica', 'buski', 'świętokrzyskie', '455', '1425', '313' UNION
			SELECT 'Stronie Śląskie', 'kłodzki', 'dolnośląskie', '238', '5741', '2412' UNION
			SELECT 'Strumień', 'cieszyński', 'śląskie', '629', '3680', '585' UNION
			SELECT 'Stryków', 'zgierski', 'łódzkie', '815', '3494', '429' UNION
			SELECT 'Strzegom', 'świdnicki', 'dolnośląskie', '2049', '16153', '788' UNION
			SELECT 'Strzelce Krajeńskie', 'strzelecko-drezdenecki', 'lubuskie', '554', '9969', '1799' UNION
			SELECT 'Strzelce Opolskie', 'strzelecki', 'opolskie', '2997', '17982', '600' UNION
			SELECT 'Strzelin', 'strzeliński', 'dolnośląskie', '1034', '12435', '1203' UNION
			SELECT 'Strzelno', 'mogileński', 'kujawsko-pomorskie', '446', '5663', '1270' UNION
			SELECT 'Strzyżów', 'strzyżowski', 'podkarpackie', '1389', '8902', '641' UNION
			SELECT 'Sucha Beskidzka', 'suski', 'małopolskie', '2765', '9165', '331' UNION
			SELECT 'Suchań', 'stargardzki', 'zachodniopomorskie', '357', '1477', '414' UNION
			SELECT 'Suchedniów', 'skarżyski', 'świętokrzyskie', '5940', '8379', '141' UNION
			SELECT 'Suchowola', 'sokólski', 'podlaskie', '2595', '2180', '84' UNION
			SELECT 'Sulechów', 'zielonogórski', 'lubuskie', '688', '16925', '2460' UNION
			SELECT 'Sulejów', 'piotrkowski', 'łódzkie', '2626', '6204', '236' UNION
			SELECT 'Sulejówek', 'miński', 'mazowieckie', '1931', '19714', '1021' UNION
			SELECT 'Sulęcin', 'sulęciński', 'lubuskie', '856', '10157', '1187' UNION
			SELECT 'Sulmierzyce', 'krotoszyński', 'wielkopolskie', '2929', '2887', '99' UNION
			SELECT 'Sułkowice', 'myślenicki', 'małopolskie', '1646', '6633', '403' UNION
			SELECT 'Supraśl', 'białostocki', 'podlaskie', '569', '4622', '812' UNION
			SELECT 'Suraż', 'białostocki', 'podlaskie', '3386', '988', '29' UNION
			SELECT 'Susz', 'iławski', 'warmińsko-mazurskie', '667', '5571', '835' UNION
			SELECT 'Suwałki', 'Suwałki[a]', 'podlaskie', '6551', '69827', '1066' UNION
			SELECT 'Swarzędz', 'poznański', 'wielkopolskie', '823', '30433', '3698' UNION
			SELECT 'Syców', 'oleśnicki', 'dolnośląskie', '1705', '10420', '611' UNION
			SELECT 'Szadek', 'zduńskowolski', 'łódzkie', '1793', '1917', '107' UNION
			SELECT 'Szamocin', 'chodzieski', 'wielkopolskie', '467', '4222', '904' UNION
			SELECT 'Szamotuły', 'szamotulski', 'wielkopolskie', '1108', '18776', '1695' UNION
			SELECT 'Szczawnica', 'nowotarski', 'małopolskie', '3290', '5776', '176' UNION
			SELECT 'Szczawno-Zdrój', 'wałbrzyski', 'dolnośląskie', '1474', '5608', '380' UNION
			SELECT 'Szczebrzeszyn', 'zamojski', 'lubelskie', '2912', '5040', '173' UNION
			SELECT 'Szczecin', 'Szczecin[a]', 'zachodniopomorskie', '30060', '402465', '1339' UNION
			SELECT 'Szczecinek', 'szczecinecki', 'zachodniopomorskie', '4848', '40114', '827' UNION
			SELECT 'Szczekociny', 'zawierciański', 'śląskie', '1803', '3622', '201' UNION
			SELECT 'Szczucin', 'dąbrowski', 'małopolskie', '685', '4173', '609' UNION
			SELECT 'Szczuczyn', 'grajewski', 'podlaskie', '1323', '3394', '257' UNION
			SELECT 'Szczyrk', 'bielski', 'śląskie', '3907', '5747', '147' UNION
			SELECT 'Szczytna', 'kłodzki', 'dolnośląskie', '8038', '5163', '64' UNION
			SELECT 'Szczytno', 'szczycieński', 'warmińsko-mazurskie', '1062', '23343', '2198' UNION
			SELECT 'Szepietowo', 'wysokomazowiecki', 'podlaskie', '196', '2171', '1108' UNION
			SELECT 'Szklarska Poręba', 'jeleniogórski', 'dolnośląskie', '7544', '6611', '88' UNION
			SELECT 'Szlichtyngowa', 'wschowski', 'lubuskie', '155', '1288', '831' UNION
			SELECT 'Szprotawa', 'żagański', 'lubuskie', '1095', '11912', '1088' UNION
			SELECT 'Sztum', 'sztumski', 'pomorskie', '459', '9990', '2176' UNION
			SELECT 'Szubin', 'nakielski', 'kujawsko-pomorskie', '765', '9576', '1252' UNION
			SELECT 'Szydłowiec', 'szydłowiecki', 'mazowieckie', '2189', '11779', '538' UNION
			SELECT 'Szydłów', 'staszowski', 'świętokrzyskie', '1621', '1106', '68' UNION
			SELECT 'Ścinawa', 'lubiński', 'dolnośląskie', '1354', '5589', '413' UNION
			SELECT 'Ślesin', 'koniński', 'wielkopolskie', '718', '3151', '439' UNION
			SELECT 'Śmigiel', 'kościański', 'wielkopolskie', '530', '5703', '1076' UNION
			SELECT 'Śrem', 'śremski', 'wielkopolskie', '1237', '29714', '2402' UNION
			SELECT 'Środa Śląska', 'średzki', 'dolnośląskie', '1494', '9484', '635' UNION
			SELECT 'Środa Wielkopolska', 'średzki', 'wielkopolskie', '2192', '23312', '1064' UNION
			SELECT 'Świątniki Górne', 'krakowski', 'małopolskie', '444', '2415', '544' UNION
			SELECT 'Świdnica', 'świdnicki', 'dolnośląskie', '2176', '57310', '2634' UNION
			SELECT 'Świdnik', 'świdnicki', 'lubelskie', '2035', '39312', '1932' UNION
			SELECT 'Świdwin', 'świdwiński', 'zachodniopomorskie', '2238', '15594', '697' UNION
			SELECT 'Świebodzice', 'świdnicki', 'dolnośląskie', '3043', '22830', '750' UNION
			SELECT 'Świebodzin', 'świebodziński', 'lubuskie', '1693', '21763', '1285' UNION
			SELECT 'Świecie', 'świecki', 'kujawsko-pomorskie', '1187', '25831', '2176' UNION
			SELECT 'Świeradów-Zdrój', 'lubański', 'dolnośląskie', '2072', '4183', '202' UNION
			SELECT 'Świerzawa', 'złotoryjski', 'dolnośląskie', '176', '2291', '1302' UNION
			SELECT 'Świętochłowice', 'Świętochłowice[a]', 'śląskie', '1331', '50012', '3757' UNION
			SELECT 'Świnoujście', 'Świnoujście[a]', 'zachodniopomorskie', '20207', '40910', '202' UNION
			SELECT 'Tarczyn', 'piaseczyński', 'mazowieckie', '523', '4129', '789' UNION
			SELECT 'Tarnobrzeg', 'Tarnobrzeg[a]', 'podkarpackie', '8540', '47047', '551' UNION
			SELECT 'Tarnogród', 'biłgorajski', 'lubelskie', '1069', '3351', '313' UNION
			SELECT 'Tarnowskie Góry', 'tarnogórski', 'śląskie', '8388', '61361', '732' UNION
			SELECT 'Tarnów', 'Tarnów[a]', 'małopolskie', '7238', '109062', '1507' UNION
			SELECT 'Tczew', 'tczewski', 'pomorskie', '2238', '60279', '2693' UNION
			SELECT 'Terespol', 'bialski', 'lubelskie', '1011', '5557', '550' UNION
			SELECT 'Tłuszcz', 'wołomiński', 'mazowieckie', '791', '8157', '1031' UNION
			SELECT 'Tolkmicko', 'elbląski', 'warmińsko-mazurskie', '229', '2692', '1176' UNION
			SELECT 'Tomaszów Lubelski', 'tomaszowski', 'lubelskie', '1329', '19198', '1445' UNION
			SELECT 'Tomaszów Mazowiecki', 'tomaszowski', 'łódzkie', '4130', '62649', '1517' UNION
			SELECT 'Toruń', 'Toruń[a]', 'kujawsko-pomorskie', '11572', '202074', '1746' UNION
			SELECT 'Torzym', 'sulęciński', 'lubuskie', '911', '2524', '277' UNION
			SELECT 'Toszek', 'gliwicki', 'śląskie', '971', '3595', '370' UNION
			SELECT 'Trzcianka', 'czarnkowsko-trzcianecki', 'wielkopolskie', '1830', '17197', '940' UNION
			SELECT 'Trzciel', 'międzyrzecki', 'lubuskie', '304', '2389', '786' UNION
			SELECT 'Trzcińsko-Zdrój', 'gryfiński', 'zachodniopomorskie', '233', '2273', '976' UNION
			SELECT 'Trzebiatów', 'gryficki', 'zachodniopomorskie', '1025', '10009', '976' UNION
			SELECT 'Trzebinia', 'chrzanowski', 'małopolskie', '3194', '19846', '621' UNION
			SELECT 'Trzebnica', 'trzebnicki', 'dolnośląskie', '1061', '13322', '1256' UNION
			SELECT 'Trzemeszno', 'gnieźnieński', 'wielkopolskie', '546', '7670', '1405' UNION
			SELECT 'Tuchola', 'tucholski', 'kujawsko-pomorskie', '1769', '13680', '773' UNION
			SELECT 'Tuchów', 'tarnowski', 'małopolskie', '1810', '6671', '369' UNION
			SELECT 'Tuczno', 'wałecki', 'zachodniopomorskie', '921', '1916', '208' UNION
			SELECT 'Tuliszków', 'turecki', 'wielkopolskie', '700', '3270', '467' UNION
			SELECT 'Tułowice', 'opolski', 'opolskie', '923', '3998', '433' UNION
			SELECT 'Turek', 'turecki', 'wielkopolskie', '1617', '27109', '1676' UNION
			SELECT 'Tuszyn', 'łódzki wschodni', 'łódzkie', '2325', '7292', '314' UNION
			SELECT 'Twardogóra', 'oleśnicki', 'dolnośląskie', '829', '6716', '810' UNION
			SELECT 'Tychowo', 'białogardzki', 'zachodniopomorskie', '396', '2517', '636' UNION
			SELECT 'Tychy', 'Tychy[a]', 'śląskie', '8181', '127831', '1563' UNION
			SELECT 'Tyczyn', 'rzeszowski', 'podkarpackie', '967', '3816', '395' UNION
			SELECT 'Tykocin', 'białostocki', 'podlaskie', '2897', '1975', '68' UNION
			SELECT 'Tyszowce', 'tomaszowski', 'lubelskie', '1852', '2132', '115' UNION
			SELECT 'Ujazd', 'strzelecki', 'opolskie', '1476', '1774', '120' UNION
			SELECT 'Ujście', 'pilski', 'wielkopolskie', '578', '3697', '640' UNION
			SELECT 'Ulanów', 'niżański', 'podkarpackie', '820', '1424', '174' UNION
			SELECT 'Uniejów', 'poddębicki', 'łódzkie', '1223', '2984', '244' UNION
			SELECT 'Urzędów', 'kraśnicki', 'lubelskie', '1291', '1709', '132' UNION
			SELECT 'Ustka', 'słupski', 'pomorskie', '1019', '15527', '1524' UNION
			SELECT 'Ustroń', 'cieszyński', 'śląskie', '5903', '16054', '272' UNION
			SELECT 'Ustrzyki Dolne', 'bieszczadzki', 'podkarpackie', '1679', '9132', '544' UNION
			SELECT 'Wadowice', 'wadowicki', 'małopolskie', '1054', '18774', '1781' UNION
			SELECT 'Wałbrzych', 'Wałbrzych[a]', 'dolnośląskie', '8470', '112594', '1329' UNION
			SELECT 'Wałcz', 'wałecki', 'zachodniopomorskie', '3817', '25359', '664' UNION
			SELECT 'Warka', 'grójecki', 'mazowieckie', '2677', '11926', '445' UNION
			SELECT 'Warszawa', 'm.st. Warszawa[a]', 'mazowieckie', '51724', '1777972', '3437' UNION
			SELECT 'Warta', 'sieradzki', 'łódzkie', '1085', '3263', '301' UNION
			SELECT 'Wasilków', 'białostocki', 'podlaskie', '2826', '11384', '403' UNION
			SELECT 'Wąbrzeźno', 'wąbrzeski', 'kujawsko-pomorskie', '853', '13605', '1595' UNION
			SELECT 'Wąchock', 'starachowicki', 'świętokrzyskie', '1602', '2764', '173' UNION
			SELECT 'Wągrowiec', 'wągrowiecki', 'wielkopolskie', '1783', '25648', '1438' UNION
			SELECT 'Wąsosz', 'górowski', 'dolnośląskie', '324', '2672', '825' UNION
			SELECT 'Wejherowo', 'wejherowski', 'pomorskie', '2699', '49789', '1845' UNION
			SELECT 'Węgliniec', 'zgorzelecki', 'dolnośląskie', '873', '2860', '328' UNION
			SELECT 'Węgorzewo', 'węgorzewski', 'warmińsko-mazurskie', '1088', '11341', '1042' UNION
			SELECT 'Węgorzyno', 'łobeski', 'zachodniopomorskie', '685', '2831', '413' UNION
			SELECT 'Węgrów', 'węgrowski', 'mazowieckie', '3551', '12672', '357' UNION
			SELECT 'Wiązów', 'strzeliński', 'dolnośląskie', '916', '2257', '246' UNION
			SELECT 'Wielbark', 'szczycieński', 'warmińsko-mazurskie', '1842', '3049', '166' UNION
			SELECT 'Wieleń', 'czarnkowsko-trzcianecki', 'wielkopolskie', '446', '5919', '1327' UNION
			SELECT 'Wielichowo', 'grodziski', 'wielkopolskie', '124', '1767', '1425' UNION
			SELECT 'Wieliczka', 'wielicki', 'małopolskie', '1341', '23395', '1745' UNION
			SELECT 'Wieluń', 'wieluński', 'łódzkie', '1687', '22521', '1335' UNION
			SELECT 'Wieruszów', 'wieruszowski', 'łódzkie', '597', '8568', '1435' UNION
			SELECT 'Więcbork', 'sępoleński', 'kujawsko-pomorskie', '431', '5966', '1384' UNION
			SELECT 'Wilamowice', 'bielski', 'śląskie', '1036', '3086', '298' UNION
			SELECT 'Wisła', 'cieszyński', 'śląskie', '11017', '11171', '101' UNION
			SELECT 'Wiślica', 'buski', 'świętokrzyskie', '471', '515', '109' UNION
			SELECT 'Witkowo', 'gnieźnieński', 'wielkopolskie', '831', '7893', '950' UNION
			SELECT 'Witnica', 'gorzowski', 'lubuskie', '824', '6763', '821' UNION
			SELECT 'Wleń', 'lwówecki', 'dolnośląskie', '722', '1778', '246' UNION
			SELECT 'Władysławowo', 'pucki', 'pomorskie', '1367', '9958', '728' UNION
			SELECT 'Włocławek', 'Włocławek[a]', 'kujawsko-pomorskie', '8432', '110802', '1314' UNION
			SELECT 'Włodawa', 'włodawski', 'lubelskie', '1797', '13220', '736' UNION
			SELECT 'Włoszczowa', 'włoszczowski', 'świętokrzyskie', '3030', '10043', '331' UNION
			SELECT 'Wodzisław Śląski', 'wodzisławski', 'śląskie', '4951', '48143', '972' UNION
			SELECT 'Wojcieszów', 'złotoryjski', 'dolnośląskie', '3217', '3676', '114' UNION
			SELECT 'Wojkowice', 'będziński', 'śląskie', '1279', '8936', '699' UNION
			SELECT 'Wojnicz', 'tarnowski', 'małopolskie', '850', '3330', '392' UNION
			SELECT 'Wolbórz', 'piotrkowski', 'łódzkie', '1518', '2337', '154' UNION
			SELECT 'Wolbrom', 'olkuski', 'małopolskie', '1012', '8604', '850' UNION
			SELECT 'Wolin', 'kamieński', 'zachodniopomorskie', '1447', '4828', '334' UNION
			SELECT 'Wolsztyn', 'wolsztyński', 'wielkopolskie', '478', '13183', '2758' UNION
			SELECT 'Wołczyn', 'kluczborski', 'opolskie', '747', '5921', '793' UNION
			SELECT 'Wołomin', 'wołomiński', 'mazowieckie', '1724', '37138', '2154' UNION
			SELECT 'Wołów', 'wołowski', 'dolnośląskie', '1854', '12425', '670' UNION
			SELECT 'Woźniki', 'lubliniecki', 'śląskie', '7101', '4338', '61' UNION
			SELECT 'Wrocław', 'Wrocław[a]', 'dolnośląskie', '29282', '640648', '2188' UNION
			SELECT 'Wronki', 'szamotulski', 'wielkopolskie', '581', '11199', '1928' UNION
			SELECT 'Września', 'wrzesiński', 'wielkopolskie', '1273', '30558', '2400' UNION
			SELECT 'Wschowa', 'wschowski', 'lubuskie', '925', '13953', '1508' UNION
			SELECT 'Wyrzysk', 'pilski', 'wielkopolskie', '412', '5139', '1247' UNION
			SELECT 'Wysoka', 'pilski', 'wielkopolskie', '482', '2647', '549' UNION
			SELECT 'Wysokie Mazowieckie', 'wysokomazowiecki', 'podlaskie', '1524', '9414', '618' UNION
			SELECT 'Wyszków', 'wyszkowski', 'mazowieckie', '2078', '26890', '1294' UNION
			SELECT 'Wyszogród', 'płocki', 'mazowieckie', '1297', '2618', '202' UNION
			SELECT 'Wyśmierzyce', 'białobrzeski', 'mazowieckie', '1684', '886', '53' UNION
			SELECT 'Zabłudów', 'białostocki', 'podlaskie', '1430', '2464', '172' UNION
			SELECT 'Zabrze', 'Zabrze[a]', 'śląskie', '8040', '173374', '2156' UNION
			SELECT 'Zagórów', 'słupecki', 'wielkopolskie', '344', '3005', '874' UNION
			SELECT 'Zagórz', 'sanocki', 'podkarpackie', '2229', '5120', '230' UNION
			SELECT 'Zakliczyn', 'tarnowski', 'małopolskie', '402', '1642', '408' UNION
			SELECT 'Zaklików', 'stalowowolski', 'podkarpackie', '1142', '3013', '264' UNION
			SELECT 'Zakopane', 'tatrzański', 'małopolskie', '8426', '27191', '323' UNION
			SELECT 'Zakroczym', 'nowodworski', 'mazowieckie', '1997', '3210', '161' UNION
			SELECT 'Zalewo', 'iławski', 'warmińsko-mazurskie', '822', '2165', '263' UNION
			SELECT 'Zambrów', 'zambrowski', 'podlaskie', '1902', '22166', '1165' UNION
			SELECT 'Zamość', 'Zamość[a]', 'lubelskie', '3034', '63813', '2103' UNION
			SELECT 'Zator', 'oświęcimski', 'małopolskie', '1152', '3698', '321' UNION
			SELECT 'Zawadzkie', 'strzelecki', 'opolskie', '1646', '7168', '435' UNION
			SELECT 'Zawichost', 'sandomierski', 'świętokrzyskie', '2029', '1776', '88' UNION
			SELECT 'Zawidów', 'zgorzelecki', 'dolnośląskie', '607', '4217', '695' UNION
			SELECT 'Zawiercie', 'zawierciański', 'śląskie', '8525', '49567', '581' UNION
			SELECT 'Ząbki', 'wołomiński', 'mazowieckie', '1098', '36706', '3343' UNION
			SELECT 'Ząbkowice Śląskie', 'ząbkowicki', 'dolnośląskie', '1367', '15072', '1103' UNION
			SELECT 'Zbąszynek', 'świebodziński', 'lubuskie', '358', '5021', '1403' UNION
			SELECT 'Zbąszyń', 'nowotomyski', 'wielkopolskie', '542', '7278', '1343' UNION
			SELECT 'Zduny', 'krotoszyński', 'wielkopolskie', '620', '4534', '731' UNION
			SELECT 'Zduńska Wola', 'zduńskowolski', 'łódzkie', '2457', '42094', '1713' UNION
			SELECT 'Zdzieszowice', 'krapkowicki', 'opolskie', '1235', '11471', '929' UNION
			SELECT 'Zelów', 'bełchatowski', 'łódzkie', '1075', '7636', '710' UNION
			SELECT 'Zgierz', 'zgierski', 'łódzkie', '4233', '56529', '1335' UNION
			SELECT 'Zgorzelec', 'zgorzelecki', 'dolnośląskie', '1588', '30521', '1922' UNION
			SELECT 'Zielona Góra', 'Zielona Góra[a]', 'lubuskie', '27832', '140297', '504' UNION
			SELECT 'Zielonka', 'wołomiński', 'mazowieckie', '7948', '17589', '221' UNION
			SELECT 'Ziębice', 'ząbkowicki', 'dolnośląskie', '1507', '8759', '581' UNION
			SELECT 'Złocieniec', 'drawski', 'zachodniopomorskie', '3228', '12950', '401' UNION
			SELECT 'Złoczew', 'sieradzki', 'łódzkie', '1379', '3384', '245' UNION
			SELECT 'Złotoryja', 'złotoryjski', 'dolnośląskie', '1151', '15655', '1360' UNION
			SELECT 'Złotów', 'złotowski', 'wielkopolskie', '1158', '18446', '1593' UNION
			SELECT 'Złoty Stok', 'ząbkowicki', 'dolnośląskie', '773', '2787', '361' UNION
			SELECT 'Zwierzyniec', 'zamojski', 'lubelskie', '619', '3194', '516' UNION
			SELECT 'Zwoleń', 'zwoleński', 'mazowieckie', '1591', '7737', '486' UNION
			SELECT 'Żabno', 'tarnowski', 'małopolskie', '1113', '4248', '382' UNION
			SELECT 'Żagań', 'żagański', 'lubuskie', '4038', '25812', '639' UNION
			SELECT 'Żarki', 'myszkowski', 'śląskie', '2544', '4568', '180' UNION
			SELECT 'Żarów', 'świdnicki', 'dolnośląskie', '757', '6755', '892' UNION
			SELECT 'Żary', 'żarski', 'lubuskie', '3349', '37682', '1125' UNION
			SELECT 'Żelechów', 'garwoliński', 'mazowieckie', '1213', '3995', '329' UNION
			SELECT 'Żerków', 'jarociński', 'wielkopolskie', '216', '2132', '987' UNION
			SELECT 'Żmigród', 'trzebnicki', 'dolnośląskie', '949', '6449', '680' UNION
			SELECT 'Żnin', 'żniński', 'kujawsko-pomorskie', '835', '13934', '1669' UNION
			SELECT 'Żory', 'Żory[a]', 'śląskie', '6464', '62456', '966' UNION
			SELECT 'Żukowo', 'kartuski', 'pomorskie', '473', '6683', '1413' UNION
			SELECT 'Żuromin', 'żuromiński', 'mazowieckie', '1118', '8901', '796' UNION
			SELECT 'Żychlin', 'kutnowski', 'łódzkie', '868', '8220', '947' UNION
			SELECT 'Żyrardów', 'żyrardowski', 'mazowieckie', '1435', '39992', '2787' UNION
			SELECT 'Żywiec', 'żywiecki', 'śląskie', '5054', '31388', '621' UNION
			SELECT 'Nowy Aleksandrów Kujawski', 'aleksandrowski', 'kujawsko-pomorskie', '723', '12220', '1690' UNION
			SELECT 'Nowy Aleksandrów Łódzki', 'zgierski', 'łódzkie', '1382', '21682', '1569' UNION
			SELECT 'Nowy Alwernia', 'chrzanowski', 'małopolskie', '888', '3370', '380' UNION
			SELECT 'Nowy Andrychów', 'wadowicki', 'małopolskie', '1033', '20260', '1961' UNION
			SELECT 'Nowy Annopol', 'kraśnicki', 'lubelskie', '773', '2528', '327' UNION
			SELECT 'Nowy Augustów', 'augustowski', 'podlaskie', '8090', '30242', '374' UNION
			SELECT 'Nowy Babimost', 'zielonogórski', 'lubuskie', '365', '3927', '1076' UNION
			SELECT 'Nowy Baborów', 'głubczycki', 'opolskie', '1186', '2920', '246' UNION
			SELECT 'Nowy Baranów Sandomierski', 'tarnobrzeski', 'podkarpackie', '915', '1463', '160' UNION
			SELECT 'Nowy Barcin', 'żniński', 'kujawsko-pomorskie', '370', '7468', '2018' UNION
			SELECT 'Nowy Barczewo', 'olsztyński', 'warmińsko-mazurskie', '458', '7535', '1645' UNION
			SELECT 'Nowy Bardo', 'ząbkowicki', 'dolnośląskie', '471', '2563', '544' UNION
			SELECT 'Nowy Barlinek', 'myśliborski', 'zachodniopomorskie', '1755', '13803', '786' UNION
			SELECT 'Nowy Bartoszyce', 'bartoszycki', 'warmińsko-mazurskie', '1179', '23609', '2002' UNION
			SELECT 'Nowy Barwice', 'szczecinecki', 'zachodniopomorskie', '752', '3723', '495' UNION
			SELECT 'Nowy Bełchatów', 'bełchatowski', 'łódzkie', '3464', '57432', '1658' UNION
			SELECT 'Nowy Bełżyce', 'lubelski', 'lubelskie', '2346', '6551', '279' UNION
			SELECT 'Nowy Będzin', 'będziński', 'śląskie', '3737', '56804', '1520' UNION
			SELECT 'Nowy Biała', 'prudnicki', 'opolskie', '1472', '2443', '166' UNION
			SELECT 'Nowy Biała Piska', 'piski', 'warmińsko-mazurskie', '324', '4030', '1244' UNION
			SELECT 'Nowy Biała Podlaska', 'Biała Podlaska[a]', 'lubelskie', '4940', '57352', '1161' UNION
			SELECT 'Nowy Biała Rawska', 'rawski', 'łódzkie', '953', '3197', '335' UNION
			SELECT 'Nowy Białobrzegi', 'białobrzeski', 'mazowieckie', '751', '6980', '929' UNION
			SELECT 'Nowy Białogard', 'białogardzki', 'zachodniopomorskie', '2573', '24339', '946' UNION
			SELECT 'Nowy Biały Bór', 'szczecinecki', 'zachodniopomorskie', '1282', '2199', '172' UNION
			SELECT 'Nowy Białystok', 'Białystok[a]', 'podlaskie', '10213', '297459', '2913' UNION
			SELECT 'Nowy Biecz', 'gorlicki', 'małopolskie', '1771', '4599', '260' UNION
			SELECT 'Nowy Bielawa', 'dzierżoniowski', 'dolnośląskie', '3621', '30055', '830' UNION
			SELECT 'Nowy Bielsk Podlaski', 'bielski', 'podlaskie', '2701', '25370', '939' UNION
			SELECT 'Nowy Bielsko-Biała', 'Bielsko-Biała[a]', 'śląskie', '12451', '171259', '1375' UNION
			SELECT 'Nowy Bieruń', 'bieruńsko-lędziński', 'śląskie', '4049', '19605', '484' UNION
			SELECT 'Nowy Bierutów', 'oleśnicki', 'dolnośląskie', '836', '4871', '583' UNION
			SELECT 'Nowy Bieżuń', 'żuromiński', 'mazowieckie', '1207', '1856', '154' UNION
			SELECT 'Nowy Biłgoraj', 'biłgorajski', 'lubelskie', '2110', '26391', '1251' UNION
			SELECT 'Nowy Biskupiec', 'olsztyński', 'warmińsko-mazurskie', '500', '10602', '2120' UNION
			SELECT 'Nowy Bisztynek', 'bartoszycki', 'warmińsko-mazurskie', '216', '2365', '1095' UNION
			SELECT 'Nowy Blachownia', 'częstochowski', 'śląskie', '3666', '9594', '262' UNION
			SELECT 'Nowy Błaszki', 'sieradzki', 'łódzkie', '162', '2122', '1310' UNION
			SELECT 'Nowy Błażowa', 'rzeszowski', 'podkarpackie', '423', '2151', '509' UNION
			SELECT 'Nowy Błonie', 'warszawski zachodni', 'mazowieckie', '909', '12327', '1356' UNION
			SELECT 'Nowy Bobolice', 'koszaliński', 'zachodniopomorskie', '477', '4018', '842' UNION
			SELECT 'Nowy Bobowa', 'gorlicki', 'małopolskie', '718', '3136', '437' UNION
			SELECT 'Nowy Bochnia', 'bocheński', 'małopolskie', '2987', '29922', '1002' UNION
			SELECT 'Nowy Bodzentyn', 'kielecki', 'świętokrzyskie', '865', '2240', '259' UNION
			SELECT 'Nowy Bogatynia', 'zgorzelecki', 'dolnośląskie', '5988', '17559', '293' UNION
			SELECT 'Nowy Boguchwała', 'rzeszowski', 'podkarpackie', '911', '6117', '671' UNION
			SELECT 'Nowy Boguszów-Gorce', 'wałbrzyski', 'dolnośląskie', '2702', '15444', '572' UNION
			SELECT 'Nowy Bojanowo', 'rawicki', 'wielkopolskie', '234', '2923', '1249' UNION
			SELECT 'Nowy Bolesławiec', 'bolesławiecki', 'dolnośląskie', '2357', '38935', '1652' UNION
			SELECT 'Nowy Bolków', 'jaworski', 'dolnośląskie', '768', '5001', '651' UNION
			SELECT 'Nowy Borek Wielkopolski', 'gostyński', 'wielkopolskie', '629', '2526', '402' UNION
			SELECT 'Nowy Borne Sulinowo', 'szczecinecki', 'zachodniopomorskie', '1815', '5090', '280' UNION
			SELECT 'Nowy Braniewo', 'braniewski', 'warmińsko-mazurskie', '1241', '17071', '1376' UNION
			SELECT 'Nowy Brańsk', 'bielski', 'podlaskie', '3243', '3774', '116' UNION
			SELECT 'Nowy Brodnica', 'brodnicki', 'kujawsko-pomorskie', '2315', '28774', '1243' UNION
			SELECT 'Nowy Brok', 'ostrowski', 'mazowieckie', '2806', '1940', '69' UNION
			SELECT 'Nowy Brusy', 'chojnicki', 'pomorskie', '520', '5232', '1006' UNION
			SELECT 'Nowy Brwinów', 'pruszkowski', 'mazowieckie', '1010', '13531', '1340' UNION
			SELECT 'Nowy Brzeg', 'brzeski', 'opolskie', '1461', '35930', '2459' UNION
			SELECT 'Nowy Brzeg Dolny', 'wołowski', 'dolnośląskie', '1720', '12492', '726' UNION
			SELECT 'Nowy Brzesko', 'brzeski', 'małopolskie', '1192', '16825', '1411' UNION
			SELECT 'Nowy Brzeszcze', 'oświęcimski', 'małopolskie', '1904', '11226', '590' UNION
			SELECT 'Nowy Brześć Kujawski', 'włocławski', 'kujawsko-pomorskie', '704', '4659', '662' UNION
			SELECT 'Nowy Brzeziny', 'brzeziński', 'łódzkie', '2158', '12547', '581' UNION
			SELECT 'Nowy Brzostek', 'dębicki', 'podkarpackie', '876', '2742', '313' UNION
			SELECT 'Nowy Brzozów', 'brzozowski', 'podkarpackie', '1146', '7455', '651' UNION
			SELECT 'Nowy Buk', 'poznański', 'wielkopolskie', '296', '6064', '2049' UNION
			SELECT 'Nowy Bukowno', 'olkuski', 'małopolskie', '6459', '10197', '158' UNION
			SELECT 'Nowy Busko-Zdrój', 'buski', 'świętokrzyskie', '1228', '15952', '1299' UNION
			SELECT 'Nowy Bychawa', 'lubelski', 'lubelskie', '669', '4942', '739' UNION
			SELECT 'Nowy Byczyna', 'kluczborski', 'opolskie', '579', '3609', '623' UNION
			SELECT 'Nowy Bydgoszcz', 'Bydgoszcz[a]', 'kujawsko-pomorskie', '17598', '350178', '1990' UNION
			SELECT 'Nowy Bystrzyca Kłodzka', 'kłodzki', 'dolnośląskie', '1074', '10189', '949' UNION
			SELECT 'Nowy Bytom', 'Bytom[a]', 'śląskie', '6944', '166795', '2402' UNION
			SELECT 'Nowy Bytom Odrzański', 'nowosolski', 'lubuskie', '230', '4331', '1883' UNION
			SELECT 'Nowy Bytów', 'bytowski', 'pomorskie', '872', '16954', '1944' UNION
			SELECT 'Nowy Cedynia', 'gryfiński', 'zachodniopomorskie', '167', '1573', '942' UNION
			SELECT 'Nowy Chełm', 'Chełm[a]', 'lubelskie', '3528', '62670', '1776' UNION
			SELECT 'Nowy Chełmek', 'oświęcimski', 'małopolskie', '827', '9061', '1096' UNION
			SELECT 'Nowy Chełmno', 'chełmiński', 'kujawsko-pomorskie', '1356', '19720', '1454' UNION
			SELECT 'Nowy Chełmża', 'toruński', 'kujawsko-pomorskie', '784', '14532', '1854' UNION
			SELECT 'Nowy Chęciny', 'kielecki', 'świętokrzyskie', '1413', '4445', '315' UNION
			SELECT 'Nowy Chmielnik', 'kielecki', 'świętokrzyskie', '780', '3703', '475' UNION
			SELECT 'Nowy Chocianów', 'polkowicki', 'dolnośląskie', '900', '7911', '879' UNION
			SELECT 'Nowy Chociwel', 'stargardzki', 'zachodniopomorskie', '367', '3209', '874' UNION
			SELECT 'Nowy Chocz', 'pleszewski', 'wielkopolskie', '688', '1777', '258' UNION
			SELECT 'Nowy Chodecz', 'włocławski', 'kujawsko-pomorskie', '139', '1899', '1366' UNION
			SELECT 'Nowy Chodzież', 'chodzieski', 'wielkopolskie', '1277', '18684', '1463' UNION
			SELECT 'Nowy Chojna', 'gryfiński', 'zachodniopomorskie', '1258', '7390', '587' UNION
			SELECT 'Nowy Chojnice', 'chojnicki', 'pomorskie', '2104', '39904', '1897' UNION
			SELECT 'Nowy Chojnów', 'legnicki', 'dolnośląskie', '532', '13426', '2524' UNION
			SELECT 'Nowy Choroszcz', 'białostocki', 'podlaskie', '1679', '5867', '349' UNION
			SELECT 'Nowy Chorzele', 'przasnyski', 'mazowieckie', '1751', '3078', '176' UNION
			SELECT 'Nowy Chorzów', 'Chorzów[a]', 'śląskie', '3324', '108434', '3262' UNION
			SELECT 'Nowy Choszczno', 'choszczeński', 'zachodniopomorskie', '958', '15248', '1592' UNION
			SELECT 'Nowy Chrzanów', 'chrzanowski', 'małopolskie', '3832', '36945', '964' UNION
			SELECT 'Nowy Ciechanowiec', 'wysokomazowiecki', 'podlaskie', '1953', '4639', '238' UNION
			SELECT 'Nowy Ciechanów', 'ciechanowski', 'mazowieckie', '3278', '44209', '1349' UNION
			SELECT 'Nowy Ciechocinek', 'aleksandrowski', 'kujawsko-pomorskie', '1526', '10596', '694' UNION
			SELECT 'Nowy Cieszanów', 'lubaczowski', 'podkarpackie', '1506', '1930', '128' UNION
			SELECT 'Nowy Cieszyn', 'cieszyński', 'śląskie', '2861', '34613', '1210' UNION
			SELECT 'Nowy Ciężkowice', 'tarnowski', 'małopolskie', '999', '2469', '247' UNION
			SELECT 'Nowy Cybinka', 'słubicki', 'lubuskie', '529', '2756', '521' UNION
			SELECT 'Nowy Czaplinek', 'drawski', 'zachodniopomorskie', '1362', '7124', '523' UNION
			SELECT 'Nowy Czarna Białostocka', 'białostocki', 'podlaskie', '1428', '9338', '654' UNION
			SELECT 'Nowy Czarna Woda', 'starogardzki', 'pomorskie', '994', '2805', '282' UNION
			SELECT 'Nowy Czarne', 'człuchowski', 'pomorskie', '4643', '5952', '128' UNION
			SELECT 'Nowy Czarnków', 'czarnkowsko-trzcianecki', 'wielkopolskie', '1017', '10735', '1056' UNION
			SELECT 'Nowy Czchów', 'brzeski', 'małopolskie', '1409', '2344', '166' UNION
			SELECT 'Nowy Czechowice-Dziedzice', 'bielski', 'śląskie', '3291', '35919', '1091' UNION
			SELECT 'Nowy Czeladź', 'będziński', 'śląskie', '1638', '31677', '1934' UNION
			SELECT 'Nowy Czempiń', 'kościański', 'wielkopolskie', '332', '5295', '1595' UNION
			SELECT 'Nowy Czerniejewo', 'gnieźnieński', 'wielkopolskie', '1019', '2663', '261' UNION
			SELECT 'Nowy Czersk', 'chojnicki', 'pomorskie', '973', '9912', '1019' UNION
			SELECT 'Nowy Czerwieńsk', 'zielonogórski', 'lubuskie', '936', '4063', '434' UNION
			SELECT 'Nowy Czerwionka-Leszczyny', 'rybnicki', 'śląskie', '3763', '28266', '751' UNION
			SELECT 'Nowy Częstochowa', 'Częstochowa[a]', 'śląskie', '15971', '222292', '1392' UNION
			SELECT 'Nowy Człopa', 'wałecki', 'zachodniopomorskie', '627', '2326', '371' UNION
			SELECT 'Nowy Człuchów', 'człuchowski', 'pomorskie', '1278', '13708', '1073' UNION
			SELECT 'Nowy Czyżew', 'wysokomazowiecki', 'podlaskie', '523', '2641', '505' UNION
			SELECT 'Nowy Ćmielów', 'ostrowiecki', 'świętokrzyskie', '1334', '3024', '227' UNION
			SELECT 'Nowy Daleszyce', 'kielecki', 'świętokrzyskie', '1550', '2907', '188' UNION
			SELECT 'Nowy Darłowo', 'sławieński', 'zachodniopomorskie', '2021', '13759', '681' UNION
			SELECT 'Nowy Dąbie', 'kolski', 'wielkopolskie', '880', '2002', '228' UNION
			SELECT 'Nowy Dąbrowa Białostocka', 'sokólski', 'podlaskie', '2264', '5553', '245' UNION
			SELECT 'Nowy Dąbrowa Górnicza', 'Dąbrowa Górnicza[a]', 'śląskie', '18873', '120259', '637' UNION
			SELECT 'Nowy Dąbrowa Tarnowska', 'dąbrowski', 'małopolskie', '2307', '11906', '516' UNION
			SELECT 'Nowy Debrzno', 'człuchowski', 'pomorskie', '751', '5102', '679' UNION
			SELECT 'Nowy Dębica', 'dębicki', 'podkarpackie', '3383', '45817', '1354' UNION
			SELECT 'Nowy Dęblin', 'rycki', 'lubelskie', '3833', '16149', '421' UNION
			SELECT 'Nowy Dębno', 'myśliborski', 'zachodniopomorskie', '1951', '13843', '710' UNION
			SELECT 'Nowy Dobczyce', 'myślenicki', 'małopolskie', '1297', '6434', '496' UNION
			SELECT 'Nowy Dobiegniew', 'strzelecko-drezdenecki', 'lubuskie', '569', '3088', '543' UNION
			SELECT 'Nowy Dobra', 'łobeski', 'zachodniopomorskie', '237', '2326', '981' UNION
			SELECT 'Nowy Dobra', 'turecki', 'wielkopolskie', '184', '1387', '754' UNION
			SELECT 'Nowy Dobre Miasto', 'olsztyński', 'warmińsko-mazurskie', '486', '10239', '2107' UNION
			SELECT 'Nowy Dobrodzień', 'oleski', 'opolskie', '1953', '3722', '191' UNION
			SELECT 'Nowy Dobrzany', 'stargardzki', 'zachodniopomorskie', '534', '2264', '424' UNION
			SELECT 'Nowy Dobrzyca', 'pleszewski', 'wielkopolskie', '1970', '3128', '159' UNION
			SELECT 'Nowy Dobrzyń nad Wisłą', 'lipnowski', 'kujawsko-pomorskie', '541', '2139', '395' UNION
			SELECT 'Nowy Dolsk', 'śremski', 'wielkopolskie', '620', '1560', '252' UNION
			SELECT 'Nowy Drawno', 'choszczeński', 'zachodniopomorskie', '503', '2290', '455' UNION
			SELECT 'Nowy Drawsko Pomorskie', 'drawski', 'zachodniopomorskie', '2233', '11657', '522' UNION
			SELECT 'Nowy Drezdenko', 'strzelecko-drezdenecki', 'lubuskie', '1072', '10182', '950' UNION
			SELECT 'Nowy Drobin', 'płocki', 'mazowieckie', '965', '2889', '299' UNION
			SELECT 'Nowy Drohiczyn', 'siemiatycki', 'podlaskie', '1569', '1987', '127' UNION
			SELECT 'Nowy Drzewica', 'opoczyński', 'łódzkie', '481', '3844', '799' UNION
			SELECT 'Nowy Dukla', 'krośnieński', 'podkarpackie', '548', '2083', '380' UNION
			SELECT 'Nowy Duszniki-Zdrój', 'kłodzki', 'dolnośląskie', '2228', '4629', '208' UNION
			SELECT 'Nowy Dynów', 'rzeszowski', 'podkarpackie', '2455', '6138', '250' UNION
			SELECT 'Nowy Działdowo', 'działdowski', 'warmińsko-mazurskie', '1147', '21275', '1855' UNION
			SELECT 'Nowy Działoszyce', 'pińczowski', 'świętokrzyskie', '192', '908', '473' UNION
			SELECT 'Nowy Działoszyn', 'pajęczański', 'łódzkie', '494', '5922', '1199' UNION
			SELECT 'Nowy Dzierzgoń', 'sztumski', 'pomorskie', '390', '5367', '1376' UNION
			SELECT 'Nowy Dzierżoniów', 'dzierżoniowski', 'dolnośląskie', '2007', '33344', '1661' UNION
			SELECT 'Nowy Dziwnów', 'kamieński', 'zachodniopomorskie', '652', '2698', '414' UNION
			SELECT 'Nowy Elbląg', 'Elbląg[a]', 'warmińsko-mazurskie', '7982', '120142', '1505' UNION
			SELECT 'Nowy Ełk', 'ełcki', 'warmińsko-mazurskie', '2105', '61928', '2942' UNION
			SELECT 'Nowy Frampol', 'biłgorajski', 'lubelskie', '467', '1437', '308' UNION
			SELECT 'Nowy Frombork', 'braniewski', 'warmińsko-mazurskie', '759', '2355', '310' UNION
			SELECT 'Nowy Garwolin', 'garwoliński', 'mazowieckie', '2208', '17494', '792' UNION
			SELECT 'Nowy Gąbin', 'płocki', 'mazowieckie', '2795', '4114', '147' UNION
			SELECT 'Nowy Gdańsk', 'Gdańsk[a]', 'pomorskie', '26196', '466631', '1781' UNION
			SELECT 'Nowy Gdynia', 'Gdynia[a]', 'pomorskie', '13514', '246309', '1823' UNION
			SELECT 'Nowy Giżycko', 'giżycki', 'warmińsko-mazurskie', '1372', '29396', '2143' UNION
			SELECT 'Nowy Glinojeck', 'ciechanowski', 'mazowieckie', '737', '3017', '409' UNION
			SELECT 'Nowy Gliwice', 'Gliwice[a]', 'śląskie', '13388', '179806', '1343' UNION
			SELECT 'Nowy Głogów', 'głogowski', 'dolnośląskie', '3511', '67615', '1926' UNION
			SELECT 'Nowy Głogów Małopolski', 'rzeszowski', 'podkarpackie', '1371', '6568', '479' UNION
			SELECT 'Nowy Głogówek', 'prudnicki', 'opolskie', '2206', '5604', '254' UNION
			SELECT 'Nowy Głowno', 'zgierski', 'łódzkie', '1984', '14291', '720' UNION
			SELECT 'Nowy Głubczyce', 'głubczycki', 'opolskie', '1254', '12596', '1004' UNION
			SELECT 'Nowy Głuchołazy', 'nyski', 'opolskie', '683', '13585', '1989' UNION
			SELECT 'Nowy Głuszyca', 'wałbrzyski', 'dolnośląskie', '1621', '6381', '394' UNION
			SELECT 'Nowy Gniew', 'tczewski', 'pomorskie', '604', '6761', '1119' UNION
			SELECT 'Nowy Gniewkowo', 'inowrocławski', 'kujawsko-pomorskie', '918', '7141', '778' UNION
			SELECT 'Nowy Gniezno', 'gnieźnieński', 'wielkopolskie', '4060', '68479', '1687' UNION
			SELECT 'Nowy Gogolin', 'krapkowicki', 'opolskie', '2035', '6661', '327' UNION
			SELECT 'Nowy Golczewo', 'kamieński', 'zachodniopomorskie', '742', '2673', '360' UNION
			SELECT 'Nowy Goleniów', 'goleniowski', 'zachodniopomorskie', '1178', '22403', '1902' UNION
			SELECT 'Nowy Golina', 'koniński', 'wielkopolskie', '352', '4503', '1279' UNION
			SELECT 'Nowy Golub-Dobrzyń', 'golubsko-dobrzyński', 'kujawsko-pomorskie', '750', '12630', '1684' UNION
			SELECT 'Nowy Gołańcz', 'wągrowiecki', 'wielkopolskie', '1264', '3336', '264' UNION
			SELECT 'Nowy Gołdap', 'gołdapski', 'warmińsko-mazurskie', '1720', '13735', '799' UNION
			SELECT 'Nowy Goniądz', 'moniecki', 'podlaskie', '428', '1813', '424' UNION
			SELECT 'Nowy Gorlice', 'gorlicki', 'małopolskie', '2353', '27597', '1173' UNION
			SELECT 'Nowy Gorzów Śląski', 'oleski', 'opolskie', '1854', '2452', '132' UNION
			SELECT 'Nowy Gorzów Wielkopolski', 'Gorzów Wielkopolski[a]', 'lubuskie', '8572', '123921', '1446' UNION
			SELECT 'Nowy Gostynin', 'gostyniński', 'mazowieckie', '3240', '18647', '576' UNION
			SELECT 'Nowy Gostyń', 'gostyński', 'wielkopolskie', '1109', '20192', '1821' UNION
			SELECT 'Nowy Gościno', 'kołobrzeski', 'zachodniopomorskie', '570', '2417', '424' UNION
			SELECT 'Nowy Gozdnica', 'żagański', 'lubuskie', '2392', '3061', '128' UNION
			SELECT 'Nowy Góra', 'górowski', 'dolnośląskie', '1365', '11859', '869' UNION
			SELECT 'Nowy Góra Kalwaria', 'piaseczyński', 'mazowieckie', '1367', '12009', '878' UNION
			SELECT 'Nowy Górowo Iławeckie', 'bartoszycki', 'warmińsko-mazurskie', '332', '3974', '1197' UNION
			SELECT 'Nowy Górzno', 'brodnicki', 'kujawsko-pomorskie', '343', '1370', '399' UNION
			SELECT 'Nowy Grabów nad Prosną', 'ostrzeszowski', 'wielkopolskie', '258', '1940', '752' UNION
			SELECT 'Nowy Grajewo', 'grajewski', 'podlaskie', '1894', '21935', '1158' UNION
			SELECT 'Nowy Grodków', 'brzeski', 'opolskie', '988', '8667', '877' UNION
			SELECT 'Nowy Grodzisk Mazowiecki', 'grodziski', 'mazowieckie', '1319', '31505', '2389' UNION
			SELECT 'Nowy Grodzisk Wielkopolski', 'grodziski', 'wielkopolskie', '1821', '14633', '804' UNION
			SELECT 'Nowy Grójec', 'grójecki', 'mazowieckie', '857', '16707', '1949' UNION
			SELECT 'Nowy Grudziądz', 'Grudziądz[a]', 'kujawsko-pomorskie', '5776', '95045', '1646' UNION
			SELECT 'Nowy Grybów', 'nowosądecki', 'małopolskie', '1695', '6038', '356' UNION
			SELECT 'Nowy Gryfice', 'gryficki', 'zachodniopomorskie', '1240', '16527', '1333' UNION
			SELECT 'Nowy Gryfino', 'gryfiński', 'zachodniopomorskie', '1181', '21274', '1801' UNION
			SELECT 'Nowy Gryfów Śląski', 'lwówecki', 'dolnośląskie', '663', '6641', '1002' UNION
			SELECT 'Nowy Gubin', 'krośnieński', 'lubuskie', '2068', '16687', '807' UNION
			SELECT 'Nowy Hajnówka', 'hajnowski', 'podlaskie', '2129', '20690', '972' UNION
			SELECT 'Nowy Halinów', 'miński', 'mazowieckie', '284', '3739', '1317' UNION
			SELECT 'Nowy Hel', 'pucki', 'pomorskie', '2295', '3285', '143' UNION
			SELECT 'Nowy Hrubieszów', 'hrubieszowski', 'lubelskie', '3303', '17735', '537' UNION
			SELECT 'Nowy Iława', 'iławski', 'warmińsko-mazurskie', '2188', '33250', '1520' UNION
			SELECT 'Nowy Iłowa', 'żagański', 'lubuskie', '918', '3912', '426' UNION
			SELECT 'Nowy Iłża', 'radomski', 'mazowieckie', '1583', '4775', '302' UNION
			SELECT 'Nowy Imielin', 'bieruńsko-lędziński', 'śląskie', '2799', '9153', '327' UNION
			SELECT 'Nowy Inowrocław', 'inowrocławski', 'kujawsko-pomorskie', '3042', '73114', '2403' UNION
			SELECT 'Nowy Ińsko', 'stargardzki', 'zachodniopomorskie', '748', '1929', '258' UNION
			SELECT 'Nowy Iwonicz-Zdrój', 'krośnieński', 'podkarpackie', '589', '1793', '304' UNION
			SELECT 'Nowy Izbica Kujawska', 'włocławski', 'kujawsko-pomorskie', '224', '2631', '1175' UNION
			SELECT 'Nowy Jabłonowo Pomorskie', 'brodnicki', 'kujawsko-pomorskie', '335', '3758', '1122' UNION
			SELECT 'Nowy Janikowo', 'inowrocławski', 'kujawsko-pomorskie', '951', '8758', '921' UNION
			SELECT 'Nowy Janowiec Wielkopolski', 'żniński', 'kujawsko-pomorskie', '304', '3966', '1305' UNION
			SELECT 'Nowy Janów Lubelski', 'janowski', 'lubelskie', '1480', '11940', '807' UNION
			SELECT 'Nowy Jaraczewo', 'jarociński', 'wielkopolskie', '1007', '1420', '141' UNION
			SELECT 'Nowy Jarocin', 'jarociński', 'wielkopolskie', '1638', '26256', '1603' UNION
			SELECT 'Nowy Jarosław', 'jarosławski', 'podkarpackie', '3461', '37690', '1089' UNION
			SELECT 'Nowy Jasień', 'żarski', 'lubuskie', '479', '4328', '904' UNION
			SELECT 'Nowy Jasło', 'jasielski', 'podkarpackie', '3652', '35192', '964' UNION
			SELECT 'Nowy Jastarnia', 'pucki', 'pomorskie', '506', '2710', '536' UNION
			SELECT 'Nowy Jastrowie', 'złotowski', 'wielkopolskie', '7230', '8598', '119' UNION
			SELECT 'Nowy Jastrzębie-Zdrój', 'Jastrzębie-Zdrój[a]', 'śląskie', '8533', '89128', '1045' UNION
			SELECT 'Nowy Jawor', 'jaworski', 'dolnośląskie', '1880', '23056', '1226' UNION
			SELECT 'Nowy Jaworzno', 'Jaworzno[a]', 'śląskie', '15259', '91563', '600' UNION
			SELECT 'Nowy Jaworzyna Śląska', 'świdnicki', 'dolnośląskie', '434', '5141', '1185' UNION
			SELECT 'Nowy Jedlicze', 'krośnieński', 'podkarpackie', '1060', '5759', '543' UNION
			SELECT 'Nowy Jedlina-Zdrój', 'wałbrzyski', 'dolnośląskie', '1745', '4851', '278' UNION
			SELECT 'Nowy Jedwabne', 'łomżyński', 'podlaskie', '454', '1632', '359' UNION
			SELECT 'Nowy Jelcz-Laskowice', 'oławski', 'dolnośląskie', '1706', '15792', '926' UNION
			SELECT 'Nowy Jelenia Góra', 'Jelenia Góra[a]', 'dolnośląskie', '10922', '79480', '728' UNION
			SELECT 'Nowy Jeziorany', 'olsztyński', 'warmińsko-mazurskie', '341', '3225', '946' UNION
			SELECT 'Nowy Jędrzejów', 'jędrzejowski', 'świętokrzyskie', '1137', '15149', '1332' UNION
			SELECT 'Nowy Jordanów', 'suski', 'małopolskie', '2103', '5373', '255' UNION
			SELECT 'Nowy Józefów', 'biłgorajski', 'lubelskie', '500', '2492', '498' UNION
			SELECT 'Nowy Józefów', 'otwocki', 'mazowieckie', '2391', '20605', '862' UNION
			SELECT 'Nowy Józefów nad Wisłą', 'opolski', 'lubelskie', '365', '923', '253' UNION
			SELECT 'Nowy Jutrosin', 'rawicki', 'wielkopolskie', '162', '1967', '1214' UNION
			SELECT 'Nowy Kalety', 'tarnogórski', 'śląskie', '7629', '8626', '113' UNION
			SELECT 'Nowy Kalisz', 'Kalisz[a]', 'wielkopolskie', '6942', '100975', '1455' UNION
			SELECT 'Nowy Kalisz Pomorski', 'drawski', 'zachodniopomorskie', '1196', '4377', '366' UNION
			SELECT 'Nowy Kalwaria Zebrzydowska', 'wadowicki', 'małopolskie', '550', '4515', '821' UNION
			SELECT 'Nowy Kałuszyn', 'miński', 'mazowieckie', '1230', '2890', '235' UNION
			SELECT 'Nowy Kamienna Góra', 'kamiennogórski', 'dolnośląskie', '1804', '19136', '1061' UNION
			SELECT 'Nowy Kamień Krajeński', 'sępoleński', 'kujawsko-pomorskie', '365', '2386', '654' UNION
			SELECT 'Nowy Kamień Pomorski', 'kamieński', 'zachodniopomorskie', '1074', '8846', '824' UNION
			SELECT 'Nowy Kamieńsk', 'radomszczański', 'łódzkie', '1199', '2782', '232' UNION
			SELECT 'Nowy Kańczuga', 'przeworski', 'podkarpackie', '760', '3171', '417' UNION
			SELECT 'Nowy Karczew', 'otwocki', 'mazowieckie', '2812', '9891', '352' UNION
			SELECT 'Nowy Kargowa', 'zielonogórski', 'lubuskie', '455', '3754', '825' UNION
			SELECT 'Nowy Karlino', 'białogardzki', 'zachodniopomorskie', '940', '5919', '630' UNION
			SELECT 'Nowy Karpacz', 'jeleniogórski', 'dolnośląskie', '3799', '4633', '122' UNION
			SELECT 'Nowy Kartuzy', 'kartuski', 'pomorskie', '735', '14557', '1981' UNION
			SELECT 'Nowy Katowice', 'Katowice[a]', 'śląskie', '16464', '294510', '1789' UNION
			SELECT 'Nowy Kazimierz Dolny', 'puławski', 'lubelskie', '3044', '2579', '85' UNION
			SELECT 'Nowy Kazimierza Wielka', 'kazimierski', 'świętokrzyskie', '533', '5579', '1047' UNION
			SELECT 'Nowy Kąty Wrocławskie', 'wrocławski', 'dolnośląskie', '861', '6948', '807' UNION
			SELECT 'Nowy Kcynia', 'nakielski', 'kujawsko-pomorskie', '684', '4670', '683' UNION
			SELECT 'Nowy Kędzierzyn-Koźle', 'kędzierzyńsko-kozielski', 'opolskie', '12371', '61062', '494' UNION
			SELECT 'Nowy Kępice', 'słupski', 'pomorskie', '611', '3606', '590' UNION
			SELECT 'Nowy Kępno', 'kępiński', 'wielkopolskie', '779', '14123', '1813' UNION
			SELECT 'Nowy Kętrzyn', 'kętrzyński', 'warmińsko-mazurskie', '1035', '27366', '2644' UNION
			SELECT 'Nowy Kęty', 'oświęcimski', 'małopolskie', '2305', '18744', '813' UNION
			SELECT 'Nowy Kielce', 'Kielce[a]', 'świętokrzyskie', '10965', '195774', '1785' UNION
			SELECT 'Nowy Kietrz', 'głubczycki', 'opolskie', '1874', '6034', '322' UNION
			SELECT 'Nowy Kisielice', 'iławski', 'warmińsko-mazurskie', '337', '2103', '624' UNION
			SELECT 'Nowy Kleczew', 'koniński', 'wielkopolskie', '780', '4186', '537' UNION
			SELECT 'Nowy Kleszczele', 'hajnowski', 'podlaskie', '4671', '1271', '27' UNION
			SELECT 'Nowy Kluczbork', 'kluczborski', 'opolskie', '1235', '23661', '1916' UNION
			SELECT 'Nowy Kłecko', 'gnieźnieński', 'wielkopolskie', '962', '2637', '274' UNION
			SELECT 'Nowy Kłobuck', 'kłobucki', 'śląskie', '4746', '12957', '273' UNION
			SELECT 'Nowy Kłodawa', 'kolski', 'wielkopolskie', '431', '6481', '1504' UNION
			SELECT 'Nowy Kłodzko', 'kłodzki', 'dolnośląskie', '2484', '26954', '1085' UNION
			SELECT 'Nowy Knurów', 'gliwicki', 'śląskie', '3395', '38402', '1131' UNION
			SELECT 'Nowy Knyszyn', 'moniecki', 'podlaskie', '2368', '2755', '116' UNION
			SELECT 'Nowy Kobylin', 'krotoszyński', 'wielkopolskie', '487', '3245', '666' UNION
			SELECT 'Nowy Kobyłka', 'wołomiński', 'mazowieckie', '1964', '23706', '1207' UNION
			SELECT 'Nowy Kock', 'lubartowski', 'lubelskie', '1678', '3315', '198' UNION
			SELECT 'Nowy Kolbuszowa', 'kolbuszowski', 'podkarpackie', '798', '9133', '1144' UNION
			SELECT 'Nowy Kolno', 'kolneński', 'podlaskie', '2507', '10261', '409' UNION
			SELECT 'Nowy Kolonowskie', 'strzelecki', 'opolskie', '5570', '3328', '60' UNION
			SELECT 'Nowy Koluszki', 'łódzki wschodni', 'łódzkie', '990', '13026', '1316' UNION
			SELECT 'Nowy Kołaczyce', 'jasielski', 'podkarpackie', '715', '1403', '196' UNION
			SELECT 'Nowy Koło', 'kolski', 'wielkopolskie', '1385', '21994', '1588' UNION
			SELECT 'Nowy Kołobrzeg', 'kołobrzeski', 'zachodniopomorskie', '2567', '46367', '1806' UNION
			SELECT 'Nowy Koniecpol', 'częstochowski', 'śląskie', '3692', '5950', '161' UNION
			SELECT 'Nowy Konin', 'Konin[a]', 'wielkopolskie', '8231', '74151', '901' UNION
			SELECT 'Nowy Konstancin-Jeziorna', 'piaseczyński', 'mazowieckie', '1774', '17086', '963' UNION
			SELECT 'Nowy Konstantynów Łódzki', 'pabianicki', 'łódzkie', '2725', '18096', '664' UNION
			SELECT 'Nowy Końskie', 'konecki', 'świętokrzyskie', '1770', '19330', '1092' UNION
			SELECT 'Nowy Koprzywnica', 'sandomierski', 'świętokrzyskie', '1790', '2488', '139' UNION
			SELECT 'Nowy Korfantów', 'nyski', 'opolskie', '1023', '1817', '178' UNION
			SELECT 'Nowy Koronowo', 'bydgoski', 'kujawsko-pomorskie', '2815', '11182', '397' UNION
			SELECT 'Nowy Korsze', 'kętrzyński', 'warmińsko-mazurskie', '403', '4259', '1057' UNION
			SELECT 'Nowy Kosów Lacki', 'sokołowski', 'mazowieckie', '1157', '2088', '180' UNION
			SELECT 'Nowy Kostrzyn', 'poznański', 'wielkopolskie', '798', '9677', '1213' UNION
			SELECT 'Nowy Kostrzyn nad Odrą', 'gorzowski', 'lubuskie', '4614', '17776', '385' UNION
			SELECT 'Nowy Koszalin', 'Koszalin[a]', 'zachodniopomorskie', '9834', '107321', '1091' UNION
			SELECT 'Nowy Koszyce', 'proszowicki', 'małopolskie', '325', '782', '241' UNION
			SELECT 'Nowy Kościan', 'kościański', 'wielkopolskie', '901', '23923', '2655' UNION
			SELECT 'Nowy Kościerzyna', 'kościerski', 'pomorskie', '1586', '23759', '1498' UNION
			SELECT 'Nowy Kowal', 'włocławski', 'kujawsko-pomorskie', '468', '3499', '748' UNION
			SELECT 'Nowy Kowalewo Pomorskie', 'golubsko-dobrzyński', 'kujawsko-pomorskie', '445', '4143', '931' UNION
			SELECT 'Nowy Kowary', 'jeleniogórski', 'dolnośląskie', '3739', '10957', '293' UNION
			SELECT 'Nowy Koziegłowy', 'myszkowski', 'śląskie', '2671', '2463', '92' UNION
			SELECT 'Nowy Kozienice', 'kozienicki', 'mazowieckie', '1045', '17331', '1658' UNION
			SELECT 'Nowy Koźmin Wielkopolski', 'krotoszyński', 'wielkopolskie', '589', '6536', '1110' UNION
			SELECT 'Nowy Kożuchów', 'nowosolski', 'lubuskie', '594', '9490', '1598' UNION
			SELECT 'Nowy Kórnik', 'poznański', 'wielkopolskie', '599', '7847', '1310' UNION
			SELECT 'Nowy Krajenka', 'złotowski', 'wielkopolskie', '376', '3638', '968' UNION
			SELECT 'Nowy Kraków', 'Kraków[a]', 'małopolskie', '32685', '771069', '2359' UNION
			SELECT 'Nowy Krapkowice', 'krapkowicki', 'opolskie', '2101', '16381', '780' UNION
			SELECT 'Nowy Krasnobród', 'zamojski', 'lubelskie', '699', '3094', '443' UNION
			SELECT 'Nowy Krasnystaw', 'krasnostawski', 'lubelskie', '4213', '18778', '446' UNION
			SELECT 'Nowy Kraśnik', 'kraśnicki', 'lubelskie', '2610', '34539', '1323' UNION
			SELECT 'Nowy Krobia', 'gostyński', 'wielkopolskie', '705', '4313', '612' UNION
			SELECT 'Nowy Krosno', 'Krosno[a]', 'podkarpackie', '4350', '46511', '1069' UNION
			SELECT 'Nowy Krosno Odrzańskie', 'krośnieński', 'lubuskie', '815', '11378', '1396' UNION
			SELECT 'Nowy Krośniewice', 'kutnowski', 'łódzkie', '418', '4375', '1047' UNION
			SELECT 'Nowy Krotoszyn', 'krotoszyński', 'wielkopolskie', '2254', '28969', '1285' UNION
			SELECT 'Nowy Kruszwica', 'inowrocławski', 'kujawsko-pomorskie', '664', '8818', '1328' UNION
			SELECT 'Nowy Krynica Morska', 'nowodworski', 'pomorskie', '11856', '1303', '11' UNION
			SELECT 'Nowy Krynica-Zdrój', 'nowosądecki', 'małopolskie', '3968', '10686', '269' UNION
			SELECT 'Nowy Krynki', 'sokólski', 'podlaskie', '383', '2415', '631' UNION
			SELECT 'Nowy Krzanowice', 'raciborski', 'śląskie', '308', '2158', '701' UNION
			SELECT 'Nowy Krzepice', 'kłobucki', 'śląskie', '2766', '4462', '161' UNION
			SELECT 'Nowy Krzeszowice', 'krakowski', 'małopolskie', '1697', '10051', '592' UNION
			SELECT 'Nowy Krzywiń', 'kościański', 'wielkopolskie', '227', '1714', '755' UNION
			SELECT 'Nowy Krzyż Wielkopolski', 'czarnkowsko-trzcianecki', 'wielkopolskie', '581', '6216', '1070' UNION
			SELECT 'Nowy Książ Wielkopolski', 'śremski', 'wielkopolskie', '196', '2726', '1391' UNION
			SELECT 'Nowy Kudowa-Zdrój', 'kłodzki', 'dolnośląskie', '3390', '9954', '294' UNION
			SELECT 'Nowy Kunów', 'ostrowiecki', 'świętokrzyskie', '726', '2979', '410' UNION
			SELECT 'Nowy Kutno', 'kutnowski', 'łódzkie', '3359', '44172', '1315' UNION
			SELECT 'Nowy Kuźnia Raciborska', 'raciborski', 'śląskie', '3149', '5386', '171' UNION
			SELECT 'Nowy Kwidzyn', 'kwidzyński', 'pomorskie', '2154', '38481', '1786' UNION
			SELECT 'Nowy Lądek-Zdrój', 'kłodzki', 'dolnośląskie', '2032', '5622', '277' UNION
			SELECT 'Nowy Legionowo', 'legionowski', 'mazowieckie', '1354', '54066', '3993' UNION
			SELECT 'Nowy Legnica', 'Legnica[a]', 'dolnośląskie', '5629', '99752', '1772' UNION
			SELECT 'Nowy Lesko', 'leski', 'podkarpackie', '1533', '5431', '354' UNION
			SELECT 'Nowy Leszno', 'Leszno[a]', 'wielkopolskie', '3186', '63952', '2007' UNION
			SELECT 'Nowy Leśna', 'lubański', 'dolnośląskie', '856', '4484', '524' UNION
			SELECT 'Nowy Leśnica', 'strzelecki', 'opolskie', '1450', '2585', '178' UNION
			SELECT 'Nowy Lewin Brzeski', 'brzeski', 'opolskie', '1164', '5743', '493' UNION
			SELECT 'Nowy Leżajsk', 'leżajski', 'podkarpackie', '2058', '13891', '675' UNION
			SELECT 'Nowy Lębork', 'lęborski', 'pomorskie', '1786', '35367', '1980' UNION
			SELECT 'Nowy Lędziny', 'bieruńsko-lędziński', 'śląskie', '3165', '16822', '532' UNION
			SELECT 'Nowy Libiąż', 'chrzanowski', 'małopolskie', '3585', '17084', '477' UNION
			SELECT 'Nowy Lidzbark', 'działdowski', 'warmińsko-mazurskie', '568', '7817', '1376' UNION
			SELECT 'Nowy Lidzbark Warmiński', 'lidzbarski', 'warmińsko-mazurskie', '1435', '15820', '1102' UNION
			SELECT 'Nowy Limanowa', 'limanowski', 'małopolskie', '1870', '15158', '811' UNION
			SELECT 'Nowy Lipiany', 'pyrzycki', 'zachodniopomorskie', '554', '3946', '712' UNION
			SELECT 'Nowy Lipno', 'lipnowski', 'kujawsko-pomorskie', '1099', '14478', '1317' UNION
			SELECT 'Nowy Lipsk', 'augustowski', 'podlaskie', '498', '2350', '472' UNION
			SELECT 'Nowy Lipsko', 'lipski', 'mazowieckie', '1570', '5544', '353' UNION
			SELECT 'Nowy Lubaczów', 'lubaczowski', 'podkarpackie', '2573', '12078', '469' UNION
			SELECT 'Nowy Lubań', 'lubański', 'dolnośląskie', '1612', '21168', '1313' UNION
			SELECT 'Nowy Lubartów', 'lubartowski', 'lubelskie', '1391', '21995', '1581' UNION
			SELECT 'Nowy Lubawa', 'iławski', 'warmińsko-mazurskie', '1684', '10381', '616' UNION
			SELECT 'Nowy Lubawka', 'kamiennogórski', 'dolnośląskie', '2244', '6063', '270' UNION
			SELECT 'Nowy Lubień Kujawski', 'włocławski', 'kujawsko-pomorskie', '231', '1397', '605' UNION
			SELECT 'Nowy Lubin', 'lubiński', 'dolnośląskie', '4077', '72581', '1780' UNION
			SELECT 'Nowy Lublin', 'Lublin[a]', 'lubelskie', '14747', '339682', '2303' UNION
			SELECT 'Nowy Lubliniec', 'lubliniecki', 'śląskie', '8936', '23818', '267' UNION
			SELECT 'Nowy Lubniewice', 'sulęciński', 'lubuskie', '1211', '2042', '169' UNION
			SELECT 'Nowy Lubomierz', 'lwówecki', 'dolnośląskie', '805', '1990', '247' UNION
			SELECT 'Nowy Luboń', 'poznański', 'wielkopolskie', '1351', '31783', '2353' UNION
			SELECT 'Nowy Lubowidz', 'żuromiński', 'mazowieckie', '527', '1697', '322' UNION
			SELECT 'Nowy Lubraniec', 'włocławski', 'kujawsko-pomorskie', '197', '3028', '1537' UNION
			SELECT 'Nowy Lubsko', 'żarski', 'lubuskie', '1251', '14000', '1119' UNION
			SELECT 'Nowy Lubycza Królewska', 'tomaszowski', 'lubelskie', '392', '2443', '623' UNION
			SELECT 'Nowy Lwówek', 'nowotomyski', 'wielkopolskie', '316', '2977', '942' UNION
			SELECT 'Nowy Lwówek Śląski', 'lwówecki', 'dolnośląskie', '1665', '8870', '533' UNION
			SELECT 'Nowy Łabiszyn', 'żniński', 'kujawsko-pomorskie', '289', '4501', '1557' UNION
			SELECT 'Nowy Łagów', 'kielecki', 'świętokrzyskie', '822', '1587', '193' UNION
			SELECT 'Nowy Łańcut', 'łańcucki', 'podkarpackie', '1942', '17738', '913' UNION
			SELECT 'Nowy Łapy', 'białostocki', 'podlaskie', '1214', '15643', '1289' UNION
			SELECT 'Nowy Łasin', 'grudziądzki', 'kujawsko-pomorskie', '479', '3298', '689' UNION
			SELECT 'Nowy Łask', 'łaski', 'łódzkie', '1567', '17344', '1107' UNION
			SELECT 'Nowy Łaskarzew', 'garwoliński', 'mazowieckie', '1535', '4860', '317' UNION
			SELECT 'Nowy Łaszczów', 'tomaszowski', 'lubelskie', '501', '2154', '430' UNION
			SELECT 'Nowy Łaziska Górne', 'mikołowski', 'śląskie', '2007', '22334', '1113' UNION
			SELECT 'Nowy Łazy', 'zawierciański', 'śląskie', '860', '6845', '796' UNION
			SELECT 'Nowy Łeba', 'lęborski', 'pomorskie', '1656', '3675', '222' UNION
			SELECT 'Nowy Łęczna', 'łęczyński', 'lubelskie', '1900', '19006', '1000' UNION
			SELECT 'Nowy Łęczyca', 'łęczycki', 'łódzkie', '895', '14094', '1575' UNION
			SELECT 'Nowy Łęknica', 'żarski', 'lubuskie', '1643', '2483', '151' UNION
			SELECT 'Nowy Łobez', 'łobeski', 'zachodniopomorskie', '1284', '10241', '798' UNION
			SELECT 'Nowy Łobżenica', 'pilski', 'wielkopolskie', '325', '2972', '914' UNION
			SELECT 'Nowy Łochów', 'węgrowski', 'mazowieckie', '1339', '6821', '509' UNION
			SELECT 'Nowy Łomianki', 'warszawski zachodni', 'mazowieckie', '840', '16977', '2021' UNION
			SELECT 'Nowy Łomża', 'Łomża[a]', 'podlaskie', '3267', '63000', '1928' UNION
			SELECT 'Nowy Łosice', 'łosicki', 'mazowieckie', '2374', '7071', '298' UNION
			SELECT 'Nowy Łowicz', 'łowicki', 'łódzkie', '2342', '28501', '1217' UNION
			SELECT 'Nowy Łódź', 'Łódź[a]', 'łódzkie', '29325', '685285', '2337' UNION
			SELECT 'Nowy Łuków', 'łukowski', 'lubelskie', '3575', '30025', '840' UNION
			SELECT 'Nowy Maków Mazowiecki', 'makowski', 'mazowieckie', '1028', '9787', '952' UNION
			SELECT 'Nowy Maków Podhalański', 'suski', 'małopolskie', '2012', '5853', '291' UNION
			SELECT 'Nowy Malbork', 'malborski', 'pomorskie', '1716', '38570', '2248' UNION
			SELECT 'Nowy Małogoszcz', 'jędrzejowski', 'świętokrzyskie', '968', '3769', '389' UNION
			SELECT 'Nowy Małomice', 'żagański', 'lubuskie', '537', '3489', '650' UNION
			SELECT 'Nowy Margonin', 'chodzieski', 'wielkopolskie', '515', '3019', '586' UNION
			SELECT 'Nowy Marki', 'wołomiński', 'mazowieckie', '2615', '33914', '1297' UNION
			SELECT 'Nowy Maszewo', 'goleniowski', 'zachodniopomorskie', '554', '3363', '607' UNION
			SELECT 'Nowy Miasteczko Śląskie', 'tarnogórski', 'śląskie', '6783', '7449', '110' UNION
			SELECT 'Nowy Miastko', 'bytowski', 'pomorskie', '568', '10473', '1844' UNION
			SELECT 'Nowy Michałowo', 'białostocki', 'podlaskie', '215', '3047', '1417' UNION
			SELECT 'Nowy Miechów', 'miechowski', 'małopolskie', '1549', '11652', '752' UNION
			SELECT 'Nowy Miejska Górka', 'rawicki', 'wielkopolskie', '314', '3244', '1033' UNION
			SELECT 'Nowy Mielec', 'mielecki', 'podkarpackie', '4689', '60478', '1290' UNION
			SELECT 'Nowy Mielno', 'koszaliński', 'zachodniopomorskie', '3345', '2952', '88' UNION
			SELECT 'Nowy Mieroszów', 'wałbrzyski', 'dolnośląskie', '1031', '4106', '398' UNION
			SELECT 'Nowy Mieszkowice', 'gryfiński', 'zachodniopomorskie', '525', '3645', '694' UNION
			SELECT 'Nowy Międzybórz', 'oleśnicki', 'dolnośląskie', '641', '2352', '367' UNION
			SELECT 'Nowy Międzychód', 'międzychodzki', 'wielkopolskie', '698', '10623', '1522' UNION
			SELECT 'Nowy Międzylesie', 'kłodzki', 'dolnośląskie', '1437', '2591', '180' UNION
			SELECT 'Nowy Międzyrzec Podlaski', 'bialski', 'lubelskie', '2003', '16796', '839' UNION
			SELECT 'Nowy Międzyrzecz', 'międzyrzecki', 'lubuskie', '1026', '18099', '1764' UNION
			SELECT 'Nowy Międzyzdroje', 'kamieński', 'zachodniopomorskie', '516', '5399', '1046' UNION
			SELECT 'Nowy Mikołajki', 'mrągowski', 'warmińsko-mazurskie', '932', '3838', '412' UNION
			SELECT 'Nowy Mikołów', 'mikołowski', 'śląskie', '7921', '40813', '515' UNION
			SELECT 'Nowy Mikstat', 'ostrzeszowski', 'wielkopolskie', '252', '1855', '736' UNION
			SELECT 'Nowy Milanówek', 'grodziski', 'mazowieckie', '1344', '16306', '1213' UNION
			SELECT 'Nowy Milicz', 'milicki', 'dolnośląskie', '1350', '11357', '841' UNION
			SELECT 'Nowy Miłakowo', 'ostródzki', 'warmińsko-mazurskie', '876', '2560', '292' UNION
			SELECT 'Nowy Miłomłyn', 'ostródzki', 'warmińsko-mazurskie', '1238', '2442', '197' UNION
			SELECT 'Nowy Miłosław', 'wrzesiński', 'wielkopolskie', '407', '3572', '878' UNION
			SELECT 'Nowy Mińsk Mazowiecki', 'miński', 'mazowieckie', '1318', '40799', '3096' UNION
			SELECT 'Nowy Mirosławiec', 'wałecki', 'zachodniopomorskie', '241', '3089', '1282' UNION
			SELECT 'Nowy Mirsk', 'lwówecki', 'dolnośląskie', '1466', '3902', '266' UNION
			SELECT 'Nowy Mława', 'mławski', 'mazowieckie', '3480', '31234', '898' UNION
			SELECT 'Nowy Młynary', 'elbląski', 'warmińsko-mazurskie', '276', '1780', '645' UNION
			SELECT 'Nowy Modliborzyce', 'janowski', 'lubelskie', '789', '1460', '185' UNION
			SELECT 'Nowy Mogielnica', 'grójecki', 'mazowieckie', '1298', '2260', '174' UNION
			SELECT 'Nowy Mogilno', 'mogileński', 'kujawsko-pomorskie', '832', '11880', '1428' UNION
			SELECT 'Nowy Mońki', 'moniecki', 'podlaskie', '766', '10010', '1307' UNION
			SELECT 'Nowy Morawica', 'kielecki', 'świętokrzyskie', '438', '1695', '387' UNION
			SELECT 'Nowy Morąg', 'ostródzki', 'warmińsko-mazurskie', '611', '13838', '2265' UNION
			SELECT 'Nowy Mordy', 'siedlecki', 'mazowieckie', '454', '1793', '395' UNION
			SELECT 'Nowy Moryń', 'gryfiński', 'zachodniopomorskie', '554', '1626', '294' UNION
			SELECT 'Nowy Mosina', 'poznański', 'wielkopolskie', '1350', '14015', '1038' UNION
			SELECT 'Nowy Mrągowo', 'mrągowski', 'warmińsko-mazurskie', '1481', '21708', '1466' UNION
			SELECT 'Nowy Mrocza', 'nakielski', 'kujawsko-pomorskie', '501', '4366', '871' UNION
			SELECT 'Nowy Mrozy', 'miński', 'mazowieckie', '773', '3552', '460' UNION
			SELECT 'Nowy Mszana Dolna', 'limanowski', 'małopolskie', '2710', '7948', '293' UNION
			SELECT 'Nowy Mszczonów', 'żyrardowski', 'mazowieckie', '856', '6386', '746' UNION
			SELECT 'Nowy Murowana Goślina', 'poznański', 'wielkopolskie', '862', '10396', '1206' UNION
			SELECT 'Nowy Muszyna', 'nowosądecki', 'małopolskie', '2443', '4831', '198' UNION
			SELECT 'Nowy Mysłowice', 'Mysłowice[a]', 'śląskie', '6562', '74586', '1137' UNION
			SELECT 'Nowy Myszków', 'myszkowski', 'śląskie', '7359', '31762', '432' UNION
			SELECT 'Nowy Myszyniec', 'ostrołęcki', 'mazowieckie', '1122', '3426', '305' UNION
			SELECT 'Nowy Myślenice', 'myślenicki', 'małopolskie', '3022', '18386', '608' UNION
			SELECT 'Nowy Myślibórz', 'myśliborski', 'zachodniopomorskie', '1504', '11235', '747' UNION
			SELECT 'Nowy Nakło nad Notecią', 'nakielski', 'kujawsko-pomorskie', '1082', '18353', '1696' UNION
			SELECT 'Nowy Nałęczów', 'puławski', 'lubelskie', '1382', '3768', '273' UNION
			SELECT 'Nowy Namysłów', 'namysłowski', 'opolskie', '2261', '16490', '729' UNION
			SELECT 'Nowy Narol', 'lubaczowski', 'podkarpackie', '1242', '2076', '167' UNION
			SELECT 'Nowy Nasielsk', 'nowodworski', 'mazowieckie', '1257', '7707', '613' UNION
			SELECT 'Nowy Nekla', 'wrzesiński', 'wielkopolskie', '1979', '3754', '190' UNION
			SELECT 'Nowy Nidzica', 'nidzicki', 'warmińsko-mazurskie', '686', '13820', '2015' UNION
			SELECT 'Nowy Niemcza', 'dzierżoniowski', 'dolnośląskie', '1981', '2974', '150' UNION
			SELECT 'Nowy Niemodlin', 'opolski', 'opolskie', '1311', '6359', '485' UNION
			SELECT 'Nowy Niepołomice', 'wielicki', 'małopolskie', '2740', '13001', '474' UNION
			SELECT 'Nowy Nieszawa', 'aleksandrowski', 'kujawsko-pomorskie', '979', '1886', '193' UNION
			SELECT 'Nowy Nisko', 'niżański', 'podkarpackie', '6096', '15359', '252' UNION
			SELECT 'Nowy Nowa Dęba', 'tarnobrzeski', 'podkarpackie', '1670', '11181', '670' UNION
			SELECT 'Nowy Nowa Ruda', 'kłodzki', 'dolnośląskie', '3705', '22246', '600' UNION
			SELECT 'Nowy Nowa Sarzyna', 'leżajski', 'podkarpackie', '915', '5880', '643' UNION
			SELECT 'Nowy Nowa Słupia', 'kielecki', 'świętokrzyskie', '1397', '1361', '97' UNION
			SELECT 'Nowy Nowa Sól', 'nowosolski', 'lubuskie', '2180', '38843', '1782' UNION
			SELECT 'Nowy Nowe', 'świecki', 'kujawsko-pomorskie', '357', '5864', '1643' UNION
			SELECT 'Nowy Nowe Brzesko', 'proszowicki', 'małopolskie', '726', '1683', '232' UNION
			SELECT 'Nowy Nowe Miasteczko', 'nowosolski', 'lubuskie', '329', '2770', '842' UNION
			SELECT 'Nowy Nowe Miasto Lubawskie', 'nowomiejski', 'warmińsko-mazurskie', '1137', '10925', '961' UNION
			SELECT 'Nowy Nowe Miasto nad Pilicą', 'grójecki', 'mazowieckie', '1125', '3789', '337' UNION
			SELECT 'Nowy Nowe Skalmierzyce', 'ostrowski', 'wielkopolskie', '158', '4770', '3019' UNION
			SELECT 'Nowy Nowe Warpno', 'policki', 'zachodniopomorskie', '2451', '1192', '49' UNION
			SELECT 'Nowy Nowogard', 'goleniowski', 'zachodniopomorskie', '1257', '16671', '1326' UNION
			SELECT 'Nowy Nowogrodziec', 'bolesławiecki', 'dolnośląskie', '1610', '4235', '263' UNION
			SELECT 'Nowy Nowogród', 'łomżyński', 'podlaskie', '2055', '2156', '105' UNION
			SELECT 'Nowy Nowogród Bobrzański', 'zielonogórski', 'lubuskie', '1463', '5188', '355' UNION
			SELECT 'Nowy Nowy Dwór Gdański', 'nowodworski', 'pomorskie', '507', '9917', '1956' UNION
			SELECT 'Nowy Nowy Dwór Mazowiecki', 'nowodworski', 'mazowieckie', '2821', '28647', '1015' UNION
			SELECT 'Nowy Nowy Korczyn', 'buski', 'świętokrzyskie', '752', '955', '127' UNION
			SELECT 'Nowy Nowy Sącz', 'Nowy Sącz[a]', 'małopolskie', '5758', '83896', '1457' UNION
			SELECT 'Nowy Nowy Staw', 'malborski', 'pomorskie', '467', '4283', '917' UNION
			SELECT 'Nowy Nowy Targ', 'nowotarski', 'małopolskie', '5107', '33373', '653' UNION
			SELECT 'Nowy Nowy Tomyśl', 'nowotomyski', 'wielkopolskie', '520', '14603', '2808' UNION
			SELECT 'Nowy Nowy Wiśnicz', 'bocheński', 'małopolskie', '497', '2745', '552' UNION
			SELECT 'Nowy Nysa', 'nyski', 'opolskie', '2751', '44044', '1601' UNION
			SELECT 'Nowy Oborniki', 'obornicki', 'wielkopolskie', '1408', '18179', '1291' UNION
			SELECT 'Nowy Oborniki Śląskie', 'trzebnicki', 'dolnośląskie', '1446', '9109', '630' UNION
			SELECT 'Nowy Obrzycko', 'szamotulski', 'wielkopolskie', '374', '2385', '638' UNION
			SELECT 'Nowy Odolanów', 'ostrowski', 'wielkopolskie', '476', '5130', '1078' UNION
			SELECT 'Nowy Ogrodzieniec', 'zawierciański', 'śląskie', '2856', '4296', '150' UNION
			SELECT 'Nowy Okonek', 'złotowski', 'wielkopolskie', '601', '3900', '649' UNION
			SELECT 'Nowy Olecko', 'olecki', 'warmińsko-mazurskie', '1154', '16477', '1428' UNION
			SELECT 'Nowy Olesno', 'oleski', 'opolskie', '1508', '9406', '624' UNION
			SELECT 'Nowy Oleszyce', 'lubaczowski', 'podkarpackie', '508', '2993', '589' UNION
			SELECT 'Nowy Oleśnica', 'oleśnicki', 'dolnośląskie', '2096', '37242', '1777' UNION
			SELECT 'Nowy Oleśnica', 'staszowski', 'świętokrzyskie', '1004', '1848', '184' UNION
			SELECT 'Nowy Olkusz', 'olkuski', 'małopolskie', '2565', '35608', '1388' UNION
			SELECT 'Nowy Olsztyn', 'Olsztyn[a]', 'warmińsko-mazurskie', '8833', '172362', '1951' UNION
			SELECT 'Nowy Olsztynek', 'olsztyński', 'warmińsko-mazurskie', '769', '7581', '986' UNION
			SELECT 'Nowy Olszyna', 'lubański', 'dolnośląskie', '2026', '4359', '215' UNION
			SELECT 'Nowy Oława', 'oławski', 'dolnośląskie', '2736', '32927', '1203' UNION
			SELECT 'Nowy Opalenica', 'nowotomyski', 'wielkopolskie', '642', '9596', '1495' UNION
			SELECT 'Nowy Opatowiec', 'kazimierski', 'świętokrzyskie', '547', '329', '60' UNION
			SELECT 'Nowy Opatów', 'opatowski', 'świętokrzyskie', '936', '6496', '694' UNION
			SELECT 'Nowy Opatówek', 'kaliski', 'wielkopolskie', '868', '3677', '424' UNION
			SELECT 'Nowy Opoczno', 'opoczyński', 'łódzkie', '2699', '21327', '790' UNION
			SELECT 'Nowy Opole', 'Opole[a]', 'opolskie', '14888', '128137', '861' UNION
			SELECT 'Nowy Opole Lubelskie', 'opolski', 'lubelskie', '1512', '8470', '560' UNION
			SELECT 'Nowy Orneta', 'lidzbarski', 'warmińsko-mazurskie', '963', '8817', '916' UNION
			SELECT 'Nowy Orzesze', 'mikołowski', 'śląskie', '8375', '20927', '250' UNION
			SELECT 'Nowy Orzysz', 'piski', 'warmińsko-mazurskie', '817', '5579', '683' UNION
			SELECT 'Nowy Osieczna', 'leszczyński', 'wielkopolskie', '476', '2347', '493' UNION
			SELECT 'Nowy Osiek', 'staszowski', 'świętokrzyskie', '1743', '2015', '116' UNION
			SELECT 'Nowy Ostrołęka', 'Ostrołęka[a]', 'mazowieckie', '3346', '52262', '1562' UNION
			SELECT 'Nowy Ostroróg', 'szamotulski', 'wielkopolskie', '125', '1920', '1536' UNION
			SELECT 'Nowy Ostrowiec Świętokrzyski', 'ostrowiecki', 'świętokrzyskie', '4643', '69051', '1487' UNION
			SELECT 'Nowy Ostróda', 'ostródzki', 'warmińsko-mazurskie', '1415', '32996', '2332' UNION
			SELECT 'Nowy Ostrów Lubelski', 'lubartowski', 'lubelskie', '2977', '2092', '70' UNION
			SELECT 'Nowy Ostrów Mazowiecka', 'ostrowski', 'mazowieckie', '2227', '22545', '1012' UNION
			SELECT 'Nowy Ostrów Wielkopolski', 'ostrowski', 'wielkopolskie', '4190', '72050', '1720' UNION
			SELECT 'Nowy Ostrzeszów', 'ostrzeszowski', 'wielkopolskie', '1213', '14176', '1169' UNION
			SELECT 'Nowy Ośno Lubuskie', 'słubicki', 'lubuskie', '801', '3949', '493' UNION
			SELECT 'Nowy Oświęcim', 'oświęcimski', 'małopolskie', '3000', '38300', '1277' UNION
			SELECT 'Nowy Otmuchów', 'nyski', 'opolskie', '4954', '6615', '134' UNION
			SELECT 'Nowy Otwock', 'otwocki', 'mazowieckie', '4731', '44880', '949' UNION
			SELECT 'Nowy Otyń', 'nowosolski', 'lubuskie', '786', '1601', '204' UNION
			SELECT 'Nowy Ozimek', 'opolski', 'opolskie', '325', '8725', '2685' UNION
			SELECT 'Nowy Ozorków', 'zgierski', 'łódzkie', '1546', '19456', '1258' UNION
			SELECT 'Nowy Ożarów', 'opatowski', 'świętokrzyskie', '779', '4599', '590' UNION
			SELECT 'Nowy Ożarów Mazowiecki', 'warszawski zachodni', 'mazowieckie', '813', '11576', '1424' UNION
			SELECT 'Nowy Pabianice', 'pabianicki', 'łódzkie', '3299', '65283', '1979' UNION
			SELECT 'Nowy Pacanów', 'buski', 'świętokrzyskie', '713', '1117', '157' UNION
			SELECT 'Nowy Paczków', 'nyski', 'opolskie', '660', '7530', '1141' UNION
			SELECT 'Nowy Pajęczno', 'pajęczański', 'łódzkie', '2023', '6781', '335' UNION
			SELECT 'Nowy Pakość', 'inowrocławski', 'kujawsko-pomorskie', '346', '5723', '1654' UNION
			SELECT 'Nowy Parczew', 'parczewski', 'lubelskie', '805', '10650', '1323' UNION
			SELECT 'Nowy Pasłęk', 'elbląski', 'warmińsko-mazurskie', '1063', '12211', '1149' UNION
			SELECT 'Nowy Pasym', 'szczycieński', 'warmińsko-mazurskie', '1518', '2517', '166' UNION
			SELECT 'Nowy Pelplin', 'tczewski', 'pomorskie', '442', '7818', '1769' UNION
			SELECT 'Nowy Pełczyce', 'choszczeński', 'zachodniopomorskie', '1307', '2589', '198' UNION
			SELECT 'Nowy Piaseczno', 'piaseczyński', 'mazowieckie', '1622', '48119', '2967' UNION
			SELECT 'Nowy Piaski', 'świdnicki', 'lubelskie', '844', '2556', '303' UNION
			SELECT 'Nowy Piastów', 'pruszkowski', 'mazowieckie', '576', '22657', '3934' UNION
			SELECT 'Nowy Piechowice', 'jeleniogórski', 'dolnośląskie', '4322', '6222', '144' UNION
			SELECT 'Nowy Piekary Śląskie', 'Piekary Śląskie[a]', 'śląskie', '3998', '55299', '1383' UNION
			SELECT 'Nowy Pieniężno', 'braniewski', 'warmińsko-mazurskie', '381', '2746', '721' UNION
			SELECT 'Nowy Pieńsk', 'zgorzelecki', 'dolnośląskie', '992', '5848', '590' UNION
			SELECT 'Nowy Pierzchnica', 'kielecki', 'świętokrzyskie', '693', '1152', '166' UNION
			SELECT 'Nowy Pieszyce', 'dzierżoniowski', 'dolnośląskie', '1772', '7136', '403' UNION
			SELECT 'Nowy Pilawa', 'garwoliński', 'mazowieckie', '666', '4589', '689' UNION
			SELECT 'Nowy Pilica', 'zawierciański', 'śląskie', '822', '1947', '237' UNION
			SELECT 'Nowy Pilzno', 'dębicki', 'podkarpackie', '1604', '4903', '306' UNION
			SELECT 'Nowy Piła', 'pilski', 'wielkopolskie', '10268', '73398', '715' UNION
			SELECT 'Nowy Piława Górna', 'dzierżoniowski', 'dolnośląskie', '2093', '6457', '309' UNION
			SELECT 'Nowy Pińczów', 'pińczowski', 'świętokrzyskie', '1433', '10844', '757' UNION
			SELECT 'Nowy Pionki', 'radomski', 'mazowieckie', '1840', '18427', '1001' UNION
			SELECT 'Nowy Piotrków Kujawski', 'radziejowski', 'kujawsko-pomorskie', '976', '4468', '458' UNION
			SELECT 'Nowy Piotrków Trybunalski', 'Piotrków Trybunalski[a]', 'łódzkie', '6724', '73670', '1096' UNION
			SELECT 'Nowy Pisz', 'piski', 'warmińsko-mazurskie', '1008', '19318', '1916' UNION
			SELECT 'Nowy Piwniczna-Zdrój', 'nowosądecki', 'małopolskie', '3830', '5882', '154' UNION
			SELECT 'Nowy Pleszew', 'pleszewski', 'wielkopolskie', '1338', '17356', '1297' UNION
			SELECT 'Nowy Płock', 'Płock[a]', 'mazowieckie', '8804', '120000', '1363' UNION
			SELECT 'Nowy Płońsk', 'płoński', 'mazowieckie', '1160', '22163', '1911' UNION
			SELECT 'Nowy Płoty', 'gryficki', 'zachodniopomorskie', '412', '3983', '967' UNION
			SELECT 'Nowy Pniewy', 'szamotulski', 'wielkopolskie', '932', '8060', '865' UNION
			SELECT 'Nowy Pobiedziska', 'poznański', 'wielkopolskie', '1024', '9181', '897' UNION
			SELECT 'Nowy Poddębice', 'poddębicki', 'łódzkie', '587', '7448', '1269' UNION
			SELECT 'Nowy Podkowa Leśna', 'grodziski', 'mazowieckie', '1013', '3854', '380' UNION
			SELECT 'Nowy Pogorzela', 'gostyński', 'wielkopolskie', '436', '2100', '482' UNION
			SELECT 'Nowy Polanica-Zdrój', 'kłodzki', 'dolnośląskie', '1722', '6357', '369' UNION
			SELECT 'Nowy Polanów', 'koszaliński', 'zachodniopomorskie', '737', '2918', '396' UNION
			SELECT 'Nowy Police', 'policki', 'zachodniopomorskie', '3731', '32685', '876' UNION
			SELECT 'Nowy Polkowice', 'polkowicki', 'dolnośląskie', '2374', '22487', '947' UNION
			SELECT 'Nowy Połaniec', 'staszowski', 'świętokrzyskie', '1741', '8120', '466' UNION
			SELECT 'Nowy Połczyn-Zdrój', 'świdwiński', 'zachodniopomorskie', '721', '8109', '1125' UNION
			SELECT 'Nowy Poniatowa', 'opolski', 'lubelskie', '1526', '9195', '603' UNION
			SELECT 'Nowy Poniec', 'gostyński', 'wielkopolskie', '348', '2851', '819' UNION
			SELECT 'Nowy Poręba', 'zawierciański', 'śląskie', '3999', '8568', '214' UNION
			SELECT 'Nowy Poznań', 'Poznań[a]', 'wielkopolskie', '26191', '536438', '2048' UNION
			SELECT 'Nowy Prabuty', 'kwidzyński', 'pomorskie', '729', '8696', '1193' UNION
			SELECT 'Nowy Praszka', 'oleski', 'opolskie', '935', '7704', '824' UNION
			SELECT 'Nowy Prochowice', 'legnicki', 'dolnośląskie', '985', '3620', '368' UNION
			SELECT 'Nowy Proszowice', 'proszowicki', 'małopolskie', '733', '6012', '820' UNION
			SELECT 'Nowy Prószków', 'opolski', 'opolskie', '1622', '2591', '160' UNION
			SELECT 'Nowy Pruchnik', 'jarosławski', 'podkarpackie', '1990', '3774', '190' UNION
			SELECT 'Nowy Prudnik', 'prudnicki', 'opolskie', '2050', '21138', '1031' UNION
			SELECT 'Nowy Prusice', 'trzebnicki', 'dolnośląskie', '1094', '2232', '204' UNION
			SELECT 'Nowy Pruszcz Gdański', 'gdański', 'pomorskie', '1647', '30878', '1875' UNION
			SELECT 'Nowy Pruszków', 'pruszkowski', 'mazowieckie', '1919', '61784', '3220' UNION
			SELECT 'Nowy Przasnysz', 'przasnyski', 'mazowieckie', '2516', '17309', '688' UNION
			SELECT 'Nowy Przecław', 'mielecki', 'podkarpackie', '1604', '1768', '110' UNION
			SELECT 'Nowy Przedbórz', 'radomszczański', 'łódzkie', '608', '3572', '588' UNION
			SELECT 'Nowy Przedecz', 'kolski', 'wielkopolskie', '298', '1670', '560' UNION
			SELECT 'Nowy Przemków', 'polkowicki', 'dolnośląskie', '617', '6149', '997' UNION
			SELECT 'Nowy Przemyśl', 'Przemyśl[a]', 'podkarpackie', '4617', '61251', '1327' UNION
			SELECT 'Nowy Przeworsk', 'przeworski', 'podkarpackie', '2213', '15376', '695' UNION
			SELECT 'Nowy Przysucha', 'przysuski', 'mazowieckie', '702', '5854', '834' UNION
			SELECT 'Nowy Pszczyna', 'pszczyński', 'śląskie', '2249', '25829', '1148' UNION
			SELECT 'Nowy Pszów', 'wodzisławski', 'śląskie', '2044', '13994', '685' UNION
			SELECT 'Nowy Puck', 'pucki', 'pomorskie', '479', '11241', '2347' UNION
			SELECT 'Nowy Puławy', 'puławski', 'lubelskie', '5049', '47774', '946' UNION
			SELECT 'Nowy Pułtusk', 'pułtuski', 'mazowieckie', '2307', '19431', '842' UNION
			SELECT 'Nowy Puszczykowo', 'poznański', 'wielkopolskie', '1639', '9698', '592' UNION
			SELECT 'Nowy Pyrzyce', 'pyrzycki', 'zachodniopomorskie', '3879', '12617', '325' UNION
			SELECT 'Nowy Pyskowice', 'gliwicki', 'śląskie', '3089', '18456', '597' UNION
			SELECT 'Nowy Pyzdry', 'wrzesiński', 'wielkopolskie', '1216', '3145', '259' UNION
			SELECT 'Nowy Rabka-Zdrój', 'nowotarski', 'małopolskie', '3631', '12780', '352' UNION
			SELECT 'Nowy Raciąż', 'płoński', 'mazowieckie', '840', '4420', '526' UNION
			SELECT 'Nowy Racibórz', 'raciborski', 'śląskie', '7501', '54882', '732' UNION
			SELECT 'Nowy Radków', 'kłodzki', 'dolnośląskie', '1503', '2418', '161' UNION
			SELECT 'Nowy Radlin', 'wodzisławski', 'śląskie', '1253', '17806', '1421' UNION
			SELECT 'Nowy Radłów', 'tarnowski', 'małopolskie', '1683', '2767', '164' UNION
			SELECT 'Nowy Radom', 'Radom[a]', 'mazowieckie', '11180', '213029', '1905' UNION
			SELECT 'Nowy Radomsko', 'radomszczański', 'łódzkie', '5143', '46087', '896' UNION
			SELECT 'Nowy Radomyśl Wielki', 'mielecki', 'podkarpackie', '879', '3196', '364' UNION
			SELECT 'Nowy Radoszyce', 'konecki', 'świętokrzyskie', '1717', '3167', '184' UNION
			SELECT 'Nowy Radymno', 'jarosławski', 'podkarpackie', '1362', '5314', '390' UNION
			SELECT 'Nowy Radziejów', 'radziejowski', 'kujawsko-pomorskie', '569', '5602', '985' UNION
			SELECT 'Nowy Radzionków', 'tarnogórski', 'śląskie', '1320', '16818', '1274' UNION
			SELECT 'Nowy Radzymin', 'wołomiński', 'mazowieckie', '2339', '12876', '550' UNION
			SELECT 'Nowy Radzyń Chełmiński', 'grudziądzki', 'kujawsko-pomorskie', '178', '1864', '1047' UNION
			SELECT 'Nowy Radzyń Podlaski', 'radzyński', 'lubelskie', '1931', '15731', '815' UNION
			SELECT 'Nowy Rajgród', 'grajewski', 'podlaskie', '3528', '1585', '45' UNION
			SELECT 'Nowy Rakoniewice', 'grodziski', 'wielkopolskie', '337', '3599', '1068' UNION
			SELECT 'Nowy Raszków', 'ostrowski', 'wielkopolskie', '205', '2099', '1024' UNION
			SELECT 'Nowy Rawa Mazowiecka', 'rawski', 'łódzkie', '1430', '17408', '1217' UNION
			SELECT 'Nowy Rawicz', 'rawicki', 'wielkopolskie', '774', '20337', '2628' UNION
			SELECT 'Nowy Recz', 'choszczeński', 'zachodniopomorskie', '1240', '2914', '235' UNION
			SELECT 'Nowy Reda', 'wejherowski', 'pomorskie', '3346', '25810', '771' UNION
			SELECT 'Nowy Rejowiec', 'chełmski', 'lubelskie', '650', '2070', '318' UNION
			SELECT 'Nowy Rejowiec Fabryczny', 'chełmski', 'lubelskie', '1428', '4417', '309' UNION
			SELECT 'Nowy Resko', 'łobeski', 'zachodniopomorskie', '449', '4231', '942' UNION
			SELECT 'Nowy Reszel', 'kętrzyński', 'warmińsko-mazurskie', '382', '4571', '1197' UNION
			SELECT 'Nowy Rogoźno', 'obornicki', 'wielkopolskie', '1124', '11148', '992' UNION
			SELECT 'Nowy Ropczyce', 'ropczycko-sędziszowski', 'podkarpackie', '4710', '15856', '337' UNION
			SELECT 'Nowy Różan', 'makowski', 'mazowieckie', '666', '2727', '409' UNION
			SELECT 'Nowy Ruciane-Nida', 'piski', 'warmińsko-mazurskie', '1707', '4474', '262' UNION
			SELECT 'Nowy Ruda Śląska', 'Ruda Śląska[a]', 'śląskie', '7773', '138000', '1775' UNION
			SELECT 'Nowy Rudnik nad Sanem', 'niżański', 'podkarpackie', '3660', '6726', '184' UNION
			SELECT 'Nowy Rumia', 'wejherowski', 'pomorskie', '3010', '49031', '1629' UNION
			SELECT 'Nowy Rybnik', 'Rybnik[a]', 'śląskie', '14836', '138696', '935' UNION
			SELECT 'Nowy Rychwał', 'koniński', 'wielkopolskie', '970', '2391', '246' UNION
			SELECT 'Nowy Rydułtowy', 'wodzisławski', 'śląskie', '1495', '21637', '1447' UNION
			SELECT 'Nowy Rydzyna', 'leszczyński', 'wielkopolskie', '220', '2867', '1303' UNION
			SELECT 'Nowy Ryglice', 'tarnowski', 'małopolskie', '2515', '2831', '113' UNION
			SELECT 'Nowy Ryki', 'rycki', 'lubelskie', '2722', '9667', '355' UNION
			SELECT 'Nowy Rymanów', 'krośnieński', 'podkarpackie', '1239', '3819', '308' UNION
			SELECT 'Nowy Ryn', 'giżycki', 'warmińsko-mazurskie', '414', '2851', '689' UNION
			SELECT 'Nowy Rypin', 'rypiński', 'kujawsko-pomorskie', '1096', '16354', '1492' UNION
			SELECT 'Nowy Rzepin', 'słubicki', 'lubuskie', '1142', '6564', '575' UNION
			SELECT 'Nowy Rzeszów', 'Rzeszów[a]', 'podkarpackie', '12661', '193883', '1531' UNION
			SELECT 'Nowy Rzgów', 'łódzki wschodni', 'łódzkie', '1677', '3401', '203' UNION
			SELECT 'Nowy Sandomierz', 'sandomierski', 'świętokrzyskie', '2869', '23644', '824' UNION
			SELECT 'Nowy Sanniki', 'gostyniński', 'mazowieckie', '1176', '1983', '169' UNION
			SELECT 'Nowy Sanok', 'sanocki', 'podkarpackie', '3808', '37577', '987' UNION
			SELECT 'Nowy Sejny', 'sejneński', 'podlaskie', '449', '5344', '1190' UNION
			SELECT 'Nowy Serock', 'legionowski', 'mazowieckie', '1343', '4416', '329' UNION
			SELECT 'Nowy Sędziszów', 'jędrzejowski', 'świętokrzyskie', '792', '6484', '819' UNION
			SELECT 'Nowy Sędziszów Małopolski', 'ropczycko-sędziszowski', 'podkarpackie', '3699', '12276', '332' UNION
			SELECT 'Nowy Sępopol', 'bartoszycki', 'warmińsko-mazurskie', '463', '1964', '424' UNION
			SELECT 'Nowy Sępólno Krajeńskie', 'sępoleński', 'kujawsko-pomorskie', '655', '9118', '1392' UNION
			SELECT 'Nowy Sianów', 'koszaliński', 'zachodniopomorskie', '1588', '6664', '420' UNION
			SELECT 'Nowy Siechnice', 'wrocławski', 'dolnośląskie', '1563', '7892', '505' UNION
			SELECT 'Nowy Siedlce', 'Siedlce[a]', 'mazowieckie', '3186', '77872', '2444' UNION
			SELECT 'Nowy Siedliszcze', 'chełmski', 'lubelskie', '1316', '1412', '107' UNION
			SELECT 'Nowy Siemianowice Śląskie', 'Siemianowice Śląskie[a]', 'śląskie', '2550', '67154', '2633' UNION
			SELECT 'Nowy Siemiatycze', 'siemiatycki', 'podlaskie', '3625', '14505', '400' UNION
			SELECT 'Nowy Sieniawa', 'przeworski', 'podkarpackie', '674', '2140', '318' UNION
			SELECT 'Nowy Sieradz', 'sieradzki', 'łódzkie', '5122', '42267', '825' UNION
			SELECT 'Nowy Sieraków', 'międzychodzki', 'wielkopolskie', '1408', '6056', '430' UNION
			SELECT 'Nowy Sierpc', 'sierpecki', 'mazowieckie', '1859', '18014', '969' UNION
			SELECT 'Nowy Siewierz', 'będziński', 'śląskie', '3866', '5592', '145' UNION
			SELECT 'Nowy Skalbmierz', 'kazimierski', 'świętokrzyskie', '713', '1289', '181' UNION
			SELECT 'Nowy Skała', 'krakowski', 'małopolskie', '297', '3803', '1280' UNION
			SELECT 'Nowy Skarszewy', 'starogardzki', 'pomorskie', '1079', '7023', '651' UNION
			SELECT 'Nowy Skaryszew', 'radomski', 'mazowieckie', '2749', '4376', '159' UNION
			SELECT 'Nowy Skarżysko-Kamienna', 'skarżyski', 'świętokrzyskie', '6439', '45358', '704' UNION
			SELECT 'Nowy Skawina', 'krakowski', 'małopolskie', '2050', '24362', '1188' UNION
			SELECT 'Nowy Skępe', 'lipnowski', 'kujawsko-pomorskie', '748', '3603', '482' UNION
			SELECT 'Nowy Skierniewice', 'Skierniewice[a]', 'łódzkie', '3460', '48178', '1392' UNION
			SELECT 'Nowy Skoczów', 'cieszyński', 'śląskie', '985', '14469', '1469' UNION
			SELECT 'Nowy Skoki', 'wągrowiecki', 'wielkopolskie', '1120', '4346', '388' UNION
			SELECT 'Nowy Skórcz', 'starogardzki', 'pomorskie', '363', '3611', '995' UNION
			SELECT 'Nowy Skwierzyna', 'międzyrzecki', 'lubuskie', '3589', '9698', '270' UNION
			SELECT 'Nowy Sława', 'wschowski', 'lubuskie', '1490', '4316', '290' UNION
			SELECT 'Nowy Sławków', 'będziński', 'śląskie', '3667', '7043', '192' UNION
			SELECT 'Nowy Sławno', 'sławieński', 'zachodniopomorskie', '1583', '12528', '791' UNION
			SELECT 'Nowy Słomniki', 'krakowski', 'małopolskie', '343', '4348', '1268' UNION
			SELECT 'Nowy Słubice', 'słubicki', 'lubuskie', '1921', '16773', '873' UNION
			SELECT 'Nowy Słupca', 'słupecki', 'wielkopolskie', '1030', '13773', '1337' UNION
			SELECT 'Nowy Słupsk', 'Słupsk[a]', 'pomorskie', '4315', '91007', '2109' UNION
			SELECT 'Nowy Sobótka', 'wrocławski', 'dolnośląskie', '3220', '6957', '216' UNION
			SELECT 'Nowy Sochaczew', 'sochaczewski', 'mazowieckie', '2619', '36462', '1392' UNION
			SELECT 'Nowy Sokołów Małopolski', 'rzeszowski', 'podkarpackie', '1554', '4165', '268' UNION
			SELECT 'Nowy Sokołów Podlaski', 'sokołowski', 'mazowieckie', '1751', '18939', '1082' UNION
			SELECT 'Nowy Sokółka', 'sokólski', 'podlaskie', '1859', '18210', '980' UNION
			SELECT 'Nowy Solec Kujawski', 'bydgoski', 'kujawsko-pomorskie', '1868', '15641', '837' UNION
			SELECT 'Nowy Sompolno', 'koniński', 'wielkopolskie', '621', '3552', '572' UNION
			SELECT 'Nowy Sopot', 'Sopot[a]', 'pomorskie', '1728', '36046', '2086' UNION
			SELECT 'Nowy Sosnowiec', 'Sosnowiec[a]', 'śląskie', '9106', '202036', '2219' UNION
			SELECT 'Nowy Sośnicowice', 'gliwicki', 'śląskie', '1167', '1906', '163' UNION
			SELECT 'Nowy Stalowa Wola', 'stalowowolski', 'podkarpackie', '8252', '61182', '741' UNION
			SELECT 'Nowy Starachowice', 'starachowicki', 'świętokrzyskie', '3182', '48965', '1539' UNION
			SELECT 'Nowy Stargard', 'stargardzki', 'zachodniopomorskie', '4808', '67938', '1413' UNION
			SELECT 'Nowy Starogard Gdański', 'starogardzki', 'pomorskie', '2528', '47776', '1890' UNION
			SELECT 'Nowy Stary Sącz', 'nowosądecki', 'małopolskie', '1500', '9048', '603' UNION
			SELECT 'Nowy Staszów', 'staszowski', 'świętokrzyskie', '2688', '14810', '551' UNION
			SELECT 'Nowy Stawiski', 'kolneński', 'podlaskie', '1324', '2195', '166' UNION
			SELECT 'Nowy Stawiszyn', 'kaliski', 'wielkopolskie', '99', '1526', '1541' UNION
			SELECT 'Nowy Stąporków', 'konecki', 'świętokrzyskie', '1094', '5679', '519' UNION
			SELECT 'Nowy Stepnica', 'goleniowski', 'zachodniopomorskie', '340', '2471', '727' UNION
			SELECT 'Nowy Stęszew', 'poznański', 'wielkopolskie', '569', '5931', '1042' UNION
			SELECT 'Nowy Stoczek Łukowski', 'łukowski', 'lubelskie', '915', '2536', '277' UNION
			SELECT 'Nowy Stopnica', 'buski', 'świętokrzyskie', '455', '1425', '313' UNION
			SELECT 'Nowy Stronie Śląskie', 'kłodzki', 'dolnośląskie', '238', '5741', '2412' UNION
			SELECT 'Nowy Strumień', 'cieszyński', 'śląskie', '629', '3680', '585' UNION
			SELECT 'Nowy Stryków', 'zgierski', 'łódzkie', '815', '3494', '429' UNION
			SELECT 'Nowy Strzegom', 'świdnicki', 'dolnośląskie', '2049', '16153', '788' UNION
			SELECT 'Nowy Strzelce Krajeńskie', 'strzelecko-drezdenecki', 'lubuskie', '554', '9969', '1799' UNION
			SELECT 'Nowy Strzelce Opolskie', 'strzelecki', 'opolskie', '2997', '17982', '600' UNION
			SELECT 'Nowy Strzelin', 'strzeliński', 'dolnośląskie', '1034', '12435', '1203' UNION
			SELECT 'Nowy Strzelno', 'mogileński', 'kujawsko-pomorskie', '446', '5663', '1270' UNION
			SELECT 'Nowy Strzyżów', 'strzyżowski', 'podkarpackie', '1389', '8902', '641' UNION
			SELECT 'Nowy Sucha Beskidzka', 'suski', 'małopolskie', '2765', '9165', '331' UNION
			SELECT 'Nowy Suchań', 'stargardzki', 'zachodniopomorskie', '357', '1477', '414' UNION
			SELECT 'Nowy Suchedniów', 'skarżyski', 'świętokrzyskie', '5940', '8379', '141' UNION
			SELECT 'Nowy Suchowola', 'sokólski', 'podlaskie', '2595', '2180', '84' UNION
			SELECT 'Nowy Sulechów', 'zielonogórski', 'lubuskie', '688', '16925', '2460' UNION
			SELECT 'Nowy Sulejów', 'piotrkowski', 'łódzkie', '2626', '6204', '236' UNION
			SELECT 'Nowy Sulejówek', 'miński', 'mazowieckie', '1931', '19714', '1021' UNION
			SELECT 'Nowy Sulęcin', 'sulęciński', 'lubuskie', '856', '10157', '1187' UNION
			SELECT 'Nowy Sulmierzyce', 'krotoszyński', 'wielkopolskie', '2929', '2887', '99' UNION
			SELECT 'Nowy Sułkowice', 'myślenicki', 'małopolskie', '1646', '6633', '403' UNION
			SELECT 'Nowy Supraśl', 'białostocki', 'podlaskie', '569', '4622', '812' UNION
			SELECT 'Nowy Suraż', 'białostocki', 'podlaskie', '3386', '988', '29' UNION
			SELECT 'Nowy Susz', 'iławski', 'warmińsko-mazurskie', '667', '5571', '835' UNION
			SELECT 'Nowy Suwałki', 'Suwałki[a]', 'podlaskie', '6551', '69827', '1066' UNION
			SELECT 'Nowy Swarzędz', 'poznański', 'wielkopolskie', '823', '30433', '3698' UNION
			SELECT 'Nowy Syców', 'oleśnicki', 'dolnośląskie', '1705', '10420', '611' UNION
			SELECT 'Nowy Szadek', 'zduńskowolski', 'łódzkie', '1793', '1917', '107' UNION
			SELECT 'Nowy Szamocin', 'chodzieski', 'wielkopolskie', '467', '4222', '904' UNION
			SELECT 'Nowy Szamotuły', 'szamotulski', 'wielkopolskie', '1108', '18776', '1695' UNION
			SELECT 'Nowy Szczawnica', 'nowotarski', 'małopolskie', '3290', '5776', '176' UNION
			SELECT 'Nowy Szczawno-Zdrój', 'wałbrzyski', 'dolnośląskie', '1474', '5608', '380' UNION
			SELECT 'Nowy Szczebrzeszyn', 'zamojski', 'lubelskie', '2912', '5040', '173' UNION
			SELECT 'Nowy Szczecin', 'Szczecin[a]', 'zachodniopomorskie', '30060', '402465', '1339' UNION
			SELECT 'Nowy Szczecinek', 'szczecinecki', 'zachodniopomorskie', '4848', '40114', '827' UNION
			SELECT 'Nowy Szczekociny', 'zawierciański', 'śląskie', '1803', '3622', '201' UNION
			SELECT 'Nowy Szczucin', 'dąbrowski', 'małopolskie', '685', '4173', '609' UNION
			SELECT 'Nowy Szczuczyn', 'grajewski', 'podlaskie', '1323', '3394', '257' UNION
			SELECT 'Nowy Szczyrk', 'bielski', 'śląskie', '3907', '5747', '147' UNION
			SELECT 'Nowy Szczytna', 'kłodzki', 'dolnośląskie', '8038', '5163', '64' UNION
			SELECT 'Nowy Szczytno', 'szczycieński', 'warmińsko-mazurskie', '1062', '23343', '2198' UNION
			SELECT 'Nowy Szepietowo', 'wysokomazowiecki', 'podlaskie', '196', '2171', '1108' UNION
			SELECT 'Nowy Szklarska Poręba', 'jeleniogórski', 'dolnośląskie', '7544', '6611', '88' UNION
			SELECT 'Nowy Szlichtyngowa', 'wschowski', 'lubuskie', '155', '1288', '831' UNION
			SELECT 'Nowy Szprotawa', 'żagański', 'lubuskie', '1095', '11912', '1088' UNION
			SELECT 'Nowy Sztum', 'sztumski', 'pomorskie', '459', '9990', '2176' UNION
			SELECT 'Nowy Szubin', 'nakielski', 'kujawsko-pomorskie', '765', '9576', '1252' UNION
			SELECT 'Nowy Szydłowiec', 'szydłowiecki', 'mazowieckie', '2189', '11779', '538' UNION
			SELECT 'Nowy Szydłów', 'staszowski', 'świętokrzyskie', '1621', '1106', '68' UNION
			SELECT 'Nowy Ścinawa', 'lubiński', 'dolnośląskie', '1354', '5589', '413' UNION
			SELECT 'Nowy Ślesin', 'koniński', 'wielkopolskie', '718', '3151', '439' UNION
			SELECT 'Nowy Śmigiel', 'kościański', 'wielkopolskie', '530', '5703', '1076' UNION
			SELECT 'Nowy Śrem', 'śremski', 'wielkopolskie', '1237', '29714', '2402' UNION
			SELECT 'Nowy Środa Śląska', 'średzki', 'dolnośląskie', '1494', '9484', '635' UNION
			SELECT 'Nowy Środa Wielkopolska', 'średzki', 'wielkopolskie', '2192', '23312', '1064' UNION
			SELECT 'Nowy Świątniki Górne', 'krakowski', 'małopolskie', '444', '2415', '544' UNION
			SELECT 'Nowy Świdnica', 'świdnicki', 'dolnośląskie', '2176', '57310', '2634' UNION
			SELECT 'Nowy Świdnik', 'świdnicki', 'lubelskie', '2035', '39312', '1932' UNION
			SELECT 'Nowy Świdwin', 'świdwiński', 'zachodniopomorskie', '2238', '15594', '697' UNION
			SELECT 'Nowy Świebodzice', 'świdnicki', 'dolnośląskie', '3043', '22830', '750' UNION
			SELECT 'Nowy Świebodzin', 'świebodziński', 'lubuskie', '1693', '21763', '1285' UNION
			SELECT 'Nowy Świecie', 'świecki', 'kujawsko-pomorskie', '1187', '25831', '2176' UNION
			SELECT 'Nowy Świeradów-Zdrój', 'lubański', 'dolnośląskie', '2072', '4183', '202' UNION
			SELECT 'Nowy Świerzawa', 'złotoryjski', 'dolnośląskie', '176', '2291', '1302' UNION
			SELECT 'Nowy Świętochłowice', 'Świętochłowice[a]', 'śląskie', '1331', '50012', '3757' UNION
			SELECT 'Nowy Świnoujście', 'Świnoujście[a]', 'zachodniopomorskie', '20207', '40910', '202' UNION
			SELECT 'Nowy Tarczyn', 'piaseczyński', 'mazowieckie', '523', '4129', '789' UNION
			SELECT 'Nowy Tarnobrzeg', 'Tarnobrzeg[a]', 'podkarpackie', '8540', '47047', '551' UNION
			SELECT 'Nowy Tarnogród', 'biłgorajski', 'lubelskie', '1069', '3351', '313' UNION
			SELECT 'Nowy Tarnowskie Góry', 'tarnogórski', 'śląskie', '8388', '61361', '732' UNION
			SELECT 'Nowy Tarnów', 'Tarnów[a]', 'małopolskie', '7238', '109062', '1507' UNION
			SELECT 'Nowy Tczew', 'tczewski', 'pomorskie', '2238', '60279', '2693' UNION
			SELECT 'Nowy Terespol', 'bialski', 'lubelskie', '1011', '5557', '550' UNION
			SELECT 'Nowy Tłuszcz', 'wołomiński', 'mazowieckie', '791', '8157', '1031' UNION
			SELECT 'Nowy Tolkmicko', 'elbląski', 'warmińsko-mazurskie', '229', '2692', '1176' UNION
			SELECT 'Nowy Tomaszów Lubelski', 'tomaszowski', 'lubelskie', '1329', '19198', '1445' UNION
			SELECT 'Nowy Tomaszów Mazowiecki', 'tomaszowski', 'łódzkie', '4130', '62649', '1517' UNION
			SELECT 'Nowy Toruń', 'Toruń[a]', 'kujawsko-pomorskie', '11572', '202074', '1746' UNION
			SELECT 'Nowy Torzym', 'sulęciński', 'lubuskie', '911', '2524', '277' UNION
			SELECT 'Nowy Toszek', 'gliwicki', 'śląskie', '971', '3595', '370' UNION
			SELECT 'Nowy Trzcianka', 'czarnkowsko-trzcianecki', 'wielkopolskie', '1830', '17197', '940' UNION
			SELECT 'Nowy Trzciel', 'międzyrzecki', 'lubuskie', '304', '2389', '786' UNION
			SELECT 'Nowy Trzcińsko-Zdrój', 'gryfiński', 'zachodniopomorskie', '233', '2273', '976' UNION
			SELECT 'Nowy Trzebiatów', 'gryficki', 'zachodniopomorskie', '1025', '10009', '976' UNION
			SELECT 'Nowy Trzebinia', 'chrzanowski', 'małopolskie', '3194', '19846', '621' UNION
			SELECT 'Nowy Trzebnica', 'trzebnicki', 'dolnośląskie', '1061', '13322', '1256' UNION
			SELECT 'Nowy Trzemeszno', 'gnieźnieński', 'wielkopolskie', '546', '7670', '1405' UNION
			SELECT 'Nowy Tuchola', 'tucholski', 'kujawsko-pomorskie', '1769', '13680', '773' UNION
			SELECT 'Nowy Tuchów', 'tarnowski', 'małopolskie', '1810', '6671', '369' UNION
			SELECT 'Nowy Tuczno', 'wałecki', 'zachodniopomorskie', '921', '1916', '208' UNION
			SELECT 'Nowy Tuliszków', 'turecki', 'wielkopolskie', '700', '3270', '467' UNION
			SELECT 'Nowy Tułowice', 'opolski', 'opolskie', '923', '3998', '433' UNION
			SELECT 'Nowy Turek', 'turecki', 'wielkopolskie', '1617', '27109', '1676' UNION
			SELECT 'Nowy Tuszyn', 'łódzki wschodni', 'łódzkie', '2325', '7292', '314' UNION
			SELECT 'Nowy Twardogóra', 'oleśnicki', 'dolnośląskie', '829', '6716', '810' UNION
			SELECT 'Nowy Tychowo', 'białogardzki', 'zachodniopomorskie', '396', '2517', '636' UNION
			SELECT 'Nowy Tychy', 'Tychy[a]', 'śląskie', '8181', '127831', '1563' UNION
			SELECT 'Nowy Tyczyn', 'rzeszowski', 'podkarpackie', '967', '3816', '395' UNION
			SELECT 'Nowy Tykocin', 'białostocki', 'podlaskie', '2897', '1975', '68' UNION
			SELECT 'Nowy Tyszowce', 'tomaszowski', 'lubelskie', '1852', '2132', '115' UNION
			SELECT 'Nowy Ujazd', 'strzelecki', 'opolskie', '1476', '1774', '120' UNION
			SELECT 'Nowy Ujście', 'pilski', 'wielkopolskie', '578', '3697', '640' UNION
			SELECT 'Nowy Ulanów', 'niżański', 'podkarpackie', '820', '1424', '174' UNION
			SELECT 'Nowy Uniejów', 'poddębicki', 'łódzkie', '1223', '2984', '244' UNION
			SELECT 'Nowy Urzędów', 'kraśnicki', 'lubelskie', '1291', '1709', '132' UNION
			SELECT 'Nowy Ustka', 'słupski', 'pomorskie', '1019', '15527', '1524' UNION
			SELECT 'Nowy Ustroń', 'cieszyński', 'śląskie', '5903', '16054', '272' UNION
			SELECT 'Nowy Ustrzyki Dolne', 'bieszczadzki', 'podkarpackie', '1679', '9132', '544' UNION
			SELECT 'Nowy Wadowice', 'wadowicki', 'małopolskie', '1054', '18774', '1781' UNION
			SELECT 'Nowy Wałbrzych', 'Wałbrzych[a]', 'dolnośląskie', '8470', '112594', '1329' UNION
			SELECT 'Nowy Wałcz', 'wałecki', 'zachodniopomorskie', '3817', '25359', '664' UNION
			SELECT 'Nowy Warka', 'grójecki', 'mazowieckie', '2677', '11926', '445' UNION
			SELECT 'Nowy Warszawa', 'm.st. Warszawa[a]', 'mazowieckie', '51724', '1777972', '3437' UNION
			SELECT 'Nowy Warta', 'sieradzki', 'łódzkie', '1085', '3263', '301' UNION
			SELECT 'Nowy Wasilków', 'białostocki', 'podlaskie', '2826', '11384', '403' UNION
			SELECT 'Nowy Wąbrzeźno', 'wąbrzeski', 'kujawsko-pomorskie', '853', '13605', '1595' UNION
			SELECT 'Nowy Wąchock', 'starachowicki', 'świętokrzyskie', '1602', '2764', '173' UNION
			SELECT 'Nowy Wągrowiec', 'wągrowiecki', 'wielkopolskie', '1783', '25648', '1438' UNION
			SELECT 'Nowy Wąsosz', 'górowski', 'dolnośląskie', '324', '2672', '825' UNION
			SELECT 'Nowy Wejherowo', 'wejherowski', 'pomorskie', '2699', '49789', '1845' UNION
			SELECT 'Nowy Węgliniec', 'zgorzelecki', 'dolnośląskie', '873', '2860', '328' UNION
			SELECT 'Nowy Węgorzewo', 'węgorzewski', 'warmińsko-mazurskie', '1088', '11341', '1042' UNION
			SELECT 'Nowy Węgorzyno', 'łobeski', 'zachodniopomorskie', '685', '2831', '413' UNION
			SELECT 'Nowy Węgrów', 'węgrowski', 'mazowieckie', '3551', '12672', '357' UNION
			SELECT 'Nowy Wiązów', 'strzeliński', 'dolnośląskie', '916', '2257', '246' UNION
			SELECT 'Nowy Wielbark', 'szczycieński', 'warmińsko-mazurskie', '1842', '3049', '166' UNION
			SELECT 'Nowy Wieleń', 'czarnkowsko-trzcianecki', 'wielkopolskie', '446', '5919', '1327' UNION
			SELECT 'Nowy Wielichowo', 'grodziski', 'wielkopolskie', '124', '1767', '1425' UNION
			SELECT 'Nowy Wieliczka', 'wielicki', 'małopolskie', '1341', '23395', '1745' UNION
			SELECT 'Nowy Wieluń', 'wieluński', 'łódzkie', '1687', '22521', '1335' UNION
			SELECT 'Nowy Wieruszów', 'wieruszowski', 'łódzkie', '597', '8568', '1435' UNION
			SELECT 'Nowy Więcbork', 'sępoleński', 'kujawsko-pomorskie', '431', '5966', '1384' UNION
			SELECT 'Nowy Wilamowice', 'bielski', 'śląskie', '1036', '3086', '298' UNION
			SELECT 'Nowy Wisła', 'cieszyński', 'śląskie', '11017', '11171', '101' UNION
			SELECT 'Nowy Wiślica', 'buski', 'świętokrzyskie', '471', '515', '109' UNION
			SELECT 'Nowy Witkowo', 'gnieźnieński', 'wielkopolskie', '831', '7893', '950' UNION
			SELECT 'Nowy Witnica', 'gorzowski', 'lubuskie', '824', '6763', '821' UNION
			SELECT 'Nowy Wleń', 'lwówecki', 'dolnośląskie', '722', '1778', '246' UNION
			SELECT 'Nowy Władysławowo', 'pucki', 'pomorskie', '1367', '9958', '728' UNION
			SELECT 'Nowy Włocławek', 'Włocławek[a]', 'kujawsko-pomorskie', '8432', '110802', '1314' UNION
			SELECT 'Nowy Włodawa', 'włodawski', 'lubelskie', '1797', '13220', '736' UNION
			SELECT 'Nowy Włoszczowa', 'włoszczowski', 'świętokrzyskie', '3030', '10043', '331' UNION
			SELECT 'Nowy Wodzisław Śląski', 'wodzisławski', 'śląskie', '4951', '48143', '972' UNION
			SELECT 'Nowy Wojcieszów', 'złotoryjski', 'dolnośląskie', '3217', '3676', '114' UNION
			SELECT 'Nowy Wojkowice', 'będziński', 'śląskie', '1279', '8936', '699' UNION
			SELECT 'Nowy Wojnicz', 'tarnowski', 'małopolskie', '850', '3330', '392' UNION
			SELECT 'Nowy Wolbórz', 'piotrkowski', 'łódzkie', '1518', '2337', '154' UNION
			SELECT 'Nowy Wolbrom', 'olkuski', 'małopolskie', '1012', '8604', '850' UNION
			SELECT 'Nowy Wolin', 'kamieński', 'zachodniopomorskie', '1447', '4828', '334' UNION
			SELECT 'Nowy Wolsztyn', 'wolsztyński', 'wielkopolskie', '478', '13183', '2758' UNION
			SELECT 'Nowy Wołczyn', 'kluczborski', 'opolskie', '747', '5921', '793' UNION
			SELECT 'Nowy Wołomin', 'wołomiński', 'mazowieckie', '1724', '37138', '2154' UNION
			SELECT 'Nowy Wołów', 'wołowski', 'dolnośląskie', '1854', '12425', '670' UNION
			SELECT 'Nowy Woźniki', 'lubliniecki', 'śląskie', '7101', '4338', '61' UNION
			SELECT 'Nowy Wrocław', 'Wrocław[a]', 'dolnośląskie', '29282', '640648', '2188' UNION
			SELECT 'Nowy Wronki', 'szamotulski', 'wielkopolskie', '581', '11199', '1928' UNION
			SELECT 'Nowy Września', 'wrzesiński', 'wielkopolskie', '1273', '30558', '2400' UNION
			SELECT 'Nowy Wschowa', 'wschowski', 'lubuskie', '925', '13953', '1508' UNION
			SELECT 'Nowy Wyrzysk', 'pilski', 'wielkopolskie', '412', '5139', '1247' UNION
			SELECT 'Nowy Wysoka', 'pilski', 'wielkopolskie', '482', '2647', '549' UNION
			SELECT 'Nowy Wysokie Mazowieckie', 'wysokomazowiecki', 'podlaskie', '1524', '9414', '618' UNION
			SELECT 'Nowy Wyszków', 'wyszkowski', 'mazowieckie', '2078', '26890', '1294' UNION
			SELECT 'Nowy Wyszogród', 'płocki', 'mazowieckie', '1297', '2618', '202' UNION
			SELECT 'Nowy Wyśmierzyce', 'białobrzeski', 'mazowieckie', '1684', '886', '53' UNION
			SELECT 'Nowy Zabłudów', 'białostocki', 'podlaskie', '1430', '2464', '172' UNION
			SELECT 'Nowy Zabrze', 'Zabrze[a]', 'śląskie', '8040', '173374', '2156' UNION
			SELECT 'Nowy Zagórów', 'słupecki', 'wielkopolskie', '344', '3005', '874' UNION
			SELECT 'Nowy Zagórz', 'sanocki', 'podkarpackie', '2229', '5120', '230' UNION
			SELECT 'Nowy Zakliczyn', 'tarnowski', 'małopolskie', '402', '1642', '408' UNION
			SELECT 'Nowy Zaklików', 'stalowowolski', 'podkarpackie', '1142', '3013', '264' UNION
			SELECT 'Nowy Zakopane', 'tatrzański', 'małopolskie', '8426', '27191', '323' UNION
			SELECT 'Nowy Zakroczym', 'nowodworski', 'mazowieckie', '1997', '3210', '161' UNION
			SELECT 'Nowy Zalewo', 'iławski', 'warmińsko-mazurskie', '822', '2165', '263' UNION
			SELECT 'Nowy Zambrów', 'zambrowski', 'podlaskie', '1902', '22166', '1165' UNION
			SELECT 'Nowy Zamość', 'Zamość[a]', 'lubelskie', '3034', '63813', '2103' UNION
			SELECT 'Nowy Zator', 'oświęcimski', 'małopolskie', '1152', '3698', '321' UNION
			SELECT 'Nowy Zawadzkie', 'strzelecki', 'opolskie', '1646', '7168', '435' UNION
			SELECT 'Nowy Zawichost', 'sandomierski', 'świętokrzyskie', '2029', '1776', '88' UNION
			SELECT 'Nowy Zawidów', 'zgorzelecki', 'dolnośląskie', '607', '4217', '695' UNION
			SELECT 'Nowy Zawiercie', 'zawierciański', 'śląskie', '8525', '49567', '581' UNION
			SELECT 'Nowy Ząbki', 'wołomiński', 'mazowieckie', '1098', '36706', '3343' UNION
			SELECT 'Nowy Ząbkowice Śląskie', 'ząbkowicki', 'dolnośląskie', '1367', '15072', '1103' UNION
			SELECT 'Nowy Zbąszynek', 'świebodziński', 'lubuskie', '358', '5021', '1403' UNION
			SELECT 'Nowy Zbąszyń', 'nowotomyski', 'wielkopolskie', '542', '7278', '1343' UNION
			SELECT 'Nowy Zduny', 'krotoszyński', 'wielkopolskie', '620', '4534', '731' UNION
			SELECT 'Nowy Zduńska Wola', 'zduńskowolski', 'łódzkie', '2457', '42094', '1713' UNION
			SELECT 'Nowy Zdzieszowice', 'krapkowicki', 'opolskie', '1235', '11471', '929' UNION
			SELECT 'Nowy Zelów', 'bełchatowski', 'łódzkie', '1075', '7636', '710' UNION
			SELECT 'Nowy Zgierz', 'zgierski', 'łódzkie', '4233', '56529', '1335' UNION
			SELECT 'Nowy Zgorzelec', 'zgorzelecki', 'dolnośląskie', '1588', '30521', '1922' UNION
			SELECT 'Nowy Zielona Góra', 'Zielona Góra[a]', 'lubuskie', '27832', '140297', '504' UNION
			SELECT 'Nowy Zielonka', 'wołomiński', 'mazowieckie', '7948', '17589', '221' UNION
			SELECT 'Nowy Ziębice', 'ząbkowicki', 'dolnośląskie', '1507', '8759', '581' UNION
			SELECT 'Nowy Złocieniec', 'drawski', 'zachodniopomorskie', '3228', '12950', '401' UNION
			SELECT 'Nowy Złoczew', 'sieradzki', 'łódzkie', '1379', '3384', '245' UNION
			SELECT 'Nowy Złotoryja', 'złotoryjski', 'dolnośląskie', '1151', '15655', '1360' UNION
			SELECT 'Nowy Złotów', 'złotowski', 'wielkopolskie', '1158', '18446', '1593' UNION
			SELECT 'Nowy Złoty Stok', 'ząbkowicki', 'dolnośląskie', '773', '2787', '361' UNION
			SELECT 'Nowy Zwierzyniec', 'zamojski', 'lubelskie', '619', '3194', '516' UNION
			SELECT 'Nowy Zwoleń', 'zwoleński', 'mazowieckie', '1591', '7737', '486' UNION
			SELECT 'Nowy Żabno', 'tarnowski', 'małopolskie', '1113', '4248', '382' UNION
			SELECT 'Nowy Żagań', 'żagański', 'lubuskie', '4038', '25812', '639' UNION
			SELECT 'Nowy Żarki', 'myszkowski', 'śląskie', '2544', '4568', '180' UNION
			SELECT 'Nowy Żarów', 'świdnicki', 'dolnośląskie', '757', '6755', '892' UNION
			SELECT 'Nowy Żary', 'żarski', 'lubuskie', '3349', '37682', '1125' UNION
			SELECT 'Nowy Żelechów', 'garwoliński', 'mazowieckie', '1213', '3995', '329' UNION
			SELECT 'Nowy Żerków', 'jarociński', 'wielkopolskie', '216', '2132', '987' UNION
			SELECT 'Nowy Żmigród', 'trzebnicki', 'dolnośląskie', '949', '6449', '680' UNION
			SELECT 'Nowy Żnin', 'żniński', 'kujawsko-pomorskie', '835', '13934', '1669' UNION
			SELECT 'Nowy Żory', 'Żory[a]', 'śląskie', '6464', '62456', '966' UNION
			SELECT 'Nowy Żukowo', 'kartuski', 'pomorskie', '473', '6683', '1413' UNION
			SELECT 'Nowy Żuromin', 'żuromiński', 'mazowieckie', '1118', '8901', '796' UNION
			SELECT 'Nowy Żychlin', 'kutnowski', 'łódzkie', '868', '8220', '947' UNION
			SELECT 'Nowy Żyrardów', 'żyrardowski', 'mazowieckie', '1435', '39992', '2787' UNION
			SELECT 'Nowy Żywiec', 'żywiecki', 'śląskie', '5054', '31388', '621'
		)
		INSERT INTO [dbo].[Location]
		(
			[LocationNo],
			[Name],
			[RegionId],
			[Province],
			[Site],
			[Address1],
			[Address2]
		)
		SELECT
			Pom.[LocationNo],
			Pom.[Name],
			d.[Id] AS [RegionId],
			Pom.[Province],
			Pom.[Site],
			'ul. ' + Pom.[Province] + 'go ' + Pom.[Density] + '/' + Pom.[Area] AS [Address1],
			CASE WHEN LEN(Pom.[Population]) > 5 THEN 'Population: [' + Pom.[Population] + ']' ELSE NULL END AS [Address2]
		FROM
		(
			SELECT 
				ROW_NUMBER() OVER (ORDER BY c.[Name]) AS [LocationNo],
				c.[Name], 
				c.[Site], 
				c.[Province], 
				c.[Area], 
				c.[Population], 
				c.[Density]
			FROM CTE c
		) AS Pom
		INNER JOIN [dbo].[Region] d ON d.[RegionNo] = Pom.[LocationNo] % 6 + 1
	END

	INSERT INTO [dbo].[Logs] ([Message], [LogType])
	SELECT '[Location] rows inserted: [' + CAST(@@ROWCOUNT AS VARCHAR) + ']', 'I'
END TRY  
BEGIN CATCH 
	INSERT INTO [dbo].[Logs] ([Message], [AdditionalMessage], [LogType])
	SELECT 
		'[Location] Insert error :[' + ERROR_MESSAGE() + ']', 
		'Line:[' + CAST(ERROR_LINE() AS VARCHAR) + ']. Error number:[' + CAST(ERROR_NUMBER() AS VARCHAR) + '].', 
		'E'
END CATCH
GO
--------------------------------------------------------------------------------------
BEGIN TRY
	
	PRINT '[Users]'
	DECLARE @UserName AS TABLE
	(
		[Name] VARCHAR(100)
	)

	-- Names fake data
	INSERT INTO @UserName ([Name])
	SELECT Pom.[Name]
	FROM
	(
		SELECT 'Ada' AS [Name] UNION
		SELECT 'Adamina' AS [Name] UNION
		SELECT 'Adela' AS [Name] UNION
		SELECT 'Adelajda' AS [Name] UNION
		SELECT 'Adriana' AS [Name] UNION
		SELECT 'Adrianna' AS [Name] UNION
		SELECT 'Agata' AS [Name] UNION
		SELECT 'Agnieszka' AS [Name] UNION
		SELECT 'Aida' AS [Name] UNION
		SELECT 'Alberta' AS [Name] UNION
		SELECT 'Albertyna' AS [Name] UNION
		SELECT 'Albina' AS [Name] UNION
		SELECT 'Aldona' AS [Name] UNION
		SELECT 'Aleksa' AS [Name] UNION
		SELECT 'Aleksandra' AS [Name] UNION
		SELECT 'Aleksja' AS [Name] UNION
		SELECT 'Alfreda' AS [Name] UNION
		SELECT 'Alicja' AS [Name] UNION
		SELECT 'Alina' AS [Name] UNION
		SELECT 'Alojza' AS [Name] UNION
		SELECT 'Amalia' AS [Name] UNION
		SELECT 'Amanda' AS [Name] UNION
		SELECT 'Amelia' AS [Name] UNION
		SELECT 'Amina' AS [Name] UNION
		SELECT 'Amira' AS [Name] UNION
		SELECT 'Anastazja' AS [Name] UNION
		SELECT 'Andrea' AS [Name] UNION
		SELECT 'Andrzeja' AS [Name] UNION
		SELECT 'Andżelika' AS [Name] UNION
		SELECT 'Aneta' AS [Name] UNION
		SELECT 'Angela' AS [Name] UNION
		SELECT 'Angelika' AS [Name] UNION
		SELECT 'Angelina' AS [Name] UNION
		SELECT 'Aniela' AS [Name] UNION
		SELECT 'Anita' AS [Name] UNION
		SELECT 'Anna' AS [Name] UNION
		SELECT 'Antonina' AS [Name] UNION
		SELECT 'Anzelma' AS [Name] UNION
		SELECT 'Apollina' AS [Name] UNION
		SELECT 'Apolonia' AS [Name] UNION
		SELECT 'Arabella' AS [Name] UNION
		SELECT 'Ariadna' AS [Name] UNION
		SELECT 'Arleta' AS [Name] UNION
		SELECT 'Arnolda' AS [Name] UNION
		SELECT 'Astryda' AS [Name] UNION
		SELECT 'Atena' AS [Name] UNION
		SELECT 'Augusta' AS [Name] UNION
		SELECT 'Augustyna' AS [Name] UNION
		SELECT 'Aurelia' AS [Name] UNION
		SELECT 'B' AS [Name] UNION
		SELECT 'Babeta' AS [Name] UNION
		SELECT 'Balbina' AS [Name] UNION
		SELECT 'Barbara' AS [Name] UNION
		SELECT 'Bartłomieja' AS [Name] UNION
		SELECT 'Beata' AS [Name] UNION
		SELECT 'Beatrycja' AS [Name] UNION
		SELECT 'Beatrycze' AS [Name] UNION
		SELECT 'Beatryksa' AS [Name] UNION
		SELECT 'Benedykta' AS [Name] UNION
		SELECT 'Beniamina' AS [Name] UNION
		SELECT 'Benigna' AS [Name] UNION
		SELECT 'Berenika' AS [Name] UNION
		SELECT 'Bernarda' AS [Name] UNION
		SELECT 'Bernadeta' AS [Name] UNION
		SELECT 'Berta' AS [Name] UNION
		SELECT 'Betina' AS [Name] UNION
		SELECT 'Bianka' AS [Name] UNION
		SELECT 'Bibiana' AS [Name] UNION
		SELECT 'Blanka' AS [Name] UNION
		SELECT 'Błażena' AS [Name] UNION
		SELECT 'Bogdana' AS [Name] UNION
		SELECT 'Bogna' AS [Name] UNION
		SELECT 'Boguchwała' AS [Name] UNION
		SELECT 'Bogumiła' AS [Name] UNION
		SELECT 'Bogusława' AS [Name] UNION
		SELECT 'Bojana' AS [Name] UNION
		SELECT 'Bolesława' AS [Name] UNION
		SELECT 'Bona' AS [Name] UNION
		SELECT 'Bożena' AS [Name] UNION
		SELECT 'Bromira' AS [Name] UNION
		SELECT 'Bronisława' AS [Name] UNION
		SELECT 'Brunhilda' AS [Name] UNION
		SELECT 'Brygida' AS [Name] UNION
		SELECT 'C' AS [Name] UNION
		SELECT 'Cecylia' AS [Name] UNION
		SELECT 'Celestyna' AS [Name] UNION
		SELECT 'Celina' AS [Name] UNION
		SELECT 'Cezaria' AS [Name] UNION
		SELECT 'Cezaryna' AS [Name] UNION
		SELECT 'Celestia' AS [Name] UNION
		SELECT 'Chociemira' AS [Name] UNION
		SELECT 'Chwalisława' AS [Name] UNION
		SELECT 'Ciechosława' AS [Name] UNION
		SELECT 'Ciesława' AS [Name] UNION
		SELECT 'Cinosława' AS [Name] UNION
		SELECT 'Cina' AS [Name] UNION
		SELECT 'Czesława' AS [Name] UNION
		SELECT 'D' AS [Name] UNION
		SELECT 'Dajmira' AS [Name] UNION
		SELECT 'Dagna' AS [Name] UNION
		SELECT 'Dagmara' AS [Name] UNION
		SELECT 'Dalia' AS [Name] UNION
		SELECT 'Dalila' AS [Name] UNION
		SELECT 'Dalmira' AS [Name] UNION
		SELECT 'Damroka' AS [Name] UNION
		SELECT 'Dana' AS [Name] UNION
		SELECT 'Daniela' AS [Name] UNION
		SELECT 'Danisława' AS [Name] UNION
		SELECT 'Danuta' AS [Name] UNION
		SELECT 'Dargomira' AS [Name] UNION
		SELECT 'Dargosława' AS [Name] UNION
		SELECT 'Daria' AS [Name] UNION
		SELECT 'Dąbrówka' AS [Name] UNION
		SELECT 'Delfina' AS [Name] UNION
		SELECT 'Delia' AS [Name] UNION
		SELECT 'Deresa' AS [Name] UNION
		SELECT 'Desreta' AS [Name] UNION
		SELECT 'Delinda' AS [Name] UNION
		SELECT 'Diana' AS [Name] UNION
		SELECT 'Dilara' AS [Name] UNION
		SELECT 'Dobiesława' AS [Name] UNION
		SELECT 'Dobrochna' AS [Name] UNION
		SELECT 'Domasława' AS [Name] UNION
		SELECT 'Dominika' AS [Name] UNION
		SELECT 'Donata' AS [Name] UNION
		SELECT 'Dorosława' AS [Name] UNION
		SELECT 'Dorota' AS [Name] UNION
		SELECT 'Dymfna' AS [Name] UNION
		SELECT 'Dyzma' AS [Name] UNION
		SELECT 'Dżanan' AS [Name] UNION
		SELECT 'Dżamila' AS [Name] UNION
		SELECT 'Dżesika' AS [Name] UNION
		SELECT 'E' AS [Name] UNION
		SELECT 'Edeltrauda, Edeltruda' AS [Name] UNION
		SELECT 'Edyta' AS [Name] UNION
		SELECT 'Eleonora' AS [Name] UNION
		SELECT 'Eliza' AS [Name] UNION
		SELECT 'Elena' AS [Name] UNION
		SELECT 'Elwira' AS [Name] UNION
		SELECT 'Elżbieta' AS [Name] UNION
		SELECT 'Elmira' AS [Name] UNION
		SELECT 'Elora' AS [Name] UNION
		SELECT 'Emanuela' AS [Name] UNION
		SELECT 'Emilia' AS [Name] UNION
		SELECT 'Emina' AS [Name] UNION
		SELECT 'Emma' AS [Name] UNION
		SELECT 'Ernesta' AS [Name] UNION
		SELECT 'Ernestyna' AS [Name] UNION
		SELECT 'Eryka' AS [Name] UNION
		SELECT 'Estera' AS [Name] UNION
		SELECT 'Eugenia' AS [Name] UNION
		SELECT 'Eunika' AS [Name] UNION
		SELECT 'Ewa' AS [Name] UNION
		SELECT 'Ewarysta' AS [Name] UNION
		SELECT 'Ewelina' AS [Name] UNION
		SELECT 'F' AS [Name] UNION
		SELECT 'Fabia' AS [Name] UNION
		SELECT 'Faria' AS [Name] UNION
		SELECT 'Fabiana' AS [Name] UNION
		SELECT 'Fabiola' AS [Name] UNION
		SELECT 'Farida' AS [Name] UNION
		SELECT 'Fatima' AS [Name] UNION
		SELECT 'Fatma' AS [Name] UNION
		SELECT 'Faustyna' AS [Name] UNION
		SELECT 'Fera' AS [Name] UNION
		SELECT 'Felicja' AS [Name] UNION
		SELECT 'Felicjana' AS [Name] UNION
		SELECT 'Felicyta' AS [Name] UNION
		SELECT 'Feliksa' AS [Name] UNION
		SELECT 'Ferdynanda' AS [Name] UNION
		SELECT 'Filipa' AS [Name] UNION
		SELECT 'Filipina' AS [Name] UNION
		SELECT 'Filomena' AS [Name] UNION
		SELECT 'Flora' AS [Name] UNION
		SELECT 'Florentyna' AS [Name] UNION
		SELECT 'Floriana' AS [Name] UNION
		SELECT 'Franciszka' AS [Name] UNION
		SELECT 'Fryderyka' AS [Name] UNION
		SELECT 'G' AS [Name] UNION
		SELECT 'Gabriela' AS [Name] UNION
		SELECT 'Gaja' AS [Name] UNION
		SELECT 'Genowefa' AS [Name] UNION
		SELECT 'Gerarda' AS [Name] UNION
		SELECT 'Gertruda' AS [Name] UNION
		SELECT 'Gizela' AS [Name] UNION
		SELECT 'Gloria' AS [Name] UNION
		SELECT 'Gniewomira' AS [Name] UNION
		SELECT 'Gracja' AS [Name] UNION
		SELECT 'Gracjana' AS [Name] UNION
		SELECT 'Grażyna' AS [Name] UNION
		SELECT 'Greta' AS [Name] UNION
		SELECT 'Gryzelda' AS [Name] UNION
		SELECT 'Grzymisława' AS [Name] UNION
		SELECT 'Grzymsława' AS [Name] UNION
		SELECT 'Gustawa' AS [Name] UNION
		SELECT 'Gwidona' AS [Name] UNION
		SELECT 'H' AS [Name] UNION
		SELECT 'Hadriana' AS [Name] UNION
		SELECT 'Halina' AS [Name] UNION
		SELECT 'Halszka' AS [Name] UNION
		SELECT 'Hanna' AS [Name] UNION
		SELECT 'Helena' AS [Name] UNION
		SELECT 'Helga' AS [Name] UNION
		SELECT 'Henrieta' AS [Name] UNION
		SELECT 'Henryka' AS [Name] UNION
		SELECT 'Herma' AS [Name] UNION
		SELECT 'Hermana' AS [Name] UNION
		SELECT 'Hermenegilda' AS [Name] UNION
		SELECT 'Hermina' AS [Name] UNION
		SELECT 'Hestia' AS [Name] UNION
		SELECT 'Hiacynta' AS [Name] UNION
		SELECT 'Hilaria' AS [Name] UNION
		SELECT 'Hildegarda' AS [Name] UNION
		SELECT 'Hipolita' AS [Name] UNION
		SELECT 'Honorata' AS [Name] UNION
		SELECT 'Hortensja' AS [Name] UNION
		SELECT 'Huberta' AS [Name] UNION
		SELECT 'I' AS [Name] UNION
		SELECT 'Ida' AS [Name] UNION
		SELECT 'Idosława' AS [Name] UNION
		SELECT 'Idzia' AS [Name] UNION
		SELECT 'Idalia' AS [Name] UNION
		SELECT 'Idzisława' AS [Name] UNION
		SELECT 'Iga' AS [Name] UNION
		SELECT 'Ildefonsa' AS [Name] UNION
		SELECT 'Ilga' AS [Name] UNION
		SELECT 'Ilia' AS [Name] UNION
		SELECT 'Iliana' AS [Name] UNION
		SELECT 'Ilona' AS [Name] UNION
		SELECT 'Ilza' AS [Name] UNION
		SELECT 'Inga' AS [Name] UNION
		SELECT 'Inka' AS [Name] UNION
		SELECT 'Ingeborga' AS [Name] UNION
		SELECT 'Ingryda' AS [Name] UNION
		SELECT 'Irena' AS [Name] UNION
		SELECT 'Iryda' AS [Name] UNION
		SELECT 'Irina' AS [Name] UNION
		SELECT 'Ira' AS [Name] UNION
		SELECT 'Irma' AS [Name] UNION
		SELECT 'Irmina' AS [Name] UNION
		SELECT 'Iwa' AS [Name] UNION
		SELECT 'Iwona' AS [Name] UNION
		SELECT 'Izabela' AS [Name] UNION
		SELECT 'Izolda' AS [Name] UNION
		SELECT 'Izydora' AS [Name] UNION
		SELECT 'J' AS [Name] UNION
		SELECT 'Jadwiga' AS [Name] UNION
		SELECT 'Jagoda' AS [Name] UNION
		SELECT 'Jagna' AS [Name] UNION
		SELECT 'Jana' AS [Name] UNION
		SELECT 'Janina' AS [Name] UNION
		SELECT 'Jarmiła' AS [Name] UNION
		SELECT 'Jaromiła' AS [Name] UNION
		SELECT 'Jaromira' AS [Name] UNION
		SELECT 'Jarosława' AS [Name] UNION
		SELECT 'Jasława' AS [Name] UNION
		SELECT 'Jaśmina' AS [Name] UNION
		SELECT 'Joachima' AS [Name] UNION
		SELECT 'Joanna' AS [Name] UNION
		SELECT 'Jolanta' AS [Name] UNION
		SELECT 'Jowita' AS [Name] UNION
		SELECT 'Józefa' AS [Name] UNION
		SELECT 'Józefina' AS [Name] UNION
		SELECT 'Judyta' AS [Name] UNION
		SELECT 'Julia' AS [Name] UNION
		SELECT 'Julianna' AS [Name] UNION
		SELECT 'Julisława' AS [Name] UNION
		SELECT 'Julita' AS [Name] UNION
		SELECT 'Justyna' AS [Name] UNION
		SELECT 'Juta' AS [Name] UNION
		SELECT 'K' AS [Name] UNION
		SELECT 'Kaja' AS [Name] UNION
		SELECT 'Kama' AS [Name] UNION
		SELECT 'Kalina' AS [Name] UNION
		SELECT 'Kamila' AS [Name] UNION
		SELECT 'Kamira' AS [Name] UNION
		SELECT 'Karima' AS [Name] UNION
		SELECT 'Karina' AS [Name] UNION
		SELECT 'Karola' AS [Name] UNION
		SELECT 'Karolina' AS [Name] UNION
		SELECT 'Karyna' AS [Name] UNION
		SELECT 'Katarzyna' AS [Name] UNION
		SELECT 'Kasandra' AS [Name] UNION
		SELECT 'Kazimiera' AS [Name] UNION
		SELECT 'Kiara' AS [Name] UNION
		SELECT 'Kiliana' AS [Name] UNION
		SELECT 'Kinga' AS [Name] UNION
		SELECT 'Kira' AS [Name] UNION
		SELECT 'Keira' AS [Name] UNION
		SELECT 'Keiria' AS [Name] UNION
		SELECT 'Klara' AS [Name] UNION
		SELECT 'Klarysa' AS [Name] UNION
		SELECT 'Klaudia' AS [Name] UNION
		SELECT 'Klaudyna' AS [Name] UNION
		SELECT 'Klementyna' AS [Name] UNION
		SELECT 'Kleopatra' AS [Name] UNION
		SELECT 'Klotylda' AS [Name] UNION
		SELECT 'Konstancja' AS [Name] UNION
		SELECT 'Kordula' AS [Name] UNION
		SELECT 'Kornelia' AS [Name] UNION
		SELECT 'Koryna' AS [Name] UNION
		SELECT 'Krystiana' AS [Name] UNION
		SELECT 'Krystyna' AS [Name] UNION
		SELECT 'Krzysztofa' AS [Name] UNION
		SELECT 'Ksawera' AS [Name] UNION
		SELECT 'Ksenia' AS [Name] UNION
		SELECT 'Kunegunda' AS [Name] UNION
		SELECT 'Kwiatosława' AS [Name] UNION
		SELECT 'Kwietosława' AS [Name] UNION
		SELECT 'L' AS [Name] UNION
		SELECT 'Laila' AS [Name] UNION
		SELECT 'Lajla' AS [Name] UNION
		SELECT 'Lana' AS [Name] UNION
		SELECT 'Lara' AS [Name] UNION
		SELECT 'Larisa' AS [Name] UNION
		SELECT 'Larysa' AS [Name] UNION
		SELECT 'Latifa' AS [Name] UNION
		SELECT 'Laura' AS [Name] UNION
		SELECT 'Laurencja' AS [Name] UNION
		SELECT 'Lea' AS [Name] UNION
		SELECT 'Leka' AS [Name] UNION
		SELECT 'Lejla' AS [Name] UNION
		SELECT 'Lena' AS [Name] UNION
		SELECT 'Leokadia' AS [Name] UNION
		SELECT 'Leona' AS [Name] UNION
		SELECT 'Leonarda' AS [Name] UNION
		SELECT 'Leoncja' AS [Name] UNION
		SELECT 'Leonora' AS [Name] UNION
		SELECT 'Leontyna' AS [Name] UNION
		SELECT 'Leopolda' AS [Name] UNION
		SELECT 'Letycja' AS [Name] UNION
		SELECT 'Lidia' AS [Name] UNION
		SELECT 'Lila' AS [Name] UNION
		SELECT 'Lisa' AS [Name] UNION
		SELECT 'Ligia' AS [Name] UNION
		SELECT 'Lilia' AS [Name] UNION
		SELECT 'Liliana' AS [Name] UNION
		SELECT 'Lilianna' AS [Name] UNION
		SELECT 'Linda' AS [Name] UNION
		SELECT 'Liwia' AS [Name] UNION
		SELECT 'Lora' AS [Name] UNION
		SELECT 'Luborada' AS [Name] UNION
		SELECT 'Lucjana' AS [Name] UNION
		SELECT 'Lucjola' AS [Name] UNION
		SELECT 'Lucyna' AS [Name] UNION
		SELECT 'Ludmiła' AS [Name] UNION
		SELECT 'Ludolfa' AS [Name] UNION
		SELECT 'Ludwika' AS [Name] UNION
		SELECT 'Ludwina' AS [Name] UNION
		SELECT 'Luiza' AS [Name] UNION
		SELECT 'Luna' AS [Name] UNION
		SELECT 'Lilianna' AS [Name] UNION
		SELECT 'Ł' AS [Name] UNION
		SELECT 'Ładana' AS [Name] UNION
		SELECT 'Ładysława' AS [Name] UNION
		SELECT 'Łagoda' AS [Name] UNION
		SELECT 'Łucja' AS [Name] UNION
		SELECT 'M' AS [Name] UNION
		SELECT 'Macieja' AS [Name] UNION
		SELECT 'Magda' AS [Name] UNION
		SELECT 'Magdalena' AS [Name] UNION
		SELECT 'Maja' AS [Name] UNION
		SELECT 'Maksa' AS [Name] UNION
		SELECT 'Maksyma' AS [Name] UNION
		SELECT 'Malina' AS [Name] UNION
		SELECT 'Malwina' AS [Name] UNION
		SELECT 'Małgorzata' AS [Name] UNION
		SELECT 'Manuela' AS [Name] UNION
		SELECT 'Marcela' AS [Name] UNION
		SELECT 'Marcelina' AS [Name] UNION
		SELECT 'Marcjana' AS [Name] UNION
		SELECT 'Marcjanna' AS [Name] UNION
		SELECT 'Maria' AS [Name] UNION
		SELECT 'Mariam' AS [Name] UNION
		SELECT 'Marianna' AS [Name] UNION
		SELECT 'Marietta' AS [Name] UNION
		SELECT 'Marika' AS [Name] UNION
		SELECT 'Mariola' AS [Name] UNION
		SELECT 'Marlena' AS [Name] UNION
		SELECT 'Marta' AS [Name] UNION
		SELECT 'Martyna' AS [Name] UNION
		SELECT 'Maryja' AS [Name] UNION
		SELECT 'Maryla' AS [Name] UNION
		SELECT 'Maryna' AS [Name] UNION
		SELECT 'Marzena' AS [Name] UNION
		SELECT 'Matylda' AS [Name] UNION
		SELECT 'Melania' AS [Name] UNION
		SELECT 'Michalina' AS [Name] UNION
		SELECT 'Mieczysława' AS [Name] UNION
		SELECT 'Milena' AS [Name] UNION
		SELECT 'Milomira' AS [Name] UNION
		SELECT 'Miłosława' AS [Name] UNION
		SELECT 'Miłowita' AS [Name] UNION
		SELECT 'Minerwa' AS [Name] UNION
		SELECT 'Mina' AS [Name] UNION
		SELECT 'Mira' AS [Name] UNION
		SELECT 'Mirabela' AS [Name] UNION
		SELECT 'Miranda' AS [Name] UNION
		SELECT 'Mirela' AS [Name] UNION
		SELECT 'Miriam' AS [Name] UNION
		SELECT 'Mirka' AS [Name] UNION
		SELECT 'Miroda' AS [Name] UNION
		SELECT 'Mirołada' AS [Name] UNION
		SELECT 'Mirosława' AS [Name] UNION
		SELECT 'Mojmira' AS [Name] UNION
		SELECT 'Mojra' AS [Name] UNION
		SELECT 'Monika' AS [Name] UNION
		SELECT 'Morzana' AS [Name] UNION
		SELECT 'Morzena' AS [Name] UNION
		SELECT 'N' AS [Name] UNION
		SELECT 'Nadia' AS [Name] UNION
		SELECT 'Nadzieja' AS [Name] UNION
		SELECT 'Najmiła' AS [Name] UNION
		SELECT 'Najsława' AS [Name] UNION
		SELECT 'Narcyza' AS [Name] UNION
		SELECT 'Natalia' AS [Name] UNION
		SELECT 'Natasza' AS [Name] UNION
		SELECT 'Nela' AS [Name] UNION
		SELECT 'Nika' AS [Name] UNION
		SELECT 'Nikodema' AS [Name] UNION
		SELECT 'Nikola' AS [Name] UNION
		SELECT 'Nitara' AS [Name] UNION
		SELECT 'Nikoleta' AS [Name] UNION
		SELECT 'Nina' AS [Name] UNION
		SELECT 'Nira' AS [Name] UNION
		SELECT 'Noemi' AS [Name] UNION
		SELECT 'Nora' AS [Name] UNION
		SELECT 'Norberta' AS [Name] UNION
		SELECT 'Norma' AS [Name] UNION
		SELECT 'O' AS [Name] UNION
		SELECT 'Oda' AS [Name] UNION
		SELECT 'Odeta' AS [Name] UNION
		SELECT 'Odyla' AS [Name] UNION
		SELECT 'Ofelia' AS [Name] UNION
		SELECT 'Oksana' AS [Name] UNION
		SELECT 'Oktawia' AS [Name] UNION
		SELECT 'Olga' AS [Name] UNION
		SELECT 'Olimpia' AS [Name] UNION
		SELECT 'Oliwia' AS [Name] UNION
		SELECT 'Oriana' AS [Name] UNION
		SELECT 'Ota' AS [Name] UNION
		SELECT 'Otylia' AS [Name] UNION
		SELECT 'Ożanna' AS [Name] UNION
		SELECT 'Obina' AS [Name] UNION
		SELECT 'Olena' AS [Name] UNION
		SELECT 'P' AS [Name] UNION
		SELECT 'Pabiana' AS [Name] UNION
		SELECT 'Pamela' AS [Name] UNION
		SELECT 'Patrycja' AS [Name] UNION
		SELECT 'Paula' AS [Name] UNION
		SELECT 'Paulina' AS [Name] UNION
		SELECT 'Pelagia' AS [Name] UNION
		SELECT 'Petra' AS [Name] UNION
		SELECT 'Petronela' AS [Name] UNION
		SELECT 'Petronia' AS [Name] UNION
		SELECT 'Placyda' AS [Name] UNION
		SELECT 'Pola' AS [Name] UNION
		SELECT 'Polianna' AS [Name] UNION
		SELECT 'Polmira' AS [Name] UNION
		SELECT 'Przemysława' AS [Name] UNION
		SELECT 'Przybysława' AS [Name] UNION
		SELECT 'R' AS [Name] UNION
		SELECT 'Rachela' AS [Name] UNION
		SELECT 'Ramona' AS [Name] UNION
		SELECT 'Radmiła' AS [Name] UNION
		SELECT 'Radomiła' AS [Name] UNION
		SELECT 'Radomira' AS [Name] UNION
		SELECT 'Radosława' AS [Name] UNION
		SELECT 'Rafaela' AS [Name] UNION
		SELECT 'Rajmunda' AS [Name] UNION
		SELECT 'Rajna' AS [Name] UNION
		SELECT 'Raszyda' AS [Name] UNION
		SELECT 'Rebeka' AS [Name] UNION
		SELECT 'Regina' AS [Name] UNION
		SELECT 'Remigia' AS [Name] UNION
		SELECT 'Renata' AS [Name] UNION
		SELECT 'Rejna' AS [Name] UNION
		SELECT 'Rita' AS [Name] UNION
		SELECT 'Roberta' AS [Name] UNION
		SELECT 'Rodzisława' AS [Name] UNION
		SELECT 'Roksana' AS [Name] UNION
		SELECT 'Roma' AS [Name] UNION
		SELECT 'Romana' AS [Name] UNION
		SELECT 'Romualda' AS [Name] UNION
		SELECT 'Rozalia' AS [Name] UNION
		SELECT 'Rozalinda' AS [Name] UNION
		SELECT 'Rozamunda' AS [Name] UNION
		SELECT 'Rozetta' AS [Name] UNION
		SELECT 'Rozwita' AS [Name] UNION
		SELECT 'Róża' AS [Name] UNION
		SELECT 'Rudolfina' AS [Name] UNION
		SELECT 'Rut' AS [Name] UNION
		SELECT 'Ruta' AS [Name] UNION
		SELECT 'Ryksa' AS [Name] UNION
		SELECT 'Ryta' AS [Name] UNION
		SELECT 'Ryszarda' AS [Name] UNION
		SELECT 'S' AS [Name] UNION
		SELECT 'Sabina' AS [Name] UNION
		SELECT 'Sabrina' AS [Name] UNION
		SELECT 'Sarina' AS [Name] UNION
		SELECT 'Sarita' AS [Name] UNION
		SELECT 'Safira' AS [Name] UNION
		SELECT 'Safana' AS [Name] UNION
		SELECT 'Salma' AS [Name] UNION
		SELECT 'Saloma' AS [Name] UNION
		SELECT 'Salomea' AS [Name] UNION
		SELECT 'Samanta' AS [Name] UNION
		SELECT 'Samantra' AS [Name] UNION
		SELECT 'Samara' AS [Name] UNION
		SELECT 'Sandra' AS [Name] UNION
		SELECT 'Sara' AS [Name] UNION
		SELECT 'Semira' AS [Name] UNION
		SELECT 'Sebastiana' AS [Name] UNION
		SELECT 'Selena' AS [Name] UNION
		SELECT 'Selma' AS [Name] UNION
		SELECT 'Serafina' AS [Name] UNION
		SELECT 'Seweryna' AS [Name] UNION
		SELECT 'Sędomira' AS [Name] UNION
		SELECT 'Sędzisława' AS [Name] UNION
		SELECT 'Sława' AS [Name] UNION
		SELECT 'Sławina' AS [Name] UNION
		SELECT 'Sławomira' AS [Name] UNION
		SELECT 'Sobiesława' AS [Name] UNION
		SELECT 'Sonia' AS [Name] UNION
		SELECT 'Stamira' AS [Name] UNION
		SELECT 'Stanisława' AS [Name] UNION
		SELECT 'Stefania' AS [Name] UNION
		SELECT 'Stela' AS [Name] UNION
		SELECT 'Stoisława' AS [Name] UNION
		SELECT 'Stella' AS [Name] UNION
		SELECT 'Strzeżymira' AS [Name] UNION
		SELECT 'Subisława' AS [Name] UNION
		SELECT 'Sulima' AS [Name] UNION
		SELECT 'Sulisława' AS [Name] UNION
		SELECT 'Sybilla' AS [Name] UNION
		SELECT 'Sydonia' AS [Name] UNION
		SELECT 'Sylwana' AS [Name] UNION
		SELECT 'Sylwia' AS [Name] UNION
		SELECT 'Szarlota' AS [Name] UNION
		SELECT 'Szarlin' AS [Name] UNION
		SELECT 'Szarlina' AS [Name] UNION
		SELECT 'Szejma' AS [Name] UNION
		SELECT 'Szymona' AS [Name] UNION
		SELECT 'Ś' AS [Name] UNION
		SELECT 'Świetlana' AS [Name] UNION
		SELECT 'Świętomira' AS [Name] UNION
		SELECT 'Świętosława' AS [Name] UNION
		SELECT 'T' AS [Name] UNION
		SELECT 'Tabita' AS [Name] UNION
		SELECT 'Tacjana' AS [Name] UNION
		SELECT 'Tadea' AS [Name] UNION
		SELECT 'Tamara' AS [Name] UNION
		SELECT 'Tatiana' AS [Name] UNION
		SELECT 'Tekla' AS [Name] UNION
		SELECT 'Telimena' AS [Name] UNION
		SELECT 'Teodora' AS [Name] UNION
		SELECT 'Teodozja' AS [Name] UNION
		SELECT 'Teofila' AS [Name] UNION
		SELECT 'Teresa' AS [Name] UNION
		SELECT 'Tęgomira' AS [Name] UNION
		SELECT 'Tina' AS [Name] UNION
		SELECT 'Tolisława' AS [Name] UNION
		SELECT 'Tomiła' AS [Name] UNION
		SELECT 'Tomisława' AS [Name] UNION
		SELECT 'Tulimira' AS [Name] UNION
		SELECT 'Tessa' AS [Name] UNION
		SELECT 'Tymora' AS [Name] UNION
		SELECT 'Tyria' AS [Name] UNION
		SELECT 'Tybita' AS [Name] UNION
		SELECT 'Tybilla' AS [Name] UNION
		SELECT 'U' AS [Name] UNION
		SELECT 'Ulana' AS [Name] UNION
		SELECT 'Ulryka' AS [Name] UNION
		SELECT 'Unima' AS [Name] UNION
		SELECT 'Urszula' AS [Name] UNION
		SELECT 'Uta' AS [Name] UNION
		SELECT 'W' AS [Name] UNION
		SELECT 'Wacława' AS [Name] UNION
		SELECT 'Walentyna' AS [Name] UNION
		SELECT 'Waleria' AS [Name] UNION
		SELECT 'Wanda' AS [Name] UNION
		SELECT 'Wanessa' AS [Name] UNION
		SELECT 'Weronika' AS [Name] UNION
		SELECT 'Weridiana' AS [Name] UNION
		SELECT 'Wiara' AS [Name] UNION
		SELECT 'Wiesława' AS [Name] UNION
		SELECT 'Wierzchosława' AS [Name] UNION
		SELECT 'Wiktoria' AS [Name] UNION
		SELECT 'Wiktoryna' AS [Name] UNION
		SELECT 'Wilhelmina' AS [Name] UNION
		SELECT 'Wincentyna' AS [Name] UNION
		SELECT 'Wioleta' AS [Name] UNION
		SELECT 'Wioletta' AS [Name] UNION
		SELECT 'Wirgilia' AS [Name] UNION
		SELECT 'Wirginia' AS [Name] UNION
		SELECT 'Wisława' AS [Name] UNION
		SELECT 'Witosława' AS [Name] UNION
		SELECT 'Władysława' AS [Name] UNION
		SELECT 'Włodzimiera' AS [Name] UNION
		SELECT 'Wolimira' AS [Name] UNION
		SELECT 'Wrocisława' AS [Name] UNION
		SELECT 'Z' AS [Name] UNION
		SELECT 'Zaida' AS [Name] UNION
		SELECT 'Zaira' AS [Name] UNION
		SELECT 'Zdzisława' AS [Name] UNION
		SELECT 'Zefiryna' AS [Name] UNION
		SELECT 'Zenobia' AS [Name] UNION
		SELECT 'Zenona' AS [Name] UNION
		SELECT 'Zofia' AS [Name] UNION
		SELECT 'Zoja' AS [Name] UNION
		SELECT 'Zuzanna' AS [Name] UNION
		SELECT 'Zwinisława' AS [Name] UNION
		SELECT 'Zygfryda' AS [Name] UNION
		SELECT 'Zygmunta' AS [Name] UNION
		SELECT 'Zyta' AS [Name] UNION
		SELECT 'Ż' AS [Name] UNION
		SELECT 'Żaklina' AS [Name] UNION
		SELECT 'Żaneta' AS [Name] UNION
		SELECT 'Żanna' AS [Name] UNION
		SELECT 'Żelisława' AS [Name] UNION
		SELECT 'Żużanna' AS [Name] UNION
		SELECT 'Żywia' AS [Name] UNION
		SELECT 'Żywisława' AS [Name] UNION
		SELECT 'Imiona męskie' AS [Name] UNION
		SELECT 'A' AS [Name] UNION
		SELECT 'Aaron' AS [Name] UNION
		SELECT 'Abdon' AS [Name] UNION
		SELECT 'Abel' AS [Name] UNION
		SELECT 'Abelard' AS [Name] UNION
		SELECT 'Abraham' AS [Name] UNION
		SELECT 'Achilles' AS [Name] UNION
		SELECT 'Adam' AS [Name] UNION
		SELECT 'Adelard' AS [Name] UNION
		SELECT 'Adnan' AS [Name] UNION
		SELECT 'Adrian' AS [Name] UNION
		SELECT 'Agapit' AS [Name] UNION
		SELECT 'Agaton' AS [Name] UNION
		SELECT 'Agrypin' AS [Name] UNION
		SELECT 'Ajdin' AS [Name] UNION
		SELECT 'Albert' AS [Name] UNION
		SELECT 'Alan' AS [Name] UNION
		SELECT 'Albin' AS [Name] UNION
		SELECT 'Albrecht' AS [Name] UNION
		SELECT 'Aleks' AS [Name] UNION
		SELECT 'Aleksander' AS [Name] UNION
		SELECT 'Aleksy' AS [Name] UNION
		SELECT 'Alfons' AS [Name] UNION
		SELECT 'Alfred' AS [Name] UNION
		SELECT 'Alojzy' AS [Name] UNION
		SELECT 'Alwin' AS [Name] UNION
		SELECT 'Amadeusz' AS [Name] UNION
		SELECT 'Ambroży' AS [Name] UNION
		SELECT 'Anastazy' AS [Name] UNION
		SELECT 'Ananiasz' AS [Name] UNION
		SELECT 'Anatol' AS [Name] UNION
		SELECT 'Andrzej' AS [Name] UNION
		SELECT 'Anioł' AS [Name] UNION
		SELECT 'Annasz' AS [Name] UNION
		SELECT 'Antoni' AS [Name] UNION
		SELECT 'Antonin' AS [Name] UNION
		SELECT 'Antonius' AS [Name] UNION
		SELECT 'Anzelm' AS [Name] UNION
		SELECT 'Apolinary' AS [Name] UNION
		SELECT 'Apollo' AS [Name] UNION
		SELECT 'Apoloniusz' AS [Name] UNION
		SELECT 'Ariel' AS [Name] UNION
		SELECT 'Arkadiusz' AS [Name] UNION
		SELECT 'Arkady' AS [Name] UNION
		SELECT 'Arnold' AS [Name] UNION
		SELECT 'Artur' AS [Name] UNION
		SELECT 'August' AS [Name] UNION
		SELECT 'Augustyn' AS [Name] UNION
		SELECT 'Aurelian' AS [Name] UNION
		SELECT 'B' AS [Name] UNION
		SELECT 'Baldwin' AS [Name] UNION
		SELECT 'Baltazar' AS [Name] UNION
		SELECT 'Barabasz' AS [Name] UNION
		SELECT 'Barnaba' AS [Name] UNION
		SELECT 'Barnim' AS [Name] UNION
		SELECT 'Bartłomiej' AS [Name] UNION
		SELECT 'Bartosz' AS [Name] UNION
		SELECT 'Bazyli' AS [Name] UNION
		SELECT 'Beat' AS [Name] UNION
		SELECT 'Benedykt' AS [Name] UNION
		SELECT 'Beniamin' AS [Name] UNION
		SELECT 'Benon' AS [Name] UNION
		SELECT 'Bernard' AS [Name] UNION
		SELECT 'Bert' AS [Name] UNION
		SELECT 'Błażej' AS [Name] UNION
		SELECT 'Bodosław' AS [Name] UNION
		SELECT 'Bogdał' AS [Name] UNION
		SELECT 'Bogdan' AS [Name] UNION
		SELECT 'Boguchwał' AS [Name] UNION
		SELECT 'Bogumił' AS [Name] UNION
		SELECT 'Bogumir' AS [Name] UNION
		SELECT 'Bogusław' AS [Name] UNION
		SELECT 'Bogusz' AS [Name] UNION
		SELECT 'Bolebor' AS [Name] UNION
		SELECT 'Bolelut' AS [Name] UNION
		SELECT 'Bolesław' AS [Name] UNION
		SELECT 'Bonawentura' AS [Name] UNION
		SELECT 'Bonifacy' AS [Name] UNION
		SELECT 'Borys' AS [Name] UNION
		SELECT 'Borysław' AS [Name] UNION
		SELECT 'Borzywoj' AS [Name] UNION
		SELECT 'Bożan' AS [Name] UNION
		SELECT 'Bożidar' AS [Name] UNION
		SELECT 'Bożydar' AS [Name] UNION
		SELECT 'Bożimir' AS [Name] UNION
		SELECT 'Bromir' AS [Name] UNION
		SELECT 'Bronisław' AS [Name] UNION
		SELECT 'Bruno' AS [Name] UNION
		SELECT 'Brunon' AS [Name] UNION
		SELECT 'Budzisław' AS [Name] UNION
		SELECT 'C' AS [Name] UNION
		SELECT 'Cecyl' AS [Name] UNION
		SELECT 'Cecylian' AS [Name] UNION
		SELECT 'Celestyn' AS [Name] UNION
		SELECT 'Cezar' AS [Name] UNION
		SELECT 'Cezary' AS [Name] UNION
		SELECT 'Chociemir' AS [Name] UNION
		SELECT 'Chrystian' AS [Name] UNION
		SELECT 'Chwalibóg' AS [Name] UNION
		SELECT 'Chwalimir' AS [Name] UNION
		SELECT 'Chwalisław' AS [Name] UNION
		SELECT 'Cichosław' AS [Name] UNION
		SELECT 'Ciechosław' AS [Name] UNION
		SELECT 'Cyprian' AS [Name] UNION
		SELECT 'Cyryl' AS [Name] UNION
		SELECT 'Czesław' AS [Name] UNION
		SELECT 'D' AS [Name] UNION
		SELECT 'Dacjusz' AS [Name] UNION
		SELECT 'Dajmir' AS [Name] UNION
		SELECT 'Dal' AS [Name] UNION
		SELECT 'Dalbor' AS [Name] UNION
		SELECT 'Dalgur' AS [Name] UNION
		SELECT 'Damazy' AS [Name] UNION
		SELECT 'Damian' AS [Name] UNION
		SELECT 'Daniel' AS [Name] UNION
		SELECT 'Danisław' AS [Name] UNION
		SELECT 'Danko' AS [Name] UNION
		SELECT 'Dargomir' AS [Name] UNION
		SELECT 'Dargosław' AS [Name] UNION
		SELECT 'Dariusz' AS [Name] UNION
		SELECT 'Darwit' AS [Name] UNION
		SELECT 'Dawid' AS [Name] UNION
		SELECT 'Denis' AS [Name] UNION
		SELECT 'Derwit' AS [Name] UNION
		SELECT 'Dionizy' AS [Name] UNION
		SELECT 'Dobiesław' AS [Name] UNION
		SELECT 'Dobrogost' AS [Name] UNION
		SELECT 'Dobrosław' AS [Name] UNION
		SELECT 'Domasław' AS [Name] UNION
		SELECT 'Dominik' AS [Name] UNION
		SELECT 'Donald' AS [Name] UNION
		SELECT 'Donat' AS [Name] UNION
		SELECT 'Dorian' AS [Name] UNION
		SELECT 'Duszan' AS [Name] UNION
		SELECT 'Dymitr' AS [Name] UNION
		SELECT 'Dyter' AS [Name] UNION
		SELECT 'Dzwonimierz' AS [Name] UNION
		SELECT 'Dżamil' AS [Name] UNION
		SELECT 'Dżan' AS [Name] UNION
		SELECT 'Dżem' AS [Name] UNION
		SELECT 'Dżemil' AS [Name] UNION
		SELECT 'E' AS [Name] UNION
		SELECT 'Edgar' AS [Name] UNION
		SELECT 'Edmund' AS [Name] UNION
		SELECT 'Edward' AS [Name] UNION
		SELECT 'Edwin' AS [Name] UNION
		SELECT 'Efraim' AS [Name] UNION
		SELECT 'Efrem' AS [Name] UNION
		SELECT 'Eliasz' AS [Name] UNION
		SELECT 'Eligiusz' AS [Name] UNION
		SELECT 'Eliot' AS [Name] UNION
		SELECT 'Emanuel' AS [Name] UNION
		SELECT 'Emil' AS [Name] UNION
		SELECT 'Emir' AS [Name] UNION
		SELECT 'Erazm' AS [Name] UNION
		SELECT 'Ernest' AS [Name] UNION
		SELECT 'Erwin' AS [Name] UNION
		SELECT 'Eugeniusz' AS [Name] UNION
		SELECT 'Eryk' AS [Name] UNION
		SELECT 'Ewald' AS [Name] UNION
		SELECT 'Ewaryst' AS [Name] UNION
		SELECT 'Ezaw' AS [Name] UNION
		SELECT 'Ezechiel' AS [Name] UNION
		SELECT 'F' AS [Name] UNION
		SELECT 'Fabian' AS [Name] UNION
		SELECT 'Famian' AS [Name] UNION
		SELECT 'Farid' AS [Name] UNION
		SELECT 'Faris' AS [Name] UNION
		SELECT 'Faustyn' AS [Name] UNION
		SELECT 'Felicjan' AS [Name] UNION
		SELECT 'Feliks' AS [Name] UNION
		SELECT 'Ferdynand' AS [Name] UNION
		SELECT 'Filip' AS [Name] UNION
		SELECT 'Florentyn' AS [Name] UNION
		SELECT 'Florian' AS [Name] UNION
		SELECT 'Fortunat' AS [Name] UNION
		SELECT 'Franciszek' AS [Name] UNION
		SELECT 'Fryc' AS [Name] UNION
		SELECT 'Fryderyk' AS [Name] UNION
		SELECT 'G' AS [Name] UNION
		SELECT 'Gabriel' AS [Name] UNION
		SELECT 'Gaj' AS [Name] UNION
		SELECT 'Gardomir' AS [Name] UNION
		SELECT 'Gaweł' AS [Name] UNION
		SELECT 'Gerard' AS [Name] UNION
		SELECT 'Gerwazy' AS [Name] UNION
		SELECT 'Gilbert' AS [Name] UNION
		SELECT 'Ginter' AS [Name] UNION
		SELECT 'Gniewomir' AS [Name] UNION
		SELECT 'Gniewosz' AS [Name] UNION
		SELECT 'Godehard' AS [Name] UNION
		SELECT 'Godfryg' AS [Name] UNION
		SELECT 'Godfryd' AS [Name] UNION
		SELECT 'Godzisław' AS [Name] UNION
		SELECT 'Gościsław' AS [Name] UNION
		SELECT 'Gotard' AS [Name] UNION
		SELECT 'Gotszalk' AS [Name] UNION
		SELECT 'Gracjan' AS [Name] UNION
		SELECT 'Grodzisław' AS [Name] UNION
		SELECT 'Grzegorz' AS [Name] UNION
		SELECT 'Grzymisław' AS [Name] UNION
		SELECT 'Gualfard' AS [Name] UNION
		SELECT 'Gustaw' AS [Name] UNION
		SELECT 'Gwalbert' AS [Name] UNION
		SELECT 'Gwido' AS [Name] UNION
		SELECT 'Gwidon' AS [Name] UNION
		SELECT 'H' AS [Name] UNION
		SELECT 'Hadrian' AS [Name] UNION
		SELECT 'Hasan' AS [Name] UNION
		SELECT 'Hektor' AS [Name] UNION
		SELECT 'Heliodor' AS [Name] UNION
		SELECT 'Henryk' AS [Name] UNION
		SELECT 'Herakles' AS [Name] UNION
		SELECT 'Herakliusz' AS [Name] UNION
		SELECT 'Herbert' AS [Name] UNION
		SELECT 'Herman' AS [Name] UNION
		SELECT 'Hermes' AS [Name] UNION
		SELECT 'Hiacynt' AS [Name] UNION
		SELECT 'Hieronim' AS [Name] UNION
		SELECT 'Hilary' AS [Name] UNION
		SELECT 'Hipolit' AS [Name] UNION
		SELECT 'Honorat' AS [Name] UNION
		SELECT 'Horacy' AS [Name] UNION
		SELECT 'Hubert' AS [Name] UNION
		SELECT 'Hugo' AS [Name] UNION
		SELECT 'Hugon' AS [Name] UNION
		SELECT 'Husajn' AS [Name] UNION
		SELECT 'I' AS [Name] UNION
		SELECT 'Idzi' AS [Name] UNION
		SELECT 'Ignacy' AS [Name] UNION
		SELECT 'Igor' AS [Name] UNION
		SELECT 'Ildefons' AS [Name] UNION
		SELECT 'Inocenty' AS [Name] UNION
		SELECT 'Ireneusz' AS [Name] UNION
		SELECT 'Iwan' AS [Name] UNION
		SELECT 'Iwo' AS [Name] UNION
		SELECT 'Iwon' AS [Name] UNION
		SELECT 'Izajasz' AS [Name] UNION
		SELECT 'Izydor' AS [Name] UNION
		SELECT 'J' AS [Name] UNION
		SELECT 'Jacek' AS [Name] UNION
		SELECT 'Jacenty' AS [Name] UNION
		SELECT 'Jakub' AS [Name] UNION
		SELECT 'Jan' AS [Name] UNION
		SELECT 'January' AS [Name] UNION
		SELECT 'Janusz' AS [Name] UNION
		SELECT 'Jarad' AS [Name] UNION
		SELECT 'Jaromir' AS [Name] UNION
		SELECT 'Jaropełk' AS [Name] UNION
		SELECT 'Jarosław' AS [Name] UNION
		SELECT 'Jarowit' AS [Name] UNION
		SELECT 'Jeremiasz' AS [Name] UNION
		SELECT 'Jerzy' AS [Name] UNION
		SELECT 'Jędrzej' AS [Name] UNION
		SELECT 'Joachim' AS [Name] UNION
		SELECT 'Jona' AS [Name] UNION
		SELECT 'Jonasz' AS [Name] UNION
		SELECT 'Jonatan' AS [Name] UNION
		SELECT 'Jozafat' AS [Name] UNION
		SELECT 'Józef' AS [Name] UNION
		SELECT 'Józefat' AS [Name] UNION
		SELECT 'Julian' AS [Name] UNION
		SELECT 'Juliusz' AS [Name] UNION
		SELECT 'Jur' AS [Name] UNION
		SELECT 'Juri' AS [Name] UNION
		SELECT 'Justyn' AS [Name] UNION
		SELECT 'Justynian' AS [Name] UNION
		SELECT 'Jasuf' AS [Name] UNION
		SELECT 'K' AS [Name] UNION
		SELECT 'Kacper' AS [Name] UNION
		SELECT 'Kajetan' AS [Name] UNION
		SELECT 'Kajfasz' AS [Name] UNION
		SELECT 'Kajusz' AS [Name] UNION
		SELECT 'Kamil' AS [Name] UNION
		SELECT 'Kanimir' AS [Name] UNION
		SELECT 'Karol' AS [Name] UNION
		SELECT 'Kasjusz' AS [Name] UNION
		SELECT 'Kasper' AS [Name] UNION
		SELECT 'Kastor' AS [Name] UNION
		SELECT 'Kazimierz' AS [Name] UNION
		SELECT 'Kemal' AS [Name] UNION
		SELECT 'Kilian' AS [Name] UNION
		SELECT 'Klaudiusz' AS [Name] UNION
		SELECT 'Klemens' AS [Name] UNION
		SELECT 'Kochan' AS [Name] UNION
		SELECT 'Konrad' AS [Name] UNION
		SELECT 'Konradyn' AS [Name] UNION
		SELECT 'Konstancjusz' AS [Name] UNION
		SELECT 'Konstanty' AS [Name] UNION
		SELECT 'Konstantyn' AS [Name] UNION
		SELECT 'Kordian' AS [Name] UNION
		SELECT 'Kornel' AS [Name] UNION
		SELECT 'Korneli' AS [Name] UNION
		SELECT 'Korneliusz' AS [Name] UNION
		SELECT 'Kosma' AS [Name] UNION
		SELECT 'Kryspin' AS [Name] UNION
		SELECT 'Krystian' AS [Name] UNION
		SELECT 'Krystyn' AS [Name] UNION
		SELECT 'Krzesimir' AS [Name] UNION
		SELECT 'Krzesisław' AS [Name] UNION
		SELECT 'Krzysztof' AS [Name] UNION
		SELECT 'Ksawery' AS [Name] UNION
		SELECT 'Kwiatosław' AS [Name] UNION
		SELECT 'Kwietosław' AS [Name] UNION
		SELECT 'L' AS [Name] UNION
		SELECT 'Lambert' AS [Name] UNION
		SELECT 'Laurencjusz' AS [Name] UNION
		SELECT 'Lech' AS [Name] UNION
		SELECT 'Lechosław' AS [Name] UNION
		SELECT 'Lenart' AS [Name] UNION
		SELECT 'Leo' AS [Name] UNION
		SELECT 'Leon' AS [Name] UNION
		SELECT 'Leokadiusz' AS [Name] UNION
		SELECT 'Leonard' AS [Name] UNION
		SELECT 'Leopold' AS [Name] UNION
		SELECT 'Lesław' AS [Name] UNION
		SELECT 'Leszek' AS [Name] UNION
		SELECT 'Lew' AS [Name] UNION
		SELECT 'Longin' AS [Name] UNION
		SELECT 'Lubisław' AS [Name] UNION
		SELECT 'Lubogost' AS [Name] UNION
		SELECT 'Lubomił' AS [Name] UNION
		SELECT 'Lubomir' AS [Name] UNION
		SELECT 'Luborad' AS [Name] UNION
		SELECT 'Lubosław' AS [Name] UNION
		SELECT 'Lucjan' AS [Name] UNION
		SELECT 'Ludmił' AS [Name] UNION
		SELECT 'Ludomił' AS [Name] UNION
		SELECT 'Ludolf' AS [Name] UNION
		SELECT 'Ludomir' AS [Name] UNION
		SELECT 'Ludowit' AS [Name] UNION
		SELECT 'Ludwik' AS [Name] UNION
		SELECT 'Ł' AS [Name] UNION
		SELECT 'Ładysław' AS [Name] UNION
		SELECT 'Łazarz' AS [Name] UNION
		SELECT 'Łucjan' AS [Name] UNION
		SELECT 'Łukasz' AS [Name] UNION
		SELECT 'M' AS [Name] UNION
		SELECT 'Machut' AS [Name] UNION
		SELECT 'Maciej' AS [Name] UNION
		SELECT 'Magnus' AS [Name] UNION
		SELECT 'Makary' AS [Name] UNION
		SELECT 'Makryn' AS [Name] UNION
		SELECT 'Maksymilian' AS [Name] UNION
		SELECT 'Maksymin' AS [Name] UNION
		SELECT 'Malachiasz' AS [Name] UNION
		SELECT 'Mamert' AS [Name] UNION
		SELECT 'Manfred' AS [Name] UNION
		SELECT 'Manuel' AS [Name] UNION
		SELECT 'Marcel' AS [Name] UNION
		SELECT 'Marceli' AS [Name] UNION
		SELECT 'Marcin' AS [Name] UNION
		SELECT 'Marcjan' AS [Name] UNION
		SELECT 'Marek' AS [Name] UNION
		SELECT 'Marian' AS [Name] UNION
		SELECT 'Marin' AS [Name] UNION
		SELECT 'Mariusz' AS [Name] UNION
		SELECT 'Maryn' AS [Name] UNION
		SELECT 'Mateusz' AS [Name] UNION
		SELECT 'Maurycjusz' AS [Name] UNION
		SELECT 'Maurycy' AS [Name] UNION
		SELECT 'Maurycjusz' AS [Name] UNION
		SELECT 'Medard' AS [Name] UNION
		SELECT 'Melchior' AS [Name] UNION
		SELECT 'Metody' AS [Name] UNION
		SELECT 'Michał' AS [Name] UNION
		SELECT 'Mieszko' AS [Name] UNION
		SELECT 'Mieczysław' AS [Name] UNION
		SELECT 'Mikołaj' AS [Name] UNION
		SELECT 'Milan' AS [Name] UNION
		SELECT 'Miłobąd' AS [Name] UNION
		SELECT 'Miłogost' AS [Name] UNION
		SELECT 'Miłomir' AS [Name] UNION
		SELECT 'Miłorad' AS [Name] UNION
		SELECT 'Miłosław' AS [Name] UNION
		SELECT 'Miłosz' AS [Name] UNION
		SELECT 'Miłowan' AS [Name] UNION
		SELECT 'Miłowit' AS [Name] UNION
		SELECT 'Mirod' AS [Name] UNION
		SELECT 'Miroład' AS [Name] UNION
		SELECT 'Miron' AS [Name] UNION
		SELECT 'Mirosław' AS [Name] UNION
		SELECT 'Mirosz' AS [Name] UNION
		SELECT 'Modest' AS [Name] UNION
		SELECT 'Mojmierz' AS [Name] UNION
		SELECT 'Mojmir' AS [Name] UNION
		SELECT 'Mojżesz' AS [Name] UNION
		SELECT 'Mściwoj' AS [Name] UNION
		SELECT 'Murat' AS [Name] UNION
		SELECT 'Myślimir' AS [Name] UNION
		SELECT 'N' AS [Name] UNION
		SELECT 'Napoleon' AS [Name] UNION
		SELECT 'Narcyz' AS [Name] UNION
		SELECT 'Nasif' AS [Name] UNION
		SELECT 'Natan' AS [Name] UNION
		SELECT 'Natanael' AS [Name] UNION
		SELECT 'Nataniel' AS [Name] UNION
		SELECT 'Nestor' AS [Name] UNION
		SELECT 'Nicefor' AS [Name] UNION
		SELECT 'Niecisław' AS [Name] UNION
		SELECT 'Nikodem' AS [Name] UNION
		SELECT 'Norbert' AS [Name] UNION
		SELECT 'Norman' AS [Name] UNION
		SELECT 'O' AS [Name] UNION
		SELECT 'Odo' AS [Name] UNION
		SELECT 'Odon' AS [Name] UNION
		SELECT 'Oktawian' AS [Name] UNION
		SELECT 'Oktawiusz' AS [Name] UNION
		SELECT 'Olaf' AS [Name] UNION
		SELECT 'Oleg' AS [Name] UNION
		SELECT 'Olgierd' AS [Name] UNION
		SELECT 'Omar' AS [Name] UNION
		SELECT 'Onufry' AS [Name] UNION
		SELECT 'Oskar' AS [Name] UNION
		SELECT 'Orian' AS [Name] UNION
		SELECT 'Otniel' AS [Name] UNION
		SELECT 'Oswald' AS [Name] UNION
		SELECT 'Otokar' AS [Name] UNION
		SELECT 'Otto' AS [Name] UNION
		SELECT 'Otton' AS [Name] UNION
		SELECT 'Owidiusz' AS [Name] UNION
		SELECT 'Ozeasz' AS [Name] UNION
		SELECT 'P' AS [Name] UNION
		SELECT 'Pabian' AS [Name] UNION
		SELECT 'Pachomiusz' AS [Name] UNION
		SELECT 'Pafnucy' AS [Name] UNION
		SELECT 'Pakosław' AS [Name] UNION
		SELECT 'Pankracy' AS [Name] UNION
		SELECT 'Paskal' AS [Name] UNION
		SELECT 'Patrycjusz' AS [Name] UNION
		SELECT 'Patryk' AS [Name] UNION
		SELECT 'Paweł' AS [Name] UNION
		SELECT 'Pelagiusz' AS [Name] UNION
		SELECT 'Petroniusz' AS [Name] UNION
		SELECT 'Piotr' AS [Name] UNION
		SELECT 'Placyd' AS [Name] UNION
		SELECT 'Polikarp' AS [Name] UNION
		SELECT 'Prokop' AS [Name] UNION
		SELECT 'Prot' AS [Name] UNION
		SELECT 'Protazy' AS [Name] UNION
		SELECT 'Przemysł' AS [Name] UNION
		SELECT 'Przemysław' AS [Name] UNION
		SELECT 'Przedpełk' AS [Name] UNION
		SELECT 'Przybysław' AS [Name] UNION
		SELECT 'R' AS [Name] UNION
		SELECT 'Radogost' AS [Name] UNION
		SELECT 'Radomił' AS [Name] UNION
		SELECT 'Radomir' AS [Name] UNION
		SELECT 'Radosław' AS [Name] UNION
		SELECT 'Radowit' AS [Name] UNION
		SELECT 'Radzimir' AS [Name] UNION
		SELECT 'Rafał' AS [Name] UNION
		SELECT 'Rajmund' AS [Name] UNION
		SELECT 'Rajner' AS [Name] UNION
		SELECT 'Randoald' AS [Name] UNION
		SELECT 'Remigiusz' AS [Name] UNION
		SELECT 'Renat' AS [Name] UNION
		SELECT 'Richariusz' AS [Name] UNION
		SELECT 'Robert' AS [Name] UNION
		SELECT 'Roch' AS [Name] UNION
		SELECT 'Roderyk' AS [Name] UNION
		SELECT 'Roland' AS [Name] UNION
		SELECT 'Roman' AS [Name] UNION
		SELECT 'Romuald' AS [Name] UNION
		SELECT 'Ronald' AS [Name] UNION
		SELECT 'Rosłan' AS [Name] UNION
		SELECT 'Rudolf' AS [Name] UNION
		SELECT 'Rufus' AS [Name] UNION
		SELECT 'Ryszard' AS [Name] UNION
		SELECT 'S' AS [Name] UNION
		SELECT 'Salomon' AS [Name] UNION
		SELECT 'Samir' AS [Name] UNION
		SELECT 'Sambor' AS [Name] UNION
		SELECT 'Samson' AS [Name] UNION
		SELECT 'Samuel' AS [Name] UNION
		SELECT 'Sebastian' AS [Name] UNION
		SELECT 'Serafin' AS [Name] UNION
		SELECT 'Sergiusz' AS [Name] UNION
		SELECT 'Serwacy' AS [Name] UNION
		SELECT 'Seweryn' AS [Name] UNION
		SELECT 'Sędomir' AS [Name] UNION
		SELECT 'Sędzisław' AS [Name] UNION
		SELECT 'Siemowit' AS [Name] UNION
		SELECT 'Skałosz' AS [Name] UNION
		SELECT 'Sław' AS [Name] UNION
		SELECT 'Sławek' AS [Name] UNION
		SELECT 'Sławomierz' AS [Name] UNION
		SELECT 'Sławomir' AS [Name] UNION
		SELECT 'Sobiesław' AS [Name] UNION
		SELECT 'Sofroniusz' AS [Name] UNION
		SELECT 'Stanisław' AS [Name] UNION
		SELECT 'Starwit' AS [Name] UNION
		SELECT 'Stefan' AS [Name] UNION
		SELECT 'Stoigniew' AS [Name] UNION
		SELECT 'Stoisław' AS [Name] UNION
		SELECT 'Stojan' AS [Name] UNION
		SELECT 'Strzeżymir' AS [Name] UNION
		SELECT 'Subisław' AS [Name] UNION
		SELECT 'Sulibor' AS [Name] UNION
		SELECT 'Sulisław' AS [Name] UNION
		SELECT 'Sydoniusz' AS [Name] UNION
		SELECT 'Sykstus' AS [Name] UNION
		SELECT 'Sylwan' AS [Name] UNION
		SELECT 'Sylwester' AS [Name] UNION
		SELECT 'Sylwiusz' AS [Name] UNION
		SELECT 'Symeon' AS [Name] UNION
		SELECT 'Symplicjusz' AS [Name] UNION
		SELECT 'Syriusz' AS [Name] UNION
		SELECT 'Szczepan' AS [Name] UNION
		SELECT 'Szymon' AS [Name] UNION
		SELECT 'Ś' AS [Name] UNION
		SELECT 'Świętibor' AS [Name] UNION
		SELECT 'Świętomir' AS [Name] UNION
		SELECT 'Świętopełk' AS [Name] UNION
		SELECT 'Świętosław' AS [Name] UNION
		SELECT 'T' AS [Name] UNION
		SELECT 'Tadeusz' AS [Name] UNION
		SELECT 'Tarik' AS [Name] UNION
		SELECT 'Telesfor' AS [Name] UNION
		SELECT 'Teobald' AS [Name] UNION
		SELECT 'Teodor' AS [Name] UNION
		SELECT 'Teodozjusz' AS [Name] UNION
		SELECT 'Teofil' AS [Name] UNION
		SELECT 'Tęgomir' AS [Name] UNION
		SELECT 'Tobiasz' AS [Name] UNION
		SELECT 'Tomasz' AS [Name] UNION
		SELECT 'Tomisław' AS [Name] UNION
		SELECT 'Tristan' AS [Name] UNION
		SELECT 'Tulimir' AS [Name] UNION
		SELECT 'Tulimierz' AS [Name] UNION
		SELECT 'Tyberiusz' AS [Name] UNION
		SELECT 'Tymon' AS [Name] UNION
		SELECT 'Tymoteusz' AS [Name] UNION
		SELECT 'Tytus' AS [Name] UNION
		SELECT 'U' AS [Name] UNION
		SELECT 'Urban' AS [Name] UNION
		SELECT 'Ursyn' AS [Name] UNION
		SELECT 'W' AS [Name] UNION
		SELECT 'Wacław' AS [Name] UNION
		SELECT 'Wahid' AS [Name] UNION
		SELECT 'Waldemar' AS [Name] UNION
		SELECT 'Walenty' AS [Name] UNION
		SELECT 'Walentyn' AS [Name] UNION
		SELECT 'Walerian' AS [Name] UNION
		SELECT 'Walery' AS [Name] UNION
		SELECT 'Walter' AS [Name] UNION
		SELECT 'Wandelin' AS [Name] UNION
		SELECT 'Waryn' AS [Name] UNION
		SELECT 'Wawrzyniec' AS [Name] UNION
		SELECT 'Więcesław' AS [Name] UNION
		SELECT 'Wenancjusz' AS [Name] UNION
		SELECT 'Wespazjan' AS [Name] UNION
		SELECT 'Wielisław' AS [Name] UNION
		SELECT 'Wiesław' AS [Name] UNION
		SELECT 'Wiktor' AS [Name] UNION
		SELECT 'Wilhelm' AS [Name] UNION
		SELECT 'Wincenty' AS [Name] UNION
		SELECT 'Wirgiliusz' AS [Name] UNION
		SELECT 'Wirginiusz' AS [Name] UNION
		SELECT 'Wisław' AS [Name] UNION
		SELECT 'Wit' AS [Name] UNION
		SELECT 'Witold' AS [Name] UNION
		SELECT 'Witołd' AS [Name] UNION
		SELECT 'Witosław' AS [Name] UNION
		SELECT 'Władysław' AS [Name] UNION
		SELECT 'Włodzimierz' AS [Name] UNION
		SELECT 'Włodzisław' AS [Name] UNION
		SELECT 'Wojciech' AS [Name] UNION
		SELECT 'Wolimir' AS [Name] UNION
		SELECT 'Wojsław' AS [Name] UNION
		SELECT 'Wrocisław' AS [Name] UNION
		SELECT 'Wszebor' AS [Name] UNION
		SELECT 'Z' AS [Name] UNION
		SELECT 'Zachariasz' AS [Name] UNION
		SELECT 'Zbigniew' AS [Name] UNION
		SELECT 'Zdzisław' AS [Name] UNION
		SELECT 'Zenobiusz' AS [Name] UNION
		SELECT 'Zefiryn' AS [Name] UNION
		SELECT 'Zenon' AS [Name] UNION
		SELECT 'Ziemowit' AS [Name] UNION
		SELECT 'Zwinisław' AS [Name] UNION
		SELECT 'Zygbert' AS [Name] UNION
		SELECT 'Zygfryd' AS [Name] UNION
		SELECT 'Zygmunt'
	) AS Pom
	WHERE LEN(Pom.[Name]) > 1

	DECLARE @UserSurname AS TABLE
	(
		[Surname] VARCHAR(100)
	)

	--Surnames fake data
	INSERT INTO @UserSurname ([Surname])
	SELECT Pom.[Surname]
	FROM
	(
		SELECT 'Toyota' AS [Surname] UNION
		SELECT 'BMW' AS [Surname] UNION
		SELECT 'Volkswagen' AS [Surname] UNION
		SELECT 'Mercedes' AS [Surname] UNION
		SELECT 'Honda' AS [Surname] UNION
		SELECT 'Ford' AS [Surname] UNION
		SELECT 'Hyundai' AS [Surname] UNION
		SELECT 'Nissan' AS [Surname] UNION
		SELECT 'Audi' AS [Surname] UNION
		SELECT 'Renault' AS [Surname] UNION
		SELECT 'Chevrolet' AS [Surname] UNION
		SELECT 'LandRover' AS [Surname] UNION
		SELECT 'Peugeot' AS [Surname] UNION
		SELECT 'Fiat' AS [Surname] UNION
		SELECT 'KiaMotors' AS [Surname] UNION
		SELECT 'Mazda' AS [Surname] UNION
		SELECT 'Ferrari' AS [Surname] UNION
		SELECT 'MINI' AS [Surname] UNION
		SELECT 'Harley-Davidson' AS [Surname] UNION
		SELECT 'Lexus' AS [Surname] UNION
		SELECT 'Volvo' AS [Surname] UNION
		SELECT 'Suzuki' AS [Surname] UNION
		SELECT 'Subaru' AS [Surname] UNION
		SELECT 'Porsche' AS [Surname] UNION
		SELECT 'Citroen' AS [Surname]
	) AS Pom

	IF NOT EXISTS (SELECT * FROM [dbo].[User])
	INSERT INTO [User] 
	(
		[UserNo],
		[Surname], 
		[Name],
		[RoleId],
		[DepartmentId],
		[RegionId],
		[LocationId],
		[Login],
		[Password]
	)
	SELECT
		Pom.[UserNo],
		Pom.[Surname],
		Pom.[Name],
		r.[Id] AS [RoleId],
		CASE WHEN r.[Id] >= 3 THEN NULL ELSE d.[Id] END AS [DepartmentId],
		CASE WHEN r.[Id] <= 3 THEN NULL ELSE w.[Id] END AS [RegionId],
		CASE WHEN r.[Id] <> 3 THEN NULL ELSE l.[Id] END AS [LocationId],
		Pom.[Login],
		Pom.[Password]
	FROM
	(
		SELECT
			ROW_NUMBER() OVER (ORDER BY NEWID()) AS [UserNo],
			s.[Surname], 
			n.[Name],
			CAST(NEWID() AS VARCHAR(40)) AS [Login],
			CAST(NEWID() AS VARCHAR(40)) AS [Password]
		FROM @UserSurname s 
		INNER JOIN @UserName n ON 1 = 1
	) AS Pom
	INNER JOIN [dbo].[Role] r ON r.[RoleNo] = Pom.[UserNo] % 6 + 1 
	INNER JOIN [dbo].[Department] d ON d.[DepartmentNo] = Pom.[UserNo] % 6 + 1 
	INNER JOIN [dbo].[Region] w ON w.[RegionNo] = Pom.[UserNo] % 6 + 1
	INNER JOIN [dbo].[Location] l ON l.[LocationNo] = Pom.[UserNo] % 900 + 1
	
	INSERT INTO [dbo].[Logs] ([Message], [LogType])
	SELECT '[Users] rows inserted: [' + CAST(@@ROWCOUNT AS VARCHAR) + ']', 'I'

END TRY  
BEGIN CATCH 
	INSERT INTO [dbo].[Logs] ([Message], [AdditionalMessage], [LogType])
	SELECT 
		'[Users] Insert error :[' + ERROR_MESSAGE() + ']', 
		'Line:[' + CAST(ERROR_LINE() AS VARCHAR) + ']. Error number:[' + CAST(ERROR_NUMBER() AS VARCHAR) + '].', 
		'E'
END CATCH
GO
--------------------------------------------------------------------------------------

SELECT * FROM [dbo].[Logs] ORDER BY 1 DESC