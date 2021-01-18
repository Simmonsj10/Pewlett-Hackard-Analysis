# Pewlett-Hackard-Analysis
Author: Jerome Simmons

## Overview of the Analysis
Pewlett-Hackard has an aging workforce and expects many of its members to retire in the near future. The company has asked us to provide a count of the number of employees up for retirement by title. In order to prepare for the upcoming rise in retirements, Pewlett-Hackard wants to develop a Mentorship Program so employees born in 1965 can learn and benefit from those with more work experience (born between 1952 & 1955).

For this assignment, we produced five outputs.
1. Retirement_titles.csv file (in data folder), which shows the count of upcoming retirees by title (contains duplicates)
2. Unique_titles.csv file (in data folder), which removes duplicates contained in the retirement_titles.csv file
3. Retiring_titles.csv file (in data folder), which takes the unique employees up for retirement and provides the total number grouped by title
4. mentorship_eligibility.csv file (in data folder), which takes the unique employees born in 1965 who are eligible for the mentorship program
5. Employee_Database_Challenge.sql (in queries folder), which contains the SQL code used to build the relational databases and csv file outputs.

## Results
Based on the employee database analysis, we have identified
* Pewlett-Hackard has over 90k unique employees who will retire in the near future
* Over 29k and 28k are Senior Engineers & Senior staff, respectively
* Pewlett-Hackard must prepare for the impending 'silver tsunami' and train its next generation of leaders
* We have identified 1.4k current employees were born in 1965 and benefit from mentorship training in order to help offset the talent gap caused by the 'silver tsunami'.

## Summary
Pewlett-Hackard can expect to lose approximately 90k employees in the next few years as its aging workforce opts for retirement. The company has a very small pipeline young talent: approximately 1.4k current employees were born in 1965. Thus, the company will need to hire approximately 89k employees in the coming years. There is a plethora of qualified, retirement-ready employees who can mentor the next generation of Pewlett Hackard employees. In fact, the company would do well to hire more young employees who would benefit from the mentorship of the retirement-ready employees.

In addition to the primary deliverables, we have completed additional analysis on the upcoming retirees and their total salary as well as their department. Please refer to the code below.
The total salaries among the 90k employees ready for retirement at over $4.7 bln, which means Pewlett-Hackard should expect substantial labor savings in the coming years.

```
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
```

The development department (25.6k), production department (22.2k), and sales department (15.7k) will have the largest number of retirements.
```
-- Employees up for retirement by department number
SELECT COUNT(ut.emp_no), d.dept_name
FROM unique_titles AS ut
LEFT JOIN dept_employees AS de
ON ut.emp_no = de.emp_no
INNER JOIN departments AS d
ON de.dept_no = d.dept_no 
GROUP BY d.dept_name
ORDER BY d.dept_name;
```
