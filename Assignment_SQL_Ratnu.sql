USE hr;


-- Display all the imformation in the tables emp and dept.
SELECT * 
FROM employees;
SELECT * 
FROM departments;


-- Display only the hire date and employee name for each employee. 
SELECT 
	first_name, hire_date 
FROM 
	employees;


-- Diplay the ename concatenated with the job ID, separated by a comma and space, and name the column employee and title. 
SELECT 
	CONCAT(first_name, " ", last_name, " , " , job_id) AS "Employee and Title"
FROM 
	employees;


-- Display the hire date, name and department number for all clerks. 
SELECT 
	hire_date, first_name, last_name, department_id 
FROM
	employees
WHERE 
	job_id RLIKE "CLERK";


-- create a query to display all the data from the EMP table. separated each column by a comma. 
-- name the column THE OUTPUT. 
SELECT 
	CONCAT_WS(",", employee_id, first_name, last_name, email, phone_number, hire_date, job_id, commission_pct, manager_id, department_id)
    AS "THE OUTPUT" 
FROM 
	employees;


--  display the names and salary with salary greater than 2000. 
SELECT
	first_name, salary
FROM
	employees
WHERE
	salary > 2000;


-- display the name and dates header Name and Start Date. 
SELECT
	first_name AS "Name", hire_date AS "Start date" 
FROM
	employees;


-- name and hire date and order they were hired. 
SELECT 
	first_name, hire_date 
FROM 
	employees 
ORDER BY
	hire_date ASC;
    

-- display name and salary in reverse salary order.
SELECT
	first_name, salary
FROM 
	employees 
ORDER BY
	salary DESC;


-- display ename and deptno who all earned commission and salary reverse order. 
SELECT
	first_name, department_id, salary, commission_pct 
FROM
	employees
WHERE
	commission_pct > 0 
ORDER BY
	salary DESC;
    

-- display last name and job title who do not have manager.
SELECT
	last_name, job_title 
FROM 
	employees AS a 
    JOIN jobs AS j  
    ON a.job_id = j.job_id
WHERE
	a.manager_id IS NULL;
    
  
-- display lastname, job , salary whose job is sales representive or stock clerk and 
-- whose salary is not equal to 2500,3500,5000. 
SELECT
	last_name, job_title, salary 
FROM
	employees AS e 
    JOIN jobs AS j 
    ON e.job_id = j.job_id
WHERE
	j.job_title IN ("Stock Clerk", "sales representative")
	AND e.salary NOT IN (2500,3500,5000);
    

-- Display max, min, avg, salary and commission earned
SELECT 
	MAX(salary), MIN(salary), AVG(salary), MAX(commission_pct), MIN(commission_pct), AVG(commission_pct)
FROM
	employees;
    

-- display dept no and and number of emp in each dept. 
SELECT 
	department_id, COUNT(employee_id) AS "Count of Emp"
FROM
	employees
GROUP BY
	department_id;
    

-- Display the department number and total salary of employees in each department
SELECT 
	department_id, SUM(salary) AS "Total salary"
FROM
	employees
GROUP BY
	department_id;
    

-- Display the employee's name who doesn't earn a commission. 
-- Order the result set without using the column name 
SELECT 
	first_name 
FROM
	employees
WHERE
	commission_pct IS NULL;
    

-- Display the employees name, department id and commission. If an Employee doesn't earn the commission, 
-- then display as 'No commission'. Name the columns appropriately
SELECT 
	first_name, department_id, 
    IF(commission_pct IS NULL, "No Commission", commission_pct) AS "Appropriately" 
FROM 
	employees;
    

-- Display the employee's name, salary and commission multiplied by 2. 
-- If an Employee doesn't earn the commission, then display as 'No commission. Name the columns appropriately
SELECT
	first_name, salary, 
    IF(commission_pct IS NULL, "No Commission", (commission_pct*2)) AS "Appropriately" 
FROM
	employees;


-- Display the employee's name, 
-- department id who have the first name same as another employee in the same department
SELECT
	first_name, department_id, COUNT(first_name) 
