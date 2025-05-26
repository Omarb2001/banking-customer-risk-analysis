COPY credit_data(
	id,
    stat_checking_acc,
    duration_months,
    credit_history,
    purpose,
    credit_amount,
    savings_bonds,
    duration_of_employment,
    installment_pct_annual_income,
    marital_status_and_sex,
    other_debtors,
    resident_since,
    property,
    age,
    other_plans,
    housing,
    num_existing_credits,
    job,
    num_liable,
    has_phone,
    foreign_worker,
    good_bad
)
FROM '<path>\updated_dataset.csv'
DELIMITER ','
CSV HEADER;

select * from credit_data