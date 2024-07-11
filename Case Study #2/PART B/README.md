# Pizza Runner Analysis

## Count of Runners Signed Up Each Week

**Problem Statement:** Find the count of runners who signed up for each 1-week period.

**Steps:**
1. **Extract the week number from the `registration_date`**:
   - Use the `EXTRACT(WEEK FROM registration_date)` function to get the week number.
2. **Group by the extracted week number**:
   - Apply the `GROUP BY` clause to the extracted week number to aggregate data by week.
3. **Count the number of runners for each week**:
   - Use the `COUNT(*)` function to count the number of runners per group.
4. **Order the results by week number**:
   - Use the `ORDER BY registration_week` clause to sort the results chronologically.

**SQL Functions Used:**
- `EXTRACT(WEEK FROM ...)`
- `GROUP BY`
- `COUNT()`
- `ORDER BY`

## Average Time Taken by Runners to Pick Up Orders

**Problem Statement:** Calculate the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pick up the order.

**Steps:**
1. **Join the `customer_orders` and `runner_orders` tables on `order_id`**:
   - Use the `JOIN` clause to combine rows from `customer_orders` and `runner_orders` based on matching `order_id`.
2. **Calculate the time difference in minutes between `order_time` and `pickup_time`**:
   - Use the `TIMESTAMP_DIFF(r.pickup_time, c.order_time, MINUTE)` function to find the difference in minutes.
3. **Filter out canceled orders**:
   - Apply a `WHERE` clause to exclude rows where `cancellation` is not NULL.
4. **Group by `runner_id`**:
   - Use the `GROUP BY r.runner_id` clause to aggregate data by runner.
5. **Calculate the average time for each runner**:
   - Use the `ROUND(AVG(...), 2)` function to find the average and round it to two decimal places.

**SQL Functions Used:**
- `JOIN`
- `TIMESTAMP_DIFF()`
- `ROUND()`
- `AVG()`
- `GROUP BY`

## Relationship Between Number of Pizzas and Preparation Time

**Problem Statement:** Determine if there is a relationship between the number of pizzas and how long the order takes to prepare.

**Steps:**
1. **Join the `customer_orders` and `runner_orders` tables on `order_id`**:
   - Use the `JOIN` clause to combine rows from `customer_orders` and `runner_orders` based on matching `order_id`.
2. **Calculate the preparation time in minutes**:
   - Use the `TIMESTAMP_DIFF(r.pickup_time, c.order_time, MINUTE)` function to find the difference in minutes.
3. **Count the number of pizzas per order**:
   - Use the `COUNT(pizza_id)` function to count the number of pizzas associated with each order.
4. **Filter out canceled orders**:
   - Apply a `WHERE` clause to exclude rows where `cancellation` is not NULL.
5. **Group by `order_id` to get unique orders**:
   - Use the `GROUP BY c.order_id` clause to aggregate data by order.
6. **Calculate the average preparation time for each pizza count**:
   - Use the `AVG(prep_time_minutes)` function to find the average preparation time for each pizza count.

**SQL Functions Used:**
- `JOIN`
- `TIMESTAMP_DIFF()`
- `COUNT()`
- `AVG()`
- `GROUP BY`

## Average Distance Traveled for Each Customer

**Problem Statement:** Calculate the average distance traveled for each customer.

**Steps:**
1. **Join the `customer_orders` and `runner_orders` tables on `order_id`**:
   - Use the `JOIN` clause to combine rows from `customer_orders` and `runner_orders` based on matching `order_id`.
2. **Filter out canceled orders**:
   - Apply a `WHERE` clause to exclude rows where `cancellation` is not NULL.
3. **Group by `customer_id`**:
   - Use the `GROUP BY c.customer_id` clause to aggregate data by customer.
4. **Calculate the average distance traveled for each customer**:
   - Use the `ROUND(AVG(r.distance), 2)` function to find the average distance and round it to two decimal places.

**SQL Functions Used:**
- `JOIN`
- `ROUND()`
- `AVG()`
- `GROUP BY`

## Range of Delivery Times for Each Order

**Problem Statement:** Find the difference between the longest and shortest delivery times for all orders.

**Steps:**
1. **Filter out canceled orders**:
   - Apply a `WHERE` clause to exclude rows where `cancellation` is not NULL.
2. **Use `MAX` and `MIN` functions to find the longest and shortest delivery times**:
   - Apply the `MAX(duration)` and `MIN(duration)` functions to get the maximum and minimum delivery times.
3. **Calculate the difference between the longest and shortest times**:
   - Subtract the result of `MIN(duration)` from `MAX(duration)`.

**SQL Functions Used:**
- `MAX()`
- `MIN()`
- `TIMESTAMP_DIFF()`

## Average Speed of Each Runner

**Problem Statement:** Calculate the average speed for each runner for each delivery.

**Steps:**
1. **Filter out canceled orders**:
   - Apply a `WHERE` clause to exclude rows where `cancellation` is not NULL.
2. **Group by `runner_id`**:
   - Use the `GROUP BY r.runner_id` clause to aggregate data by runner.
3. **Calculate the total distance and total duration for each runner**:
   - Use the `SUM(distance)` and `SUM(duration)` functions to get the total distance and duration.
4. **Calculate the average speed**:
   - Use the formula `ROUND(SUM(distance) * 60.0 / SUM(duration), 2)` to calculate the average speed in kilometers per hour.

**SQL Functions Used:**
- `SUM()`
- `ROUND()`
- `GROUP BY`

## Successful Delivery Percentage of Each Runner

**Problem Statement:** Calculate the successful delivery percentage for each runner.

**Steps:**
1. **Group by `runner_id`**:
   - Use the `GROUP BY r.runner_id` clause to aggregate data by runner.
2. **Calculate the number of successful deliveries using a `CASE` statement**:
   - Use `SUM(CASE WHEN cancellation IS NULL THEN 1 ELSE 0 END)` to count successful deliveries.
3. **Calculate the total number of orders for each runner**:
   - Use `COUNT(*)` to get the total number of orders.
4. **Calculate the percentage of successful deliveries**:
   - Use the formula `ROUND(SUM(...) * 100.0 / COUNT(*), 2)` to calculate the percentage.

**SQL Functions Used:**
- `SUM()`
- `CASE`
- `COUNT()`
- `ROUND()`
- `GROUP BY`

---

This README provides a detailed overview of the problem statements and the SQL functions and steps required to address each question in the Pizza Runner analysis project. By following these steps and utilizing the appropriate SQL functions, we can gain valuable insights into various aspects of the delivery service.
