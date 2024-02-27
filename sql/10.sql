/*
 * Management is planning on purchasing new inventory.
 * Films with special features cost more to purchase than films without special features,
 * and so management wants to know if the addition of special features impacts revenue from movies.
 *
 * Write a query that for each special_feature, calculates the total profit of all movies rented with that special feature.
 *
 * HINT:
 * Start with the query you created in pagila-hw1 problem 16, but add the special_features column to the output.
 * Use this query as a subquery in a select statement similar to answer to the previous problem.
 */
SELECT
    feature.special_feature,
    SUM(p.amount) AS profit
FROM
    (
        SELECT
            f.film_id,
            UNNEST(f.special_features) AS special_feature
        FROM
            film f
    ) AS feature
INNER JOIN
    inventory i ON i.film_id = feature.film_id
INNER JOIN
    rental r ON r.inventory_id = i.inventory_id
INNER JOIN
    payment p ON p.rental_id = r.rental_id
GROUP BY
    feature.special_feature
ORDER BY
    feature.special_feature;

