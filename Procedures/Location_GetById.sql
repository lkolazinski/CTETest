CREATE PROCEDURE [dbo].[Location_GetById]
(
	@Id INT
)
AS
BEGIN
	SELECT
		l.[Id],
		l.[LocationNo],
		l.[Name],
		l.[RegionId],
		l.[Province],
		l.[Site],
		l.[Address1],
		l.[Address2],
		l.[CreationDate],
		l.[ModificationDate]
	FROM [dbo].[Location] l
	WHERE l.[Id] = @Id
END
