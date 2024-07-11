SELECT *
FROM `pizza_runner.runners`;

-- count of runners that registered each week
SELECT 
  EXTRACT(WEEK FROM registration_date) AS registration_week,
  STRING_AGG(CAST(registration_date AS STRING), ', ') AS date_list,
  COUNT(*) AS runner_count
FROM `pizza_runner.runners`
GROUP BY EXTRACT(WEEK FROM registration_date)
ORDER BY registration_week;

-- average time taken by runners to pick up the order
SELECT 
  r.runner_id,
  ROUND(AVG(TIMESTAMP_DIFF(r.pickup_time, c.order_time, MINUTE)), 2) AS avg_time_taken
FROM `pizza_runner.customer_orders` c 
JOIN `pizza_runner.runner_orders` r 
  ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
  AND DATE(c.order_time) = DATE(r.pickup_time)
GROUP BY r.runner_id
ORDER BY r.runner_id;

-- number of pizzas vs hours taken to prepare
WITH prep_time_cte AS (
  SELECT 
    c.order_id, 
    c.order_time, 
    r.pickup_time, 
    TIMESTAMP_DIFF(r.pickup_time, c.order_time, MINUTE) AS prep_time_minutes,
    COUNT(c.pizza_id) AS pizza_count, 
  FROM `pizza_runner.customer_orders` AS c
  JOIN `pizza_runner.runner_orders` AS r
    ON c.order_id = r.order_id
  WHERE r.cancellation IS NULL
    AND DATE(c.order_time) = DATE(r.pickup_time)
  GROUP BY 
    c.order_id, 
    c.order_time, 
    r.pickup_time
)

SELECT 
  pizza_count, 
  AVG(prep_time_minutes) AS avg_prep_time_minutes
FROM prep_time_cte
WHERE prep_time_minutes > 1
GROUP BY pizza_count
ORDER BY pizza_count;

-- avg distance travelled for each customer
SELECT 
  c.customer_id,
  ROUND(AVG(r.distance), 2) AS avg_distance
FROM `pizza_runner.customer_orders` c
JOIN `pizza_runner.runner_orders` r 
  ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY c.customer_id
ORDER BY c.customer_id;

-- range of delivery times for each order
SELECT 
  (MAX(duration) - MIN(duration)) AS difference
FROM `pizza_runner.runner_orders`
WHERE cancellation IS NULL;

-- average speed of each runner
SELECT 
  runner_id,
  ROUND(SUM(distance) * 60.0 / SUM(duration), 2) AS avg_speed_kmph
FROM `pizza_runner.runner_orders`
WHERE cancellation IS NULL
GROUP BY runner_id
ORDER BY runner_id;

-- successful delivery percentage of each runner
SELECT 
  runner_id,
  ROUND(SUM(CASE WHEN cancellation IS NULL THEN 1 ELSE 0 END) * 100.0
    / COUNT(*), 2) AS delivery_perc
FROM `pizza_runner.runner_orders`
GROUP BY runner_id
ORDER BY runner_id;









