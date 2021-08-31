-- 1. Select * all values from the table;
SELECT * FROM actor;

-- Select distinct values from the table;

SELECT DISTINCT rating FROM film;
SELECT DISTINCT rental_duration FROM film; 
SELECT DISTINCT first_name FROM actor;

-- 2. Use “=“ “>” “<“ “>=“ “<=“ “<>” “between” (number and dates); 
-- BETWEEN 'year/month/date' AND BETWEEN 'year/month/date'

SELECT first_name FROM actor WHERE first_name ='Ed';
SELECT DISTINCT rental_date FROM rental; 
SELECT rental_date FROM rental WHERE rental_date BETWEEN '2005/05/24' AND '2005/06/15';

-- 3. Use “IN” “LIKE”/'NOT LIKE' (text) 
--- Use IN allows us to check if an item is in a list; Always use ' ';

SELECT country from country;
SELECT 
country_id,
country
FROM country 
WHERE  country IN ('Canada','China', 'Finland','France'); 

SELECT customer_id, payment_date, amount
FROM payment
WHERE amount>2.99; 

SELECT customer_id, payment_date, amount
FROM payment
WHERE payment_date>='2005/06/24'; 

SELECT payment_date, amount
FROM payment
WHERE payment_date>='2005/06/24' AND amount>'2.99'; 

SELECT customer_id, payment_date, amount
FROM payment
WHERE payment_date>='2005/06/24' OR amount>'2.99'; 

-- 4. Use 'Character%' to show the first character in the name
-- E.g 'T%': 'TIM', 'TOM', 'THORA', 'TEMPLE'
SELECT
first_name,
last_name
FROM actor
WHERE first_name like 'T%'; 

-- Use '%Character' to show the last character in the name
-- 'ANGELA', 'ANGELINA', 'BELA'
SELECT
first_name,
last_name
FROM actor
WHERE first_name like '%A'; 
-- 
-- Use '%Character%' to show the character somewhere in the name (maybe first/middle/last). For example, wants to know how many people are using Amazon transaction.  WHERE merchant_name like 'amazon%' OR merchant_name 'amzn%';

SELECT
first_name,
last_name
FROM actor
WHERE first_name like '%A%'; 

SELECT *
FROM customer
WHERE first_name like 'A%'; 

SELECT *
FROM customer
WHERE first_name not like 'A%'and last_name not like 'A%';

-- 5. ORDER BY (optional) column (2) [ASC/DESC] appears at a very end of the statement
-- SELECT column (1), column (2)....column (n)
-- FROM table_name
-- WHERE column (1)='value x' AND column (2)='value y' 
-- ORDER BY column (2) [ASC/DESC] ASC - low to highl DESC - high to low

SELECT payment_id, customer_id, payment_date, amount
FROM payment
WHERE payment_date>='2005/06/24'
ORDER BY amount ASC; 

-- Option 1
SELECT payment_id, customer_id, payment_date, amount
FROM payment
WHERE payment_date>='2005/06/24'
ORDER BY amount DESC;

SELECT
first_name,
last_name
FROM actor
ORDER BY first_name ASC;

SELECT
customer_id,
rental_id,
amount,
payment_date
FROM payment
WHERE payment_date>'2006-01-01'
ORDER BY amount DESC;

SELECT
customer_id,
rental_id,
amount,
payment_date
FROM payment
WHERE customer_id <='100'
ORDER BY amount ASC;

SELECT
customer_id,
rental_id,
amount,
payment_date
FROM payment
WHERE payment_date>'2006-01-01' AND amount='0.99'
ORDER BY amount DESC;

-- AGGREGATING DATA (SUM, AVG, COUNT, MAX, MIN)
-- 1.GROUP BY statement: group column values together using aggregate functions after SELECT WHERE FROM but before ORDER BY (i.e HOW MANY SALES DID EACH SALESPERSON DO LAST YEAR?)
-- SELECT column (1), column (2)....column (n)
-- FROM table_name
-- WHERE column (1)='value x' AND column (2)='value y' 
-- GROUP BY column (1) 
-- ORDER BY column (2) [ASC/DESC] ASC - low to highl DESC - high to low

