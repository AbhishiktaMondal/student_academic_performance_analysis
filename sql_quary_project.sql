--CREATE TABLE
CREATE TABLE student_performance
( Hours_Studied	INT,
Attendance INT,	
Parental_Involvement VARCHAR (10),	
Access_to_Resources	VARCHAR(10),
Extracurricular_Activities	VARCHAR(5),
Sleep_Hours	INT,
Previous_Scores	INT,
Motivation_Level VARCHAR(10),	
Internet_Access	VARCHAR (5),
Tutoring_Sessions INT,	
Family_Income VARCHAR(20),
Teacher_Quality	VARCHAR(20),
School_Type	VARCHAR(10),
Peer_Influence VARCHAR(10),
Physical_Activity INT,
Learning_Disabilities VARCHAR(5),
Parental_Education_Level VARCHAR(20),
Distance_from_Home	VARCHAR(10),
Gender VARCHAR(10),
Exam_Score INT);




--SEE THE VALUE
SELECT COUNT(*)
FROM student_performance;


SELECT * FROM student_performance;



---DATA CLEANING
SELECT * FROM student_performance
WHERE Hours_Studied IS NULL 
OR 
Attendance	IS NULL 
OR
Parental_Involvement IS NULL 
OR 
Access_to_Resources	IS NULL 
OR
Extracurricular_Activities	IS NULL 
OR
Sleep_Hours	IS NULL 
OR
Previous_Scores	IS NULL 
OR
Motivation_Level IS NULL 
OR
Internet_Access	IS NULL 
OR
Tutoring_Sessions IS NULL 
OR
Family_Income IS NULL 
OR
Teacher_Quality IS NULL 
OR
School_Type	IS NULL 
OR
Peer_Influence	IS NULL 
OR
Physical_Activity IS NULL 
OR
Learning_Disabilities IS NULL 
OR
Parental_Education_Level IS NULL 
OR
Distance_from_Home	IS NULL 
OR
Gender	IS NULL 
OR
Exam_Score IS NULL;



--DELETE NULL DATA
DELETE FROM student_performance
WHERE Hours_Studied IS NULL 
OR 
Attendance	IS NULL 
OR
Parental_Involvement IS NULL 
OR 
Access_to_Resources	IS NULL 
OR
Extracurricular_Activities	IS NULL 
OR
Sleep_Hours	IS NULL 
OR
Previous_Scores	IS NULL 
OR
Motivation_Level IS NULL 
OR
Internet_Access	IS NULL 
OR
Tutoring_Sessions IS NULL 
OR
Family_Income IS NULL 
OR
Teacher_Quality IS NULL 
OR
School_Type	IS NULL 
OR
Peer_Influence	IS NULL 
OR
Physical_Activity IS NULL 
OR
Learning_Disabilities IS NULL 
OR
Parental_Education_Level IS NULL 
OR
Distance_from_Home	IS NULL 
OR
Gender	IS NULL 
OR
Exam_Score IS NULL;




--DATA EXPLORATION

SELECT DISTINCT(COUNT(*)) student FROM student_performance



--PROBLEMS & SOLUTIONS

--1)Find the top 10 students with the highest exam scores.
SELECT DISTINCT(exam_score) 
FROM student_performance
ORDER BY exam_score DESC
LIMIT 10;


--2)Calculate the average exam score based on gender.
SELECT gender, ROUND(AVG(exam_score),2) as average_marks
FROM student_performance
GROUP BY gender;


--3)Find the average exam score for each school type.
SELECT school_type, ROUND(AVG(exam_score),2) FROM student_performance
GROUP BY school_type;


--4)Analyse the relationship between attendance percentage and exam scores.
SELECT
	CASE
		WHEN attendance BETWEEN 50 AND 60 THEN 'Low Attendance'
		WHEN attendance BETWEEN 61 AND 75 THEN 'Medium Attendance'
		WHEN attendance BETWEEN 76 AND 90 THEN 'Good Attendance'
		ELSE 'Excellent Attendance'
	END AS attendance_category,
	COUNT(*) as total_students,
	ROUND(AVG(exam_score), 2) as average_score,
	MAX(exam_score) as highest_score,
	MIN(exam_score) as lowest_score
