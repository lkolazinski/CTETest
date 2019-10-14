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

--------------------------------------------------------------------------------------
BEGIN TRY
	PRINT '[Region]'

	IF NOT EXISTS (SELECT * FROM [dbo].[Region])
	INSERT INTO [dbo].[Region] ([RegionNo], [Name], [Description])
	SELECT
		ROW_NUMBER() OVER (ORDER BY Pom.[Name]) AS [DepartmentNo],
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
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
BEGIN TRY
	PRINT '[Role]'

	IF NOT EXISTS (SELECT * FROM [dbo].[Role])
	INSERT INTO [dbo].[Role] ([RoleNo], [Name], [Description])
	SELECT
		ROW_NUMBER() OVER (ORDER BY Pom.[Name]) AS [DepartmentNo],
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
		[Login],
		[Password]
	)
	SELECT
		Pom.[UserNo],
		Pom.[Surname],
		Pom.[Name],
		r.[Id] AS [RoleId],
		CASE WHEN r.[Id] > 3 THEN NULL ELSE d.[Id] END AS [DepartmentId],
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
--------------------------------------------------------------------------------------

SELECT * FROM [dbo].[Logs] ORDER BY 1 DESC