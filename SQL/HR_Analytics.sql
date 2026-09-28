-- 01_Data_Validation -----------

create database hr_analytics;
use hr_analytics;

create table employees (
	employee_id varchar(10) primary key,
    employee_name varchar(50),
    gender varchar(10),
    age int,
    department varchar(50),
    job_role varchar(50),
    city varchar(50),
    joining_date date,
    annual_salary decimal(10,2)
);

create table attendance (
	attendance_id varchar(10) primary key,
    employee_id varchar(10),
    month date,
    working_days int,
    present_days int,
    leave_days int,
    overtime_hours decimal(5,2)
);

create table performance (
	employee_id varchar(10),
    review_years int,
    performance_score decimal(3,1),
    training_hours int,
    promotion varchar(10)
);

create table status (
	employee_id varchar(10) primary key,
    status varchar(20),
    exit_date date,
    exit_reason varchar(50)
);

describe employees;

describe attendance;

describe performance;

describe status;

-- VALIDATION ----------

-- ROW COUNT OF EMPLOYEES TABLE

select count(*) as total_employees
from employees;

-- ATTENDANCE RECORDS

select count(*) as total_attendance_records
from attendance;

-- PERFORMANCE RECORDS

select count(*) as total_performance_records
from performance;

-- STATUS RECORDS

select count(*) as total_status_records
from status;

-- EMPLOYEES DUPLICATE CHECK

select employee_id, count(*) as record_count
from employees
group by employee_id
having record_count > 1;

-- ATTENDANCE DUPLICATE CHECK 

select employee_id, month, count(*) as record_count
from attendance
group by employee_id, month 
having record_count > 1;

-- PERFORMANCE DUPLICATE CHECK 

select employee_id, count(*) as record_count
from performance
group by employee_id
having record_count > 1;

-- STATUS DUPLICATE CHECK 

select employee_id, count(*) as record_count
from status
group by employee_id
having record_count > 1;

-- EMPLOYEES NULL CHECK 

select 
	sum(employee_id is null) as employee_id_null,
    sum(employee_name is null) as employee_name_null,
    sum(gender is null) as gender_null,
    sum(age is null) as age_null,
    sum(department is null) as department_null,
    sum(job_role is null) as job_role_null,
    sum(city is null) as city_null,
    sum(joining_date is null) as joining_date_null,
    sum(annual_salary is null) as annual_salary_null
from employees;

-- ATTENDANCE NULL CHECK

select 
	sum(attendance_id is null) as attendance_id_null,
    sum(employee_id is null) as employee_id_null,
    sum(month is null) as month_null,
    sum(working_days is null) as working_days_null,
    sum(present_days is null) as present_days_null,
    sum(leave_days is null) as leave_days_null,
    sum(overtime_hours is null) as overtime_hours_null
from attendance;

-- PERFORMANCE NULL CHECK 

select
	sum(employee_id is null) as employee_id_null,
    sum(review_years is null) as review_years_null,
    sum(performance_score is null) as performance_score_null,
    sum(training_hours is null) as training_hours_null,
    sum(promotion is null) as promotion_null
from performance;

-- STATUS NULL CHECK

select 
	sum(employee_id is null) as employee_id_null,
    sum(status is null) as status_null,
    sum(exit_date is null) as exit_date_null,
    sum(exit_reason is null) as exit_reason_null
from status;

-- VALUE VALIDATION

select 
	min(age) as min_age,
    max(age) as max_age,
    min(annual_salary) as min_salary,
    max(annual_salary) as max_salary
from employees;

-- AGE VALIDATION

select count(*) as invalid_age_records
from employees
where age < 18 or age > 60;

-- 60+ EMPLOYEE IDENTITY

select
	employee_id,
    employee_name,
    age,
    department,
    job_role
from employees
where age > 60;

-- SALARY VALIDATION

select count(*) as invalid_salary_records
from employees
where annual_salary <= 0;

-- ATTENDANCE NUMERICAL VALIDATION

select count(*) as invalid_attendance_records
from attendance
where working_days <= 0
	or present_days < 0
    or leave_days < 0
    or overtime_hours < 0;
    
