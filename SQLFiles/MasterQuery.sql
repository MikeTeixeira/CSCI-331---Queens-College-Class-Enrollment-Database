USE QueensCollegeSchedulSpring2019
GO

-- MASTER QUERY -----


CREATE SCHEMA Process;
GO
CREATE SCHEMA [Queens-College];
GO
CREATE SCHEMA [Project3];
GO








-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Process].[usp_CreateWorkFlowStepTableRowCountSequenceObject]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for the WorkFlowStepTableRowCount in the WorkFlowSteps Table 
-- =============================================



DROP PROCEDURE IF EXISTS [Process].[usp_CreateWorkFlowStepTableRowCountSequenceObject];
GO

CREATE PROCEDURE [Process].[usp_CreateWorkFlowStepTableRowCountSequenceObject]

AS
BEGIN

    SET NOCOUNT ON;

    CREATE SEQUENCE [Process].[WorkFlowStepTableRowCountBy1]
        START WITH 1
        INCREMENT BY 1;
END
GO













-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Process].[CreateWorkFlowStepsTable]
-- Create date: November 25th, 2019
-- Description: Creates the WorkFlowSteps Table 
-- =============================================

DROP PROCEDURE IF EXISTS [Process].[usp_CreateWorkFlowStepsTable];
GO



CREATE PROCEDURE [Process].[usp_CreateWorkFlowStepsTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime  DATETIME2(7);
    SET @StartTime = SYSDATETIME();

CREATE TABLE [Process].[WorkFlowSteps] (
    WorkFlowStepKey INT IDENTITY(1,1) NOT NULL, -- PK
    WorkFlowStepDescription NVARCHAR(100) NOT NULL,
    WorkFlowStepTableRowCount INT NULL DEFAULT (0),
    LastName varchar(30) NULL DEFAULT ('Teixeira'),
    FirstName varchar(30) NULL DEFAULT ('Michael'),
    StartingDateTime DATETIME2(7) NULL DEFAULT (SYSDATETIME()),
    EndingDateTime DATETIME2(7) NULL DEFAULT (SYSDATETIME()),
    ClassTime CHAR(5) NULL DEFAULT ('09:15'),
    QmailEmailAddress varchar(40) DEFAULT ('Michael.Teixeira93@qmail.cuny.edu') NOT NULL, -- Changed to 40 b/c of qmail being longer than 30
    AuthorizedUserId INT NOT NULL DEFAULT(93)
)


    INSERT INTO [Process].[WorkFlowSteps](WorkFlowStepDescription, StartingDateTime, EndingDateTime)
    VALUES('Created the Work Flow Steps table', @StartTime, SYSDATETIME());

END
GO








-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Process].[usp_TrackWorkFlow]
-- Create date: November 25th, 2019
-- Description: Creates the TrackWorkFlow procedure to help keep track of the tasks completed in the project 
-- =============================================


DROP PROCEDURE IF EXISTS [Process].[usp_TrackWorkFlow];
GO


CREATE PROCEDURE [Process].[usp_TrackWorkFlow]

    @StartingTime DATETIME2(7),
    @WorkFlowStepDescription NVARCHAR(100)
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO [Process].[WorkFlowSteps](WorkFlowStepDescription, WorkFlowStepTableRowCount, StartingDateTime)
    VALUES( @WorkFlowStepDescription, NEXT VALUE FOR [Process].[WorkFlowStepTableRowCountBy1] , @StartingTime)


END
GO










EXEC [Process].[usp_CreateWorkFlowStepTableRowCountSequenceObject];
GO
EXEC [Process].[usp_CreateWorkFlowStepsTable];
GO







-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateDepartmentTable]
-- Create date: November 25th, 2019
-- Description: Creates the Department Table 
-- =============================================



DROP PROCEDURE IF EXISTS [Project3].[usp_CreateDepartmentTable];
GO

CREATE PROCEDURE [Project3].[usp_CreateDepartmentTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()

    CREATE TABLE [Queens-College].[Department](
        DepartmentID INT NOT NULL,
        DepartmentName NVARCHAR(7)  NULL,
        DepartmentPhoneNumber NVARCHAR(15) NULL,
        ClassTime char(5) Default('9:15'),
        LastName VARCHAR(30) DEFAULT ('Teixeira') NOT NULL,
        FirstName VARCHAR(30)  DEFAULT ('Michael') NOT NULL,
        QmailEmailAddress VARCHAR(45) DEFAULT ('Michael.Teixeira93@qmail.cuny.edu') NOT NULL,
        DateAdded DATETIME2(7) DEFAULT sysdatetime() NOT NULL,
        DateOfLastUpdate DATETIME2(7) DEFAULT sysdatetime() not null,
        AuthorizedUserId int null DEFAULT(93)

        CONSTRAINT PK_DepartmentID PRIMARY KEY(DepartmentID)
    )

    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Created the Department Table', @StartingTime = @StartTime;


END
GO







-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateInstructorTable]
-- Create date: November 25th, 2019
-- Description: Creates the Instructor Table 
-- =============================================



