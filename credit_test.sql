select * from credit_test

--Q1 Which loan purpose has highest average loan amount?
select purpose,ROUND(avg(current_loan_amount::numeric),2)as avg_loan
from credit_test
group by purpose 
order by avg_loan desc;

--Q2 Average credit score by home ownership?
select home_ownership,round(avg(credit_score::numeric),2) as avg_credit_score
from credit_test
group by home_ownership
order by avg_credit_score;

--Q3 Top 10 customer with highest debt-to-income ratio
select customer_id,round((debt_to_income::numeric),2) as highest_debt_to_income
from credit_test
order by highest_debt_to_income desc
limit 10;

--Q4 Credit category distribution.
select credit_category,count(*) as customers
from credit_test
group by credit_category
order by customers desc;

--Q5 Average annual income by credit category.
select credit_category,round(avg(annual_income::numeric),2) as avg_annual_income 
from credit_test
group by credit_category
order by avg_annual_income desc;

--Q6 Which term gets larger loans?
select term,round(avg(current_loan_amount::numeric),2) as avg_current_loan
from credit_test
group by term
order by avg_current_loan desc;

--Q7 Purpose with highest avaerage credit score?
select purpose, round(avg(credit_score::numeric),2) as average_credit_score
from credit_test
group by purpose 
order by average_credit_score desc;

--Q8 Average loan amount by credit category?
select credit_category,round(avg(current_loan_amount::numeric),2) as avg_loan_amount
from credit_test
group by credit_category
order by avg_loan_amount desc;


--Q9 Top 5 loan purpose by customer count
select purpose,count(*) as customer
from credit_test
group by purpose
order by customer desc
limit 5;

--Q10 Rank customer by credit score.
select customer_id,credit_score,
rank() over(order by credit_score desc) as credit_rank
from credit_test;

--Q11 Top 3 highest loan within each purpose.
select * from(
select customer_id,purpose,current_loan_amount,
row_number() over(partition by purpose order by current_loan_amount desc ) as top_3
from credit_test)t
where top_3 >=3;

--Q12 Customer with bankruptcy history.
select count(*) as bankruptcy_customer
from credit_test
where bankruptcies >0;

--Q13 Compare customer loan to category average.
select customer_id,credit_category,current_loan_amount,avg(current_loan_amount)
over(partition by credit_category) as category_avg
from credit_test;


--Q14 Which factor are associated with higher loan amounts?
select credit_category,
term,
round(avg(current_loan_amount::numeric),2) avg_loan
from credit_test
group by credit_category,term
order by avg_loan desc;