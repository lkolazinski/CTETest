CREATE PROCEDURE [dbo].[Logs_Insert]
(
    @Message VARCHAR(MAX),
    @AdditionalMessage VARCHAR(MAX),
    @LogType CHAR
)
AS
BEGIN
	INSERT INTO [dbo].[Logs]
	(
		[Message],
		[AdditionalMessage],
		[LogType]
	)
	SELECT
		@Message,
		@AdditionalMessage,
		@LogType

	EXEC [dbo].[Logs_GetById] @@IDENTITY
END
