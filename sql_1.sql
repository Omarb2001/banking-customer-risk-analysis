--CTEs for all data, data with only car loans, data with only bad car loans
WITH 
all_data AS (
    SELECT * FROM credit_data
),
car_loans AS (
    SELECT * FROM credit_data
    WHERE purpose IN ('car_new', 'car_used')
),
bad_car_loans AS (
    SELECT * FROM credit_data
    WHERE purpose IN ('car_new', 'car_used') AND good_bad = 2
),
job_counts AS (
    SELECT job, COUNT(*) AS job_count
    FROM all_data
    GROUP BY job
),
max_job AS (
    SELECT MAX(job_count) AS max_count FROM job_counts
),
total_rows AS (
    SELECT COUNT(*) AS total_count FROM all_data
),
house_counts AS (
    SELECT housing, COUNT(*) AS house_count
    FROM all_data
    GROUP BY housing
),
max_house AS (
    SELECT MAX(house_count) AS max_count FROM house_counts
),
phone_counts AS (
    SELECT has_phone, COUNT(*) AS phone_count
    FROM all_data
    GROUP BY has_phone
),
max_phone AS (
    SELECT MAX(phone_count) AS max_count FROM phone_counts
),
property_counts AS (
    SELECT property, COUNT(*) AS property_count
    FROM all_data
    GROUP BY property
),
max_property AS (
    SELECT MAX(property_count) AS max_count FROM property_counts
),



total_rows_c AS (
    SELECT COUNT(*) AS total_count FROM car_loans
),
job_counts_c AS (
    SELECT job, COUNT(*) AS job_count
    FROM car_loans
    GROUP BY job
),
max_job_c AS (
    SELECT MAX(job_count) AS max_count FROM job_counts_c
),
house_counts_c AS (
    SELECT housing, COUNT(*) AS house_count
    FROM car_loans
    GROUP BY housing
),
max_house_c AS (
    SELECT MAX(house_count) AS max_count FROM house_counts_c
),
phone_counts_c AS (
    SELECT has_phone, COUNT(*) AS phone_count
    FROM car_loans
    GROUP BY has_phone
),
max_phone_c AS (
    SELECT MAX(phone_count) AS max_count FROM phone_counts_c
),
property_counts_c AS (
    SELECT property, COUNT(*) AS property_count
    FROM car_loans
    GROUP BY property
),
max_property_c AS (
    SELECT MAX(property_count) AS max_count FROM property_counts_c
),


total_rows_bc AS (
    SELECT COUNT(*) AS total_count FROM bad_car_loans
),
job_counts_bc AS (
    SELECT job, COUNT(*) AS job_count
    FROM bad_car_loans
    GROUP BY job
),
max_job_bc AS (
    SELECT MAX(job_count) AS max_count FROM job_counts_bc
),
house_counts_bc AS (
    SELECT housing, COUNT(*) AS house_count
    FROM bad_car_loans
    GROUP BY housing
),
max_house_bc AS (
    SELECT MAX(house_count) AS max_count FROM house_counts_bc
),
phone_counts_bc AS (
    SELECT has_phone, COUNT(*) AS phone_count
    FROM bad_car_loans
    GROUP BY has_phone
),
max_phone_bc AS (
    SELECT MAX(phone_count) AS max_count FROM phone_counts_bc
),
property_counts_bc AS (
    SELECT property, COUNT(*) AS property_count
    FROM bad_car_loans
    GROUP BY property
),
max_property_bc AS (
    SELECT MAX(property_count) AS max_count FROM property_counts_bc
)





SELECT 
    'All' AS group_name,
    COUNT(*) AS total,
    ROUND(AVG(duration_months), 2) AS avg_duration,
    ROUND(AVG(credit_amount), 2) AS avg_credit_amount,
    ROUND(AVG(installment_pct_annual_income), 2) AS avg_installment_pct,
    ROUND(AVG(age), 2) AS avg_age,
	MODE() within group (order by lower(job)) AS most_common_job_type,
	ROUND(mj.max_count * 100.0 / tr.total_count, 2) AS most_common_job_pct,
	MODE() within group (order by lower(housing)) AS most_common_housing,
	ROUND(mh.max_count * 100.0 / tr.total_count, 2) AS most_common_housing_pct,
    MODE() within group (order by has_phone) AS majority_has_phone,
	ROUND(mp.max_count * 100.0 / tr.total_count, 2) AS most_common_phone_own_pct,
    MODE() within group (order by lower(property)) AS most_common_property,
	ROUND(mp2.max_count * 100.0 / tr.total_count, 2) AS most_common_property_pct
    
FROM all_data,
	max_job mj,
	total_rows tr,
	max_house mh,
	max_phone mp,
	max_property mp2
	GROUP BY most_common_job_pct, most_common_housing_pct, most_common_phone_own_pct, most_common_property_pct

UNION ALL

SELECT 
    'Car Loans',
    COUNT(*) AS total,
    ROUND(AVG(duration_months), 2) AS avg_duration,
    ROUND(AVG(credit_amount), 2) AS avg_credit_amount,
    ROUND(AVG(installment_pct_annual_income), 2) AS avg_installment_pct,
    ROUND(AVG(age), 2) AS avg_age,
	MODE() within group (order by lower(job)) AS most_common_job_type,
	ROUND(mjc.max_count * 100.0 / trc.total_count, 2) AS most_common_job_pct,
	MODE() within group (order by lower(housing)) AS most_common_housing,
	ROUND(mhc.max_count * 100.0 / trc.total_count, 2) AS most_common_housing_pct,
    MODE() within group (order by has_phone) AS majority_has_phone,
	ROUND(mpc.max_count * 100.0 / trc.total_count, 2) AS most_common_phone_own_pct,
    MODE() within group (order by lower(property)) AS most_common_property,
	ROUND(mp2c.max_count * 100.0 / trc.total_count, 2) AS most_common_property_pct
FROM car_loans,
	max_job_c mjc,
	total_rows_c trc,
	max_house_c mhc,
	max_phone_c mpc,
	max_property_c mp2c
	GROUP BY most_common_job_pct, most_common_housing_pct, most_common_phone_own_pct, most_common_property_pct

UNION ALL

SELECT 
    'Bad Car Loans',
    COUNT(*) AS total,
    ROUND(AVG(duration_months), 2) AS avg_duration,
    ROUND(AVG(credit_amount), 2) AS avg_credit_amount,
    ROUND(AVG(installment_pct_annual_income), 2) AS avg_installment_pct,
    ROUND(AVG(age), 2) AS avg_age,
	MODE() within group (order by lower(job)) AS most_common_job_type,
	ROUND(mjbc.max_count * 100.0 / trbc.total_count, 2) AS most_common_job_pct,
	MODE() within group (order by lower(housing)) AS most_common_housing,
	ROUND(mhbc.max_count * 100.0 / trbc.total_count, 2) AS most_common_housing_pct,
    MODE() within group (order by has_phone) AS majority_has_phone,
	ROUND(mpbc.max_count * 100.0 / trbc.total_count, 2) AS most_common_phone_own_pct,
    MODE() within group (order by lower(property)) AS most_common_property,
	ROUND(mp2bc.max_count * 100.0 / trbc.total_count, 2) AS most_common_property_pct
FROM bad_car_loans,
	max_job_bc mjbc,
	total_rows_bc trbc,
	max_house_bc mhbc,
	max_phone_bc mpbc,
	max_property_bc mp2bc
	GROUP BY most_common_job_pct, most_common_housing_pct, most_common_phone_own_pct, most_common_property_pct
;