FROM
	employees
GROUP BY
	first_name, department_id
	HAVING COUNT(first_name) > 1;
    

-- Display the sum of salaries of the employees working under each Manager. 
SELECT
	SUM(salary), manager_id
FROM
	employees
GROUP BY 
	manager_id;
    

-- Select the Managers name, the count of employees working under and the department ID of the manager. 
SELECT 
	m.first_name AS "manager_name", count(e.employee_id) AS "total", m.department_id
FROM
	employees AS e 
	JOIN employees AS m 
	ON e.manager_id = m.employee_id
GROUP BY 
	e.manager_id;
    

-- Select the employee name, department id, and the salary. 
-- Group the result with the manager name and the employee last name should have second letter 'a! 
SELECT 
	first_name, last_name, department_id, salary 
FROM 
	employees
	JOIN jobs
    ON employees.job_id = jobs.job_id
WHERE 
	job_title RLIKE "manager"
	AND last_name LIKE"_a%";
    

-- Display the average of sum of the salaries and group the result with the department id.
-- Order the result with the department id.
SELECT
	department_id, AVG(salary)
FROM 
	employees
GROUP BY 
	department_id
ORDER BY 
	department_id ASC;
    

-- Select the maximum salary of each department along with the department id 
SELECT 
	department_id, MAX(salary) 
FROM
	employees
GROUP BY
	department_id;
    

-- Display the commission, if not null display 10% of salary, if null display a default value 1
SELECT
	salary, IF(commission_pct IS NOT NULL, salary/10, 1) AS "commission"
FROM
	employees;


-- Write a query that displays the employee's last names only from the string's 2-5th position 
-- with the first letter capitalized and all other letters lowercase, Give each column an appropriate label. 
SELECT
	last_name, 
CONCAT(UPPER(SUBSTRING(last_name,2,1)), LOWER(SUBSTRING(last_name, 3,3)))
FROM
	employees;
    

-- Write a query that displays the employee's first name and last name along with a " in between for 
-- e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined. 
SELECT
	CONCAT(first_name, "-", last_name,"-",MONTHNAME(hire_date)) AS name_month
FROM
	employees;


-- Write a query to display the employee's last name and if half of the salary is greater than ten thousand then
-- increase the salary by 10% else by 11.5% along with the bonus amount of 1500 each. Provide each column an appropriate label. 
SELECT
	last_name, salary,
	IF((salary / 2) > 10000, 1500 + salary + salary*10/100, 1500 + salary + salary*11.5/100 ) AS "Bonus_salary"
FROM
	employees;


-- Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, department id, salary 
-- and the manager name all in Upper case, if the Manager name consists of 'z' replace it with '$!   
SELECT
	e.employee_id, 
	CONCAT(SUBSTRING(e.employee_id, 1,2),"00",substring(e.employee_id, 3),"E") AS emp,
	e.department_id, e.salary,
	UPPER(REPLACE(m.first_name, "z", "$")) AS manager_name
FROM
	employees AS e
	JOIN employees AS m
	ON e.manager_id = m.employee_id;
    

-- Write a query that displays the employee's last names with the first letter capitalized and all other letters
-- lowercase, and the length of the names, for all employees whose name starts with J, A, or M. 
-- Give each column an appropriate label. Sort the results by the employees' last names  
SELECT 
	LENGTH(CONCAT(first_name, last_name)) AS len, last_name
FROM
	employees
WHERE
	last_name LIKE "j%" OR 
    last_name LIKE"a%" OR
	last_name LIKE "m%"
ORDER BY
	last_name;
    

-- Create a query to display the last name and salary for all employees. 
-- Format the salary to be 15 characters long, left-padded with $. Label the column SALARY
SELECT last_name, 
	LPAD(salary,15, "$") 
FROM
	employees;
    
    
-- Display the employee's name if it is a palindrome
SELECT 
	first_name
FROM
	employees
WHERE 
	REVERSE(first_name) = first_name;


-- Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end.
-- Name the column as e-mail address. All characters should be in lower case. Display this along with their First Name. 
SELECT
	first_name,
    CONCAT(SUBSTRING(LOWER(first_name),1,1),LOWER(last_name),"@systechusa.com") AS "e-mail address" 
FROM
	employees;


-- Display the names and job titles of all employees with the same job as Trenna
SELECT
	first_name, job_title
FROM
	employees AS e
	JOIN jobs AS j
	ON e.job_id = j.job_id
WHERE 
	job_title = (
	SELECT job_title 
	FROM jobs 
	JOIN employees 
	ON employees.job_id=jobs.job_id 
	WHERE first_name = "Trenna");
    

-- Display the names and department name of all employees working in the same city as Trenna.
SELECT
	e.first_name, d.department_name, l.city
FROM 
	employees AS e
	JOIN departments AS d
	ON e.department_id = d.department_id 
	JOIN locations AS l
	ON l.location_id = d.location_id
WHERE
	l.city = (
	SELECT l.city 
	FROM locations AS l
	JOIN departments AS d
	ON l.location_id = d.location_id
	JOIN employees AS e
	ON e.department_id = d.department_id
	WHERE e.first_name = "Trenna" );
    

-- Display the name of the employee whose salary is the lowest.
SELECT
	first_name, salary 
FROM
	employees
WHERE
	salary = (SELECT MIN(salary) FROM employees);
    

-- Display the names of all employees except the lowest paid.
SELECT 
	first_name, salary 
FROM
	employees
WHERE
	salary != (SELECT MIN(salary) FROM employees);
    

-- Write a query to display the last name, department number, department name for all employees. 
SELECT 
	e.last_name, d.department_id, d.department_name
FROM 
	employees AS e
	JOIN departments AS d
	ON e.department_id = d.department_id;


-- Write a query to display the employee last name,department name,location id and city of all employees who earn commission. 
SELECT 
	e.last_name, d.department_name, d.location_id, l.city, e.commission_pct
FROM
	employees AS e
	JOIN departments AS d
	ON e.department_id = d.department_id
	JOIN locations AS l
	ON l.location_id = d.location_id
WHERE
	e.commission_pct IS NOT NULL;


-- Display the employee last name and department name of all employees who have an 'a' in their last name 
SELECT
	last_name, department_name 
FROM
	employees AS e
	JOIN departments AS d
	ON e.department_id = d.department_id
WHERE 
	last_name LIKE "%a%";


-- Display the employee last name and employee number along with their manager's last name and manager number
SELECT 
	e.last_name AS emp_lname, e.employee_id, m.last_name AS mng_lname, m.employee_id AS mng_id
FROM
	employees AS e
	JOIN employees AS m
	ON  e.manager_id = m.employee_id;
    

-- Display the employee last name and employee number along with their manager's last name and 
-- manager number (including the employees who have no manager). 
SELECT
	e.last_name AS emp_lname, e.employee_id, m.last_name AS mng_lname, m.employee_id AS mng_id
FROM
	employees AS e
	LEFT JOIN employees AS m
	ON e.manager_id = m.employee_id;
    

-- Create a query that displays employees last name,department number,and 
-- all the employees who work in the same department as a given employee. 
SELECT 
	department_id, last_name FROM employees
ORDER BY
	department_id;


-- Create a query that displays the name,job,department name,salary,grade for all employees.
--  Derive grade based on salary(>=50000=A, >=30000=B,<30000=C) 
SELECT
	e.first_name, j.job_title, d.department_name, e.salary, 
CASE 
	WHEN e.salary >= 20000 THEN "A"
    WHEN e.salary >= 10000 THEN "B"
    ELSE "C" 
END AS grade 
FROM 
	employees AS e
	JOIN jobs AS j 
	ON e.job_id = j.job_id
	JOIN departments AS d
	ON d.department_id = e.department_id;
    

-- Display the names and hire date for all employees who were hired before theirmanagers along withe their
--  manager names and hire date. Label the columns as Employee name, emp_hire_date,manager name,man_hire_date
SELECT 
	e.first_name, e.hire_date AS "emp_hire_date", 
	m.first_name AS manager_name, m.hire_date AS "man_hire_date"
