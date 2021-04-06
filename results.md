### INVESTIGATE RELATIONAL DATABASE*/ /* Question 1 of 3
## Let's start with creating a table that provides the following details: actor's first and last name combined as full_name, film title, film description and length of the movie. How many rows are there in the table?

```sql
SELECT a.first_name,
       a.last_name,
       a.first_name || ' ' || a.last_name AS full_name,
       f.title,
       f.length
FROM film_actor fa
JOIN actor a ON fa.actor_id = a.actor_id
JOIN film f ON f.film_id = fa.film_id;
```

### Question 2 of 3
## Write a query that creates a list of actors and movies where the movie length was more than 60 minutes. How many rows are there in this query result?

```sql
SELECT a.first_name,
       a.last_name,
       a.first_name || ' ' || a.last_name AS full_name,
       f.title,
       f.length
FROM film_actor fa
JOIN actor a ON fa.actor_id = a.actor_id
JOIN film f ON f.film_id = fa.film_id
WHERE f.length > 60;
```

### Question 3 of 3
## Write a query that captures the actor id, full name of the actor, and counts the number of movies each actor has made. (HINT: Think about whether you should group by actor id or the full name of the actor.) Identify the actor who has made the maximum number movies.

```sql
SELECT actorid,
       full_name,
       COUNT(filmtitle) film_count_peractor
FROM
    (SELECT a.actor_id actorid,
            a.first_name,
            a.last_name,
            a.first_name || ' ' || a.last_name AS full_name,
            f.title filmtitle
     FROM film_actor fa
     JOIN actor a ON fa.actor_id = a.actor_id
     JOIN film f ON f.film_id = fa.film_id) t1
GROUP BY 1,
         2
ORDER BY 3 DESC
limit 1;
```

### Question 1 of 2

## Write a query that displays a table with 4 columns: actor's full name, film title, length of movie, and a column name "filmlen_groups" that classifies movies based on their length. Filmlen_groups should include 4 categories: 1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours.

## Match the filmlen_groups with the movie titles in your result dataset.

```sql
SELECT full_name,
       film_title,
       length movie_duration,

FROM
    (
        SELECT a.first_name,
            a.last_name,
            a.first_name || ' ' || a.last_name AS full_name,
            f.title film_title
     FROM film_actor fa
     JOIN actor a ON fa.actor_id = a.actor_id
     JOIN film f ON f.film_id = fa.film_id
     ) t1
GROUP BY 1,
         2
ORDER BY 3 DESC
limit 1;
```
