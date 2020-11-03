3.1. Please provide data about all books published in 2010. Required attributes are Title and Isbn.

SELECT Title, Isbn
FROM Book
WHERE Publication_year = 2010;

3.2. Please provide data about all employees whose last name contains the substring ki. Data about all attributes are required.

SELECT *
FROM Employee
WHERE Last_name LIKE '%Ki%';

3.3 Please provide data about all books whose title either contains the word HTML or Web. Data about all attributes are required.

SELECT *
FROM Book
WHERE title LIKE '%HTML%' OR title LIKE '%WEB%';

3.4 Please provide data about all employees whose salary ranges from 40000 to 70000 inclusive. Data about all attributes are required.

SELECT *
FROM Employee 
WHERE Salary >= 40000 AND Salary <= 70000;

3.5 Please provide data about all books whose title contains the word Head and published either in 2009 or 2012. Data about all attributes are required.

SELECT *
FROM Book
WHERE title LIKE '%Head%' 
AND (Publication_year = 2009 OR Publication_year = 2012);

3.6 Please provide data about all books either whose Isbn begins with 978 or whose title containts the word First. On top of that, books published in 2009 only are needed. Required attributes are Title and Isbn.

SELECT Title, Isbn
FROM Book
WHERE  Publication_year = 2009 AND (Isbn LIKE '978%' 
OR Title LIKE '%First%')

4.1 Please provide data about all books which have neither been published in 2008 nor in 2012. Required attributes are Publication_year and Title which have to be renamed into Year and BookTitle.

SELECT Publication_year AS Year, Title AS BookTitle
FROM Book
WHERE Publication_year <>2008 AND Publication_year <>2012;

4.2 Please provide data about all authors whose first name contains the word Michael. Required attributes are Last_name and First_name which have to be renamed into LastName and FirstName.

SELECT Last_name AS LastName, First_name AS FirstName
FROM Author
WHERE First_name LIKE '%Michael%';

5.1 Please provide the number of books published in 2012. Rename the header into Published2012.

SELECT COUNT(*) AS Published2012
FROM Book
WHERE Publication_year = 2012;

5.2 Please provide the average number of kids employees who currently working for the company have (i.e. End is NULL). Rename the header into AverageKids.

SELECT AVG(kids_number) AS AverageKids
FROM Employee
WHERE END is NULL;

5.3 Please provide the total amount of salaries of all employees currently working for the company (i.e. End is NULL). Rename the header into TotalSalaries.

SELECT SUM(Salary) AS TotalSalaries
FROM Employee
WHERE END is NULL;

5.4 Please provide the number of employees having at least one kid. Rename the header into WithKids.

SELECT COUNT(*) AS WithKids 
FROM Employee
WHERE Kids_number >= 1;

6.1 Please provide data about all books published by O’Reilly. Required attributes are Title and Isbn. 

SELECT Book.Title, Book.Isbn
FROM Book, Publisher
WHERE Book.Publisher_id = Publisher.id 
AND Publisher.name = "O'Reilly";

6.2 Please provide data about all books in which Andrew Duncan was involved in the drafting.

SELECT b.Title, b.Isbn
FROM Book AS b, Writing AS w, Author AS a
WHERE b.ID = w.Book_id AND a.ID = w.Author_id
AND a.First_Name = 'Andrew' AND a.Last_name = 'Duncan';

6.3 Please provide data about all employees not working in the Finance department (regardless if employees have left the company or not). Required attributes are last name, first name and department name.

SELECT emp.Last_name,
emp.First_name, dep.Name
FROM Employee AS emp, Department AS dep
WHERE emp.Department_id = dep.ID AND dep.Name <> 'Finance';

7.1 Please provide data about all books having been written by Andrew Duncan only, i.e. without any other co-authors.

SELECT *
FROM Author AS a, Writing AS w, Book AS b
WHERE b.ID = w.Book_id AND a.ID = w.Author_id
GROUP BY b.ID
HAVING COUNT(*) = 1 AND a.First_name = 'Andrew' 
AND a.Last_name = 'Duncan';

Order of FROM is order of dispay in table

7.2 Please provide data about all books (Title, Isbn) having been written by two or more people and whose title contains the word Head.

SELECT b.Title, b.Isbn
FROM Book AS b, Writing AS w
WHERE b.ID = w.Book_id AND b.Title LIKE '%Head%'
GROUP BY b.ID
HAVING COUNT(*) > 1;

7.3 Please provide data about all authors and the number of books in which each has been involved in the drafting. Required attributes are last name, first name and the number of books, which have to be renamed into LastName, FirstName and NbOfBooks.

SELECT a.First_name AS FirstName, a.Last_name AS LastName, COUNT(*) AS NbOfBooks
FROM Author AS a, Writing AS w, Book AS b
WHERE b.ID = w.Book_id AND w.Author_id = a.ID
GROUP BY a.ID