FROM student_performance
GROUP BY attendance_category
ORDER BY average_score DESC;


--5)Find students who studied more than the average study hours.
SELECT hours_studied 
FROM student_performance
WHERE hours_studied > (SELECT AVG(hours_studied) as avarage_study_time FROM student_performance);


--6)Identify students with high attendance but low exam scores.
--We know that 75% attendance is mandatory to attend the exam in academics.
SELECT * FROM student_performance
WHERE attendance > 75
AND exam_score < 60;


--7)Find the average exam score for each motivation level.
SELECT motivation_level, ROUND(AVG(exam_score),2) AS average_exam_score
FROM student_performance
GROUP BY motivation_level;


--8)Compare exam scores of students with and without internet access.
SELECT internet_access, ROUND(AVG(exam_score),2) AS average_score
FROM student_performance
GROUP BY internet_access;


--9)Find which parental involvement level has the highest average exam score.
SELECT parental_involvement, ROUND(AVG(exam_score), 2) as average_score
FROM student_performance
GROUP BY parental_involvement
LIMIT 1;


--10)Calculate the average exam score based on family income category.
SELECT family_income, ROUND(AVG(exam_score), 2) as average_score
FROM student_performance
GROUP BY family_income;


--11)Find the impact of tutoring sessions on exam performance.
SELECT 
	CASE
		WHEN tutoring_sessions BETWEEN 0 AND 2 THEN 'Lower'
		WHEN tutoring_sessions BETWEEN 3 AND 6 THEN 'Medium'
		ELSE 'Higher'
	END AS tutoring_level,
	ROUND(AVG(exam_score), 2) as average_exam_score	
FROM student_performance
GROUP BY tutoring_level
ORDER BY average_exam_score DESC;


--12)Rank students based on exam scores using window functions.
SELECT exam_score,
ROW_NUMBER() OVER (ORDER BY exam_score DESC) as student_rank
FROM student_performance;


--13)Find the top-performing student from each school type.
SELECT *
FROM(SELECT *,
	 RANK() OVER(PARTITION BY school_type ORDER BY exam_score DESC) AS rank_no
	 FROM student_performance) ranked_students
WHERE rank_no = 1;


--14)Find the percentage of students participating in extracurricular activities.
SELECT ROUND((COUNT
				   (CASE
				 	WHEN extracurricular_activities = 'Yes'
				 	THEN 1
				 	END)* 100.0) / COUNT(*),2) AS participation_percentage
		FROM student_performance;
	

--15)Analyse how sleep hours affect exam scores.
SELECT 
	 CASE
	 	 WHEN sleep_hours BETWEEN 1 AND 4 THEN 'Poor Sleep'
		 WHEN sleep_hours BETWEEN 5 AND 7 THEN 'Average Sleep'
		 WHEN sleep_hours BETWEEN 8 and 9 THEN 'Healthy Sleep'
		 ELSE 'OverSleep'
	 END AS sleep_category,
	 COUNT(*) AS total_student,
	 ROUND(AVG(exam_score), 2) AS average_score,
	 MAX(exam_score) AS highest_score,
	 MIN(exam_score) AS lowest_score
FROM student_performance
GROUP BY sleep_category
ORDER BY highest_score DESC;

		  
--16)Find students whose exam scores are above their previous scores.
SELECT exam_score, previous_scores 
FROM student_performance
WHERE exam_score > previous_scores 


--17)Find the average exam score grouped by teacher quality.
SELECT teacher_quality, ROUND(AVG(exam_score), 2) AS average_exam_score
FROM student_performance
GROUP BY teacher_quality;


--18)Identify the most common characteristics of students scoring above 90.
SELECT hours_studied, attendance, parental_involvement, extracurricular_activities, sleep_hours, motivation_level, internet_access, physical_activity, exam_score 
FROM student_performance
WHERE exam_score > 90
ORDER BY exam_score DESC;