-- PRESENT DAYS + LEAVE DAYS VS WORKING DAYS

select count(*) as invalid_records
from attendance
where present_days + leave_days > working_days;

-- INVALID ATTENDANCE RECORD IDENTIFICATION

select
	attendance_id,
    employee_id,
    month,
    working_days,
    present_days,
    leave_days,
    overtime_hours
from attendance
where present_days + leave_days > working_days;

-- LEAVE DAYS > WORKING DAYS

select count(*) as invalid_leave_records
from attendance
where leave_days > working_days;

-- PRESENT DAYS > WORKING DAYS

select count(*) as invalid_present_records
from attendance
where present_days > working_days;

-- PERFORMANCE VALIDATION

select 
	min(performance_score) as min_score,
    max(performance_score) as max_score
from performance;

-- INVALID PERFORMANCE SCORE

select count(*) as invalid_score_records
from performance
where performance_score < 1
	or performance_score > 5;
    
-- TRAINING HOURS AND REVIEW YEARS VALIDATION

select count(*) as invalid_records
from performance
where review_years < 0
	or training_hours < 0;
    
-- PROMOTION VALUES CHECK 

select promotion, count(*) as employee_count
from performance
group by promotion
order by employee_count desc;

-- STATUS VALUE VALIDATION

select status, count(*) as employee_count
from status
group by status
order by employee_count desc;

-- INVALID STATUS DATES

select count(*) as invalid_status_dates
from status
where (status = 'Exited' and exit_date is null)
	or (status = 'Active' and exit_date is not null);
    
-- RELATIONSHIP VALIDATION

select count(*) as orphan_attendance_records
from attendance a
left join employees e 
	on a.employee_id = e.employee_id
where e.employee_id is null;

select count(*) as orphan_performance_records
from performance p 
left join employees e 
	on p.employee_id = e.employee_id
where e.employee_id is null;

select count(*) as orphan_status_records
from status s 
left join employees e 
	on s.employee_id = e.employee_id
where e.employee_id is null;

-- ATTENDANCE DUPLICATE CHECK 

select employee_id,
	month,
    count(*) as record_count
from attendance 
group by employee_id, month
having record_count > 1;

-- EMPLOYEES WITH MORE THAN 1 RECORD

select employee_id, count(*) as record_count
from performance
group by employee_id
having record_count <> 1;

-- 02_Data_Cleaning ----------------

-- EMPLOYEE CATEGORICAL VALUES 

select distinct
	concat('[', department, ']') as department,
    concat('[', job_role, ']') as job_role,
    concat('[', city, ']') as city,
    concat('[', gender, ']') as gender
from employees
group by department, job_role, city, gender;

-- HIDDEN SPACES CHECK 

select count(*) as whitespace_issues
from employees
where department <> trim(department)
	or job_role <> trim(job_role)
    or city <> trim(city)
    or gender <> trim(gender);

-- ATTENDANCE CATEGORICAL VALUES

select count(*) as whitespace_issues
from attendance
where employee_id <> trim(employee_id);

-- PERFORMANCE CATEGORICAL VALUES

select count(*) as whitespace_issues
from performance
where employee_id <> trim(employee_id);

-- STATUS CATEGORICAL VALUES

select count(*) as whitespace_issues
from status
where employee_id <> trim(employee_id)
	or status <> trim(status)
    or exit_reason <> trim(exit_reason);
    
-- STATUS VALUE CONSISTENCY

select 
	status,
    count(*) as employee_count
from status
group by status
order by status;

-- PERFORMANCE PROMOTION STANDARDIZATION

select 
	promotion,
    count(*) as employee_count
from performance
group by promotion
order by promotion;

-- EMPLOYEE CATEGORICAL VALUES FINAL COUNT

select 'Department' as field_name, department as field_value, count(*) as record_count
from employees
group by department

union all

select 'Job Role', job_role, count(*)
from employees
group by job_role

union all

select 'City', city, count(*)
from employees
group by city

union all

select 'Gender', gender, count(*)
from employees
group by gender

