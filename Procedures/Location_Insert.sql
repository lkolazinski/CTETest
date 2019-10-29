CREATE PROCEDURE [dbo].[Location_Insert]
(
	@LocationNo INT,
	@Name VARCHAR(200),
	@RegionId INT,
	@Province VARCHAR(200),
	@Site VARCHAR(200),
	@Address1 VARCHAR(200),
	@Address2 VARCHAR(200)
)
AS
BEGIN
	INSERT [dbo].[Location]
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
		@LocationNo,
		@Name,
		@RegionId,
		@Province,
		@Site,
		@Address1,
		@Address2

	EXEC [dbo].[Location_GetById] @@IDENTITY
END
