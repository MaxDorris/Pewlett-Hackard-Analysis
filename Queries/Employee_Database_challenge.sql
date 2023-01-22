
/* [[ DELIVERABLE 1 ]] */

-- Create retirement_titles
SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

SELECT * FROM retirement_titles LIMIT 10;

-------------------------------------------------------------

-- Use Dictinct with Orderby to remove duplicate rows
-- (retiremnt_titles has lists all positions an employee has held in this company)
SELECT DISTINCT ON (emp_no)
	emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles LIMIT 10;

-------------------------------------------------------------

-- retrieve potential retirement titles (simplifying unique_titles)
SELECT
	COUNT(title),
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY 1 DESC;

DROP TABLE retiring_titles;
SELECT * FROM retiring_titles;

-------------------------------------------------------------

/* [[ DELIVERABLE 2 ]] */

-- Create list of mentorship-eligible employees
SELECT DISTINCT ON (emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
LEFT JOIN dept_emp AS de
ON e.emp_no = de.emp_no
LEFT JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

SELECT * FROM mentorship_eligibility LIMIT 10;
-------------------------------------------------------------

/* [[ DELIVERABLE 3 ]] */

-- Create count of mentorship-ready employees for each type of position held
SELECT
	COUNT(title) as Count,
	title as Position
INTO mentor_count
FROM mentorship_eligibility
GROUP BY title
ORDER BY 1 DESC;


SELECT * FROM mentor_count;

-------------------------------------------------------------

-- combine eligibility data AND positon-opening data to see mentor-to-rookie ratio
SELECT
		COALESCE(mc.count,0) AS mentors,
		rt.count AS open_positions,
		rt.title AS position,
	CASE
		WHEN mc.count = 0
		THEN 0
		ELSE rt.count / mc.count
	END AS ratio
	-- INTO mentor_retired
	FROM retiring_titles AS rt
	LEFT JOIN mentor_count AS mc
	ON rt.title = mc.position
	ORDER BY 1 DESC;