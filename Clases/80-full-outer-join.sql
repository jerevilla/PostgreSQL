--country a 	-name, continent (codigo numerico)
--continent b 	-name 

SELECT a.name as country, a.continent as code, b.name as continent
FROM
country a FULL OUTER JOIN continent b
ON a.continent = b.code
ORDER BY a.name DESC;