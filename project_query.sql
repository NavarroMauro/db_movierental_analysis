/*QUESTION SET 1*/
/*Question 1.1
We want to understand more about the movies that families are watching. The following categories are considered family movies: Animation, Children, Classics, Comedy, Family and Music.
Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out.*/
SELECT   f.title, 
         c.name, 
         COUNT(r.rental_id)
FROM     film_category fc
JOIN     category c ON c.category_id = fc.category_id
JOIN     film f ON f.film_id = fc.film_id
JOIN     inventory i ON i.film_id = f.film_id
JOIN     rental r ON r.inventory_id = i.inventory_id
WHERE    c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
GROUP BY 1, 2
ORDER BY 2, 1;

/*Question 1.2
Now we need to know how the length of rental duration of these family-friendly movies compares to the duration that all movies are rented for. Can you provide a table with the movie titles and divide them into 4 levels (first_quarter, second_quarter, third_quarter, and final_quarter) based on the quartiles (25%, 50%, 75%) of the rental duration for movies across all categories? Make sure to also indicate the category that these family-friendly movies fall into.*/
SELECT   f.title, 
         c.name, 
         f.rental_duration, 
         NTILE(4) OVER (ORDER BY f.rental_duration) AS standard_quartile
FROM     film_category fc
JOIN     category c ON c.category_id = fc.category_id
JOIN     film f ON f.film_id = fc.film_id
WHERE    c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
ORDER BY 3;

/*QUESTION SET 2*/
/* Question 2.1 
We want to find out how the two stores compare in their count of rental orders during every month for all the years we have data for. 
Write a query that returns the store ID for the store, the year and month and the number of rental orders each store has fulfilled for that month. Your table should include a column for each of the following: year, month, store ID and count of rental orders fulfilled during that month.
 */
SELECT   EXTRACT('month' FROM r.rental_date) AS rental_month,
         EXTRACT('year' FROM r.rental_date) AS rental_year,
         s.store_id,
         COUNT(r.rental_id) AS count_rentals
FROM     rental r
JOIN     store s ON s.manager_staff_id = r.staff_id
GROUP BY 1, 2, 3
ORDER BY 4, 1 DESC;

/*Question 2.2
We would like to know who were our top 10 paying customers, how many payments they made on a monthly basis during 2007, and what was the amount of the monthly payments.
Can you write a query to capture the customer name, month and year of payment, and total payment amount for each month by these top 10 paying customers?
 */
SELECT            EXTRACT('month' FROM p.payment_date) AS pay_month,
                  c.first_name || ' ' || c.last_name AS full_name,
                  COUNT(p.amount) AS pay_count_per_mon,
                  SUM(p.amount) AS pay_amount
FROM              customer c
JOIN              payment p ON p.customer_id = c.customer_id
WHERE             c.first_name || ' ' || c.last_name IN (
   SELECT         sq.full_name
      FROM  (
         SELECT   c.first_name || ' ' || c.last_name AS full_name,
                  SUM(p.amount) AS amount_total
         FROM     customer c
         JOIN     payment p ON p.customer_id = c.customer_id
         GROUP BY 1
         ORDER BY 2 DESC
         LIMIT    10
      )  sq
)  AND   (
                  p.payment_date BETWEEN '2007-01-01' AND '2008-01-01'
   )
GROUP BY          2, 1
ORDER BY          2, 1, 3 DESC;
