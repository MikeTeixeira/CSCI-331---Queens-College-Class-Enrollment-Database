USE QueensCollegeSchedulSpring2019
GO





DROP PROCEDURE IF EXISTS [Project3].[BuildQueensCollegeScheduleSpring2019Database];
GO


CREATE PROCEDURE [Project3].[BuildQueensCollegeScheduleSpring2019Database]


AS

BEGIN

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



END
GO