DROP PROCEDURE IF EXISTS [Project3].[usp_CreateInstructorTable];
GO

CREATE PROCEDURE [Project3].[usp_CreateInstructorTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()

    CREATE TABLE [Queens-College].[Instructor](
        InstructorID INT NOT NULL,
        InstructorFullName NVARCHAR(50) NOT NULL,
        ClassTime char(5) Default('9:15'),
        LastName VARCHAR(30) DEFAULT ('Teixeira') NOT NULL,
        FirstName VARCHAR(30)  DEFAULT ('Michael') NOT NULL,
        QmailEmailAddress VARCHAR(45) DEFAULT ('Michael.Teixeira93@qmail.cuny.edu') NOT NULL,
        DateAdded DATETIME2(7) DEFAULT sysdatetime() NOT NULL,
        DateOfLastUpdate DATETIME2(7) DEFAULT sysdatetime() NOT NULL,
        AuthorizedUserId INT NULL DEFAULT(93)

        CONSTRAINT PK_InstructorID PRIMARY KEY(InstructorID)
    )

    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Created the Instructor Table', @StartingTime = @StartTime;



END
GO







-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateDepartmentInstructorTable]
-- Create date: November 25th, 2019
-- Description: Creates the DepartmentInstructor Table 
-- =============================================


DROP PROCEDURE IF EXISTS[Project3].[usp_CreateDepartmentInstructorTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateDepartmentInstructorTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7);
    SET @StartTime = SYSDATETIME();

    CREATE TABLE [Queens-College].[DepartmentInstructor](
        DepartmentInstructorID INT NOT NULL,
        DepartmentKey INT NOT NULL DEFAULT(-1),
        InstructorKey INT NOT NULL DEFAULT(-1),
        ClassTime char(5) Default('9:15'),
        LastName VARCHAR(30) DEFAULT ('Teixeira') NOT NULL,
        FirstName VARCHAR(30)  DEFAULT ('Michael') NOT NULL,
        QmailEmailAddress VARCHAR(45) DEFAULT ('Michael.Teixeira93@qmail.cuny.edu') NOT NULL,
        DateAdded DATETIME2(7) DEFAULT sysdatetime() NOT NULL,
        DateOfLastUpdate DATETIME2(7) DEFAULT sysdatetime() not null,
        AuthorizedUserId int null DEFAULT(93)

        CONSTRAINT PK_DepartmentInstructor PRIMARY KEY(DepartmentInstructorID),
    )


    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Created the DepartmentInstructor Table', @StartingTime = @StartTime;


END
GO









-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateModeOfInstructionTable]
-- Create date: November 25th, 2019
-- Description: Creates the ModeOfInstruction Table 
-- =============================================


DROP PROCEDURE IF EXISTS[Project3].[usp_CreateModeOfInstructionTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateModeOfInstructionTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()

    CREATE TABLE [Queens-College].[ModeOfInstruction](
        ModeOfInstructionID INT NOT NULL,
        ModeOfInstructionName NVARCHAR(15) NOT NULL,
        ClassTime char(5) Default('9:15'),
        LastName VARCHAR(30) DEFAULT ('Teixeira') NOT NULL,
        FirstName VARCHAR(30)  DEFAULT ('Michael') NOT NULL,
        QmailEmailAddress VARCHAR(45) DEFAULT ('Michael.Teixeira93@qmail.cuny.edu') NOT NULL,
        DateAdded DATETIME2(7) DEFAULT sysdatetime() NOT NULL,
        DateOfLastUpdate DATETIME2(7) DEFAULT sysdatetime() not null,
        AuthorizedUserId int null DEFAULT(93)

        CONSTRAINT PK_ModeOfInstruction PRIMARY KEY(ModeOfInstructionID)
    )
    

    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Created the ModeOfInstruction Table', @StartingTime = @StartTime;
END
GO









-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateRoomLocationTable]
-- Create date: November 25th, 2019
-- Description: Creates the RoomLocation Table 
-- =============================================


