select * from continent where code in (4, 6,8);

SELECT code, name FROM continent where name like '% America'
union
SELECT code, name FROM continent where code in (3,5)
order by name asc;