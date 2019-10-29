CREATE PROCEDURE [dbo].[Logs_GetById]
(
	@Id INT
)
AS
BEGIN
	SELECT
		d.[Id],
		d.[LogType],
		d.[Message],
		d.[AdditionalMessage],
		d.[CreationDate]
	FROM [dbo].[Logs] d
	WHERE d.[Id] = @Id
END
