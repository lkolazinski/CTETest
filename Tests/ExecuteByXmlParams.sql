DECLARE @RoleIdXml XML = 
'<root>
	<row><id>1</id></row>
	<row><id>2</id></row>
	<row><id>3</id></row>
	<row><id>4</id></row>
	<row><id>4</id></row>
</root>'

DECLARE @DepartmentIdXml XML = 
'<root>
	<row><id>1</id></row>
	<row><id>2</id></row>
	<row><id>3</id></row>
	<row><id>4</id></row>
	<row><id>4</id></row>
</root>'

EXEC [dbo].[User_GetFiltredByXml] @RoleIdXml, @DepartmentIdXml, 'name', 1, 200