-- E.g HOW MANY SALES DID EACH SALESPERSON DO LAST YEAR? Count the number of transactions (payment_id) + total sales that each saleperson was responsible and then group by staff id
SELECT
staff_id,
COUNT(payment_id) as 'Total Transaction',
SUM(amount) as 'Total Sales Amount',
AVG(amount) as 'Average Sales Amount'
FROM payment
GROUP BY staff_id;

SELECT
staff_id,
AVG(amount) as 'Average Sales Amount'
FROM payment
GROUP BY staff_id;

SELECT
rental_duration as 'Rental Duraction',
COUNT(film_id) as '# of Movies'
FROM film
GROUP BY rental_duration
ORDER BY rental_duration DESC;
 
SELECT
rating,
COUNT(film_id) as '# of Movies',
MIN(rental_rate),
MAX(rental_rate),
AVG(rental_rate)
FROM film
GROUP BY rating;

-- 2. HAVING command (similar to where) filters out the individual rows of data based on AGGREGATE FUNCTIONS. The WHERE command filters out the individual rows of data based on COLUMN VALUES.
-- HAVING command is used AFTER the GROUP BY command but BEFORE the ORDER BY command
-- SELECT column (1), column (2)....column (n)
-- FROM table_name
-- WHERE column (1)='value x' AND column (2)='value y' 
-- GROUP BY column (1) 
-- HAVING SUM(colum(2))>'value z'
-- ORDER BY column (2) [ASC/DESC] ASC - low to highl DESC - high to low

SELECT
rating,
COUNT(film_id) as '# of Movies',
MIN(rental_rate),
MAX(rental_rate),
AVG(rental_rate)
FROM film
GROUP BY rating
HAVING AVG(rental_rate)>3;

SELECT 
customer_id as 'Customer ID',
COUNT(rental_id) as 'Total rentals'
FROM payment
GROUP BY customer_id
HAVING COUNT(rental_id)>=25
ORDER BY count(rental_id) DESC;

SELECT 
customer_id as 'Customer ID',
COUNT(customer_id) as 'Number of transactions'
FROM payment
GROUP BY customer_id
HAVING COUNT(payment_id)>=25
ORDER BY count(payment_id) DESC;


SELECT 
customer_id as 'Customer ID',
COUNT(rental_id) as 'Total rentals',
SUM(Amount) as 'Total revenues'
FROM payment
GROUP BY customer_id
HAVING SUM(Amount)>=100
ORDER BY SUM(Amount) DESC; 


SELECT 
customer_id as 'Customer ID',
COUNT(rental_id) as 'Total rentals',
SUM(Amount) as 'Total revenues'
FROM payment
GROUP BY customer_id
HAVING SUM(Amount)>=100 AND COUNT(rental_id)>=25
ORDER BY SUM(Amount) DESC;

-- 3.SQL JOINS: 
-- LEFT JOIN (Vlookup/Index Match in Excel): return all records from the left table A and the matched records from the table B
-- INNER JOINs only retrieve values where the matching key exists in both tables - Select the records that have matching values from both tables (less results than LEFT JOIN)
-- JOIN (mean default INNTER JOIN)
-- FOREIGN KEY is the primary key of a different table 
-- Create a calling list for outbound marketing campaign - Need first name, last name, phone numbers how to join values from diffeent tables
-- INNER JOIN: the table we join the values. E.g. address table has address_id
-- on: matching values from two tables e.g. on customer.address_id=address.address_id (from customer table and address table);
-- INNER JOIN + ON: used after FROM and before 'WHERE';

SELECT 
a.first_name as 'First Name',
a.last_name as 'Last Name',
b.phone as 'Phone Number'
FROM customer as a
INNER JOIN address as b
on a.address_id=b.address_id;

SELECT 
a.first_name as 'First Name',
a.last_name as 'Last Name',
b.phone as 'Phone Number'
FROM customer as a
INNER JOIN address as b
on a.address_id=b.address_id;

-- Retrieve all distinct titles and their description from store 2;
SELECT DISTINCT
a.title as 'Movie Title',
a.description as 'Movie Description',
b.store_id as 'Store ID' 
FROM film as a
INNER JOIN inventory as b 
on a.film_id=b.film_id
HAVING b.store_id =2;

-- Find the title and how many actors acted in each movie. Sort by the highest number of actors to lowest in DESC order 
SELECT
a.title as 'Movie Title',
COUNT(b.actor_id) as 'Number of actors'
FROM film as a
LEFT JOIN film_actor as b 
on a.film_id=b.film_id
GROUP BY a.title 
ORDER BY COUNT(b.actor_id) DESC; 

