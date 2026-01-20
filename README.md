# Global Data Science Market Analysis (2020-2022) 📊

## 📌 Project Overview
This project provides a comprehensive analysis of the **Data Science job market** using a global salary dataset. The goal was to move beyond simple statistics and uncover deep business insights regarding compensation trends, the impact of remote work, and hiring momentum across different seniority levels.

Through advanced SQL querying, I analyzed salary distributions, career progression, and market shifts during the post-pandemic recovery period.

## ❓ Key Questions Answered
* **Salary Growth:** How did average salaries evolve Year-over-Year (YoY)?
* **Remote Work:** Is there a "Remote Premium" compared to On-site or Hybrid roles?
* **Market Dynamics:** Which seniority levels (Entry to Executive) are currently expanding or shrinking?
* **Top Roles:** What are the top 5 highest-paying job titles (filtered for statistical significance)?

## 🛠 Tech Stack & SQL Techniques
* **Language:** MS SQL Server
* **Window Functions:** `LAG()`, `DENSE_RANK()`, `OVER(PARTITION BY...)` for trend and rank analysis.
* **CTEs (Common Table Expressions):** To build modular, readable, and efficient queries.
* **Data Transformation:** `CASE` statements for market segmentation and trend labeling.
* **Statistical Filtering:** Used `HAVING COUNT(*)` to ensure results are based on a reliable sample size.

---

## 📈 Analysis & Key Insights

### 1. Annual Salary Trends (YoY Growth)
I tracked the "market temperature" by calculating the average salary and its growth rate.
* **Finding:** The analysis shows the exact percentage increase in global compensation, identifying 2022 as a peak year for salary jumps.

### 2. Market Momentum & Hiring Trends
One of the most advanced parts of this project is the **Hiring Dynamics** classification. 
* **Logic:** Using `LAG` to compare headcounts, I categorized each seniority level's status as **Growth**, **Stable**, or **Decline**.
* **Insight:** This reveals whether the market is shifting toward Senior-heavy recruitment or remaining open to Entry-level talent.



### 3. Remote Work Performance
I compared **On-site**, **Hybrid**, and **Remote** settings to see which format offers the best ROI for professionals.
* **Finding:** Remote roles consistently command higher averages, likely due to companies competing for specialized talent on a global scale.

### 4. Seniority vs. Compensation
A deep dive into the "Salary Gap" across **EN (Entry), MI (Mid), SE (Senior),** and **EX (Executive)** levels.
* **Insight:** I identified not just the average, but the "Salary Range" (Min/Max), showing where the highest earning potential lies.

---

## 📁 Project Structure
* `analysis_script.sql`: The primary SQL file containing the full analytical pipeline, from data exploration to executive reporting.
* `README.md`: Project documentation and summary of insights.

## 🎯 Conclusion
The Data Science market is rapidly maturing. The analysis proves that **Remote work** is no longer just a perk but a high-paying standard. Furthermore, while the market started from a "New Baseline" in 2020, the **Market Trend** analysis highlights a clear shift towards experienced (Senior/Executive) roles in recent years.

---
**Tools:** SQL Server, GitHub, Data Analysis.
