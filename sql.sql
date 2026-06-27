SELECT * FROM employe.employe_salary;

--- Re-nameing Table name 
rename table cleaned_dataset to Employe_salary ;


-- 1. Top 3 salaryed employ from each job_title .
select job_title , salary_in_usd as  top_3
from (select*, Row_Number() over (partition by job_title order by salary_in_usd desc ) as rn from employe_salary )t where rn <=3 ;

-- 2. Top 10 salary employ and job title
select job_title , salary_in_usd
from employe_salary
order by salary_in_usd desc
limit 10 ;

-- 3. Average salary by experience level 
select experience_level, round(avg(salary_in_usd),2) as average_salary
from employe_salary
group by experience_level
order by experience_level ; 

-- 4. Count of male and female 
select work_setting ,count(-1) as count 
from employe_salary
group by work_setting 
order by  count desc;

-- 5. Top paying country 
select company_location,round(avg(salary_in_usd),2) as Top_avg_paying_country 
from employe_salary
group by company_location 
order by  Top_avg_paying_country desc ;

-- 6. Top second highest salary employe 
select max(salary_in_usd) as top_second
from employe_salary 
where salary_in_usd <( select max(salary_in_usd) from employe_salary);
       
     ---  or ----

select distinct salary_in_usd 
from employe_salary
order by salary_in_usd desc
limit 1 offset 1;     
       
-- 7.  Finding employe types 
select employment_type ,count(*) type
from employe_salary
group by employment_type ;

-- 8. Ranking based on salary 
select salary_in_usd ,job_title, rank() over (order by salary_in_usd desc) as salary_rank
from employe_salary 
limit 10;

-- 9. year over year salary growth 
select work_year ,round(avg(salary_in_usd),2) as avg_salary 
from employe_salary
group by work_year
order by work_year ; 
       
-- 10.  finding duplicate job titles 
select job_title ,count(*) as job_count 
from employe_salary
group by job_title
having count(*) > 1 ;
       


