CREATE PROCEDURE [dbo].[Location_Update]
(
	@Id INT,
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
	UPDATE [dbo].[Location]
	SET
		[LocationNo] = ISNULL(@LocationNo, [LocationNo]),
		[Name] = ISNULL(@Name, [Name]),
		[RegionId] = ISNULL(@RegionId, [RegionId]),
		[Province] = ISNULL(@Province, [Province]),
		[Site] = ISNULL(@Site, [Site]),
		[Address1] = ISNULL(@Address1, [Address1]),
		[Address2] = ISNULL(@Address2, [Address2]),
		[ModificationDate] = GETDATE()
	WHERE [Id] = @Id

	EXEC [dbo].[Location_GetById] @Id
END
