-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.

select title 
from film f
where rating = 'R';

-- 3.Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.

select first_name , last_name 
from actor a 
where a.actor_id between 30 and 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.

select title 
from film f  
where language_id =original_language_id ;

-- 5. Ordena las películas por duración de forma ascendente.

select *
from film f 
order by length ;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.

select first_name , last_name 
from actor a 
where last_name = 'Allen;'

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.

select rating, count(*) as total_film 
from film f 
group by rating;

-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.

select title, 
rating as clasificacion,
length as duracion
from film f 
where rating = 'PG-13' or length > 180;

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

select round(variance(replacement_cost),2) as variabilidad 
from film f ;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

select min(length),
max(length) 
from film f;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select amount 
from payment p 
order by payment_date
limit 1 offset 2;

-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC- 17’ ni ‘G’ en cuanto a su clasificación.

select title, rating 
from film f 
where rating not in ('NC-17','G')

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

select rating , round(avg(length),2) as promedio_duracion
from film f 
group by rating ;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

select title , length 
from film f 
where length >180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?

select sum(amount) as total_vendido
from payment p ;

-- 16. Muestra los 10 clientes con mayor valor de id.

select customer_id , first_name , last_name 
from customer c
order by customer_id desc 
limit 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.

select first_name , last_name 
from actor a 
join film_actor fa on a.actor_id = fa.actor_id 
join film f on fa.film_id = f.film_id 
where f.title ='Egg Igby';

-- 18. Selecciona todos los nombres de las películas únicos.

select distinct title 
from film f ;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.

select f.title 
from film f 
join film_category fc on f.film_id =fc.film_id 
join category c on c.category_id = fc.category_id 
where c.name = 'Comedy'
	and f.length > 180;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoria junto con el promedio de duración.


select c.name as nombre_categoria, round(avg(f.length),2) as promedio_duracion
from category c 
join film_category fc on c.category_id =fc.category_id 
join film f on f.film_id = fc.film_id 
group by c.name
having round(avg(length),2) > 110;

--21. ¿Cuál es la media de duración del alquiler de las películas?


select avg(return_date-rental_date) as promedio_duracion_alquiler
from rental ;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices

select concat(first_name, ' ',last_name)
from actor a ;

-- 22 Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

select rental_date ::Date  as fecha_alquiler, count(*) as total_alquileres 
from rental r 
group by fecha_alquiler
order by total_alquileres;

-- 24. Encuentra las películas con una duración superior al promedio.

select title  , length 
from film 
where length > (select round(avg(length),2) from film f );

-- 25. Averigua el número de alquileres registrados por mes.

select 
extract (year from rental_date) as año,
extract	(month from rental_date) as mes,
count(*) as total_alquileres
from rental r 
group by año, mes
order by año desc , mes desc ;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

select 
round(avg(amount),2) as promedio,
round(stddev(amount),2) as desviacion_estandar,
round(variance(amount),2) as varianza
from payment p ;

-- 27. ¿Qué películas se alquilan por encima del precio medio?

select title , rental_rate 
from film
where rental_rate > (select round(avg(rental_rate),2) from film f);

-- 28.  Muestra el id de los actores que hayan participado en más de 40 películas.

select actor_id, count(*) as  total_peliculas 
from actor a 
group by actor_id 
having count(*)> 40
order by total_peliculas desc ;

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

select f.title as titulo,
count(i.inventory_id) as cantidad_disponible 
from film f 
left join inventory i on  i.film_id= f.film_id 
group by f.film_id , f.title 
order by cantidad_disponible desc ;

-- 30. Obtener los actores y el número de películas en las que ha actuado.

select concat(a.first_name , ' ',  a.last_name) as nombre_actor ,  count(fa.film_id) as total_peliculas 
from actor a 
join film_actor fa on a.actor_id = fa.actor_id 
group by nombre_actor
order by total_peliculas desc;

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

select f.title,  
coalesce (a.first_name, 'Sin actor') as nombre_actor,
coalesce (a.last_name, '') as apellido_actor
from film f
left join film_actor fa  on f.film_id = fa.film_id
left join actor a  on fa.actor_id = a.actor_id
order by f.title, a.first_name, a.last_name;

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

select a.first_name as nombre_actor, a.last_name as apellido_actor, coalesce (f.title, '') as titulo_pelicula
from actor a 
right join film_actor fa on fa.actor_id =a.actor_id 
right join film f on f.film_id =fa.film_id 
order by a.first_name, a.last_name , f.title ;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.