order by field_name, field_value;

-- IDENTIFY UNKOWN EMPLOYEE

select * from employees
where  city = 'Unknown';

-- BLANK/NULL CITY

select 
	sum(city is null) as null_city,
    sum(trim(city) = '') as blank_city,
    sum(city = 'Unknown') as unknown_city
from employees;

-- TENURE CALCULATION

select 
	employee_id,
    employee_name,
    joining_date,
    timestampdiff(year, joining_date, curdate()) as tenure_years
from employees
order by tenure_years desc;

-- AGE GROUP

select 
	employee_id,
    age,
    case
		when age < 25 then 'Under 25'
        when age between 25 and 34 then '25 - 34'
        when age between 35 and 44 then '35 - 44'
        when age between 45 and 54 then '45 - 54'
        else '55+'
	end as age_group
from employees;

-- SALARY BAND

select 
	employee_id,
    annual_salary,
    case
		when annual_salary < 40000 then 'Low'
        when annual_salary < 60000 then 'Lower-Mid'
        when annual_salary < 80000 then 'Mid'
        when annual_salary < 100000 then 'Upper-Mid'
        else 'High'
	end as salary_band
from employees;

-- ATTENDANCE RATE

select 
	attendance_id,
    employee_id,
    month,
    working_days,
    present_days,
    leave_days,
    overtime_hours,
    round((present_days / working_days) * 100, 2) as attendance_rate
from attendance;

-- OVERTIME CATEGORY

select 
	employee_id,
    month,
    overtime_hours,
    case
		when overtime_hours = 0 then 'No Overtime'
        when overtime_hours <= 10 then 'Low'
        when overtime_hours <= 20 then 'Moderate'
        else 'High'
	end as overtime_category
from attendance;

-- PERFORMANCE CATEGORY

select 
	employee_id,
    review_years,
    performance_score,
    training_hours,
    promotion,
    case
		when performance_score <= 2 then 'Low'
        when performance_score <= 3 then 'Average'
        when performance_score <= 4 then 'Good'
        else 'Excellent'
	end as performance_category
from performance;

-- PROMOTION FLAG

select 
	employee_id,
    promotion,
    case
		when promotion = 'Yes' then 1
        else 0
	end as promotion_flag
from performance;

-- EXIT FLAG

select 
	employee_id,
    status,
    exit_date,
    exit_reason,
    case
		when status = 'Exited' then 1
        else 0
	end as exit_flag
from status;

-- EMPLOYEE MASTER ANALYTICAL VIEW

create or replace view employee_analytics as
select 
	e.employee_id,
    e.employee_name,
    e.gender,
    e.age,
    case
		when e.age < 25 then 'Under 25'
        when e.age between 25 and 34 then '25-34'
        when e.age between 35 and 44 then '35-44'
        when e.age between 45 and 54 then '45-54'
        else '55+'
	end as age_group,
    
    e.department,
    e.job_role,
    e.city,
    e.joining_date,
    timestampdiff(year, e.joining_date, curdate()) as tenure_years,
    
    e.annual_salary,
    case
		when e.annual_salary < 40000 then 'Low'
        when e.annual_salary < 60000 then 'Lower-Mid'
        when e.annual_salary < 80000 then 'Mid'
        when e.annual_salary < 100000 then 'Upper-Mid'
        else 'High'
	end as salary_band,
    
    p.review_years,
    p.performance_score,
    p.training_hours,
    p.promotion,
    case
		when p.performance_score <= 2.0 then 'Low'
        when p.performance_score <= 3.0 then 'Average'
        when p.performance_score <= 4.0 then 'Good'
        else 'Excellent'
	end as performance_category,
    
    case
		when p.promotion = 'Yes' then 1
        else 0
	end as promotion_flag,
    
    s.status,
    s.exit_date,
    s.exit_reason,
    case
		when s.status = 'Exited' then 1
        else 0
	end as exit_flag
    
    from employees e 
    left join performance p 
		on e.employee_id = p.employee_id
	left join status s 
		on e.employee_id = s.employee_id;
        
