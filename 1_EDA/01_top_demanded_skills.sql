/* 
    Question: What are the most in-demand skills for data engineers? 
    - Identify the top 10 in-demand skills for data engineers in Canada. 
    - Focus on remote job postings. 
    - Why?
        - Retrieve the top 10 skills with the highest demand in the remote job market in Canada, providing insights into the most valuable skills for data engineers seeking remote work. 
*/

SELECT
    sd.skills,
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
ORDER BY
    COUNT(jpf.*) DESC
LIMIT 10;

/*
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
*/

SELECT
    sd.skills,
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
ORDER BY
    COUNT(jpf.*) DESC
LIMIT 10;

/*
-- The breakdown follows similar patterns from what the tutorial shows, despite the concentration mostly, in my estimation, being in the USA. Some skills are of different orders compared to what is globally followed or used in terms of remote work. 

The breakdown for the results for the top 10 most demanded skills for data engineers in Canada and not working remotely:
- SQL and Python remain the foundational skills for data engineers, besides what the tutorial showed. 
- The result also shows that in Canada, the top two cloud platforms are Azure and AWS, respectively. 
- Big data tools like Spark  is highly valued. 
- Data pipeline tools: DataBricks, Snowflake, and Airflow are what Canadian companies are using. 
- Programming languages like Java and Scala are among the top 10 skills. 

My key takeaway from this is that, despite there being fewer Canadian companies amongst the raw data, there isn't a substantial number to draw a conclusion. 
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │         8426 │
│ python     │         8079 │
│ azure      │         4848 │
│ aws        │         4510 │
│ spark      │         3994 │
│ databricks │         2938 │
│ snowflake  │         2685 │
│ java       │         2463 │
│ airflow    │         2106 │
│ scala      │         2045 │
└────────────┴──────────────┘
*/