select f.title as titulo_pelicula,
f.film_id as numero_pelicula ,
r.rental_id as numero_alquiler ,
r.rental_date as fecha_alquiler
from film f 
full outer join inventory i on i.film_id =f.film_id 
full outer join rental r on i.inventory_id = r.inventory_id 
order by f.title , r.rental_date ;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

select p.customer_id , 
c.first_name as nombre_cliente,
c.last_name as apellido_cliente,
sum(p.amount) as total_gasto 
from payment p
join customer c on c.customer_id =p.customer_id 
group by p.customer_id,c.first_name, c.last_name
order by total_gasto desc 
limit 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

select first_name , last_name 
from actor a 
where first_name = 'Johnny';

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

select first_name as nombre, last_name as apellido
from actor a ;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

select min(actor_id) as id_minimo,
max(actor_id) as id_maximo 
from actor a ;

--38. Cuenta cuántos actores hay en la tabla “actor”.

 select count(*) 
 from actor a ;
 
 -- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

 select actor_id , first_name , last_name 
 from actor a 
 order by last_name desc;
 
 -- 40. Selecciona las primeras 5 películas de la tabla “film”.
 
 select title 
 from film f 
 limit 5;
 
 -- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
 
 select first_name ,
 count(*) as cantidad
 from actor a 
 group by first_name
 order by cantidad desc 
 limit 1;
 
 -- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
 
 select r.rental_id , 
 r.rental_date as fecha_alquiler,
 c.customer_id , 
 c.first_name as nombre_cliente, 
 c.last_name as apellido_cliente
 from rental r 
 join customer c on c.customer_id = r.customer_id
 order by r.rental_id desc;
 
 -- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
 
 select c.customer_id, c.first_name, c.last_name, r.rental_id, r.rental_date 
 from  customer c
 left join rental r on c.customer_id = r.customer_id
 order by c.first_name, c.last_name,r.rental_date ;
 
 -- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
 
 select f.film_id, f.title , c.category_id, c.name
 from film f
 cross join category c
 order by  f.film_id, c.category_id;
 
 		-- No aporta nada de valor esta consulta. El Cross Join no tiene sentido si no hay relación lógica entre películas y categorías. En un sistema de alquiler de películas, cada pelicula pertenece a una o más categorías, pero no a todas. Una consulta con 'InnerJoin' sería más útil porque solo muestra las categorías reales de cada película.
 
 -- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
 
 select a.actor_id , a.first_name ,a.last_name
 from actor a 
 join film_actor fa on fa.actor_id = a.actor_id 
 join film f on f.film_id = fa.film_id 
 join film_category fc on f.film_id =fc.film_id 
 join category c on fc.category_id =c.category_id 
 where c."name" ='Action'
 order by a.first_name , a.last_name ;
 
 -- 46. Encuentra todos los actores que no han participado en películas.
 select a.actor_id , a.first_name , a.last_name 
 from actor a 
 left join film_actor fa on fa.actor_id =a.actor_id 
 where fa.film_id is null 
 order by a.first_name ,a.last_name ;
 -- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
 
 select a.actor_id, concat(a.first_name,' ', a.last_name) as nombre_actor, count(fa.film_id) as total_peliculas
 from actor a
 left join film_actor fa on a.actor_id = fa.actor_id 
 group by a.actor_id , nombre_actor
 order by total_peliculas desc;
 
 -- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
 
 create views actor_num_peliculas as
 
 select a.actor_id , a.first_name , a.last_name , count(fa.film_id) as total_peliculas 
 from actor a 
 left join film_actor fa on fa.actor_id =a.actor_id 
 group by a.actor_id , a.first_name , a.last_name 
 order by a.actor_id asc ;
 
 -- 49. Calcula el número total de alquileres realizados por cada cliente.
 
 select c.customer_id , c.first_name ,c.last_name , count(r.rental_id) as total_alquileres
 from customer c 
 left join rental r on r.customer_id = c.customer_id 
 group by c.customer_id , c.first_name , c.last_name 
 order by total_alquileres desc ;
 
 -- 50. Calcula la duración total de las películas en la categoría 'Action'.
 
 select sum(f.length) as total_duracion 
 from film f 
 join film_category fc on f.film_id = fc.film_id 
 join category c on fc.category_id = c.category_id 
 where c."name" = 'Action';
 
 -- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
 
 create temporary  table  cliente_rentas_temporal as
 
 select c.customer_id , c.first_name , c.last_name ,
 count(r.rental_id) as total_alquileres 
 from customer c 
 left join rental r on c.customer_id = r.customer_id 
 group by  c.customer_id , c.first_name , c.last_name 
 order by c.customer_id , c.first_name , c.last_name;
 
 -- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
 
 create temporary table peliculas_alquiladas as
 
 select f.title, count(r.rental_id) as total_alquileres
 from film f 
 join inventory i on f.film_id = i.film_id 
 join rental r on i.inventory_id =r.inventory_id 
 group by f.film_id , f.film_id 
 having count(r.rental_id) >= 10;
  