FROM
	employees AS e
	JOIN employees AS m
	ON e.manager_id = m.employee_id
WHERE
	DATEDIFF(e.hire_date, m.hire_date) < 0;
    

-- Write a query to display the last name and hire date of any employee in the same department as SALES. 
SELECT 
	e.last_name, e.hire_date, d.department_name
FROM 
	employees AS e
	JOIN departments AS d
	ON e.department_id = d.department_id
WHERE
	d.department_name = "sales";
    

-- Create a query to display the employee numbers and last names of all employees who earn more than the 
-- average salary. Sort the results in ascending order of salary. 
SELECT 
	employee_id, last_name, salary
FROM 
	employees
WHERE
	salary > (SELECT avg(salary) FROM employees)
ORDER BY 
	salary;
    

-- Write a query that displays the employee numbers and last names of all employees 
-- who work in a department with any employee whose last name contains a' u  
SELECT 
	employee_id, last_name, department_id
FROM
	employees
WHERE
	department_id IN (
	SELECT department_id 
	FROM employees
	WHERE last_name LIKE "%u%");
    

--  Modify the above query to display the employee numbers, last names, and salaries of all employees 
-- who earn more than the average salary and who work in a department with any employee with a 'u'in their name. 
SELECT 
	employee_id, last_name, department_id
FROM	
	employees
WHERE
	department_id IN (
	SELECT department_id 
	FROM employees
	WHERE last_name LIKE "%u%")
AND 
	salary > (
	SELECT avg(salary)
	FROM employees);


-- Display the department number, last name, and job ID for every employee in the OPERATIONS department. 
SELECT 
	e.department_id, e.last_name, e.job_id, d.department_name
FROM 
	employees AS e
	JOIN departments AS d
WHERE
	d.department_name = "Oparations";
    

-- Display the names of all employees whose job title is the same as anyone in the sales dept.
SELECT
	e.first_name, j.job_title, d.department_name
FROM
	employees AS e
	JOIN jobs AS j
	ON e.job_id = j.job_id
	JOIN departments AS d
	ON e.department_id = d.department_id
WHERE
	d.department_name = "sales";


-- Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries. 
SELECT
	last_name, salary
FROM 
	employees
ORDER BY
	salary DESC
LIMIT 3;


-- Display the names of all employees with their salary and commission earned. Employees with a null commission
--  should have O in the commission column
SELECT 
	salary,
    IF(commission_pct IS NULL , 0 , commission_pct)  AS cummission_Pct
FROM 
	employees;


-- Display the Managers (name) with top three salaries along with their salaries and department information.
SELECT 
	DISTINCT m.first_name AS manager_name,
    m.salary, m.department_id, d.department_name
FROM 
	employees AS e
	JOIN employees AS M
	ON e.manager_id = m.employee_id
	JOIN departments AS d
	ON d.department_id = m.department_id
ORDER BY
	salary DESC
LIMIT 3;


USE adventureworks;

-- Write a query to display employee numbers and employee name (first name, last name) of all the sales
-- employees who received an amount of 2000 in bonus. 
SELECT
	employeeID,
    CONCAT(firstname, " ", lastname) AS Fullname,
    s.bonus
FROM 
	employee AS e
	JOIN contact AS c
	ON e.contactid = c.contactid
	JOIN salesperson AS s
	ON c.modifieddate = s.ModifiedDate
WHERE
	s.bonus = 2000;



-- Write a query that displays all the products along with the Sales OrderID even if an order has never been placed for that product.  
SELECT
	product.productid, name, salesorderid
FROM 
	product
	LEFT JOIN salesorderdetail
	ON product.productID = salesorderdetail.productId;
    

-- Find the subcategories that have at least two different prices less than $15. 
SELECT
	p.name, s.UnitPrice
FROM
	productsubcategory AS p
	JOIN product as pp
	ON p.ProductSubcategoryID = pp.ProductSubcategoryID
	JOIN salesorderdetail as s
	ON pp.productid = s.productid
