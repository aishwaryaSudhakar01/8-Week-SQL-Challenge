SELECT *
FROM `dannys_diner.sales`;

-- total amount spent by each customer
SELECT 
  s.customer_id,
  SUM(m.price) AS total_amount
FROM `dannys_diner.sales` s
JOIN `dannys_diner.menu` m 
  ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- customer visit count
SELECT
  customer_id,
  COUNT(DISTINCT order_date) AS visit_days_count
FROM `dannys_diner.sales` 
GROUP BY customer_id;

-- first item purchased by each customer
WITH purchase_rank AS (
  SELECT
    s.customer_id,
    s.order_date,
    m.product_name,
    ROW_NUMBER() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS rn
  FROM `dannys_diner.sales` s
  JOIN `dannys_diner.menu` m 
    ON s.product_id = m.product_id
)

SELECT 
  customer_id,
  product_name,
  order_date
FROM purchase_rank
WHERE rn = 1
ORDER BY customer_id;

-- most purchased item and its count of purchase 
WITH items AS (
  SELECT
    m.product_name,
    COUNT(m.product_name) AS purchase_count,
    RANK() OVER (ORDER BY COUNT(m.product_name) DESC) AS rn
  FROM `dannys_diner.sales` s
  JOIN `dannys_diner.menu` m 
    ON s.product_id = m.product_id
  GROUP BY m.product_name
)

SELECT 
  product_name,
  purchase_count
FROM items
WHERE rn = 1;

-- most popular item for each customer
WITH items AS (
  SELECT 
    s.customer_id,
    m.product_name,
    COUNT(m.product_name) AS purchase_count,
    RANK() OVER (PARTITION BY s.customer_id ORDER BY COUNT(m.product_name) DESC) AS rn
  FROM `dannys_diner.sales` s
  JOIN `dannys_diner.menu` m 
    ON s.product_id = m.product_id
  GROUP BY 
    s.customer_id,
    m.product_name
)

SELECT
  customer_id,
  product_name,
  purchase_count
FROM items
WHERE rn = 1
ORDER BY customer_id;

-- first item purchased after attaining membership
WITH items AS (
  SELECT 
    s.customer_id,
    m.product_name,
    s.order_date,
    RANK() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS rn
  FROM `dannys_diner.sales` s
  JOIN `dannys_diner.menu` m 
    ON s.product_id = m.product_id
  JOIN `dannys_diner.members` mem
    ON s.customer_id = mem.customer_id
  WHERE s.order_date >= mem.join_date
)

SELECT 
  customer_id,
  order_date,
  product_name
FROM items
WHERE rn = 1
ORDER BY customer_id;

-- last item purchased before becoming a member
WITH items AS (
  SELECT 
    s.customer_id,
    m.product_name,
    s.order_date,
    RANK() OVER (PARTITION BY s.customer_id ORDER BY s.order_date DESC) AS rn
  FROM `dannys_diner.sales` s
  JOIN `dannys_diner.menu` m 
    ON s.product_id = m.product_id
  JOIN `dannys_diner.members` mem
    ON s.customer_id = mem.customer_id
  WHERE s.order_date < mem.join_date
)

SELECT 
  DISTINCT customer_id,
  order_date
  product_name
FROM items
WHERE rn = 1
ORDER BY customer_id;

-- total items and amount spent before attaining membership
SELECT 
  s.customer_id,
  COUNT(*) AS total_items,
  SUM(m.price) AS total_amount
FROM `dannys_diner.sales` s
JOIN `dannys_diner.menu` m 
  ON s.product_id = m.product_id
JOIN `dannys_diner.members` mem
  ON s.customer_id = mem.customer_id
WHERE s.order_date < mem.join_date
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- points earned
SELECT 
  s.customer_id,
  SUM(CASE WHEN m.product_name = 'sushi' THEN (20 * m.price)
    ELSE (10 * price) END) AS points_earned
FROM `dannys_diner.sales` s
JOIN `dannys_diner.menu` m 
  ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- points earned by members
SELECT 
  s.customer_id,
  SUM(
    CASE 
      WHEN s.order_date BETWEEN mem.join_date AND DATE_ADD(mem.join_date, INTERVAL 6 DAY) THEN (20 * m.price)
      WHEN m.product_name = 'sushi' THEN (20 * m.price)
      ELSE (10 * m.price)
    END
  ) AS total_points
FROM `dannys_diner.sales` s
JOIN `dannys_diner.menu` m 
  ON s.product_id = m.product_id
JOIN `dannys_diner.members` mem
  ON s.customer_id = mem.customer_id
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- sales table
SELECT 
  s.customer_id,
  s.order_date,
  m.product_name,
  m.price,
  CASE WHEN mem.join_date > s.order_date OR mem.join_date IS NULL 
    THEN 'N' ELSE 'Y' END AS member
FROM `dannys_diner.sales` s
JOIN `dannys_diner.menu` m 
  ON s.product_id = m.product_id
LEFT JOIN `dannys_diner.members` mem
  ON s.customer_id = mem.customer_id;

-- sales table 
WITH items AS (
  SELECT 
    s.customer_id,
    s.order_date,
    m.product_name,
    m.price,
    CASE WHEN mem.join_date > s.order_date OR mem.join_date IS NULL 
        THEN 'N' ELSE 'Y' END AS member
  FROM `dannys_diner.sales` s
  JOIN `dannys_diner.menu` m 
    ON s.product_id = m.product_id
  LEFT JOIN `dannys_diner.members` mem
    ON s.customer_id = mem.customer_id
)

SELECT *,
  CASE WHEN member = 'N' THEN NULL 
   ELSE RANK() OVER (PARTITION BY customer_id, member ORDER BY order_date)
  END AS ranking
FROM items
ORDER BY 
  customer_id,
  member;
