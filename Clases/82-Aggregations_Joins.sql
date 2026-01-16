
SELECT count(*) as cantidad, continent from country
GROUP BY continent
ORDER BY continent asc;

--ejercicio

SELECT count(*) as cantidad, b.name as continent
FROM
country a INNER JOIN continent b
ON a.continent = b.code
GROUP by b.name
ORDER BY count(*) asc;