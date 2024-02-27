/*
 * This problem is the same as 05.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
SELECT
    last_name, first_name
FROM
    actor
WHERE
    (first_name, last_name) NOT IN (
        SELECT
            first_name, last_name
        FROM
            customer
    )
ORDER BY
	actor.last_name, actor.first_name;
