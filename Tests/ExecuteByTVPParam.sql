DECLARE @TmpRoleIdTable [dbo].[TVPUserType] 
INSERT INTO @TmpRoleIdTable VALUES(1)
INSERT INTO @TmpRoleIdTable VALUES(2)
INSERT INTO @TmpRoleIdTable VALUES(3)
INSERT INTO @TmpRoleIdTable VALUES(4)
INSERT INTO @TmpRoleIdTable VALUES(5)

DECLARE @TmpDepartmentIdTable [dbo].[TVPUserType] 
INSERT INTO @TmpDepartmentIdTable VALUES(1)
INSERT INTO @TmpDepartmentIdTable VALUES(2)
INSERT INTO @TmpDepartmentIdTable VALUES(3)
INSERT INTO @TmpDepartmentIdTable VALUES(4)
INSERT INTO @TmpDepartmentIdTable VALUES(5)

EXEC [dbo].[User_GetFiltredMars] @TmpRoleIdTable, @TmpDepartmentIdTable, 'name', 1, 200