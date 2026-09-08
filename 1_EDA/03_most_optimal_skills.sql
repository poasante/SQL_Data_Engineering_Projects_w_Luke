/*
Question: What are the most optimal skills for data engineers - balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on Canadian Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately, rather than letting rare, outlier skills distort the results.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))) / 1_000_000 ,2) AS optimal_score
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    (jpf.job_title_short = 'Data Engineer' AND jpf.job_country = 'Canada')
    AND jpf.job_work_from_home = False
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY
    optimal_score DESC
LIMIT 25;

/*
Breakdown of the most optimal skills for Data Engineers in Canada, based on high demand and high salaries:

Top Skills by Optimal Score:
- AWS leads the list with $125K median salary and 107 postings, resulting in the highest ovearall "optimal skill"
- Python and SQL dominate demand (over 147 postings each), with low median salaries of $107K and $106K, respectively.  
┌─────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│ skills  │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│ varchar │    double     │    int64     │     double      │    double     │
├─────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ aws     │      125000.0 │          107 │             4.7 │          0.58 │
│ python  │      107900.0 │          148 │             5.0 │          0.54 │
│ sql     │      106300.0 │          147 │             5.0 │          0.53 │
└─────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
*/