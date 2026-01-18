
--quiero que se muestre el país con más ciudades
--campos: total de ciudades y el nombre del país 
--usar INNER JOIN


select  count(*) AS TOTAL, b.name  from city a
inner join country b 
on a.countrycode = b.code
GROUP BY b.name
ORDER BY total DESC
LIMIT 1;