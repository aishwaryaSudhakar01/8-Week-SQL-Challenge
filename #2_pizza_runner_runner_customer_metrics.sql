USE pizza_runner;

-- number of runners that signed up for each 1 week period
SELECT
  EXTRACT(WEEK FROM registration_date) AS registration_week,
  COUNT(runner_id) AS runner_count
FROM runners
GROUP BY EXTRACT(WEEK FROM registration_date);

-- average pickup time taken by each runner
SELECT
  r.runner_id,
  ROUND(AVG(TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time)),2) AS avg_time_taken
FROM customer_orders c
JOIN runner_orders r
  ON c.order_id = r.order_id
GROUP BY runner_id;

-- relationship between number of pizzas and preparation time
WITH pizza_order AS (
  SELECT
    order_id,
    order_time,
    COUNT(pizza_id) AS pizza_count
  FROM customer_orders
  GROUP BY 
    order_id,
    order_time
)

SELECT
  pizza_count,
  ROUND(AVG(TIMESTAMPDIFF(MINUTE, p.order_time, r.pickup_time)), 2) AS avg_time
FROM pizza_order p
JOIN runner_orders r
  ON p.order_id = r.order_id
WHERE r.distance != 0
GROUP BY pizza_count
ORDER BY pizza_count DESC;

-- average distance travelled for each customer
SELECT 
  c.customer_id,
  ROUND(AVG(r.distance)) AS avg_distance
FROM customer_orders c
JOIN runner_orders r
  ON c.order_id = r.order_id
WHERE r.distance != 0
GROUP BY c.customer_id
ORDER BY avg_distance;

-- difference between longest and shortest delivery time
SELECT
  MAX(duration) - MIN(duration) AS delivery_time_diff
FROM runner_orders
WHERE distance != 0;

-- average speed for each runner for each delivery
SELECT
  c.order_id,
  r.runner_id,
  ROUND(AVG(r.distance/(r.duration/60)), 2) AS avg_speed_kmph
FROM customer_orders c
JOIN runner_orders r
  ON c.order_id = r.order_id
WHERE r.distance != 0
GROUP BY 
  c.order_id,
  r.runner_id
ORDER BY 
  c.order_id,
  r.runner_id;
  
-- successful delivery percentage
WITH deliveries AS (
  SELECT
    runner_id,
    SUM(CASE WHEN distance != 0 THEN 1 ELSE 0 END) AS successful_deliveries,
    COUNT(*) AS total_orders
  FROM runner_orders
  GROUP BY runner_id
)

SELECT
  runner_id,
  ROUND((successful_deliveries*100.0/total_orders)) AS successful_perc
FROM deliveries;











