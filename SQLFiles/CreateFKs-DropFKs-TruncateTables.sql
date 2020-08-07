USE QueensCollegeSchedulSpring2019;
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













