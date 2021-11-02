CREATE
DATABASE demo_stored_procedure;
CREATE TABLE students
(
    id            INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(60) NOT NULL,
    date_of_birth DATE,
    email         VARCHAR(60)
);
INSERT INTO students(name, date_of_birth, email)
VALUES ("Xuân Anh", "1999/06/09", "xa@gmail.com"),
       ("Xuân Annn", "1999/01/02", "xann@gmail.com"),
       ("Wangyiboo", "1997/08/05", "wyb@gmail.com"),
       ("Matsumoto Jun", "1983/08/30", "mtmt@gmail.com"),
       ("Komatsu Nana", "1996/02/16", "nana@gmail.com");

CREATE TABLE account_wed_learning
(
    account    VARCHAR(30) PRIMARY KEY,
    password   VARCHAR(50),
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students (id)
);

-- khong co tham so
DELIMITER //
CREATE PROCEDURE `get_all_student`()
BEGIN
select * from `students` ;
END//
DELIMITER ;

CALL get_all_student();
DROP PROCEDURE `get_all_student`;


DELIMITER //
CREATE PROCEDURE `get_all_student_az`()
BEGIN
select * from `students` order by name asc;
END//
DELIMITER ;

CALL `get_all_student_az`();
DROP PROCEDURE `get_all_student_az`;

-- co tham so
DELIMITER //
CREATE PROCEDURE `find_all_student`(IN `a_keyword` VARCHAR (10))
BEGIN
SELECT *
FROM students
WHERE `name` LIKE CONCAT('%', a_keyword, '%');
END//
DELIMITER ;

CALL find_all_student('w');
CALL find_all_student('o');
DROP PROCEDURE `find_all_student`;


    DELIMITER //
CREATE PROCEDURE `find_student_birth_in_year`(IN `year` int )
BEGIN
SELECT * FROM students
WHERE YEAR (date_of_birth)=`year`;
END//
DELIMITER ;
call `find_student_birth_in_year`(1994);
DROP PROCEDURE `find_student_birth_in_year`;


DELIMITER //
CREATE PROCEDURE `getById`(IN `iddd` INT)
BEGIN
SELECT * FROM students
WHERE id = iddd;
END//
DELIMITER ;


CALL getById('6');
CALL getById('3');
DROP PROCEDURE `getById`;


DELIMITER //
CREATE PROCEDURE `changeName`(OUT name VARCHAR(50))
BEGIN
    SET name = 'Xuan Anhhhh';
END//
DELIMITER ;

CALL changeName(@name);
SELECT @name;

DELIMITER //
CREATE PROCEDURE GetStudentCountByBirthOfYear(IN year INT,OUT total INT)
BEGIN
    SELECT COUNT(name)
    INTO total
    FROM students
    WHERE YEAR (date_of_birth)= year;
END//
DELIMITER ;
CALL GetStudentCountByBirthOfYear('1999',@total);
SELECT @total;


DELIMITER //
CREATE PROCEDURE SetCounter(IN counterIn INT, out counterOut int)
BEGIN
    SET counterOut = counterIn + 10;
END//
DELIMITER ;
-- Gọi store procedure:
SET @counter1 = 1, @counter2;
CALL SetCounter(@counter,@counter2 ); -- 2
CALL SetCounter(@counter,1); -- 3
CALL SetCounter(@counter,5); -- 8
SELECT @counter; -- 8
