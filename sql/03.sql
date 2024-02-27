/*
 * Management wants to send coupons to customers who have previously rented one of the top-5 most profitable movies.
 * Your task is to list these customers.
 *
 * HINT:
 * In problem 16 of pagila-hw1, you ordered the films by most profitable.
 * Modify this query so that it returns only the film_id of the top 5 most profitable films.
 * This will be your subquery.
 * 
 * Next, join the film, inventory, rental, and customer tables.
 * Use a where clause to restrict results to the subquery.
 */
SELECT DISTINCT c.customer_id
FROM customer c
INNER JOIN rental r ON r.customer_id = c.customer_id
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN film f ON f.film_id = i.film_id
INNER JOIN payment p ON p.rental_id = r.rental_id
INNER JOIN (
    SELECT
        f.film_id,
        SUM(p.amount) AS profit
    FROM
        film f
    INNER JOIN
        inventory i ON i.film_id = f.film_id
    INNER JOIN
        rental r ON r.inventory_id = i.inventory_id
    INNER JOIN
        payment p ON p.rental_id = r.rental_id
    GROUP BY
        f.film_id
    ORDER BY
        profit DESC
    LIMIT 5
) AS top_profitable_films ON top_profitable_films.film_id = f.film_id
ORDER BY
    c.customer_id ASC;

