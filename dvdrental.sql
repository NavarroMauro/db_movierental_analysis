/*
 INVESTIGATE RELATIONAL DATABASE
 */
SELECT *
FROM film;

SELECT *
FROM Actor;

SELECT *
FROM Rental;

SELECT *
FROM City;

SELECT *
FROM Country;

/*
 Practice Quiz #1 - 1 of 3
 
 Let's start with creating a table that provides the following details: actor's first and last name combined as full_name, film title, film description and length of the movie
 */
SELECT a.first_name || ' ' || a.last_name AS full_name,
       f.title,
       f.length,
       f.description
FROM   film_actor fa
       JOIN actor a ON fa.actor_id = a.actor_id
       JOIN film f ON f.film_id = fa.film_id;

/*How many rows are there in the table?*/
SELECT COUNT(*)
FROM   film_actor fa
       JOIN actor a ON fa.actor_id = a.actor_id
       JOIN film f ON f.film_id = fa.film_id;

/*
 Practice Quiz #1 - 2 of 3
 
 Write a query that creates a list of actors and movies where the movie length was more than 60 minutes.
 */
SELECT a.first_name || ' ' || a.last_name AS full_name,
       f.title,
       f.length
FROM   film_actor fa
       JOIN actor a ON fa.actor_id = a.actor_id
       JOIN film f ON f.film_id = fa.film_id
WHERE  f.length > 60;

/*How many rows are there in this query result?*/
SELECT COUNT(*)
FROM   film_actor fa
       JOIN actor a ON fa.actor_id = a.actor_id
       JOIN film f ON f.film_id = fa.film_id
WHERE  f.length > 60;

/*
 Practice Quiz #1 - 3 of 3
 
 Write a query that captures the actor id, full name of the actor, and counts the number of movies each actor has made. (HINT: Think about whether you should group by actor id or the full name of the actor.) Identify the actor who has made the maximum number movies.
 */
SELECT actor_id,
       full_name,
       COUNT(filmtitle) film_count_peractor
FROM   (
       SELECT a.actor_id actor_id,
              a.first_name,
              a.last_name,
              a.first_name || ' ' || a.last_name AS full_name,
              f.title filmtitle
       FROM   film_actor fa
       JOIN   actor a ON fa.actor_id = a.actor_id
       JOIN   film f ON f.film_id = fa.film_id
       )      t1
GROUP BY      1, 2
ORDER BY      3 DESC
LIMIT         1;

/*
 Practice Quiz #2 - 1 of 2
 
 Write a query that displays a table with 4 columns: actor's full name, film title, length of movie, and a column name "filmlen_groups" that classifies movies based on their length. Filmlen_groups should include 4 categories: 1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours. Match the filmlen_groups with the movie titles in your result dataset.
 */
SELECT full_name,
       filmtitle,
       filmlen,
       CASE
              WHEN filmlen <= 60 THEN '1 hour or less'
              WHEN filmlen > 60
              AND filmlen <= 120 THEN 'Between 1-2 hours'
              WHEN filmlen > 120
              AND filmlen <= 180 THEN 'Between 2-3 hours'
              ELSE 'More than 3 hours'
       END AS filmlen_groups
FROM   (
       SELECT a.first_name || ' ' || a.last_name AS full_name,
              f.title filmtitle,
              f.length filmlen
       FROM   film_actor fa
       JOIN actor a ON fa.actor_id = a.actor_id
       JOIN film f ON f.film_id = fa.film_id
       )      sq;

/*
 Practice Quiz #2 - 2 of 2
 
Now, we bring in the advanced SQL query concepts! Revise the query you wrote above to create a count of movies in each of the 4 filmlen_groups: 1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours.

Match the count of movies in each filmlen_group.
 */
SELECT
       DISTINCT(filmlen_groups),
       COUNT(title) OVER (PARTITION BY filmlen_groups) AS filmcount_bylencat
FROM
       (
              SELECT title,
                     length,
                     CASE
                            WHEN length <= 60 THEN '1 hour or less'
                            WHEN length > 60 AND length <= 120 THEN 'Between 1-2 hours'
                            WHEN length > 120 AND length <= 180 THEN 'Between 2-3 hours'
                            ELSE 'More than 3 hours'
                     END AS filmlen_groups
              FROM   film
       )      sq
ORDER BY      filmlen_groups;