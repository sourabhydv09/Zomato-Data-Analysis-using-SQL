# Zomato Data Analysis using SQL

![](https://images.app.goo.gl/TvEbaZNpoDqYB2xh7)

# Overview

This project uses SQL to analyze Zomato's sales and user data comprehensively. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

# Schema

```sql
CREATE TABLE goldusers_signup(userid integer,gold_signup_date date);

CREATE TABLE users(userid integer,signup_date date);

CREATE TABLE sales(userid integer,created_date date,product_id integer);

CREATE TABLE product(product_id integer,product_name text,price integer);
```

## Business Problems and Solutions

### 1. What is the total amount each customer spent on Zomato?

```sql
select s.userid, sum(p.price) total_amount_spent from sales s inner join product p 
on s.product_id = p.product_id
group by s.userid
```
### 2. How many days has each customer visited Zomato?

```sql
select userid, count(distinct created_date) total_days
from sales group by userid
```
### 3. What is the first product purchased by each customer?

```sql
with cte as 
(Select *, rank() over(partition by userid order by created_date) rnk from sales)
select * from cte 
where rnk = 1
```
### 4. What is the most purchased item on the menu and how many times was it purchased?

```sql
select userid, count(product_id) from sales where product_id =  (select product_id from sales
group by product_id
limit 1 ) group by userid
```
### 5. which item was the most popular for each customer?

```sql
with cte as (select *, rank() over(partition by userid order by ct desc) rnk from
(select userid, product_id, count(product_id) ct from sales group by userid, product_id) a)

select * from cte 
where rnk = 1
```

## Findings and Conclusion 

- **Profit Estimation:** The dataset contains the amount spent by each customer.
- **Famous Item:** Insights into most items provide an understanding of the Zomatos target audience.
- **Regular Use:** The regular customers and the average amount spend by them can tell us the popularity gain of Zomato.
  
This analysis provides a comprehensive view of Zomato's Sales and can help inform content strategy and decision-making.
