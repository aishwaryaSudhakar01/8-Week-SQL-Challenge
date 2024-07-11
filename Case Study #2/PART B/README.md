# Pizza Runner Analysis (B) - Customer & Runner Experience

### Problem Statements and Steps

1. **Count of Runners Signed Up Each Week**
- **Problem Statement:** Find the count of runners who signed up for each 1-week period.
- **Steps:**
  - Extract the week number from the `registration_date` using `EXTRACT(WEEK FROM registration_date)`.
  - Count the number of runners for each week using `COUNT(*)`.

![sql_2_2_1](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/b41771a3-0db5-48a2-80df-886eeda8d62b)

2. **Average Time Taken by Runners to Pick Up Orders**
- **Problem Statement:** Calculate the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pick up the order.
- **Steps:**
  - Calculate the time difference in minutes between `order_time` and `pickup_time` using `TIMESTAMP_DIFF`.
  - Calculate the average time for each runner using `ROUND(AVG(...), 2)`.

![sql_2_2_2](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/74e9371e-2ada-4110-b8a9-60e8ce2d6983)

3. **Relationship Between Number of Pizzas and Preparation Time**
- **Problem Statement:** Determine if there is a relationship between the number of pizzas and how long the order takes to prepare.
- **Steps:**
  - Calculate the preparation time in minutes using `TIMESTAMP_DIFF`.
  - Count the number of pizzas per order using `COUNT(pizza_id)`.
  - Calculate the average preparation time for each pizza count using `AVG(prep_time_minutes)`.

![sql_2_2_3](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/c68b9cff-57d2-43e1-9d11-d213cd6e9a41)

4. **Average Distance Traveled for Each Customer**
- **Problem Statement:** Calculate the average distance traveled for each customer.
- **Steps:**
  - Calculate the average distance traveled for each customer using `ROUND(AVG(r.distance), 2)`.
  - Group by `customer_id` using `GROUP BY`.

![sql_2_2_4](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/b1b2d46a-6e29-4f2e-96dd-99f2c08efc91)

5. **Range of Delivery Times for Each Order**
- **Problem Statement:** Find the difference between the longest and shortest delivery times for all orders.
- **Steps:**
  - Calculate the difference between the longest and shortest times using `(MAX(duration) - MIN(duration))`.

![sql_2_2_5](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/6c179228-d161-45f7-97b0-54433daaf448)

6. **Average Speed of Each Runner**
- **Problem Statement:** Calculate the average speed for each runner for each delivery.
- **Steps:**
  - Calculate the total distance and total duration for each runner using `SUM(distance)` and `SUM(duration)`.
  - Calculate the average speed using `ROUND(SUM(distance) * 60.0 / SUM(duration), 2)`.

![sql_2_2_6](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/82d365e6-0740-4e55-9fee-8406250c7c58)

7. **Successful Delivery Percentage of Each Runner**
- **Problem Statement:** Calculate the successful delivery percentage for each runner.
- **Steps:**
  - Group by `runner_id` using `GROUP BY`.
  - Calculate the number of successful deliveries using a `CASE` statement with `SUM(CASE WHEN cancellation IS NULL THEN 1 ELSE 0 END)`.
  - Calculate the total number of orders for each runner using `COUNT(*)`.
  - Calculate the percentage of successful deliveries using `ROUND(SUM(...) * 100.0 / COUNT(*), 2)`.

![sql_2_2_7](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/d887a2f5-f23f-4be2-87b9-b4c85ad403bc)