DROP PROCEDURE IF EXISTS[Project3].[usp_CreateRoomLocationTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateRoomLocationTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()

    CREATE TABLE [Queens-College].[RoomLocation](
        RoomLocationID INT NOT NULL,
        RoomName NVARCHAR(9) NOT NULL,
        ClassTime char(5) Default('9:15'),
        LastName VARCHAR(30) DEFAULT ('Teixeira') NOT NULL,
        FirstName VARCHAR(30)  DEFAULT ('Michael') NOT NULL,
        QmailEmailAddress VARCHAR(45) DEFAULT ('Michael.Teixeira93@qmail.cuny.edu') NOT NULL,
        DateAdded DATETIME2(7) DEFAULT sysdatetime() NOT NULL,
        DateOfLastUpdate DATETIME2(7) DEFAULT sysdatetime() not null,
        AuthorizedUserId int null DEFAULT(93)
        
        CONSTRAINT PK_RoomLocation PRIMARY KEY(RoomLocationID)
    )

    EXEC  [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Created the RoomLocation Table', @StartingTime = @StartTime;


END
GO





-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateBuildingLocationTable]
-- Create date: November 25th, 2019
-- Description: Creates the BuildingLocation Table 
-- =============================================


DROP PROCEDURE IF EXISTS[Project3].[usp_CreateBuildingLocationTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateBuildingLocationTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()

    
    CREATE TABLE [Queens-College].[BuildingLocation](
        BuildingLocationID INT NOT NULL,
        BuildingName NVARCHAR(5),
        ClassTime char(5) Default('9:15'),
        LastName VARCHAR(30) DEFAULT ('Teixeira') NOT NULL,
        FirstName VARCHAR(30)  DEFAULT ('Michael') NOT NULL,
        QmailEmailAddress VARCHAR(45) DEFAULT ('Michael.Teixeira93@qmail.cuny.edu') NOT NULL,
        DateAdded DATETIME2(7) DEFAULT sysdatetime() NOT NULL,
        DateOfLastUpdate DATETIME2(7) DEFAULT sysdatetime() not null,
        AuthorizedUserId int null DEFAULT(93)

        CONSTRAINT PK_BuildingLocation PRIMARY KEY(BuildingLocationID)
    )

    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription ='Created the BuildingLocation Table', @StartingTime = @StartTime;


END
GO




-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateBuildingRoomTable]
-- Create date: November 25th, 2019
-- Description: Creates the BuildingRoom Table 
-- =============================================




DROP PROCEDURE IF EXISTS [Project3].[usp_CreateBuildingRoomTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateBuildingRoomTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()

    CREATE TABLE [Queens-College].[BuildingRoom](
        BuildingRoomID INT NOT NULL,
        RoomLocationKey INT NOT NULL,
        BuildingLocationKey INT NOT NULL,
        ClassTime char(5) Default('9:15'),
        LastName VARCHAR(30) DEFAULT ('Teixeira') NOT NULL,
        FirstName VARCHAR(30)  DEFAULT ('Michael') NOT NULL,
        QmailEmailAddress VARCHAR(45) DEFAULT ('Michael.Teixeira93@qmail.cuny.edu') NOT NULL,
        DateAdded DATETIME2(7) DEFAULT sysdatetime() NOT NULL,
        DateOfLastUpdate DATETIME2(7) DEFAULT sysdatetime() not null,
        AuthorizedUserId int null DEFAULT(93)


        CONSTRAINT PK_BuildingRoomID PRIMARY KEY(BuildingRoomID)
    )

    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription ='Created the BuildingRoom Table', @StartingTime = @StartTime;

END
GO
























-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateCourseTable]
-- Create date: November 25th, 2019
-- Description: Creates the Course Table 
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[usp_CreateCourseTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateCourseTable]


AS
BEGIN

    SET NOCOUNT ON;


    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()

    CREATE TABLE [Queens-College].[Course](
        CourseID INT NOT NULL,
        CourseName NVARCHAR(50) NOT NULL,
        CourseHour NVARCHAR(2) NULL,
        CourseCredit NVARCHAR(2) NULL,
        ClassTime char(5) Default('9:15'),
        LastName VARCHAR(30) DEFAULT ('Teixeira') NOT NULL,
        FirstName VARCHAR(30)  DEFAULT ('Michael') NOT NULL,
        QmailEmailAddress VARCHAR(45) DEFAULT ('Michael.Teixeira93@qmail.cuny.edu') NOT NULL,
        DateAdded DATETIME2(7) DEFAULT sysdatetime() NOT NULL,
        DateOfLastUpdate DATETIME2(7) DEFAULT sysdatetime() not null,
        AuthorizedUserId int null DEFAULT(93)


        CONSTRAINT PK_Course PRIMARY KEY(CourseID)

    )

    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Created the Course Table', @StartingTime = @StartTime;

END
GO






-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateTimeSlotTable]
-- Create date: November 25th, 2019
-- Description: Creates the TimeSlot Table 
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[usp_CreateTimeSlotTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateTimeSlotTable]


