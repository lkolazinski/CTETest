CREATE PROCEDURE [dbo].[Role_GetById]
(
	@Id INT
)
AS
BEGIN
	SELECT
		d.[Id],
		d.[RoleNo],
		d.[CreationDate],
		d.[Description],
		d.[Name]
	FROM [dbo].[Role] d
	WHERE d.[Id] = @Id
END
