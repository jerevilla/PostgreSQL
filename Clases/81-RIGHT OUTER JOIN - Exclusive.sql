

SELECT a.name as country, a.continent as code, b.name as continent
FROM
country a RIGHT JOIN continent b
ON a.continent = b.code
WHERE a.continent IS NULL;