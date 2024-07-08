# Danny's Diner - Customer Behavior Analysis

![img](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/6bb0c6ad-4aff-49aa-8f35-ab6339669390)

**Dataset Link:** [Danny's Diner](https://8weeksqlchallenge.com/case-study-1/)

**IDE:** BigQuery 

1. **Total Amount Each Customer Spent at the Restaurant**

   - **Problem Statement:** Calculate the total amount each customer has spent at Danny's Diner.
   - **Business Purpose:** Understanding customer spending behavior helps design personalized marketing strategies and loyalty programs, identify high-value customers, and tailor offers to enhance their experience and retention.
   - **SQL Functions and Steps:**
     - **SUM()**: Calculate the total spend per customer.
     - **JOIN**: Combine sales and menu tables to get the price information.
     - **GROUP BY**: Aggregate the spend data by customer ID.
     - **Explanation**: 
       1. **Join Tables**: Join the sales and menu tables to access product prices.
       2. **Aggregation**: Use SUM() to calculate the total spend for each customer.

![sql_1](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/7b341f68-0e3f-45b2-999c-0232fb758ab1)

2. **Number of Days Each Customer Visited the Restaurant**

   - **Problem Statement:** Determine the number of days each customer visited Danny's Diner.
   - **Business Purpose:** Analyzing visit frequency helps in understanding customer loyalty and visit patterns, which can inform targeted promotions to increase visit frequency.
   - **SQL Functions and Steps:**
     - **COUNT(DISTINCT)**: Count unique visit days per customer.
     - **GROUP BY**: Aggregate the visit data by customer ID.
     - **Explanation**: 
       1. **Count Unique Days**: Use COUNT(DISTINCT) to determine the number of unique days each customer visited.
       2. **Group by Customer**: Aggregate this data by customer ID.

![sql_2](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/10248491-457e-48e7-b160-e5cc528f0f54)

3. **First Item Purchased by Each Customer**

   - **Problem Statement:** Identify the first item each customer purchased.
   - **Business Purpose:** Knowing the first purchase can help in understanding initial customer preferences and designing onboarding offers or promotions.
   - **SQL Functions and Steps:**
     - **ROW_NUMBER()**: Assign a rank to each purchase by date for each customer.
     - **JOIN**: Combine sales and menu tables to get product information.
     - **ORDER BY**: Order the purchases by date.
     - **Explanation**: 
       1. **Rank Purchases**: Use ROW_NUMBER() to rank purchases by date for each customer.
       2. **Filter First Purchase**: Select the item with the first rank for each customer.

![sql_3](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/165cd845-db47-40fd-9e01-f2c020579091)

4. **Most Purchased Item on the Menu**

   - **Problem Statement:** Determine the most purchased item on the menu and the total number of times it was purchased.
   - **Business Purpose:** Identifying popular items helps in menu optimization and stock management.
   - **SQL Functions and Steps:**
     - **COUNT()**: Count the number of purchases for each item.
     - **RANK()**: Rank items by their purchase count.
     - **GROUP BY**: Group purchase data by item.
     - **Explanation**: 
       1. **Count Purchases**: Use COUNT() to determine the number of times each item was purchased.
       2. **Rank Items**: Use RANK() to identify the most purchased item.

![sql_4](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/6607831c-686b-4727-ace2-689f63ffeb59)

5. **Most Popular Item for Each Customer**

   - **Problem Statement:** Find the most popular item for each customer.
   - **Business Purpose:** Understanding individual preferences allows for personalized recommendations and targeted marketing.
   - **SQL Functions and Steps:**
     - **COUNT()**: Count the number of times each item was purchased by each customer.
     - **RANK()**: Rank items by their purchase count for each customer.
     - **GROUP BY**: Group purchase data by customer and item.
     - **Explanation**: 
       1. **Count Purchases**: Use COUNT() to determine how many times each item was purchased by each customer.
       2. **Rank Items**: Use RANK() to identify the most popular item for each customer.

![sql_5](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/4a4ef01f-51f6-45a4-9113-c620205cc3fc)

6. **First Item Purchased After Becoming a Member**

   - **Problem Statement:** Identify the first item purchased by each customer after they became a member.
   - **Business Purpose:** This insight helps in understanding the impact of membership on purchase behavior and preferences.
   - **SQL Functions and Steps:**
     - **RANK()**: Assign a rank to each purchase by date after membership.
     - **JOIN**: Combine sales, menu, and membership tables to get necessary information.
     - **FILTER**: Filter purchases to include only those after membership date.
     - **Explanation**: 
       1. **Rank Purchases**: Use RANK() to rank purchases by date after becoming a member.
       2. **Filter First Purchase**: Select the item with the first rank after membership.

![sql_6](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/447041e1-7edb-407b-b19b-077f03cf67bf)

7. **Last Item Purchased Before Becoming a Member**

   - **Problem Statement:** Identify the last item purchased by each customer before they became a member.
   - **Business Purpose:** This insight helps in understanding pre-membership behavior and designing pre-membership incentives.
   - **SQL Functions and Steps:**
     - **RANK()**: Assign a rank to each purchase by date before membership.
     - **JOIN**: Combine sales, menu, and membership tables to get necessary information.
     - **FILTER**: Filter purchases to include only those before membership date.
     - **Explanation**: 
       1. **Rank Purchases**: Use RANK() to rank purchases by date before becoming a member.
       2. **Filter Last Purchase**: Select the item with the first rank before membership.

![sql_7](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/1afbe555-28d8-4f70-9ce6-49f491da5e91)

8. **Total Items and Amount Spent Before Becoming a Member**

   - **Problem Statement:** Calculate the total number of items and the total amount spent by each customer before they became a member.
   - **Business Purpose:** Understanding pre-membership spending helps in assessing the potential value of non-members and designing targeted membership incentives.
   - **SQL Functions and Steps:**
     - **COUNT()**: Count the total number of items purchased.
     - **SUM()**: Calculate the total amount spent.
     - **JOIN**: Combine sales, menu, and membership tables to get necessary information.
     - **FILTER**: Filter purchases to include only those before membership date.
     - **Explanation**: 
       1. **Count Items**: Use COUNT() to determine the total number of items purchased.
       2. **Sum Amount**: Use SUM() to calculate the total amount spent.
       3. **Filter Purchases**: Include only purchases before the membership date.

![sql_8](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/aaf875bd-f660-4cfe-a646-adb00cbfb87a)

9. **Points Earned by Each Customer**

   - **Problem Statement:** Calculate the total points earned by each customer, considering a $1 spend equates to 10 points and sushi has a 2x points multiplier.
   - **Business Purpose:** This insight helps in understanding the effectiveness of the points system and customer engagement.
   - **SQL Functions and Steps:**
     - **SUM()**: Calculate the total points based on spend and item type.
     - **JOIN**: Combine sales and menu tables to get necessary information.
     - **CASE**: Apply different point multipliers based on item type.
     - **Explanation**: 
       1. **Calculate Points**: Use SUM() and CASE to calculate points earned based on spend and item type.

![sql_9](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/d2b67077-db90-48b6-bf45-5007ceeba504)

10. **Points Earned by Members**

    - **Problem Statement:** Calculate the total points earned by customers A and B in the first week after joining the program, with a 2x points multiplier on all items.
    - **Business Purpose:** This insight helps in evaluating the impact of the membership program on customer engagement and spending.
    - **SQL Functions and Steps:**
      - **SUM()**: Calculate the total points based on spend, item type, and membership status.
      - **JOIN**: Combine sales, menu, and membership tables to get necessary information.
      - **CASE**: Apply different point multipliers based on item type and membership status.
      - **Explanation**: 
        1. **Calculate Points**: Use SUM() and CASE to calculate points earned based on spend, item type, and membership status.
        2. **Filter Membership Period**: Include only purchases in the first week after membership.

![sql_10](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/ef6da51d-4924-441b-a6bb-d5ae017aac50)

---

### Bonus Questions

1. **Join All The Things**

   - **Problem Statement:** Recreate a table showing customer orders, product names, prices, and membership status.
   - **Business Purpose:** Creating a comprehensive view of customer transactions helps in quick insights and decision-making.
   - **SQL Functions and Steps:**
     - **JOIN**: Combine sales, menu, and membership tables.
     - **CASE**: Determine membership status based on order date.
     - **Explanation**: 
       1. **Join Tables**: Combine sales, menu, and membership tables to get necessary information.
       2. **Determine Membership**: Use CASE to determine if the order was made by a member.

![sql_11](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/02153547-cb1d-4761-9acb-0030f45d081c)

2. **Rank All The Things**

   - **Problem Statement:** Rank products purchased by customers who are members, and return null for non-member purchases.
   - **Business Purpose:** Understanding product preferences among members helps in targeted promotions and inventory management.
   - **SQL Functions and Steps:**
     - **RANK()**: Rank products based on purchase order date for members.
     - **JOIN**: Combine sales, menu, and membership tables.
     - **CASE**: Determine membership status and apply ranking only to members.
     - **Explanation**: 
       1. **Rank Products**: Use RANK() to rank products based on purchase date for members.
       2. **Handle Non-Members**: Return null for non-member purchases.

![sql_12](https://github.com/aishwaryaSudhakar01/8-Week-SQL-Challenge/assets/126569607/e1d3023e-f35b-40ac-9859-44a9c132496c)