--19)Find the relationship between physical activity and academic performance.
SELECT 
	  CASE 
	  	  WHEN physical_activity BETWEEN 5 AND 6 THEN 'High'
		  WHEN physical_activity BETWEEN 2 AND 4 THEN 'Medium'
		  ELSE 'Low'
	  END AS activity_analysis,	  
	  COUNT (*) AS total_student,
	  ROUND (AVG(exam_score), 2) AS average_exam_score,
	  MAX(exam_score) AS maximum_score,
	  MIN(exam_score) AS mimimun_score
FROM student_performance
GROUP BY activity_analysis 
ORDER BY activity_analysis;


--20)Create student performance categories: Excellent, Good, Average, Poor, using CASE WHEN.
SELECT 
	  CASE
	  	  WHEN exam_score BETWEEN 90 AND 101 THEN 'Excellent'
		  WHEN exam_score BETWEEN 75 AND 89 THEN 'Good'
		  WHEN exam_score BETWEEN 59 AND 74 THEN 'Average'
		  ELSE 'Poor'
	 END AS category,
	 COUNT(*) AS total_students
FROM student_performance
GROUP BY category
ORDER BY total_students DESC;

	 
--21)Find students who have both high motivation and high attendance.
SELECT * FROM student_performance
WHERE attendance > 75 AND motivation_level = 'High'


--22)Calculate the average attendance for each gender.
SELECT gender, ROUND(AVG(attendance), 2) AS average_attendance
FROM student_performance
GROUP BY gender
ORDER BY average_attendance DESC;


--23)Find the number of students in each parental education level.
SELECT parental_education_level, COUNT(*) AS number_of_students
FROM student_performance
GROUP BY parental_education_level;


--24)Identify students with low study hours but high exam scores.
SELECT hours_studied, exam_score
FROM student_performance
WHERE hours_studied < 8 AND exam_score > 80;


--25)Find the correlation-style comparison between hours studied and exam scores.
SELECT
	  CASE
	  	  WHEN hours_studied BETWEEN 1 AND 6 THEN 'Low Study'
		  WHEN hours_studied BETWEEN 7 AND 12 THEN 'Medium Study'
		  ELSE 'High Study'
	 END AS study_hours,
	 COUNT(*) AS total_students,
	 ROUND(AVG(exam_score), 2) AS average_exam_score,
	 MAX(exam_score) AS  highest_score,
	 MIN(exam_score) AS lowest_score
FROM student_performance
GROUP BY study_hours


--26)Find the highest and lowest exam scores in each school type.
SELECT school_type, MAX(exam_score) AS highest_score, MIN(exam_score) AS lowest_score 
FROM student_performance 
GROUP BY school_type;


--27)Analyse exam performance based on peer influence.
SELECT peer_influence, COUNT(*) AS total_students,
ROUND(AVG(exam_score)) as average_score,
MAX(exam_score) AS highest_score,
MIN(exam_score) AS lowest_score
FROM student_performance
GROUP BY peer_influence;


--28)Find students whose attendance is below 75% and exam scores below average.
SELECT attendance, exam_score
FROM student_performance
WHERE attendance < 75 AND exam_score < (SELECT ROUND(AVG(exam_score), 2)FROM student_performance); 


--29)Compare exam scores of students with and without learning disabilities.
SELECT learning_disabilities, 
COUNT(*) AS total_student, 
ROUND(AVG(exam_score), 2) AS average_score,
MAX(exam_score) AS highest_score,
MIN(exam_score) AS lowest_score
FROM student_performance
GROUP BY learning_disabilities;


--30)Create a ranking of motivation levels based on average exam scores.
SELECT *,
RANK() OVER(ORDER BY average_score DESC) AS rank_no
FROM(SELECT motivation_level,
	 ROUND(AVG(exam_score), 2) AS average_score
	 FROM student_performance
	 GROUP BY motivation_level);



--End of Project