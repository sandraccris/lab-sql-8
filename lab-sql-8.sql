-- Lab | SQL Queries 8

-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

USE sakila;

SELECT title, length, DENSE_RANK() OVER (ORDER BY length DESC) AS 'ranking' 
FROM film
WHERE length > 0;


-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.

SELECT title, length, rating, DENSE_RANK() OVER (ORDER BY length DESC) AS 'ranking' 
FROM film
WHERE length > 0
ORDER BY rating;


-- 3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".

SELECT count(f.film_id) as total_films, cat.category_id, cat.name
FROM category as cat
INNER JOIN film_category as f
ON f.category_id = cat.category_id
GROUP BY category_id;


-- 4.Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

SELECT a.first_name, a.last_name, a.actor_id, count(f.film_id)
FROM actor AS a
INNER JOIN film_actor as f
ON a.actor_id = f.actor_id
GROUP BY actor_id
ORDER BY count(f.film_id) DESC;

-- Gina Degeneres is the actor that appears in most films: 42 times.


-- 5. Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

SELECT c.first_name, c.last_name, c.customer_id, count(r.rental_id) as total_rentings
FROM customer as c
INNER JOIN rental as r
ON c.customer_id = r.customer_id
GROUP BY customer_id
ORDER BY total_rentings DESC;

-- Eleanor Hunt as rented the most number of films, 46 times.


-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).


SELECT f.title, count(r.rental_id) as total_rentings
FROM film as f
INNER JOIN inventory as i
ON f.film_id = i.film_id
INNER JOIN rental as r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY total_rentings DESC;

-- The most rented film is 'BUCKET BROTHERHOOD' with 34 rentings in total.