-- VIEW VALIDATION

select 
	count(*) as total_employees,
    count(distinct employee_id) as unique_employees
from employee_analytics;

select * from employee_analytics;

-- EMPLOYEE ATTENDANCE SUMMARY

create or replace view employee_attendance_summary as 
select 
	employee_id,
    sum(working_days) as total_working_days,
    sum(present_days) as total_present_days,
    sum(leave_days) as total_leave_days,
    sum(overtime_hours) as total_overtime,
    round(
		sum(present_days) / nullif(sum(working_days), 0) * 100, 2
        ) as attendance_rate
from attendance
group by employee_id;

select * from employee_attendance_summary;

select 
	count(*) as attendance_employees,
    count(distinct employee_id) as unique_employees
from employee_attendance_summary;

-- MISSING ATTENDANCE EMPLOYEES

select 
	e.employee_id,
    e.employee_name,
    e.department,
    e.job_role,
    s.status
from employees e 
left join employee_attendance_summary a 
	on e.employee_id = a.employee_id
left join status s 
	on e.employee_id = s.employee_id
where a.employee_id is null
order by e.employee_id;

-- 20 EMPLOYEES ARE ACTIVE/EXITED

select 
	s.status,
    count(*) as employee_count
from employees e 
left join employee_attendance_summary a 
	on e.employee_id = a.employee_id
left join status s 
	on e.employee_id = s.employee_id
where a.employee_id is null
group by s.status;

-- EMPLOYEE ANALYTICS + EMPLOYEE ATTENDANCE SUMMARY

create or replace view hr_employee_analytics as 
select 
	e.*,
    a.total_working_days,
    a.total_present_days,
    a.total_leave_days,
    a.total_overtime,
    a.attendance_rate
from employee_analytics e 
left join employee_attendance_summary a 
	on e.employee_id = a.employee_id;
    
-- FINAL VIEW VALIDATION

select 
	count(*) as total_rows,
    count(distinct employee_id) as unique_employees,
    count(attendance_rate) as employee_with_attendance,
    count(*) - count(attendance_rate) as employee_without_attendance
from hr_employee_analytics;

-- 03_Business_Analysis ----------------------------

-- OVERALL HR WORKFORCE SNAPSHOT

select 
	count(*) as total_employees,
    sum(status = 'Active') as active_employees,
    sum(status = 'Exited') as exited_employees,
    round(sum(status = 'Exited') / count(*) * 100, 2) as attrition_rate,
    round(avg(age), 1) as average_age,
    round(avg(annual_salary), 2) as average_salary,
    round(avg(performance_score), 2) as average_performance
from hr_employee_analytics;

-- DEPARTMENT-WISE WORKFORCE & ATTRITION

select 
	department,
    count(*) as total_employee,
    sum(status = 'Active') as active_employees,
    sum(status = 'Exited') as exited_employees,
    round(sum(status = 'Exited') / count(*) * 100, 2) as attrition_rate
from hr_employee_analytics
group by department
order by attrition_rate desc;

-- EXITED REASONS

select 
	exit_reason,
    count(*) as total_employee
from hr_employee_analytics
where status = 'Exited'
group by exit_reason
order by total_employee desc;

-- DEPARTMENT + EXIT REASON EMPLOYEES EXIT

select 
	department,
    exit_reason,
    count(*) as total_employee
from hr_employee_analytics
where status = 'Exited'
group by department, exit_reason
order by total_employee desc;

-- EXITED DEPARTMENT PERCENTAGE

select 
	department,
    exit_reason,
    count(*) as total_employee,
    round(count(*) * 100.0 / sum(count(*)) over (partition by department), 2) as reason_percentage
from hr_employee_analytics
where status = 'Exited'
group by department, exit_reason
order by department, reason_percentage desc;

-- FINAL VALIDATION OF hr_employee_analytics

select 
	count(*) as total_rows,
    count(distinct employee_id) as unique_employees,
    count(attendance_rate) as employees_with_attendance,
    count(*) - count(attendance_rate) as employees_without_attendance
from hr_employee_analytics;