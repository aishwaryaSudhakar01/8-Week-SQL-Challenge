# Pizza Runner Analysis (A) - Pizza Metrics

### Problem Statements and Steps

1. **Total Number of Pizza Orders**

   - **Problem Statement:** Calculate the total number of pizza orders.
   - **Steps:**
     - Use the **COUNT()** function to count all orders from the customer orders table.

  ![sql_2_1_1](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/77c1447e-01e0-414d-8c83-3b668ae4c9d5)

2. **Unique Orders Count**

   - **Problem Statement:** Calculate the number of unique orders.
   - **Steps:**
     - Use the **COUNT(DISTINCT)** function to count distinct order IDs from the customer orders table.

![sql_2_1_2](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/f5414f8e-85bb-406b-af6d-658245cce661)

3. **Successful Orders Delivered by Each Runner**

   - **Problem Statement:** Determine the number of successful deliveries made by each runner.
   - **Steps:**
     - Select the runner ID and use the **COUNT()** function to count orders where the cancellation is NULL.
     - Group by runner ID and order the results.

![sql_2_1_3](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/ab8dad9c-f169-4c1b-9f44-9a5cef42d04b)

4. **Count of Each Type of Pizza Delivered**

   - **Problem Statement:** Find the count of each type of pizza delivered.
   - **Steps:**
     - Join the customer orders table with the runner orders table and the pizza names table.
     - Count the pizzas where the cancellation is NULL.
     - Group by pizza name and order the results.

![sql_2_1_4](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/87758a85-98a6-4561-8bb5-7fa03452e99b)

5. **Count of Pizza Types Ordered by Each Customer**

   - **Problem Statement:** Find the count of vegetarian and meatlovers pizzas ordered by each customer.
   - **Steps:**
     - Join the customer orders table with the pizza names table.
     - Use **SUM(CASE)** statements to count vegetarian and meatlovers pizzas separately for each customer.
     - Group by customer ID and order the results.

![sql_2_1_5](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/0266cc73-b80c-4ba3-9fce-dff3808765b9)

6. **Maximum Count of Pizzas Delivered in a Single Order**

   - **Problem Statement:** Find the maximum count of pizzas delivered in a single order.
   - **Steps:**
     - Use a CTE (Common Table Expression) to count pizzas for each order.
     - Rank the results based on pizza count.
     - Select the top-ranked order.

![sql_2_1_6](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/57951faa-08d1-4137-865f-48c1680fae03)

7. **Count of Delivered Pizzas with and without Changes**

   - **Problem Statement:** Determine the count of delivered pizzas with and without changes.
   - **Steps:**
     - Join the customer orders table with the runner orders table.
     - Use **SUM(CASE)** statements to count pizzas with and without changes for each customer.
     - Group by customer ID.

![sql_2_1_7](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/55bb55ac-4e32-4f98-9ff2-7d9ba0b11146)

8. **Count of Pizzas with Both Exclusions and Extras**

   - **Problem Statement:** Find the count of pizzas with both exclusions and extras.
   - **Steps:**
     - Join the customer orders table with the runner orders table.
     - Use **SUM(CASE)** statements to count pizzas with both exclusions and extras where the cancellation is NULL.

![sql_2_1_8](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/531f7e84-8a29-4007-8982-0a2090359345)

9. **Total Volume of Pizzas Ordered for Each Hour of the Day**

   - **Problem Statement:** Determine the total volume of pizzas ordered for each hour of the day.
   - **Steps:**
     - Use the **EXTRACT(HOUR FROM order_time)** function to group orders by hour.
     - Count pizzas for each hour.

![sql_2_1_9](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/c4d4fdd8-9335-4cc4-8d95-4f503fd3c902)

10. **Volume of Orders for Each Day of the Week**

    - **Problem Statement:** Find the volume of orders for each day of the week.
    - **Steps:**
      - Use the **FORMAT_TIMESTAMP('%w', order_time)** function to group orders by day of the week.
      - Use the **FORMAT_TIMESTAMP('%A', order_time)** function to get the day names.
      - Count orders for each day and order the results by day number.

![sql_2_1_10](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/0feccff7-39b3-4924-87ce-af7595745b6b)

