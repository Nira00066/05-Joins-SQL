-- PARTIE 1 INNER join 

--*************** 1 Afficher le nom complet de l'étudiant et l'institulé de sa formation.**************************
 SELECT s.first_name,s.last_name,c.course_name FROM Student AS s INNER JOIN Course AS c  ON s.course_id = c.course_id ;

+------------+-----------+---------------------------+
| first_name | last_name | course_name               |
+------------+-----------+---------------------------+
| Sofia      | Martin    | Développement Web         |
| Ali        | Kacem     | Data Analyst              |
| Tom        | Lemoine   | Data Analyst              |
| Julie      | Durand    | Cybersécurité             |
| Emma       | Rossi     | Intelligence Artificielle |
+------------+-----------+---------------------------+


 --**** 2 Liste les étudiantq inscrits en 'Data Analyste'
  SELECT s.first_name,s.last_name, FROM Student AS s INNER JOIN Course AS c  ON s.course_id = c.course_id WHERE course_name = 'Data Analyst' ;

  +------------+----------+
| first_name | last_name | 
+------------+-----------+
| Ali        | Kacem     |
| Tom        | Lemoine   |
+------------+-----------+


-- 3 Lister les examens avec le prénom, nom de l’étudiant, le nom du cours, la note et la date.--

SELECT s.first_name, s.last_name , c.course_name , e.exam_date , e.score  FROM Student AS s INNER JOIN Exam AS e ON e.student_id = e.student_id 
INNER JOIN Course AS c ON c.course_id = e.course_id; 

-- PARTIE 2

--4-Afficher tous les étudiants avec leur formation, y compris ceux sans formation

SELECT * FROM Student AS s LEFT JOIN Course AS c  ON s.course_id = c.course_id ;

-- 5- Afficher les étudiants sans formation (champ NULL).
SELECT * FROM Student AS s LEFT JOIN Course AS c  ON s.course_id = c.course_id
    WHERE course_name is NULL ;
+------------+------------+-----------+------------+-------------------+-----------+-----------+-------------+--------------+
| student_id | first_name | last_name | birth_year | registration_year | course_id | course_id | course_name | course_level |
+------------+------------+-----------+------------+-------------------+-----------+-----------+-------------+--------------+
|          4 | Karim      | Belaid    |       2000 |              2023 |      NULL |      NULL | NULL        | NULL         |
|          7 | Ines       | Ndiaye    |       2001 |              2022 |      NULL |      NULL | NULL        | NULL         |
+------------+------------+-----------+------------+-------------------+-----------+-----------+-------------+--------------+

--6  Afficher tous les étudiants avec leurs examens, même s’ils n’en ont pas passé.

SELECT * FROM Student AS s LEFT JOIN Exam AS e ON e.student_id = s.student_id


-- PARTIE  3  

-- 7 Afficher toutes les formations même si aucun étudiant n'y est inscrit

SELECT * FROM Course AS c RIGHT JOIN Student AS s  ON s.course_id = c.course_id ;


-- 8 Afficher les examens associés à un cours, y compris les cours sans examens (si possible).
SELECT * FROM Course AS c RIGHT JOIN Student AS s  ON s.course_id = c.course_id  WHERE course_name is NULL;


-- 9 Lister toutes les combinaisons étudiant-formation même sans correspondance.

 SELECT * FROM Student AS s LEFT JOIN Course AS c  ON s.course_id = c.course_id ;

 SELECT * FROM Student AS s RIGHT JOIN Course AS c  ON s.course_id = c.course_id ;

 -- 10 Lister tous les examens et étudiants, même si l'un des deux est manquant.

 SELECT * FROM Student AS s RIGHT JOIN Exam AS e  ON s.student_id = e.student_id ;

!
-- 11 Trouvr les paire d'etudiant nés la meme année

SELECT s1.first_name, s1.birth_year , s2.first_name, s2.birth_year  FROM Student AS s1 JOIN Student  AS s2 ON s1.birth_year = s2.birth_year AND  s1.Student_id < s2.Student_id;

-- 12. Associer chaque étudiant à ceux qui sont plus âgés qu’eux.
SELECT s1.first_name, s1.birth_year , s2.first_name, s2.birth_year  FROM Student AS s1 JOIN Student  AS s2 ON s1.birth_year > s2.birth_year AND NOT s1.Student_id =  s2.Student_id;

-- 13 Générer toutes les combinaisons possibles entre étudiants et types d’examen ('Écrit', 'Oral', 'Projet').

SELECT e.exam_type, s.first_name FROM Student AS s CROSS JOIN Exam As e;

--14 Compter le nombre de lignes produites par ce CROSS JOIN.
'IL y en as 49 row '
SELECT COUNT(*)FROM Student AS s CROSS JOIN Exam As e;




-- PARTIE 7 

--  15 Afficher la moyenne des notes par étudiant.

SELECT AVG(e.score), s.first_name FROM Exam AS e INNER JOIN Student AS s ON s.student_id = e.student_id GROUP BY e.student_id ;

 -- 16 Afficher la note maximale obtenue par cours

  SELECT MAX(e.score), s.first_name , c.course_name FROM Exam AS e INNER JOIN Student AS s ON s.student_id = e.student_id GROUP BY e.student_id JOIN Course AS c ON c.course_id = e.course_id ;

SELECT 
    MAX(e.score) AS max_score,
    s.first_name,
    c.course_name
FROM Exam AS e
INNER JOIN Student AS s ON s.student_id = e.student_id
INNER JOIN Course AS c ON c.course_id = e.course_id
GROUP BY e.student_id , c.course_id;

  -- 17 Lister les étudiants ayant obtenu une note supérieure à 15 à au moins un examen.

SELECT DISTINCT e.score , s.first_name, c.course_name  FROM Exam AS e 
INNER JOIN Student AS s ON s.student_id = e.student_id
INNER JOIN Course AS c ON c.course_id = e.course_id 
WHERE e.score >= 15 ;
