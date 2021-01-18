# Pewlett-Hackard-Analysis
Author: Jerome Simmons

## Overview of the Analysis
Pewlett-Hackard has an aging workforce and expects many of its members to retire in the near future. The company has asked us to provide a count of the number of employees up for retirement by title. In order to prepare for the upcoming rise in retirements, Pewlett-Hackard wants to develop a Mentorship Program so employees born in 1965 can learn and benefit from those with more work experience (born between 1952 & 1955).

For this assignment, we produced five outputs.
1. Retirement_titles.csv file, which shows the count of upcoming retirees by title (contains duplicates)
2. Unique_titles.csv file, which removes duplicates contained in the retirement_titles.csv file
3. Retiring_titles.csv file, which takes the unique employees up for retirement and provides the total number grouped by title
4. mentorship_eligibility.csv file, which takes the unique employees born in 1965 who are eligible for the mentorship program
5. Employee_Database_Challenge.sql, which contains the SQL code used to build the relational databases and csv file outputs.

## Results
Based on the employee database analysis, we have identified
* Pewlett-Hackard has over 90k unique employees who will retire in the near future
* Over 29k and 28k are Senior Engineers & Senior staff, respectively
* Pewlett-Hackard must prepare for the impending 'silver tsunami' and train its next generation of leaders
* We have identified 1.4k current employees were born in 1965 and benefit from mentorship training in order to help offset the talent gap caused by the 'silver tsunami'.

## Summary
Pewlett-Hackard can expect to lose approximately 90k employees in the next few years as its aging workforce opts for retirement. The company has a very small pipeline young talent: approximately 1.4k current employees were born in 1965. Thus, the company will need to hire approximately 89k employees in the coming years. There is a plethora of qualified, retirement-ready employees who can mentor the next generation of Pewlett Hackard employees. In fact, the company would do well to hire more young employees who would benefit from the mentorship of the retirement-ready employees.

In looking for employees born before 1965, we only
-- Look for even younger employees born on or before 1965
SELECT DISTINCT ON (emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
-- INTO mentorship_eligibility
FROM employees AS e
    INNER JOIN dept_employees AS de
        ON (e.emp_no = de.emp_no)
    INNER JOIN titles AS t
        ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no ASC;

rovide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."
How many roles will need to be filled as the "silver tsunami" begins to make an impact?
Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
