
(SELECT count(*) as count, b.name from country a
FULL OUTER JOIN continent b on a.continent = b.code
GROUP BY b.name)
union
(SELECT 0 as count, b.name from country a
RIGHT JOIN continent b on a.continent = b.code
WHERE a.continent is null
GROUP BY b.name)
ORDER by count;