7.4 Please provide data about all publishers having published only one book. Required attributes are publisher’s name and book’s title.

SELECT p.Name, b.Title
FROM Publisher AS p, Book AS b
WHERE b.Publisher_id = p.id
GROUP BY p.id
HAVING COUNT(*) = 1;

7.5 Please provide data about departments whose total of salaries of employees working in it exceeds 61,000. Required attributes are the department name and the related total of salaries which have to be renamed into Department and TotalSalaries.

SELECT Department.Name AS Department, SUM(Employee.Salary) AS TotalSalaries
FROM Employee, Department 
WHERE Department.ID = Employee.Department_id
GROUP BY Department.ID
HAVING SUM(Employee.Salary) > 61000; 

8.1 Please provide data about all books having been published the same year or later than the book whose title is Head First Data Analysis. Required attributes are Title, Isbn and Publication_year.

SELECT Title, Isbn, Publication_year 
FROM Book
WHERE Publication_year >= 
(
SELECT Publication_year 
FROM Book
WHERE Title = 'Head First Data Analysis'
);

8.2 Please provide data about all employees having joined the company the same date or later than the employee called Oleg (first name) Grichkin (last name). The result must not include that employee. All attributes are required

SELECT *
FROM Employee
WHERE Start >= (
   SELECT Start FROM Employee WHERE Last_name = 'Grichkin' AND First_name ='Oleg'
) AND ID <> (
   SELECT ID FROM Employee WHERE Last_name = 'Grichkin' AND First_name ='Oleg'
)

8.3 Please provide data about all employees whose salary is higher or equal to the average salary of employees working in the same department (regardless if employees have left the company or not). Required attributes are last name, first name, salary and department name.

SELECT emp.Last_name, emp.First_name, emp.Salary, D.Name
FROM Employee AS emp, Department AS D
WHERE emp.Department_id = D.id AND emp.Salary >= 
(
SELECT AVG(e.Salary) 
FROM Employee AS e 
GROUP BY e.Department_id 
HAVING e.Department_id = emp.Department_id
)

8.4 Please provide data about all books having been written by two or more people and in those Christophe Wolfhugel was involved in the drafting.

SELECT b.title, b.Isbn
FROM Book as b, Author AS a, Writing as w1
WHERE b.ID = w1.Book_id AND a.ID = w1.author_id 
AND a.First_name = 'Christophe' AND a.Last_name = 'Wolfhugel'
AND
(
SELECT COUNT(*)
FROM Writing as w2
WHERE w2.Book_id = b.ID
GROUP BY b.id ) > 1;

9.1 Please provide data about all books in ascending order by publication year firstly and in alphabetical order by title secondly. Required attributes are Publication_year and Title

SELECT Publication_year, Title
FROM Book
ORDER BY Publication_year, Title ASC;

9.2 Please provide data about all books published in 2012. Only the three first records in alphabetical order by title must be displayed. Required attributes are Publication_year and Title.

SELECT Publication_year, Title
FROM Book
WHERE Publication_year = 2012 
ORDER BY Title ASC
LIMIT 3

9.3 Please provide data about the two employees having the lowest salary among all employees. Required attributes are First_name, Last_name and Salary and data must be displayed in ascending order by the salary value.

SELECT Last_name, First_name, Salary 
FROM Employee
ORDER BY Salary ASC
LIMIT 0,2;

10.1 Please provide data about all books having been published by Packt and in which Andrew Duncan was not involved in the drafting. Required attributes are Title and Isbn.

SELECT b.Title, b.Isbn
FROM Book AS b, Publisher as p
WHERE b.publisher_id = p.ID AND p.name = 'Packt'
AND b.ID NOT IN
(
SELECT w.Book_id FROM Writing AS w, Author AS a 
WHERE w.Author_id = a.ID AND First_name = 'Andrew' AND Last_name = 'Duncan'
);

10.2 Please provide data about all publishers having published more books than the publisher called CreateSpace. All attributes are required and data must be displayed in ascending order by publisher’s name.

SELECT p.*
FROM Book AS b, Publisher AS p
WHERE b.Publisher_id = p.ID
GROUP BY p.ID
HAVING COUNT(*) > 
(
SELECT COUNT(*)
FROM Publisher AS pub, Book as book
WHERE pub.ID = book.Publisher_id AND pub.name = 'CreateSpace'
)
ORDER BY p.name;

10.3 Please provide data about the number of books published for each year. Data must be displayed in descending order by the number of published books. Required attributes are Publication_year and the number of published books, which have to be renamed into Year and NbOfBooks.

SELECT Publication_year AS Year, Count(*) AS NbOfBooks
FROM Book
GROUP BY Publication_year
ORDER BY NbofBooks DESC;