SELECT
a.title as 'Movie Title',
COUNT(b.actor_id) as 'Number of actors'
FROM film as a
JOIN film_actor as b 
on a.film_id=b.film_id
GROUP BY a.title 
ORDER BY COUNT(b.actor_id) DESC; 

-- Retrieve the title from the film table and the category from the category table;
SELECT 
a.title as 'Movie Title',
c.name as 'Movie Category'
FROM film as a
LEFT JOIN film_category as b
on a.film_id=b.film_id
LEFT JOIN category as c
on b.category_id=c.category_id;

-- Send the holiday cards to 10 most profitable customers. Create a mail list of 10 customers: first+last name, address, city, pronvince, postal code, country and email;
-- USE LIMIT function to limite the number of data shown up.
CREATE VIEW top_10_profitable_customers as 
SELECT
a.customer_id as 'CUSTOMER ID',
a.first_name as 'FIRST NAME',
a.last_name as 'LAST NAME',
c.address as 'ADDRESS',
d.city as 'CITY',
c.district as 'PROVINCE',
c.postal_code as 'POSTAL CODE',
e.country as 'COUNTRY',
a.email as 'EMAIL',
SUM(b.amount) as 'Total revenues'
FROM customer as a 
LEFT JOIN payment as b
on a.customer_id=b.customer_id
LEFT JOIN address as c
on a.address_id=c.address_id
LEFT JOIN city as d
on c.city_id=d.city_id
LEFT JOIN country as e
on d.country_id=e.country_id
GROUP BY a.customer_id 
ORDER BY SUM(b.amount) DESC
LIMIT 10;

-- CREATE VIEW view_name as ... and type in your regular queries that you want to use as a view. Use VIEW to simplify your queries. For example, if you find you constantly join the same few tables together, you can create a view so that for future queries, you just query views rather than joining mutiple tables together.
-- E.g Create a view that joins all the customer tables together;

CREATE VIEW customer_details as 
SELECT
a.customer_id as 'CUSTOMER ID',
a.first_name as 'FIRST NAME',
a.last_name as 'LAST NAME',
c.address as 'ADDRESS',
d.city as 'CITY',
c.district as 'PROVINCE',
c.postal_code as 'POSTAL CODE',
e.country as 'COUNTRY',
a.email as 'EMAIL',
c.phone as 'PHONE NUMBER'
FROM customer as a 
LEFT JOIN payment as b
on a.customer_id=b.customer_id
LEFT JOIN address as c
on a.address_id=c.address_id
LEFT JOIN city as d
on c.city_id=d.city_id
LEFT JOIN country as e
on d.country_id=e.country_id
GROUP BY a.customer_id 
ORDER BY SUM(b.amount) DESC
LIMIT 10;

-- WINDOW function: OVER/PARTITION BY clause are 'Window' functions. Used to perform calculations on a subset of your data.
-- OVER clause: used after an aggregation clause (su dung may phep tinh) and BEFORE a PARTITION BY Clause 
-- SELECT column (1), SUM(column (2)OVER PATRITION BY column 1;
-- How much does each customer spend?;
SELECT
customer_id as 'Customer ID',
payment_id as ' Payment ID',
payment_date as 'Payment Date',
SUM(amount) OVER (PARTITION BY customer_id) as 'Total Spent'
FROM payment;
-- FIND total amount spent by each customers but also ensured all the details for each individual transaction are still displayed 
SELECT *,
SUM(amount) OVER (PARTITION BY customer_id) as 'Total Spent'
FROM payment;
-- Show the average amoung spent by each customer
SELECT *,
SUM(amount) OVER (PARTITION BY customer_id) as 'Total Spent',
AVG(amount) OVER (PARTITION BY customer_id) as 'Average Spent'
FROM payment;
-- show what percentage represents as % of the customer's total spending
SELECT *,
SUM(amount) OVER (PARTITION BY customer_id) as 'Total Spent',
AVG(amount) OVER (PARTITION BY customer_id) as 'Average Spent',
amount/SUM(amount) OVER (PARTITION BY customer_id) as '% of Total Spending',
amount/AVG(amount) OVER (PARTITION BY customer_id) as '% of Average Spending'
FROM payment;











