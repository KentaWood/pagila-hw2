/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */
SELECT
    RANK() OVER (ORDER BY revenueCalc.revenue DESC) AS rank,
    revenueCalc.title,
    revenueCalc.revenue,
    SUM(revenueCalc.revenue) OVER (ORDER BY revenueCalc.revenue DESC) AS "total revenue",
    to_char(
        100.0 * SUM(revenueCalc.revenue) OVER (ORDER BY revenueCalc.revenue DESC) / SUM(revenueCalc.revenue) OVER (),
        'FM9999999900.00'
    ) AS "percent revenue"
FROM (
    SELECT
        f.title,
        COALESCE(SUM(p.amount), 0.00) AS revenue
    FROM
        film f
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY f.title
) AS revenueCalc
ORDER BY revenueCalc.revenue DESC, revenueCalc.title ASC;

