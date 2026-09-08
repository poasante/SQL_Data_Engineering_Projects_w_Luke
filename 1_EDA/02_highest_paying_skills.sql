/*
    Question: what are the highest-paying skills for data engineers? 
    - Calculate the median salary for each skill required in data engineer positions. 
    - Focus on postings where the job country is Canada with specified salaries.
    - Include skill frequency to identify both salary and demand.
    - Why?
        - Helps identify which skills command the highest compensation while also showing how common skills are, providing a more complete picture for skill development priorities.
        - The median is used instead of the average to reduce the impact of outlier salaries. 
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
GROUP BY
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY
    median_salary DESC
LIMIT 25;

/*
┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ golang     │      184000.0 │          912 │
│ terraform  │      184000.0 │         3248 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154224.0 │          129 │
│ c          │      151500.0 │          444 │
│ atlassian  │      151500.0 │          249 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ ruby       │      150000.0 │          736 │
│ css        │      150000.0 │          262 │
│ airflow    │      150000.0 │         9996 │
│ node       │      150000.0 │          179 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ ansible    │      148798.0 │          475 │
│ jupyter    │      147500.0 │          400 │
└────────────┴───────────────┴──────────────┘
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    (jpf.job_title_short = 'Data Engineer' AND jpf.job_country = 'Canada')
    AND jpf.job_work_from_home = False
GROUP BY
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY
    median_salary DESC
LIMIT 25;

/*
Here's a breakdown of the highest paying skills for Data Engineers in Canada:

Key Insights:
- DAX is the top-paying skill at $155K median salary, though demand is still relatively limited (128 postings)
- Ruby has a high median salary at $147K, with a relatively limited demand (328 posting)
- TensorFlow and PyTorch both have high pay and relatively limited demand (TensorFlow: 199 postings; PyTorch: 206 postings)

Takeaway: The top-paying skills in Canada has nothing to do with Data Engineering.
┌───────────────┬───────────────┬──────────────┐
│    skills     │ median_salary │ demand_count │
│    varchar    │    double     │    int64     │
├───────────────┼───────────────┼──────────────┤
│ dax           │      155905.0 │          128 │
│ ruby          │      147500.0 │          328 │
│ tensorflow    │      140000.0 │          199 │
│ pytorch       │      140000.0 │          206 │
│ cassandra     │      138750.0 │          255 │
│ express       │      137075.0 │          130 │
│ postgresql    │      136250.0 │          714 │
│ excel         │      133000.0 │          631 │
│ golang        │      130000.0 │          119 │
│ elasticsearch │      130000.0 │          190 │
│ spring        │      130000.0 │          217 │
│ unity         │      127500.0 │          128 │
│ looker        │      125500.0 │          381 │
│ jira          │      125000.0 │          526 │
│ java          │      125000.0 │         2463 │
│ jenkins       │      125000.0 │          790 │
│ aws           │      125000.0 │         4510 │
│ kubernetes    │      125000.0 │         1154 │
│ mongodb       │      125000.0 │          906 │
│ confluence    │      125000.0 │          332 │
│ databricks    │      125000.0 │         2938 │
│ airflow       │      125000.0 │         2106 │
│ dynamodb      │      125000.0 │          144 │
│ git           │      122500.0 │         1410 │
│ sas           │      122472.0 │          426 │
└───────────────┴───────────────┴──────────────┘
*/
