

SELECT a.name as country, b.name as continent FROM country a, continent b
where a.continent = b.code
order by b.name;
