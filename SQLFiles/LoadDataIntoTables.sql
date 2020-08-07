USE QueensCollegeSchedulSpring2019;
GO







-- ----------------------------------------------------------------------- DEPARTMENT TABLE ------------------------------------------------------------------------------------------------



-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[CreateSequenceObjectForDepartmentTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for the Department Table 
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[CreateSequenceObjectForDepartmentTable]
GO

CREATE PROCEDURE [Project3].[CreateSequenceObjectForDepartmentTable]

AS
BEGIN

    CREATE SEQUENCE [Project3].[SequenceObjectForDepartmentId]
        START WITH 1
        INCREMENT BY 1

END
GO

EXEC [Project3].[CreateSequenceObjectForDepartmentTable];
GO






-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[LoadDepartmentTable]
-- Create date: November 25th, 2019
-- Description: Loads data into the Department Table using the UploadFile.CoursesSpring2019 
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[LoadDepartmentTable]
GO

CREATE PROCEDURE [Project3].[LoadDepartmentTable]


AS
BEGIN

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();


    INSERT INTO [Queens-College].[Department]
        (DepartmentID, DepartmentName)
    SELECT
        NEXT VALUE FOR [Project3].[SequenceObjectForDepartmentId],
        DepartmentName
    FROM (
        SELECT
            DISTINCT
            SUBSTRING([Course (hr, crd)], 0, charindex(' ', [Course (hr, crd)])) AS DepartmentName
        FROM Uploadfile.CoursesSpring2019
        WHERE LEN([Course (hr, crd)]) > 0
    ) AS Result


    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Loaded data into the Department Table', @StartingTime = @StartTime;

END
GO

EXEC [Project3].[LoadDepartmentTable];
GO


-- ----------------------------------------------------------------------- INSTRUCTOR TABLE ------------------------------------------------------------------------------------------------



-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[CreateSequenceObjectForInstructorTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for the InstructorID
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[CreateSequenceObjectForInstructorTable]
GO

CREATE PROCEDURE [Project3].[CreateSequenceObjectForInstructorTable]

AS
BEGIN

    CREATE SEQUENCE [Project3].[SequenceObjectForInstructorId]
        START WITH 1
        INCREMENT BY 1

END
GO

EXEC [Project3].[CreateSequenceObjectForInstructorTable];
GO







-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[LoadInstructorTable]
-- Create date: November 25th, 2019
-- Description: Loads the Instructor Table with the Data from the UploadFile.SpringCourses2019
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[LoadInstructorTable] 
GO


CREATE PROCEDURE [Project3].[LoadInstructorTable]

AS
BEGIN

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()


    INSERT INTO [Queens-College].[Instructor]
        (InstructorID, InstructorFullName)
    SELECT
        NEXT VALUE FOR [Project3].[SequenceObjectForInstructorId],
        [CS].[Instructor]
    FROM (SELECT DISTINCT Instructor
        FROM [Uploadfile].[CoursesSpring2019]) AS CS


    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Loaded data into the Instructor Table', @StartingTime = @StartTime;

END
GO

EXEC [Project3].[LoadInstructorTable];
GO



-- ----------------------------------------------------------------------- DEPARTMENT_INSTRUCTOR TABLE ------------------------------------------------------------------------------------------------


-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[CreateSequenceObjectForDepartmentInstructorTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for the DepartmentInstructorID
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[CreateSequenceObjectForDepartmentInstructorTable]
GO

CREATE PROCEDURE [Project3].[CreateSequenceObjectForDepartmentInstructorTable]

AS
BEGIN

    CREATE SEQUENCE [Project3].[SequenceObjectForDepartmentInstructorId]
        START WITH 1
        INCREMENT BY 1

END
GO

EXEC [Project3].[CreateSequenceObjectForDepartmentInstructorTable];
GO





-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[LoadDepartmentInstructorTable]
-- Create date: November 25th, 2019
-- Description: Loads the DepartmentInstructor Table with the Data from the UploadFile.SpringCourses2019
-- =============================================



DROP PROCEDURE IF EXISTS [Project3].[LoadTheDepartmentInstructorTable];
GO

CREATE PROCEDURE [Project3].[LoadTheDepartmentInstructorTable]


AS
BEGIN

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()


    INSERT INTO [Queens-College].[DepartmentInstructor] (DepartmentInstructorID, DepartmentKey, InstructorKey)
    SELECT
        NEXT VALUE FOR [Project3].[SequenceObjectForDepartmentInstructorId],
        DepartmentID,
        InstructorID
    FROM (
        SELECT DISTINCT InstructorID, DepartmentID
        FROM Uploadfile.CoursesSpring2019 AS CS
            INNER JOIN [Queens-College].[Instructor] AS I
                ON CS.Instructor = I.InstructorFullName
            INNER JOIN [Queens-College].[Department] AS D
                ON SUBSTRING([Course (hr, crd)], 0, charindex(' ', [Course (hr, crd)])) = D.DepartmentName 
    ) AS Result



    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Loaded data into the DepartmentInstructor Table', @StartingTime = @StartTime;


END
GO

EXEC [Project3].[LoadTheDepartmentInstructorTable];







-- ----------------------------------------------------------------------- MODE OF INSTRUCTION TABLE ------------------------------------------------------------------------------------------------






-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[CreateSequenceObjectForModeOfInstructionTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for the ModeOfInstructionID
-- =============================================



DROP PROCEDURE IF EXISTS [Project3].[CreateSequenceObjectForModeOfInstructionTable]
GO

CREATE PROCEDURE [Project3].[CreateSequenceObjectForModeOfInstructionTable]

AS
BEGIN

    CREATE SEQUENCE [Project3].[SequenceObjectForModeOfInstructionId]
        START WITH 1
        INCREMENT BY 1

END
GO

EXEC [Project3].[CreateSequenceObjectForModeOfInstructionTable];



-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[LoadModeOfInstructionTable]
-- Create date: November 25th, 2019
-- Description: Loads the Mode Of Instruction with data from the UploadFile.CoursesSpring2019
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[LoadModeOfInstructionTable]
GO

CREATE PROCEDURE [Project3].[LoadModeOfInstructionTable]


AS
BEGIN

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()


    INSERT INTO [Queens-College].[ModeOfInstruction] (ModeOfInstructionID, ModeOfInstructionName)
    SELECT
        NEXT VALUE FOR [Project3].[SequenceObjectForModeOfInstructionId],
        Result.MOI
    FROM (SELECT DISTINCT [Mode Of Instruction] AS MOI
        FROM Uploadfile.CoursesSpring2019 ) AS Result



    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Loaded data into the Mode Of Instruction Table', @StartingTime = @StartTime;


END
GO

EXEC [Project3].[LoadModeOfInstructionTable];
GO



-- ----------------------------------------------------------------------- BUILDING_LOCATION TABLE ------------------------------------------------------------------------------------------------


-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[CreateSequenceObjectForBuildingLocationTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for BuildingLocation Table
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[CreateSequenceObjectForBuildingLocationTable]
GO

CREATE PROCEDURE [Project3].[CreateSequenceObjectForBuildingLocationTable]

AS
BEGIN

    CREATE SEQUENCE [Project3].[SequenceObjectForBuildingLocationId]
        START WITH 1
        INCREMENT BY 1

END
GO

EXEC [Project3].[CreateSequenceObjectForBuildingLocationTable];





-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[LoadBuildingLocationTable]
-- Create date: November 25th, 2019
-- Description: Loads the BuildingLocation table with data from the UploadFile.CoursesSpring2019
-- =============================================



DROP PROCEDURE IF EXISTS [Project3].[LoadBuildingLocationTable]
GO

CREATE PROCEDURE [Project3].[LoadBuildingLocationTable]


AS
BEGIN

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();



    INSERT INTO [Queens-College].[BuildingLocation]
        (BuildingLocationID, BuildingName)
    SELECT
        NEXT VALUE FOR [Project3].[SequenceObjectForBuildingLocationId],
        BuildingName
    FROM (SELECT DISTINCT
            SUBSTRING([Location], 0, 3) AS BuildingName
        FROM Uploadfile.CoursesSpring2019) AS R


    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Loaded data into the BuildingLocation Table', @StartingTime = @StartTime;



END
GO

EXEC [Project3].[LoadBuildingLocationTable];
GO


-- ----------------------------------------------------------------------- ROOM_LOCATION TABLE ------------------------------------------------------------------------------------------------


-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[CreateSequenceObjectForRoomLocationTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for RoomLocation Table
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[CreateSequenceObjectForRoomLocationTable]
GO

CREATE PROCEDURE [Project3].[CreateSequenceObjectForRoomLocationTable]

AS
BEGIN

    CREATE SEQUENCE [Project3].[SequenceObjectForRoomId]
        START WITH 1
        INCREMENT BY 1

END
GO

EXEC [Project3].[CreateSequenceObjectForRoomLocationTable];




-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[LoadRoomLocationTable]
-- Create date: November 25th, 2019
-- Description: Loads the RoomLocation table with data from the UploadFile.CoursesSpring2019
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[LoadRoomLocationTable]
GO

CREATE PROCEDURE [Project3].[LoadRoomLocationTable]


AS
BEGIN

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();


    INSERT INTO [Queens-College].[RoomLocation]
        (RoomLocationID, RoomName)
    SELECT
        NEXT VALUE FOR [Project3].[SequenceObjectForRoomId],
        RoomNumber
    FROM (
        SELECT distinct 
            SUBSTRING([Location], CHARINDEX(' ', [Location])+1, LEN([Location]) - CHARINDEX(' ', [Location]) + 1) AS [RoomNumber]
        FROM Uploadfile.CoursesSpring2019 AS CS
            LEFT OUTER JOIN [Queens-College].[BuildingLocation] AS BL
                ON SUBSTRING(CS.[Location], 0 , 3) = BL.BuildingName) AS Result;



    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Loaded data into the RoomLocation Table', @StartingTime = @StartTime;


END
GO

EXEC [Project3].[LoadRoomLocationTable];
GO





-- ----------------------------------------------------------------------- BUILDING-ROOM TABLE ------------------------------------------------------------------------------------------------





-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[CreateSequenceObjectForBuildingRoomLocationTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for BuildingRoomLocation Table
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[CreateSequenceObjectForBuildingRoomLocationTable]
GO

CREATE PROCEDURE [Project3].[CreateSequenceObjectForBuildingRoomLocationTable]

AS
BEGIN

    CREATE SEQUENCE [Project3].[SequenceObjectForBuildingRoomId]
        START WITH 1
        INCREMENT BY 1

END
GO

EXEC [Project3].[CreateSequenceObjectForBuildingRoomLocationTable];
GO






-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[LoadBuildingRoomLocationTable]
-- Create date: November 25th, 2019
-- Description: Loads the RoomLocation table with data from the UploadFile.CoursesSpring2019
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[LoadBuildingRoomLocationTable]
GO

CREATE PROCEDURE [Project3].[LoadBuildingRoomLocationTable]


AS
BEGIN


    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()


    INSERT INTO [Queens-College].[BuildingRoom](BuildingRoomID, BuildingLocationKey, RoomLocationKey)
    SELECT
        NEXT VALUE FOR [Project3].[SequenceObjectForBuildingRoomId],
        R.BuildingLocationID,
        R.RoomLocationID
    FROM (
        SELECT
            DISTINCT
            BuildingLocationID,
            RoomLocationID
        FROM  Uploadfile.CoursesSpring2019 AS CS
            INNER JOIN [Queens-College].[BuildingLocation] AS BL
                ON SUBSTRING(CS.[Location], 0, 3) = BL.BuildingName
            INNER JOIN [Queens-College].[RoomLocation] AS RL
                ON SUBSTRING([Location], CHARINDEX(' ', [Location])+1, LEN([Location]) - CHARINDEX(' ', [Location]) + 1) = RL.RoomName
    ) AS R


    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Loaded data into the BuildingRoomLocation Table', @StartingTime = @StartTime;


END
GO

EXEC [Project3].[LoadBuildingRoomLocationTable];
GO


-- ----------------------------------------------------------------------- COURSE TABLE ------------------------------------------------------------------------------------------------



-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[CreateSequenceObjectForCourseTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for CourseTable
-- =============================================




DROP PROCEDURE IF EXISTS [Project3].[CreateSequenceObjectForCourseTable]
GO

CREATE PROCEDURE [Project3].[CreateSequenceObjectForCourseTable]

AS
BEGIN

    CREATE SEQUENCE [Project3].[SequenceObjectForCourseId]
        START WITH 1
        INCREMENT BY 1

END
GO

EXEC [Project3].[CreateSequenceObjectForCourseTable];
GO


-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[LoadModeOfInstructionTable]
-- Create date: November 25th, 2019
-- Description: Loads the Course table with data from the UploadFile.CoursesSpring2019
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[usp_LoadCourseTable]
GO

CREATE PROCEDURE [Project3].[usp_LoadCourseTable]


AS
BEGIN

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();



INSERT INTO [Queens-College].[Course] (CourseID, CourseName, CourseHour, CourseCredit)
SELECT
    NEXT VALUE FOR [Project3].[SequenceObjectForCourseId],
    CourseName,
    CourseHour,
    CourseCredit
FROM (SELECT DISTINCT
        [Description] AS CourseName,
        SUBSTRING([Course (hr, crd)], CHARINDEX('(', [Course (hr, crd)]) + 1, 
            CASE
                WHEN SUBSTRING([Course (hr, crd)], CHARINDEX('(', [Course (hr, crd)]) + 2, 1) = ',' THEN 1
                ELSE
                    2
            end
        ) AS CourseHour,
        SUBSTRING([Course (hr, crd)], CHARINDEX(',', [Course (hr, crd)]) + 2, 1) AS CourseCredit
    FROM Uploadfile.CoursesSpring2019
    ) AS Result;



    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Loaded data into the Course Table', @StartingTime = @StartTime;


END
GO

EXEC [Project3].[usp_LoadCourseTable];
GO





-- ----------------------------------------------------------------------- TIME SLOT TABLE ------------------------------------------------------------------------------------------------


-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[CreateSequenceObjectForTimeSlotTable]
-- Create date: November 25th, 2019
-- Description: Loads the TimeSlot table with data from the UploadFile.CoursesSpring2019
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[CreateSequenceObjectForTimeSlotTable]
GO

CREATE PROCEDURE [Project3].[CreateSequenceObjectForTimeSlotTable]

AS
BEGIN

    CREATE SEQUENCE [Project3].[SequenceObjectForTimeSlotId]
        START WITH 1
        INCREMENT BY 1

END
GO

EXEC [Project3].[CreateSequenceObjectForTimeSlotTable];
GO


-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[LoadTimeSlotTable]
-- Create date: November 25th, 2019
-- Description: Loads the TimeSlot table with data from the UploadFile.CoursesSpring2019
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[LoadTimeSlotTable]
GO

CREATE PROCEDURE [Project3].[LoadTimeSlotTable]


AS
BEGIN

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();


    INSERT INTO [Queens-College].[TimeSlot] (TimeSlotID, ClassStartingTime, ClassEndingTime, ClassDay)
    SELECT
        NEXT VALUE FOR [Project3].[SequenceObjectForTimeSlotId],
        StartingTime,
        EndingTime,
        [Day]
    FROM (
        SELECT
        DISTINCT 
            SUBSTRING([Time], 0, CHARINDEX('-', [Time])) AS StartingTime,
            SUBSTRING([Time], CHARINDEX('M', [Time]) + 4, LEN([Time])) AS [EndingTime],
            [Day]
        FROM Uploadfile.CoursesSpring2019
    ) AS Result


    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Loaded data into the TimeSlot Table', @StartingTime = @StartTime;


END
GO

EXEC [Project3].[LoadTimeSlotTable];
GO

-- ----------------------------------------------------------------------- Semester TABLE ------------------------------------------------------------------------------------------------


-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[CreateSequenceObjectForSemesterTable]
-- Create date: November 25th, 2019
-- Description: Loads the Semester table with data from the UploadFile.CoursesSpring2019
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[CreateSequenceObjectForSemesterTable]
GO

CREATE PROCEDURE [Project3].[CreateSequenceObjectForSemesterTable]

AS
BEGIN

    CREATE SEQUENCE [Project3].[SequenceObjectForSemesterId]
        START WITH 1
        INCREMENT BY 1

END
GO

EXEC [Project3].[CreateSequenceObjectForSemesterTable];
GO




-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[LoadTimeSlotTable]
-- Create date: November 25th, 2019
-- Description: Loads the TimeSlot table with data from the UploadFile.CoursesSpring2019
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[LoadSemesterTable]
GO

CREATE PROCEDURE [Project3].[LoadSemesterTable]


AS
BEGIN

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();


    INSERT INTO [Queens-College].[Semester] (SemesterID, Semester, SemesterYear)
    SELECT
        NEXT VALUE FOR [Project3].[SequenceObjectForSemesterId],
        Semester,
        SemesterYear
    FROM (
        SELECT
        DISTINCT
        SUBSTRING([Semester], 0, CHARINDEX(' ', [Semester])) as Semester,
        SUBSTRING([Semester], CHARINDEX(' ', [Semester]) + 1, 4) AS SemesterYear
        FROM Uploadfile.CoursesSpring2019
    ) AS R



    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Loaded data into the Semester Table', @StartingTime = @StartTime;


END
GO

EXEC [Project3].[LoadSemesterTable];
GO





-- ----------------------------------------------------------------------- Class TABLE ------------------------------------------------------------------------------------------------





-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[CreateSequenceObjectForClassTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for Class Table
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[CreateSequenceObjectForClassTable]
GO

CREATE PROCEDURE [Project3].[CreateSequenceObjectForClassTable]

AS
BEGIN

    CREATE SEQUENCE [Project3].[SequenceObjectForClassId]
        START WITH 1
        INCREMENT BY 1

END
GO

EXEC [Project3].[CreateSequenceObjectForClassTable];
GO




-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[LoadClassTable]
-- Create date: November 25th, 2019
-- Description: Loads the Class table with data from the UploadFile.CoursesSpring2019, TimeSlot, BuildingRoom, Instructor, and Course table
-- =============================================



DROP PROCEDURE IF EXISTS [Project3].[LoadClassTable]
GO

CREATE PROCEDURE [Project3].[LoadClassTable]

AS
BEGIN

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();

    INSERT INTO[Queens-College].[Class]
        (ClassID,TimeSlotKey, InstructorKey, BuildingRoomKey, CourseKey, ModeOfInstructionKey, [Limit], [Enrolled], SemesterKey, ClassName)
    SELECT
        NEXT VALUE FOR [Project3].[SequenceObjectForClassId],
        TimeSlotID,
        InstructorID,
        BuildingRoomID,
        CourseID,
        ModeOfInstructionID,
        [Limit],
        [Enrolled],
        SemesterID,
        [Description]
    FROM(
        SELECT
                [Description],
                I.InstructorID,
                Course.CourseID,
                BR.BuildingRoomID,
                MOI.ModeOfInstructionID,
                TS.TimeSlotID,
                [Limit],
                [Enrolled],
                SemesterID
            FROM [Queens-College].[Instructor] AS I
                INNER JOIN Uploadfile.CoursesSpring2019 AS CS
                    ON CS.Instructor = I.InstructorFullName
                INNER JOIN [Queens-College].[Course] AS Course
                    ON CS.[Description] = Course.CourseName AND
                        SUBSTRING([Course (hr, crd)], CHARINDEX('(', [Course (hr, crd)]) + 1, 
                    CASE
                        WHEN SUBSTRING([Course (hr, crd)], CHARINDEX('(', [Course (hr, crd)]) + 2, 1) = ',' THEN 1
                        ELSE
                            2
                    end
                )  =  Course.CourseHour AND
                    SUBSTRING([Course (hr, crd)], CHARINDEX(',', [Course (hr, crd)]) + 2, 1) = Course.CourseCredit
                INNER JOIN [Queens-College].[RoomLocation] AS RL
                    ON SUBSTRING([Location], CHARINDEX(' ', [Location])+1, LEN([Location]) - CHARINDEX(' ', [Location]) + 1) = RL.RoomName
                INNER JOIN [Queens-College].[BuildingLocation] AS BL
                    ON SUBSTRING([Location], 0, 3) = BL.BuildingName
                INNER JOIN [Queens-College].[BuildingRoom] AS BR
                    ON RL.RoomLocationID = BR.RoomLocationKey AND BL.BuildingLocationID = BR.BuildingLocationKey
                INNER JOIN [Queens-College].[ModeOfInstruction] AS MOI
                    ON CS.[Mode of Instruction] =  MOI.ModeOfInstructionName
                INNER JOIN [Queens-College].[TimeSlot] AS TS
                    ON   SUBSTRING([Time], 0, CHARINDEX('-', [Time])) = TS.ClassStartingTime AND
                    SUBSTRING([Time], CHARINDEX('M', [Time]) + 4, LEN([Time])) = TS.ClassEndingTime AND
                    [Day] = TS.[ClassDay]
                INNER JOIN [Queens-College].[Semester] AS S
                    ON SUBSTRING(CS.[Semester], 0, CHARINDEX(' ', CS.[Semester])) = S.[Semester] AND
                    SUBSTRING(CS.[Semester], CHARINDEX(' ', CS.[Semester]) + 1, 4) = S.[SemesterYear]



        ) AS R

    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Loaded data into the Class Table', @StartingTime = @StartTime;


END
GO

TRUNCATE TABLE [Queens-College].[Class];

EXEC [Project3].[LoadClassTable];
GO



