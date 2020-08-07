USE QueensCollegeSchedulSpring2019
GO




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





