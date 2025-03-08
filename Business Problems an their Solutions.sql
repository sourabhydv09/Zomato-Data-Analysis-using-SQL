-- 1  What is the total amount each customer spent on zomato?

select s.userid, sum(p.price) total_amount_spent
from sales s inner join product p 
on s.product_id = p.product_id
group by s.userid 

-- 2  How many days has each customer visited zomato?

select userid, count(distinct created_date) total_days
from sales group by userid

-- 3  What is the first product purchased by each customer?

with cte as 
(Select *, rank() over(partition by userid order by created_date) rnk from sales)
select * from cte 
where rnk = 1



-- 4  What is the most purchased item on the menu and how many times was it purchased?

select userid, count(product_id) 
from sales where product_id =  
(select product_id from sales
group by product_id
limit 1 ) 
group by userid


-- 5  Which item was the most popular for each customer?

with cte as 
(select *, rank() over(partition by userid order by ct desc) rnk from
(select userid, product_id, count(product_id) ct from sales group by userid, product_id) a)

select * from cte 
where rnk = 1