AS
BEGIN

    SET NOCOUNT ON;


    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()


    CREATE TABLE [Queens-College].[TimeSlot](
        TimeSlotID INT NOT NULL,
        ClassStartingTime NVARCHAR(20) NULL,
        ClassEndingTime NVARCHAR(20) NULL,
        ClassDay NVARCHAR(9) NULL,
        ClassTime char(5) Default('9:15'),
        LastName VARCHAR(30) DEFAULT ('Teixeira') NOT NULL,
        FirstName VARCHAR(30)  DEFAULT ('Michael') NOT NULL,
        QmailEmailAddress VARCHAR(45) DEFAULT ('Michael.Teixeira93@qmail.cuny.edu') NOT NULL,
        DateAdded DATETIME2(7) DEFAULT sysdatetime() NOT NULL,
        DateOfLastUpdate DATETIME2(7) DEFAULT sysdatetime() not null,
        AuthorizedUserId int null DEFAULT(93)


        CONSTRAINT PK_TimeSlot PRIMARY KEY(TimeSlotID)
    )

    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Created the TimeSlot Table', @StartingTime = @StartTime;


END
GO








-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateSemesterTable]
-- Create date: November 25th, 2019
-- Description: Creates the Semester Table 
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[usp_CreateSemesterTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateSemesterTable]


AS
BEGIN

    SET NOCOUNT ON;


    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()

    CREATE TABLE [Queens-College].[Semester](
        SemesterID INT NOT NULL,
        Semester NVARCHAR(8) NOT NULL,
        SemesterYear NVARCHAR(4) NOT NULL,
        ClassTime CHAR(5) Default('9:15'),
        LastName VARCHAR(30) DEFAULT ('Teixeira') NOT NULL,
        FirstName VARCHAR(30)  DEFAULT ('Michael') NOT NULL,
        QmailEmailAddress VARCHAR(45) DEFAULT ('Michael.Teixeira93@qmail.cuny.edu') NOT NULL,
        DateAdded DATETIME2(7) DEFAULT SYSDATETIME() NOT NULL,
        DateOfLastUpdate DATETIME2(7) DEFAULT SYSDATETIME() not null,
        AuthorizedUserId INT NOT NULL DEFAULT(93)

        CONSTRAINT PK_SemesterID PRIMARY KEY(SemesterID)
    )

    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Created the Semester Table', @StartingTime = @StartTime;


END
GO




-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateClassTable]
-- Create date: November 25th, 2019
-- Description: Creates the Class Table 
-- =============================================




DROP PROCEDURE IF EXISTS [Project3].[usp_CreateClassTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateClassTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()


    CREATE TABLE [Queens-College].[Class](
        ClassID INT NOT NULL,
        TimeSlotKey INT NOT NULL DEFAULT(-1),
        InstructorKey INT NOT NULL DEFAULT(-1),
        BuildingRoomKey INT NOT NULL DEFAULT(-1),
        CourseKey INT NOT NULL DEFAULT(-1),
        ModeOfInstructionKey INT NOT NULL DEFAULT(-1),
        SemesterKey INT NOT NULL DEFAULT(-1),
        [Limit] INT NOT NULL DEFAULT(0),
        Enrolled INT NOT NULL DEFAULT(0),
        ClassName NVARCHAR(40) NOT NULL DEFAULT('Not Provided'),
        ClassTime CHAR(5) Default('9:15'),
        LastName VARCHAR(30) DEFAULT ('Teixeira') NOT NULL,
        FirstName VARCHAR(30)  DEFAULT ('Michael') NOT NULL,
        QmailEmailAddress VARCHAR(45) DEFAULT ('Michael.Teixeira93@qmail.cuny.edu') NOT NULL,
        DateAdded DATETIME2(7) DEFAULT SYSDATETIME() NOT NULL,
        DateOfLastUpdate DATETIME2(7) DEFAULT SYSDATETIME() not null,
        AuthorizedUserId INT NOT NULL DEFAULT(93)


        CONSTRAINT PK_Class PRIMARY KEY(ClassID) 

    )

    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Created the Class Table', @StartingTime = @StartTime;



END
GO









-- ----------------------------------------------------------------------- DEPARTMENT TABLE ------------------------------------------------------------------------------------------------



-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateSequenceObjectForDepartmentTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for the Department Table 
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[usp_CreateSequenceObjectForDepartmentTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateSequenceObjectForDepartmentTable]

AS
BEGIN

    SET NOCOUNT ON;

    CREATE SEQUENCE [Project3].[SequenceObjectForDepartmentId]
        START WITH 1
        INCREMENT BY 1

END
GO







-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_LoadDepartmentTable]
-- Create date: November 25th, 2019
-- Description: Loads data into the Department Table using the UploadFile.CoursesSpring2019 
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[usp_LoadDepartmentTable]
GO

