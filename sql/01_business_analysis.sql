-- Healthcare Insurance Cost & Risk Analytics
-- SQL Business Analysis

USE healthcare_insurance;

-- 1. Overall insurance charge summary
SELECT
    MIN(charges) AS min_charges,
    MAX(charges) AS max_charges,
    ROUND(AVG(charges), 2) AS avg_charges
FROM insurance_data;


-- 2. Insurance charges by smoking status
SELECT
    smoker,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS avg_charges,
    ROUND(MIN(charges), 2) AS min_charges,
    ROUND(MAX(charges), 2) AS max_charges
FROM insurance_data
GROUP BY smoker;


-- 3. Average charge ratio: smokers vs non-smokers
SELECT
    ROUND(
        MAX(CASE WHEN smoker = 'yes' THEN avg_charge END) /
        MAX(CASE WHEN smoker = 'no' THEN avg_charge END),
        2
    ) AS smoker_to_nonsmoker_ratio
FROM (
    SELECT
        smoker,
        AVG(charges) AS avg_charge
    FROM insurance_data
    GROUP BY smoker
) AS smoker_summary;


-- 4. Insurance charges by gender
SELECT
    sex,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS avg_charges
FROM insurance_data
GROUP BY sex;


-- 5. Insurance charges by age group
SELECT
    CASE
        WHEN age BETWEEN 18 AND 29 THEN 'Young Adult'
        WHEN age BETWEEN 30 AND 49 THEN 'Adult'
        WHEN age BETWEEN 50 AND 64 THEN 'Senior Adult'
    END AS age_group,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS avg_charges
FROM insurance_data
GROUP BY age_group
ORDER BY avg_charges;


-- 6. Insurance charges by region
SELECT
    region,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS avg_charges
FROM insurance_data
GROUP BY region
ORDER BY avg_charges DESC;


-- 7. Insurance charges by BMI category
SELECT
    CASE
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi < 25 THEN 'Normal'
        WHEN bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS avg_charges
FROM insurance_data
GROUP BY bmi_category
ORDER BY avg_charges DESC;


-- 8. High-cost customer segmentation
SELECT
    CASE
        WHEN charges >= 30000 THEN 'High Cost'
        ELSE 'Below 30000'
    END AS cost_segment,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS avg_charges
FROM insurance_data
GROUP BY cost_segment
ORDER BY avg_charges DESC;


-- 9. High-cost customers by smoking status
SELECT
    smoker,
    COUNT(*) AS high_cost_customers
FROM insurance_data
WHERE charges >= 30000
GROUP BY smoker
ORDER BY high_cost_customers DESC;


-- 10. Age group and smoking status analysis
SELECT
    CASE
        WHEN age BETWEEN 18 AND 29 THEN 'Young Adult'
        WHEN age BETWEEN 30 AND 49 THEN 'Adult'
        WHEN age BETWEEN 50 AND 64 THEN 'Senior Adult'
    END AS age_group,
    smoker,
    COUNT(*) AS customers,
    ROUND(AVG(charges), 2) AS avg_charges
FROM insurance_data
GROUP BY
    CASE
        WHEN age BETWEEN 18 AND 29 THEN 'Young Adult'
        WHEN age BETWEEN 30 AND 49 THEN 'Adult'
        WHEN age BETWEEN 50 AND 64 THEN 'Senior Adult'
    END,
    smoker
ORDER BY age_group, smoker;


-- 11. Top 10 highest insurance charges
SELECT
    age,
    sex,
    bmi,
    children,
    smoker,
    region,
    charges
FROM insurance_data
ORDER BY charges DESC
LIMIT 10;
