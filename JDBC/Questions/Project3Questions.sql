USE QueensCollegeSchedulSpring2019;
GO




/*
1. Show all instructors who are teaching in classes in multiple departments
2. How many instructors are in each department?
3. How may classes that are being taught that semester grouped by course and aggregating the total enrollment, total class limit and the percentage of enrollment.
4. 3 more queries of your choice and their proposition.
*/


-- 1. Show all instructors who are teaching in classes in multiple departments

-- There exists many instructors who are teaching in several departments

SELECT
    DISTINCT
    InstructorFullName,
    DepartmentName
FROM [Queens-College].[Instructor] AS I
    INNER JOIN [Queens-College].[DepartmentInstructor] AS DI
        ON I.InstructorID = DI.[InstructorKey]
    INNER JOIN [Queens-College].[Department] AS D
        ON DI.[DepartmentKey] = D.DepartmentID
    INNER JOIN [Queens-College].[Class] AS C
        ON DI.InstructorKey = I.InstructorID
ORDER BY InstructorFullName, DepartmentName;


-- 2. How many instructors are in each department?

-- There exists many instructors in each department



SELECT
    COUNT(InstructorFullName) AS InstructorCount,
    DepartmentName
FROM [Queens-College].[Instructor] AS I
    INNER JOIN [Queens-College].[DepartmentInstructor] AS DI
        ON I.InstructorID = DI.[InstructorKey]
    INNER JOIN [Queens-College].[Department] AS D
        ON DI.[DepartmentKey] = D.DepartmentID
GROUP BY DepartmentName;













-- 3. How many classes that are being taught that semester grouped by course and aggregating the total enrollment, total class limit and the percentage of enrollment.

-- PROPOSITION - There exists many classes with an enrollment to limit ratio that is less than or equal to 100%



SELECT
    CourseName,
    SUM(Enrolled) AS [Total Number Of People Enrolled],
    SUM([Limit]) AS [Total Class Limit],
    CASE WHEN 
        SUM([Limit]) = 0 THEN CONCAT(0, '%')
        ELSE
            CONCAT((SUM([Enrolled]) * 100) / SUM([Limit]), '%')
    END AS PercentOfEnrollment 
FROM [Queens-College].[Class] AS C
    INNER JOIN [Queens-College].[Course] AS Course
        ON C.CourseKey = Course.CourseID
GROUP BY CourseName;



-- 4 Which class had the most students enrolled?

-- PROPOSITION - There exists a class with the most student enrollment

SELECT
    CourseName,
    SUM(Enrolled) AS [Total Number Of People Enrolled]
FROM [Queens-College].[Class] AS C
    INNER JOIN [Queens-College].[Course] AS Course
        ON C.CourseKey = Course.CourseID
GROUP BY CourseName
ORDER BY [Total Number Of People Enrolled] DESC;



-- 5 What was the 5th most common time slot for classes?

-- PROPOSITION - There exists a time slot that is the 5th most common.

SELECT
    ClassStartingTime,
    COUNT(ClassStartingTime) AS [Total Starting Time]
FROM [Queens-College].[TimeSlot] AS TS
    INNER JOIN [Queens-College].[Class] AS C
        ON TS.TimeSlotID = C.TimeSlotKey
GROUP BY ClassStartingTime
ORDER BY [Total Starting Time] DESC
OFFSET 4 ROWS FETCH NEXT 1 ROWS ONLY;




-- 6 Display the amount of classes taught by each professor per department. Grouped by InstructorFullName and DepartmentName

-- PROPOSITAION - There exists Instructors in several departments that have taught various classes.

SELECT
    InstructorFullName,
    COUNT(InstructorFullName) AS [Number Of Classes Taught]
FROM [Queens-College].[Instructor] AS I
    INNER JOIN [Queens-College].[Class] AS C
        ON I.InstructorID = C.InstructorKey
    INNER JOIN [Queens-College].[DepartmentInstructor] AS DI
        ON DI.InstructorKey = I.InstructorID
    INNER JOIN [Queens-College].[Department] AS D
        ON D.DepartmentID = DI.DepartmentKey 
WHERE LEN(InstructorFullName) > 1
GROUP BY InstructorFullName ORDER BY InstructorFullName;

SELECT
    InstructorFullName
FROM [Queens-College].[Instructor] AS I
    INNER JOIN [Queens-College].[Class] AS C
        ON I.InstructorID = C.InstructorKey
    INNER JOIN [Queens-College].[DepartmentInstructor] AS DI
        ON DI.InstructorKey = I.InstructorID
    INNER JOIN [Queens-College].[Department] AS D
        ON D.DepartmentID = DI.DepartmentKey 




