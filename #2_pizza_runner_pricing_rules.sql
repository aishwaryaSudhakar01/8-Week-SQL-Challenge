USE pizza_runner;

-- money made by Pizza Runner of Vegetarian ($10) and Meatlovers ($12)
SELECT
  SUM(CASE WHEN c.pizza_id = 1 THEN 12 
           WHEN c.pizza_id = 2 THEN 10
	  END) AS total_amount
FROM customer_orders c
JOIN pizza_names n
  ON c.pizza_id = n.pizza_id
JOIN runner_orders r
  ON c.order_id = r.order_id
WHERE r.distance != 0;

-- when $1 extra is charged for extra toppings
WITH extras_modified AS (
  SELECT 
    order_id,
    pizza_id,
    LENGTH(REPLACE(REPLACE((extras), ' ', ''), ',', '')) AS extras_count
  FROM customer_orders
)

SELECT
  (SUM(CASE WHEN c.pizza_id = 1 THEN 12
           WHEN c.pizza_id = 2 THEN 10
           ELSE 0 END) +
  SUM(CASE WHEN (c.extras_count IS NOT NULL OR c.extras_count != 0) THEN c.extras_count
           ELSE 0
	  END)) AS total_amount
FROM extras_modified c
JOIN runner_orders r
  ON c.order_id = r.order_id
WHERE r.distance != 0;

-- combined_information


-- money left with Pizza Runner if runners made $0.30 per kilometer travelled (no extra charges)
SELECT
  SUM(CASE WHEN c.pizza_id = 1 THEN 12
           WHEN c.pizza_id = 2 THEN 10
           ELSE 0 END) -
  (0.30 * SUM(r.distance)) AS total_amount
FROM customer_orders c
JOIN runner_orders r
  ON c.order_id = r.order_id
WHERE r.distance != 0;
