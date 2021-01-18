-- Creating tables for PH-EmployeeDB
-- creating departments table
CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);
-- creating employee table
CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);
-- creating salaries table
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);
-- creating titles table
CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);
-- creating dept manager table
CREATE TABLE dept_manager (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
-- creating department employees table
CREATE TABLE dept_employees (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);


-- Retrieve the emp_no, first_name, last_name from Employees Table
SELECT emp_no,
    first_name,
    last_name
FROM employees;
-- SELECT title, from_date, & to_date from the Titles table
SELECT title,
    from_date,
    to_date
FROM titles


-- Create a new table using the INTO clause and join both tables on primary key
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    t.title,
    t.from_date,
    t.to_date
-- INTO Retirement_Titles
FROM employees AS e
    INNER JOIN titles AS t
        ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no DESC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Confirm duplicates removed
-- SELECT * FROM unique_titles
-- ORDER BY emp_no ASC;

-- Count retirements by title and store into data table
SELECT COUNT (first_name),
title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT (first_name) DESC;

-- CREATE A MENTORSHIP-ELIGIBILITY TABLE with CURRENT EMPLOYEES BORN BETWEEN JAN 1 '65 & DEC 31 '65
SELECT DISTINCT ON (emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibility
FROM employees AS e
    INNER JOIN dept_employees AS de
        ON (e.emp_no = de.emp_no)
    INNER JOIN titles AS t
        ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no ASC;

-- Create 2 more insights on the Silver Tsunami population
-- Sum of salary among retirement list
SELECT ut.emp_no,
	ut.first_name,
	s.salary
INTO ut_salary
FROM unique_titles AS ut
	 LEFT JOIN salaries AS s
	 	ON (ut.emp_no = s.emp_no);
		
SELECT SUM (salary)
FROM ut_salary

-- Employees up for retirement by department number
SELECT COUNT(ut.emp_no), d.dept_name
FROM unique_titles AS ut
LEFT JOIN dept_employees AS de
ON ut.emp_no = de.emp_no
INNER JOIN departments AS d
ON de.dept_no = d.dept_no 
GROUP BY d.dept_name
ORDER BY d.dept_name;