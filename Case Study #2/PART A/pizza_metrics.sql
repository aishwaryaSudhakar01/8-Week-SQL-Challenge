-- total pizzas orders 
SELECT COUNT(order_id) AS order_count
FROM `pizza_runner.customer_orders`;

-- unique orders
SELECT COUNT(DISTINCT order_id) AS unique_orders_count
FROM `pizza_runner.customer_orders`;

-- sucessful orders delivered by each runner
SELECT
  runner_id,
  COUNT(order_id) AS successful_deliveries_count
FROM `pizza_runner.runner_orders`
WHERE cancellation IS NULL
GROUP BY runner_id
ORDER BY runner_id;

-- count of each type of pizza delivered
SELECT 
  pn.pizza_name,
  COUNT(*) AS pizza_count
FROM `pizza_runner.customer_orders` c
JOIN `pizza_runner.runner_orders` r
  ON c.order_id = r.order_id
JOIN `pizza_runner.pizza_names` pn 
  ON c.pizza_id = pn.pizza_id
WHERE cancellation IS NULL
GROUP BY pn.pizza_name
ORDER BY pizza_name;

-- count of pizza types (Vegetarian / Meatlovers) ordered by each customer
SELECT 
  c.customer_id,
  SUM(CASE WHEN pn.pizza_name = 'Vegetarian' THEN 1 ELSE 0 END) AS vegetarian_count,
  SUM(CASE WHEN pn.pizza_name = 'Meatlovers' THEN 1 ELSE 0 END) AS meatlovers_count
FROM `pizza_runner.customer_orders` c 
JOIN `pizza_runner.pizza_names` pn
  ON c.pizza_id = pn.pizza_id
GROUP BY c.customer_id
ORDER BY c.customer_id;

-- maximum count of pizzas delivered in a single order
WITH deliveries AS (
  SELECT 
    order_id,
    COUNT(pizza_id) AS pizza_count,
    RANK() OVER (ORDER BY COUNT(pizza_id) DESC) AS rn 
  FROM `pizza_runner.customer_orders` 
  GROUP BY order_id
)

SELECT 
  order_id,
  pizza_count
FROM deliveries
WHERE rn = 1;

-- count of delivered pizzas with and without changes
SELECT 
  c.customer_id,
  SUM(CASE WHEN c.extras IS NOT NULL OR c.exclusions IS NOT NULL THEN 1 ELSE 0 END) AS changes_count,
  SUM(CASE WHEN c.extras IS NULL AND c.exclusions IS NULL THEN 1 ELSE 0 END) AS no_changes_count
FROM `pizza_runner.customer_orders` c
JOIN `pizza_runner.runner_orders` r 
  ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY c.customer_id;

-- count of pizzas with both exclusions and extras 
SELECT SUM(CASE WHEN c.extras IS NOT NULL AND c.exclusions IS NOT NULL THEN 1 ELSE 0 END) AS exclusions_extras_count
FROM `pizza_runner.customer_orders` c
JOIN `pizza_runner.runner_orders` r 
  ON c.order_id = r.order_id
WHERE r.cancellation IS NULL;

-- total volume of pizzas ordered for each hour of the day
SELECT 
  EXTRACT(HOUR FROM order_time) AS order_hour,
  COUNT(pizza_id) AS pizza_count
FROM `pizza_runner.customer_orders`
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY order_hour;

-- volume of orders for each day of the week
SELECT 
  FORMAT_TIMESTAMP('%w', order_time) AS day_num,
  FORMAT_TIMESTAMP('%A', order_time) AS day_name,
  COUNT(*) AS order_count
FROM `pizza_runner.customer_orders`
GROUP BY 
  FORMAT_TIMESTAMP('%w', order_time),
  FORMAT_TIMESTAMP('%A', order_time)
ORDER BY day_num;