CREATE PROCEDURE [Project3].[usp_LoadDepartmentTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();

    EXEC [Project3].[usp_CreateSequenceObjectForDepartmentTable];



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




-- ----------------------------------------------------------------------- INSTRUCTOR TABLE ------------------------------------------------------------------------------------------------



-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateSequenceObjectForInstructorTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for the InstructorID
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[usp_CreateSequenceObjectForInstructorTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateSequenceObjectForInstructorTable]

AS
BEGIN

    SET NOCOUNT ON;

    CREATE SEQUENCE [Project3].[SequenceObjectForInstructorId]
        START WITH 1
        INCREMENT BY 1

END
GO







-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_LoadInstructorTable]
-- Create date: November 25th, 2019
-- Description: Loads the Instructor Table with the Data from the UploadFile.SpringCourses2019
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[usp_LoadInstructorTable] 
GO


CREATE PROCEDURE [Project3].[usp_LoadInstructorTable]

AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()


    EXEC [Project3].[usp_CreateSequenceObjectForInstructorTable];


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


-- ----------------------------------------------------------------------- DEPARTMENT_INSTRUCTOR TABLE ------------------------------------------------------------------------------------------------



-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateSequenceObjectForDepartmentInstructorTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for the DepartmentInstructorID
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[usp_CreateSequenceObjectForDepartmentInstructorTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateSequenceObjectForDepartmentInstructorTable]

AS
BEGIN

    SET NOCOUNT ON;

    CREATE SEQUENCE [Project3].[SequenceObjectForDepartmentInstructorId]
        START WITH 1
        INCREMENT BY 1

END
GO





-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_LoadDepartmentInstructorTable]
-- Create date: November 25th, 2019
-- Description: Loads the DepartmentInstructor Table with the Data from the UploadFile.SpringCourses2019
-- =============================================



DROP PROCEDURE IF EXISTS [Project3].[usp_LoadTheDepartmentInstructorTable];
GO