WHERE
	s.UnitPrice < 15;


-- Write a query to display employees and their manager details. Fetch employee id, employee first name, and manager id, manager name
SELECT 
	e.employeeid, c.FirstName, 
    m.employeeid AS managerid, cc.FirstName AS managername
FROM
	employee AS e
	JOIN employee AS m 
	ON e.managerid = m.employeeid
	JOIN contact AS c
	ON c.contactid = e.contactid
	JOIN contact AS cc
	ON cc.contactid = m.contactid;
    

-- Display the employee id and employee name of employees who do not have manager. 
SELECT 
	e.employeeid , c.firstname 
FROM 
	employee AS e
	JOIN contact AS c
	ON e.contactid = c.contactid
WHERE
	e.managerid IS NULL;
    

-- Display the names of all products of a particular subcategory 15 and the names of their vendors
SELECT 
	p.name AS "Product_Name", p.ProductSubcategoryID, 
    v.name AS "Vendor_Name"
FROM
	vendor AS v
	JOIN productvendor AS pv
	ON v.vendorid = pv.vendorid
	JOIN product AS p
	ON p.productid = pv.productid
	JOIN productsubcategory AS c
	ON c.ProductSubcategoryID = p.ProductSubcategoryID
WHERE
	p.ProductSubcategoryID = 15;


-- Find the products that have more than one vendor
SELECT 
	p.name, COUNT(v.vendorid) AS "Vendor_count"
FROM 
	vendor AS v
	JOIN productvendor AS pv
	ON v.vendorid = pv.vendorid
	JOIN product AS p
	ON p.productid = pv.productid
	JOIN productsubcategory AS c
	ON c.ProductSubcategoryID = p.ProductSubcategoryID
GROUP BY
	p.name
HAVING
	Vendor_count > 1;


-- Display product number, description and sales of each product in the year 2001. 
SELECT 
	p.name, p.ProductNumber, d.description, YEAR(o.modifieddate) 
FROM 
	salesorderdetail AS o
	JOIN product AS p 
	ON o.ProductID = p.ProductID
	JOIN productmodelproductdescriptionculture AS pd
	ON p.ProductModelID = pd.ProductModelID
	JOIN productdescription AS d
	ON d.ProductDescriptionID = pd.ProductDescriptionID
WHERE
	YEAR(o.modifieddate) = 2001;



USE dates;

-- Find the date difference between the hire date and resignation_date for all the employees.
-- Display in no. of days, months and year(1 year 3 months 5 days).
SELECT 
	CONCAT(FLOOR(DATEDIFF(resignation_date, hire_date)/365)," Year ",
		   FLOOR(DATEDIFF(resignation_date, hire_date)%365/30), " Month ",
           FLOOR(DATEDIFF(resignation_date, hire_date)%365%30), " Day") AS "Date"
FROM 
	empdates; -- IN THIS METHOD WE HAVE SMALL BUG IN DAYS
    
 
-- Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd,yyyy(Aug 12th, 2004).
-- Display the null as (DEC, 01th 1900)
SELECT 
	DATE_FORMAT(hire_date, "%d / %m / %Y") AS hire_date,
    IF(resignation_date IS NULL, "DEC, 01th 1900", DATE_FORMAT(resignation_date, "%b  %D,  %Y ")) AS "Resignation_Date"    
FROM 
	empdates;
    
    
-- Calcuate experience of the employee till date in Years and months(example 1 year and 3 months)
SELECT 
	CONCAT(FLOOR(DATEDIFF(IF(resignation_date IS NULL, CURDATE(), resignation_date), hire_date)/365)," Year ",
		   FLOOR(DATEDIFF(IF(resignation_date IS NULL, CURDATE(), resignation_date), hire_date)%365/30), " Month ",
           FLOOR(DATEDIFF(IF(resignation_date IS NULL, CURDATE(), resignation_date), hire_date)%365%30), " Day") AS experience
FROM 
	empdates;