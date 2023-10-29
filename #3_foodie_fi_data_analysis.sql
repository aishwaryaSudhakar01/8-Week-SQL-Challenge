USE foodie_fi;

-- customer onboarding journey summary
SELECT
  s.customer_id,
  s.start_date,
  p.plan_name,
  p.price
FROM subscriptions s
JOIN plans p
  ON s.plan_id = p.plan_id
WHERE s.customer_id IN (1, 2, 11, 13, 15, 16, 18, 19);

-- total customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM subscriptions;

-- monthly distribution of trial plan start date values
SELECT
  MONTH(start_date) AS plan_month,
  DATE_FORMAT(start_date, '%M') AS month_name,
  COUNT(customer_id) AS customer_count
FROM subscriptions
WHERE plan_id = 0
GROUP BY
  MONTH(start_date),
  DATE_FORMAT(start_date, '%M')
ORDER BY plan_month;

-- number of events for each plan after 2021
SELECT
  s.plan_id,
  p.plan_name,
  COUNT(customer_id) AS customer_count
FROM subscriptions s
JOIN plans p
  ON s.plan_id = p.plan_id
WHERE YEAR(start_date) >= 2021
GROUP BY 
  s.plan_id,
  p.plan_name
ORDER BY s.plan_id;

-- churned customers count and rate
WITH counts AS (
  SELECT
    SUM(CASE WHEN plan_id = 4 THEN 1 ELSE 0 END) AS churned_count,
    COUNT(DISTINCT customer_id) AS customer_count
  FROM subscriptions 
)

SELECT
  churned_count,
  ROUND((churned_count*100.0/customer_count), 1) AS churn_perc
FROM counts;

-- customers that churned straight after initial trial
WITH churned AS (
  SELECT
    customer_id,
    plan_id,
    RANK() OVER (PARTITION BY customer_id ORDER BY start_date) AS rn
FROM subscriptions
),

counts AS (
  SELECT
    COUNT(DISTINCT customer_id) AS churned_customer_count
  FROM churned
  WHERE rn = 2
    AND plan_id = 4
)

SELECT
  churned_customer_count,
  ROUND(churned_customer_count*100.0/
    (SELECT COUNT(DISTINCT customer_id) FROM subscriptions)) AS churn_perc
FROM counts;

-- customer plans after initial free trial
WITH plan_types AS (
  SELECT
    p.plan_name,
    COUNT(p.plan_name) AS plan_count,
    (SELECT COUNT(DISTINCT customer_id) FROM subscriptions) AS customer_count
  FROM subscriptions s
  JOIN plans p
    ON s.plan_id = p.plan_id
  WHERE s.plan_id != 0
  GROUP BY p.plan_name
)

SELECT
  plan_name,
  plan_count,
  ROUND((plan_count*100.0/customer_count), 2) AS plan_perc
FROM plan_types;

-- breakdown of all plan values on 2020-12-31
WITH counts AS (
  SELECT
    s.customer_id,
    p.plan_name,
    s.start_date,
    LEAD(s.start_date) OVER (PARTITION BY s.customer_id ORDER BY s.start_date) AS next_date
  FROM subscriptions s 
  JOIN plans p 
    ON s.plan_id = p.plan_id
  WHERE s.start_date <= '2020-12-31'
  GROUP BY 
    s.customer_id,
    p.plan_name,
    s.start_date
)

SELECT
  plan_name,
  COUNT(DISTINCT customer_id) AS customer_count,
  ROUND((COUNT(DISTINCT customer_id)*100.0/
        (SELECT COUNT(DISTINCT customer_id) FROM subscriptions)), 2) AS perc
FROM counts
WHERE next_date IS NULL
GROUP BY plan_name;

-- customers that upgraded to the annual plan in 2020
SELECT COUNT(customer_id) AS customer_count
FROM subscriptions s
JOIN plans p
  ON s.plan_id = p.plan_id
WHERE p.plan_name = 'pro annual'
  AND YEAR(start_date) = 2020;

-- average time taken to upgrade to annual plan
WITH plan_rank AS (
  SELECT
    s.customer_id,
    p.plan_name,
    s.start_date,
    RANK() OVER (PARTITION BY s.customer_id ORDER BY s.start_date) AS rn
  FROM subscriptions s
  JOIN plans p
    ON s.plan_id = p.plan_id
),

next_dates AS (
  SELECT
    customer_id,
    plan_name,
    start_date,
    LEAD(start_date) OVER (PARTITION BY customer_id ORDER BY start_date) AS next_date
  FROM plan_rank
  WHERE plan_name IN ('trial', 'pro annual')
)

SELECT
  ROUND(AVG(TIMESTAMPDIFF(DAY, start_date, next_date))) AS avg_time
FROM next_dates
WHERE next_date IS NOT NULL;

-- 30-day breakdown of time taken to upgrade to annual plan
WITH plan_rank AS (
  SELECT
    s.customer_id,
    p.plan_name,
    s.start_date,
    RANK() OVER (PARTITION BY s.customer_id ORDER BY s.start_date) AS rn
  FROM subscriptions s
  JOIN plans p
    ON s.plan_id = p.plan_id
),

next_dates AS (
  SELECT
    customer_id,
    plan_name,
    start_date,
    LEAD(start_date) OVER (PARTITION BY customer_id ORDER BY start_date) AS next_date
  FROM plan_rank
  WHERE plan_name IN ('trial', 'pro annual')
)

SELECT
  FLOOR(avg_time / 30) AS period,
  COUNT(*) AS num_customers
FROM (
  SELECT
    customer_id,
    TIMESTAMPDIFF(DAY, start_date, next_date) AS avg_time
  FROM next_dates
  WHERE next_date IS NOT NULL
) AS subquery
GROUP BY period
ORDER BY period;

-- customers that downgraded from a pro monthly to a basic monthly
WITH plan_types AS (
  SELECT
    s.customer_id,
    p.plan_name,
    s.start_date,
    RANK() OVER (PARTITION BY s.customer_id ORDER BY s.start_date) AS rn
  FROM subscriptions s
  JOIN plans p
    ON s.plan_id = p.plan_id
  WHERE p.plan_name IN ('pro monthly', 'basic monthly')
    AND YEAR(s.start_date) = 2020
)

SELECT
  COUNT(DISTINCT customer_id) AS customer_count
FROM plan_types
WHERE rn = 2
  AND plan_name = 'basic monthly';
  


