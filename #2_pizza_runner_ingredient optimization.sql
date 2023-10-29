USE pizza_runner;

DROP TABLE IF EXISTS toppings_list;

CREATE TABLE pizza_recipes_cleaned (
   pizza_id INT,
   toppings int);
   
INSERT INTO pizza_recipes_cleaned(pizza_id, toppings) 
VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,8),
(1,10),
(2,4),
(2,6),
(2,7),
(2,9),
(2,11),
(2,12);

SELECT * 
FROM pizza_recipes_cleaned;

WITH pizza1 AS (
  SELECT *
  FROM pizza_recipes_cleaned
  WHERE pizza_id = 1
),

pizza2 AS (
  SELECT *
  FROM pizza_recipes_cleaned
  WHERE pizza_id = 2
)

SELECT
  t.topping_name
FROM pizza1 AS p1
JOIN pizza2 AS p2
  ON p1.toppings = p2.toppings
JOIN pizza_toppings t
  ON p1.toppings = t.topping_id;

