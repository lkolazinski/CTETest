DECLARE @RoleIdTable AS TABLE
(
	[Id] INT PRIMARY KEY
)


DECLARE @RoleIdXml XML = 
'<root>
	<row><id>1</id></row>
	<row><id>2</id></row>
	<row><id>3</id></row>
	<row><id>4</id></row>
</root>'

INSERT INTO @RoleIdTable([Id])
SELECT DISTINCT
	'Id' = x.v.value('id[1]', 'Int')
FROM @RoleIdXml.nodes('/root/row') x(v)

--select * from @RoleIdTable