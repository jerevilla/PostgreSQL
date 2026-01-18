

-- Count Union - Tarea
-- Total |  Continent
-- 5	  | Antarctica
-- 28	  | Oceania
-- 46	  | Europe
-- 51	  | America
-- 51	  | Asia
-- 58	  | Africa


	
	(SELECT count(*) as total, b.name as continent FROM country a 
		inner join continent b 
	ON a.continent = b.code
	WHERE b.name not LIKE '%America'
	GROUP BY b.name)
	union
	(select count(*) as total, 'AMERICA' from country a
	inner join continent b 
	on a.continent = b.code
	where b.name LIKE '%America')
	order by total ASC;

-- 2 option
select * from continent;
	(SELECT count(*) as total, b.name as continent FROM country a 
		inner join continent b 
	ON a.continent = b.code
	WHERE b.code in (1,2,3,5,7)
	GROUP BY b.name)
	union
	(select count(*) as total, 'AMERICA' from country a
	inner join continent b 
	on a.continent = b.code
	where b.code in (4,6,8))
	order by total ASC;
	
--3 option

select * from continent;
	(SELECT count(*) as total, b.name as continent FROM country a 
		inner join continent b 
	ON a.continent = b.code
	WHERE b.code not in (4,6,8)
	GROUP BY b.name)
	union
	(select count(*) as total, 'AMERICA' from country a
	inner join continent b 
	on a.continent = b.code
	where b.code in (4,6,8))
	order by total ASC;