CREATE PROCEDURE [Project3].[usp_LoadTheDepartmentInstructorTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()

    EXEC [Project3].[usp_CreateSequenceObjectForDepartmentInstructorTable];



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





-- ----------------------------------------------------------------------- MODE OF INSTRUCTION TABLE ------------------------------------------------------------------------------------------------






-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateSequenceObjectForModeOfInstructionTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for the ModeOfInstructionID
-- =============================================



DROP PROCEDURE IF EXISTS [Project3].[usp_CreateSequenceObjectForModeOfInstructionTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateSequenceObjectForModeOfInstructionTable]

AS
BEGIN

    SET NOCOUNT ON;

    CREATE SEQUENCE [Project3].[SequenceObjectForModeOfInstructionId]
        START WITH 1
        INCREMENT BY 1

END
GO



-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[LoadModeOfInstructionTable]
-- Create date: November 25th, 2019
-- Description: Loads the Mode Of Instruction with data from the UploadFile.CoursesSpring2019
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[usp_LoadModeOfInstructionTable]
GO

CREATE PROCEDURE [Project3].[usp_LoadModeOfInstructionTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()

    EXEC [Project3].[usp_CreateSequenceObjectForModeOfInstructionTable];



    INSERT INTO [Queens-College].[ModeOfInstruction] (ModeOfInstructionID, ModeOfInstructionName)
    SELECT
        NEXT VALUE FOR [Project3].[SequenceObjectForModeOfInstructionId],
        Result.MOI
    FROM (SELECT DISTINCT [Mode Of Instruction] AS MOI
        FROM Uploadfile.CoursesSpring2019 ) AS Result



    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Loaded data into the Mode Of Instruction Table', @StartingTime = @StartTime;


END
GO





-- ----------------------------------------------------------------------- BUILDING_LOCATION TABLE ------------------------------------------------------------------------------------------------


-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateSequenceObjectForBuildingLocationTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for BuildingLocation Table
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[usp_CreateSequenceObjectForBuildingLocationTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateSequenceObjectForBuildingLocationTable]

AS
BEGIN

    SET NOCOUNT ON;

    CREATE SEQUENCE [Project3].[SequenceObjectForBuildingLocationId]
        START WITH 1
        INCREMENT BY 1

END
GO




-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_LoadBuildingLocationTable]
-- Create date: November 25th, 2019
-- Description: Loads the BuildingLocation table with data from the UploadFile.CoursesSpring2019
-- =============================================



DROP PROCEDURE IF EXISTS [Project3].[usp_LoadBuildingLocationTable]
GO

CREATE PROCEDURE [Project3].[usp_LoadBuildingLocationTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();

    EXEC [Project3].[usp_CreateSequenceObjectForBuildingLocationTable];




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





-- ----------------------------------------------------------------------- ROOM_LOCATION TABLE ------------------------------------------------------------------------------------------------


-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateSequenceObjectForRoomLocationTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for RoomLocation Table
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[usp_CreateSequenceObjectForRoomLocationTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateSequenceObjectForRoomLocationTable]

AS
BEGIN

    SET NOCOUNT ON;

    CREATE SEQUENCE [Project3].[SequenceObjectForRoomId]
        START WITH 1
        INCREMENT BY 1

END
GO



-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_LoadRoomLocationTable]
-- Create date: November 25th, 2019
-- Description: Loads the RoomLocation table with data from the UploadFile.CoursesSpring2019
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[usp_LoadRoomLocationTable]
GO

CREATE PROCEDURE [Project3].[usp_LoadRoomLocationTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();

    EXEC [Project3].[usp_CreateSequenceObjectForRoomLocationTable];



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





-- ----------------------------------------------------------------------- BUILDING-ROOM TABLE ------------------------------------------------------------------------------------------------





-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateSequenceObjectForBuildingRoomLocationTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for BuildingRoomLocation Table
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[usp_CreateSequenceObjectForBuildingRoomLocationTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateSequenceObjectForBuildingRoomLocationTable]

AS
BEGIN

    SET NOCOUNT ON;

    CREATE SEQUENCE [Project3].[SequenceObjectForBuildingRoomId]
        START WITH 1
        INCREMENT BY 1

END
GO






-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_LoadBuildingRoomLocationTable]
-- Create date: November 25th, 2019
-- Description: Loads the RoomLocation table with data from the UploadFile.CoursesSpring2019
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[usp_LoadBuildingRoomLocationTable]
GO

CREATE PROCEDURE [Project3].[usp_LoadBuildingRoomLocationTable]


AS
BEGIN

    SET NOCOUNT ON;


    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME()

    EXEC [Project3].[usp_CreateSequenceObjectForBuildingRoomLocationTable];



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


-- ----------------------------------------------------------------------- COURSE TABLE ------------------------------------------------------------------------------------------------



-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateSequenceObjectForCourseTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for CourseTable
-- =============================================




DROP PROCEDURE IF EXISTS [Project3].[usp_CreateSequenceObjectForCourseTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateSequenceObjectForCourseTable]

AS
BEGIN

    SET NOCOUNT ON;

    CREATE SEQUENCE [Project3].[SequenceObjectForCourseId]
        START WITH 1
        INCREMENT BY 1

END
GO


-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_LoadCourseTable]
-- Create date: November 25th, 2019
-- Description: Loads the Course table with data from the UploadFile.CoursesSpring2019
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[usp_LoadCourseTable]
GO

CREATE PROCEDURE [Project3].[usp_LoadCourseTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();

    EXEC [Project3].[usp_CreateSequenceObjectForCourseTable];




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




-- ----------------------------------------------------------------------- TIME SLOT TABLE ------------------------------------------------------------------------------------------------


-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateSequenceObjectForTimeSlotTable]
-- Create date: November 25th, 2019
-- Description: Loads the TimeSlot table with data from the UploadFile.CoursesSpring2019
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[usp_CreateSequenceObjectForTimeSlotTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateSequenceObjectForTimeSlotTable]

AS
BEGIN

    SET NOCOUNT ON;

    CREATE SEQUENCE [Project3].[SequenceObjectForTimeSlotId]
        START WITH 1
        INCREMENT BY 1

END
GO


-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_LoadTimeSlotTable]
-- Create date: November 25th, 2019
-- Description: Loads the TimeSlot table with data from the UploadFile.CoursesSpring2019
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[usp_LoadTimeSlotTable]
GO

CREATE PROCEDURE [Project3].[usp_LoadTimeSlotTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();


    EXEC [Project3].[usp_CreateSequenceObjectForTimeSlotTable];



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

-- ----------------------------------------------------------------------- Semester TABLE ------------------------------------------------------------------------------------------------


-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateSequenceObjectForSemesterTable]
-- Create date: November 25th, 2019
-- Description: Loads the Semester table with data from the UploadFile.CoursesSpring2019
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[usp_CreateSequenceObjectForSemesterTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateSequenceObjectForSemesterTable]

AS
BEGIN

    SET NOCOUNT ON;

    CREATE SEQUENCE [Project3].[SequenceObjectForSemesterId]
        START WITH 1
        INCREMENT BY 1

END
GO



-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_LoadTimeSlotTable]
-- Create date: November 25th, 2019
-- Description: Loads the TimeSlot table with data from the UploadFile.CoursesSpring2019
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[usp_LoadSemesterTable]
GO

CREATE PROCEDURE [Project3].[usp_LoadSemesterTable]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();

    EXEC [Project3].[usp_CreateSequenceObjectForSemesterTable];


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





-- ----------------------------------------------------------------------- Class TABLE ------------------------------------------------------------------------------------------------





-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_CreateSequenceObjectForClassTable]
-- Create date: November 25th, 2019
-- Description: Creates the Sequence Object for Class Table
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[usp_CreateSequenceObjectForClassTable]
GO

CREATE PROCEDURE [Project3].[usp_CreateSequenceObjectForClassTable]

AS
BEGIN

    SET NOCOUNT ON;

    CREATE SEQUENCE [Project3].[SequenceObjectForClassId]
        START WITH 1
        INCREMENT BY 1

END
GO



-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[usp_LoadClassTable]
-- Create date: November 25th, 2019
-- Description: Loads the Class table with data from the UploadFile.CoursesSpring2019, TimeSlot, BuildingRoom, Instructor, and Course table
-- =============================================



DROP PROCEDURE IF EXISTS [Project3].[usp_LoadClassTable]
GO

CREATE PROCEDURE [Project3].[usp_LoadClassTable]

AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();

    EXEC [Project3].[usp_CreateSequenceObjectForClassTable];


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




-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[SetupForeignKeyRelationships]
-- Create date: November 25th, 2019
-- Description: Setups up the foreign key relationships for the DepartmentInstructor table, InstructorModeOfInstruction table, BuildingLocation table, and the Class table
-- =============================================


CREATE PROCEDURE [Project3].[SetupForeignKeyRelationships]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();

    ALTER TABLE [Queens-College].[DepartmentInstructor]
    ADD CONSTRAINT FK_Department FOREIGN KEY(DepartmentKey) REFERENCES [Queens-College].[Department] (DepartmentID),
        CONSTRAINT FK_Instructor FOREIGN KEY(InstructorKey) REFERENCES [Queens-College].[Instructor] (InstructorID)




    ALTER TABLE [Queens-College].[BuildingRoom]
    ADD CONSTRAINT FK_BuildingLocation FOREIGN KEY(BuildingLocationKey) REFERENCES [Queens-College].[BuildingLocation](BuildingLocationID),
        CONSTRAINT FK_RoomLocation FOREIGN KEY(RoomLocationKey) REFERENCES [Queens-College].[RoomLocation](RoomLocationID)



    ALTER TABLE [Queens-College].[Class]
    ADD CONSTRAINT FK_TimeSlot FOREIGN KEY(TimeSlotKey) REFERENCES [Queens-College].[TimeSlot](TimeSlotID),
        CONSTRAINT FK_InstructorClass FOREIGN KEY(InstructorKey) REFERENCES [Queens-College].[Instructor](InstructorID),
        CONSTRAINT FK_BuildingRoom FOREIGN KEY(BuildingRoomKey) REFERENCES [Queens-College].[BuildingRoom](BuildingRoomID),
        CONSTRAINT FK_Course FOREIGN KEY(CourseKey) REFERENCES [Queens-College].[Course](CourseID),
        CONSTRAINT FK_ModeOfInstruction FOREIGN KEY(ModeOfInstructionKey) REFERENCES [Queens-College].[ModeOfInstruction](ModeOfInstructionID),
        CONSTRAINT FK_Semester FOREIGN KEY(SemesterKey) REFERENCES [Queens-College].[Semester](SemesterID)


    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Added Foreign Keys to  tables', @StartingTime = @StartTime;

END
GO


















-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[DropAllForeignKeyConstraints]
-- Create date: November 25th, 2019
-- Description: Drops the FKs from the Class table, BuildingLocation table, and the  DepartmentInstructor table
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[DropAllForeignKeyConstraints]
GO

CREATE PROCEDURE [Project3].[DropAllForeignKeyConstraints]

AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();

    ALTER TABLE [Queens-College].[DepartmentInstructor]
    DROP CONSTRAINT FK_Department, FK_Instructor;

    ALTER TABLE [Queens-College].[BuildingRoom]
    DROP CONSTRAINT FK_BuildingLocation, FK_RoomLocation

    ALTER TABLE [Queens-College].[Class]
    DROP CONSTRAINT FK_TimeSlot, FK_InstructorClass, FK_BuildingRoom, FK_Course, FK_ModeOfInstruction, FK_Semester 


    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Dropped all foreign key constraints', @StartingTime = @StartTime;
END
GO









-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[TruncateAllTables]
-- Create date: November 25th, 2019
-- Description: Truncates all of the data in every table
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[TruncateAllTables];
GO


CREATE PROCEDURE [Project3].[TruncateAllTables]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();


    TRUNCATE TABLE [Queens-College].[BuildingLocation];
    TRUNCATE TABLE [Queens-College].[BuildingRoom];
    TRUNCATE TABLE [Queens-College].[Class];
    TRUNCATE TABLE [Queens-College].[Course];
    TRUNCATE TABLE [Queens-College].[Department];
    TRUNCATE TABLE [Queens-College].[DepartmentInstructor];
    TRUNCATE TABLE [Queens-College].[Instructor];
    TRUNCATE TABLE [Queens-College].[ModeOfInstruction];
    TRUNCATE TABLE [Queens-College].[RoomLocation];
    TRUNCATE TABLE [Queens-College].[Semester];
    TRUNCATE TABLE [Queens-College].[TimeSlot];


    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Truncated all data in every table ', @StartingTime = @StartTime;


END
GO








EXEC [Project3].[usp_CreateDepartmentTable];
GO
EXEC [Project3].[usp_CreateInstructorTable];
GO
EXEC [Project3].[usp_CreateDepartmentInstructorTable];
GO



EXEC [Project3].[usp_CreateBuildingLocationTable];
GO
EXEC [Project3].[usp_CreateRoomLocationTable];
GO
EXEC [Project3].[usp_CreateBuildingRoomTable];
GO


EXEC [Project3].[usp_CreateModeOfInstructionTable];
GO
EXEC [Project3].[usp_CreateCourseTable];
GO
EXEC [Project3].[usp_CreateTimeSlotTable];
GO
EXEC [Project3].[usp_CreateSemesterTable]
GO


EXEC [Project3].[usp_CreateClassTable]
GO





-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project3].[BuildQueensCollegeScheduleSpring2019Database]
-- Create date: November 25th, 2019
-- Description: Loads all the stored procedures to create the QueensCollege dScheduling Database
-- =============================================



DROP PROCEDURE IF EXISTS [Project3].[BuildQueensCollegeScheduleSpring2019Database];
GO


CREATE PROCEDURE [Project3].[BuildQueensCollegeScheduleSpring2019Database]


AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(7)
    SET @StartTime = SYSDATETIME();

    EXEC [Project3].[usp_LoadDepartmentTable];

    EXEC [Project3].[usp_LoadInstructorTable];

    EXEC [Project3].[usp_LoadTheDepartmentInstructorTable];

    EXEC [Project3].[usp_LoadModeOfInstructionTable];

    EXEC [Project3].[usp_LoadBuildingLocationTable];

    EXEC [Project3].[usp_LoadRoomLocationTable];

    EXEC [Project3].[usp_LoadBuildingRoomLocationTable];

    EXEC [Project3].[usp_LoadCourseTable];

    EXEC [Project3].[usp_LoadTimeSlotTable];

    EXEC [Project3].[usp_LoadSemesterTable];

    EXEC [Project3].[usp_LoadClassTable];


    EXEC [Project3].[SetupForeignKeyRelationships];

    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Loaded star schema', @StartingTime = @StartTime;


END
GO




-- EXEC [Project3].[usp_LoadDepartmentTable];
-- GO
-- EXEC [Project3].[usp_LoadInstructorTable];
-- GO
-- EXEC [Project3].[usp_LoadDepartmentInstructorTable];
-- GO
-- EXEC [Project3].[usp_LoadModeOfInstructionTable]
-- GO
-- EXEC [Project3].[usp_LoadBuildingLocationTable];
-- GO
-- EXEC [Project3].[usp_LoadRoomLocationTable];
-- GO
-- EXEC [Project3].[usp_LoadBuildingRoomLocationTable];
-- GO
-- EXEC [Project3].[usp_LoadCourseTable];
-- GO
-- EXEC [Project3].[usp_LoadTimeSlotTable];
-- GO
-- EXEC [Project3].[usp_LoadSemesterTable];
-- GO
-- EXEC [Project3].[usp_LoadClassTable];
