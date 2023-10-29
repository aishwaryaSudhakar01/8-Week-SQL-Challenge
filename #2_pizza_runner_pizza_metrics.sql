USE pizza_runner;

-- number of pizzas ordered
SELECT COUNT(pizza_id) AS pizza_count
FROM customer_orders;

-- unique customer orders
SELECT COUNT(DISTINCT order_id) AS ditinct_order_count
FROM customer_orders;

-- successful orders delivered by each runner
SELECT 
  runner_id,
  COUNT(order_id) AS order_count
FROM runner_orders
WHERE distance IS NOT NULL
GROUP BY runner_id;

-- count of each type of pizza
SELECT
  n.pizza_name,
  COUNT(c.pizza_id) AS pizza_count
FROM customer_orders c
JOIN runner_orders r
  ON c.order_id = r.order_id
JOIN pizza_names n
  ON c.pizza_id = n.pizza_id
WHERE r.distance IS NOT NULL
GROUP BY n.pizza_name;

-- Vegetarian & Meatlovers ordered by each customer
SELECT
  c.customer_id,
  SUM(CASE WHEN n.pizza_name = 'Vegetarian' THEN 1 ELSE 0 END) AS vegetarian_count,
  SUM(CASE WHEN n.pizza_name = 'Meatlovers' THEN 1 ELSE 0 END) AS meatlovers_count
FROM customer_orders c
JOIN pizza_names n
  ON c.pizza_id = n.pizza_id
GROUP BY c.customer_id;

-- maximum pizzas delivered in a single order
WITH pizzas AS (
  SELECT
    c.order_id,
    COUNT(c.pizza_id) AS pizza_count
  FROM customer_orders c
  JOIN runner_orders r
    ON c.order_id = r.order_id
  WHERE r.distance IS NOT NULL
  GROUP BY c.order_id
)

SELECT MAX(pizza_count) AS maximum_pizza_count
FROM pizzas;

-- count of delivered pizzas with at least 1 change and zero changes
SELECT
  c.customer_id,
  SUM(CASE WHEN (exclusions = 0 OR exclusions IS NULL) 
                AND (extras = 0 OR extras IS NULL) THEN 1 ELSE 0 END) AS no_changes_count,
  SUM(CASE WHEN (exclusions != 0 OR exclusions IS NOT NULL) 
                OR (extras != 0 OR extras IS NOT NULL) THEN 1 ELSE 0 END) AS changes_count
FROM customer_orders c
JOIN runner_orders r
  ON c.order_id = r.order_id
WHERE r.distance IS NOT NULL
GROUP BY c.customer_id;

-- count of delivered pizzas with exclusions and extras
SELECT SUM(CASE WHEN (exclusions != 0 OR exclusions IS NOT NULL) 
                AND (extras != 0 OR extras IS NOT NULL) THEN 1 ELSE 0 END) AS changes_count
FROM customer_orders c
JOIN runner_orders r
  ON c.order_id = r.order_id
WHERE r.distance IS NOT NULL;

-- volume of pizzas ordered from each hour of the day
SELECT
  HOUR(order_time) AS order_hour,
  COUNT(order_id) AS order_count
FROM customer_orders 
GROUP BY HOUR(order_time)
ORDER BY order_count DESC;

-- volume of orders for each day of the week
SELECT
  DAYNAME(order_time) AS order_dayname,
  COUNT(order_id) AS order_count
FROM customer_orders
GROUP BY DAYNAME(order_time)
ORDER BY order_dayname;