-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
 
 select f.title
 from rental r
 join customer c on r.customer_id= r.customer_id
 join inventory i on i.inventory_id= r.inventory_id
 join film f on f.film_id= i.film_id
 where c.first_name = 'Tammy'
 	and c.last_name= 'Sanders'
 	and r.return_date is null
 order by f.title;
 
 -- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
 
select a.first_name , a.last_name 
from actor a
join film_actor fa on fa.actor_id =a.actor_id 
join film f on fa.film_id =f.film_id 
join film_category fc on fc.film_id =f.film_id 
join category c on fc.category_id =c.category_id 
where c."name" = 'Sci-Fi'
order by a.first_name , a.last_name ;

 -- 55.Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
 
SELECT a.first_name, a.last_name  
FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.actor_id 
JOIN film f ON f.film_id = fa.film_id 
JOIN inventory i ON f.film_id = i.film_id 
JOIN rental r ON i.inventory_id = r.inventory_id 
WHERE r.rental_date > (
    SELECT MIN(r.rental_date) 
    FROM film f 
    JOIN inventory i ON f.film_id = i.film_id 
    JOIN rental r ON i.inventory_id = r.inventory_id 
    WHERE f.title = 'Spartacus Cheaper'
)
ORDER BY a.last_name, a.first_name;


 -- 56.Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.

select a.first_name , a.last_name 
from actor a 
where a.actor_id not in (
	select fa.actor_id
	from film_actor fa 
	join film_category fc on fc.film_id =fa.film_id 
	join category c on c.category_id =fc.category_id 
	where c.name= 'Music'
	)
order by a.first_name ,a.last_name ;

 
 -- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

select distinct f.title
from rental r 
join inventory i on r.inventory_id = i.inventory_id 
join film f on i.film_id =f.film_id 
where extract (day from (r.return_date - r.rental_date)) > 8
order by f.title ;
 
 -- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.

select f.title 
from film f 
join film_category fc on fc.film_id= f.film_id 
where fc.category_id = (
	select c.category_id
	from category c 
	where name= 'Animation'
)
order by f.title ;

 
 -- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
 
select f.title
from film f 
where f.length = (

	select f.length  
	from film f 
	where f.title= 'Dancing Fever'
	)
order by f.title ;

 -- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
 
select c.first_name , c.last_name 
from customer c 
join rental r on r.customer_id =c.customer_id 
join inventory i on r.inventory_id =i.inventory_id 
join film f on f.film_id =i.film_id 
group by c.first_name ,c.last_name 
having count(distinct f.film_id) >= 7
order by c.first_name , c.last_name ;

 -- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

select c.name as categoria, count(r.rental_id) as total_alquileres
from rental r 
join inventory i on i.inventory_id =r.inventory_id 
join film f ON f.film_id = i.film_id 
join film_category fc on f.film_id =fc.film_id 
join category c on fc.category_id = c.category_id 
group by c.category_id, c."name" 
order by total_alquileres desc;

 -- 62. Encuentra el número de películas por categoría estrenadas en 2006.

select c."name" , count(f.film_id) as  total_peliculas 
from film f
join film_category fc on f.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
where f.release_year = 2006
group by c.category_id , c."name" 
order by total_peliculas desc;
 
 -- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
 
select s.first_name , s.last_name , s2.store_id as tienda
from staff s 
cross join store s2 
order by s.first_name , s.last_name , s2.store_id;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

select c.customer_id , c.first_name , c.last_name, count(r.rental_id) as total_alquileres 
from customer c 
left join rental r on c.customer_id =r.customer_id 
group by c.customer_id ,c.first_name , c.last_name 
order by total_alquileres desc;



