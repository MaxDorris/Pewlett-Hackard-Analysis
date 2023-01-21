# *Pewlett-Hackard-Analysis*
## Overview
### Purpose and Background
Structured Query Language, or SQL, is a tool used to access and manipulate databases. In this Vanderbilt Data Analytics Bootcamp project, I used SQL and a provided dataset to aid retirement strategy planning and find eligible employees for an internal mentorship program for a large company.

### Method and Results
I first created tables and filled them with the necessary .csv files within my PostgreSQL database. These dataframes included unique employee numbers, salaries, position titles, dates of employment, names, birthdates, departments, and manager details. However, the initial spreadsheets needed to be combined to create tables with relevant information.

#### Deliverable 1: Number of Retiring Employees by Title

The first step in creating this table was to find all current employees within a specific age range. While I do not know what year this data is actually from, the desired birth-dates were between January 1st, 1952 and December 31st, 1955. The marker for current-employees was a *to_date* of 'January 1st, 9999'. I combined the name and employee number data from the **employees.csv** dataset with the position title and position-related start and finish dates frm the **titles.csv** dataset. Since many employees had mutliple tenures in their history, I then filterd all repeating employee numbers by ordering by employee number AND end_date (descending). Then, using **DISTINCT ON (emp_no)**, I selected the first listed row (moost recent end-date) for each grouping of employee positions. Then I filtered the selected values by only allowing finish dates = 01-01-9999 into the new table. This table was saved as **unique_titles.csv** and is shown below:

<p align="center">
  <img width=auto height="150" src=Resources/Images/retire_positions.png>
  </p>
  
- This table simplifies the connection between current employees and their position significantly.
- This still returns a very long list.
  
The final step for fulfilling this deliverable was to create a new table that displayed the number of employees in the retirement age-range for each listed position in the company. I used **COUNT(title)** to get a numerical representaion of each person sharing each unique company title, and I selected title to get the character value of each position. I then grouped the table by the positions' character values to created the following table, saved as **retiring_titles.csv**):

<p align="center">
  <img width=auto height="500" src=Resources/Images/position_counts.png>
  </p>
  
- It is evident that a large amount of Senior Engineer and Senior Staff will be lost soon, 
- Very few management positions will be left empty.

#### Deliverable 2: Eligible Employees for the Mentorship Program

For this task, I combined the employee number, name, and birth-date data from the **employees.csv** dataset, the position-related start and finish dates from the **dept_emp.csv** dataset, and the position titles from the **titles.csv** dataset. I then filtered out all non-employed persons outside of another desired age-range of January 1st, 1965 to Decemeber 31st, 1965 using the **WHERE-AND** operation. I then ordered by employee number to get the following table, saved as **mentorship_eligibility.csv**:

<p align="center">
  <img width=auto height="350" src=Resources/Images/eligile_emp.png>
  </p>
  
- This draws clear connections between age, and tenure.
- The table is still quite long, despite filtering out non-current employees.
- All columns are helpful in deciding eligilibity.
- The date format is organized better, but is still a little awkward to interpret.

### Conclusions

- One improvement on this table could be manipulating the columns of *birth_date* and *from_date / to_date* to instead show *age* and *years in the company*. This would certainly help me narrow down the prospects by removing the need to do mental date math.....
