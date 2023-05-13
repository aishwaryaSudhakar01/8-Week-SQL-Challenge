-- DANNYS DINER 
SET search_path = dannys_diner;

-- total amount spent by each customer
SELECT 
  s.customer_id,
  SUM(m.price) AS total_amount
FROM sales s 
  JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- number of days each customer has visited the restaurant
SELECT
  customer_id,
  COUNT(DISTINCT order_date) AS num_days
FROM sales 
GROUP BY customer_id
ORDER BY customer_id;

-- first item from the menu purchased by each customer
WITH CTE AS (
  SELECT 
	s.customer_id,
	m.product_name,
	s.order_date,
	RANK() OVER(PARTITION BY m.product_name ORDER BY s.order_date) AS row_num
  FROM sales s
  JOIN menu m ON s.product_id = m.product_id
)

SELECT
  customer_id,
  product_name as product_name
FROM CTE
WHERE row_num = 1
ORDER BY customer_id;

-- most purchased item and number of times it was purchased
SELECT
  m.product_name,
  COUNT(s.product_id) AS num_purchase
FROM sales s 
JOIN menu m ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY num_purchase DESC
LIMIT 1;
  
-- most popular item for each customer
WITH CTE AS (
SELECT
  s.customer_id,
  m.product_name,
  RANK() OVER(PARTITION BY s.customer_id ORDER BY COUNT(s.product_id) DESC) AS row_num
FROM sales s 
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id, m.product_name
)

SELECT
  customer_id,
  product_name
FROM CTE
WHERE row_num = 1;

-- item purchased first by the customer after they became a member
WITH CTE AS (
  SELECT
	s.customer_id,
	m.product_name,
	RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date) AS row_num
  FROM sales s 
  JOIN menu m ON s.product_id = m.product_id
  JOIN members mem ON s.customer_id = mem.customer_id
  WHERE s.order_date >= mem.join_date
)

SELECT
  customer_id,
  product_name
FROM CTE
WHERE row_num = 1;

-- item purchased just before the customer became a member
WITH CTE AS (
  SELECT
	s.customer_id,
	m.product_name,
	s.order_date,
	RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date DESC) AS row_num
  FROM sales s 
  JOIN menu m ON s.product_id = m.product_id
  JOIN members mem ON s.customer_id = mem.customer_id
  WHERE mem.join_date > s.order_date
)

SELECT
  customer_id,
  product_name,
  order_date
FROM CTE
WHERE row_num = 1;

-- total items and amount spent for each member before they became a member
SELECT
  s.customer_id,
  COUNT(s.product_id) AS total_items,
  SUM(m.price) AS total_amount
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mem ON s.customer_id = mem.customer_id
WHERE s.order_date < mem.join_date
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- number of points each customer would have if $1 spent equates to 10 points and sushi has a 2x points multiplier
SELECT
  s.customer_id,
  SUM(CASE WHEN m.product_name = 'sushi' THEN (m.price*20) 
	  ELSE (m.price*10) END) AS num_points
FROM sales s 
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- points customer A and B have at the end of January if members earn 2x points on all items for the first week
SELECT
  s.customer_id,
  SUM(CASE WHEN m.product_name = 'sushi' THEN (m.price*20)
           WHEN s.order_date >= mem.join_date AND s.order_date < mem.join_date + INTERVAL '7 days' THEN (m.price*20)
      ELSE (m.price*10) END) AS points_earned
FROM sales s 
JOIN menu m ON s.product_id = m.product_id
JOIN members mem ON s.customer_id = mem.customer_id
WHERE s.order_date >= '2021-01-01' 
  AND s.order_date < '2021-02-01'
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- recreating table output
SELECT
  s.customer_id,
  s.order_date,
  m.product_name,
  m.price,
  (CASE WHEN s.customer_id = mem.customer_id 
    AND mem.join_date <= s.order_date THEN 'Y' ELSE 'N' END) AS member
FROM sales s
LEFT JOIN menu m ON s.product_id = m.product_id
LEFT JOIN members mem ON mem.customer_id = s.customer_id
ORDER BY s.customer_id, s.order_date;

-- ranking of products by members
WITH CTE AS (
SELECT
  s.customer_id,
  s.order_date,
  m.product_name,
  m.price,
  (CASE WHEN s.customer_id = mem.customer_id 
    AND s.order_date >= mem.join_date THEN 'Y' ELSE 'N' END) AS member
FROM sales s
LEFT JOIN menu m ON s.product_id = m.product_id
LEFT JOIN members mem ON mem.customer_id = s.customer_id
ORDER BY s.customer_id, s.order_date)

SELECT
  *,
  (CASE WHEN member = 'Y' 
        THEN RANK() OVER (PARTITION BY customer_id, member ORDER BY order_date) 
        ELSE NULL END) AS ranking
FROM CTE;


