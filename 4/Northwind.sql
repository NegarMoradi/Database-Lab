-- 1

select r.region_description , t.territory_description 

from region r inner join territories t on r.region_id = t.region_id;




-- 2

select distinct c.category_name , count(p.product_id) over (partition by c.category_name) as discount_amount

from products p inner join categories c on p.category_id = c.category_id 

where p.discontinued = 1

order by discount_amount desc;


-- 3
select distinct od.order_id , sum(od.quantity * od.unit_price * (1 - od.discount)) over (partition by od.order_id) as total_paid

from order_details od;




-- 3.2


select distinct c.customer_id , sum(od.quantity * od.unit_price * od.discount) over (partition by c.customer_id) as total_discount

from  customers c inner join orders o on o.customer_id = c.customer_id inner join order_details od on od.order_id = o.order_id

order by total_discount desc

limit 10;


-- 4


select distinct p.product_name , count(od.order_id) over (partition by p.product_name) as order_counts

from products p inner join order_details od on p.product_id = od.product_id 

order by order_counts desc 

limit 10;


-- 5

select p.product_name 

from products p left join order_details od on p.product_id = od.product_id

where od.order_id is null;


-- 6

select distinct c.category_name , count(od.order_id) over (partition by c.category_name) as order_counts

from (categories c left outer join products p on p.category_id = c.category_id) 

inner join order_details od on p.product_id = od.product_id 


-- 7

with orders_in_year as
(
	select distinct o.order_id , o.employee_id from orders o where extract(year from o.order_date) = 1996
), orders_amount_in_year as
(
	select distinct od.order_id, o2.employee_id , sum(od.unit_price * od.quantity * (1 - od.discount))
	over (partition by od.order_id) as total_paid
	from orders_in_year o2 inner join order_details od on o2.order_id = od.order_id 
)
select distinct e.employee_id , e.last_name, sum (oy.total_paid) 
	over (partition by e.employee_id) as solds_amount
	from employees e left join orders_amount_in_year oy on e.employee_id = oy.employee_id
	
order by solds_amount desc 
limit 1;


-- 8
select o.order_id ,
	case
		when o.shipped_date = o.order_date then 'Perfect'
		when o.shipped_date - o.order_date <= 3 then 'Good'
		else 'Bad'
	end order_label
from orders o;


-- 9

with recursive reporters as 
(
	(select e.employee_id, e.first_name , e.last_name , e.reports_to as manager_id
	from employees e
	where e.employee_id = 8)
	union
		(select e2.employee_id, e2.first_name , e2.last_name , e2.reports_to  
		from employees e2 
		inner join reporters r on e2.employee_id  = r.manager_id)
) 
select *
from reporters r;


-- 10

create view products_that_need_recorder as
(
	select p.product_id , p.product_name , p.units_in_stock 
	from products p 
	where p.units_in_stock < p.reorder_level
	order by p.units_in_stock asc
);
select * from products_that_need_recorder;


-- 11

select distinct c.category_name , count(o.order_id) 
over (partition by c.category_name) as order_counts
from orders o
	inner join order_details od on o.order_id = od.order_id 
	inner join products p on od.product_id = p.product_id 
	inner join categories c on c.category_id = p.category_id
where o.ship_country = 'Germany'

order by order_counts desc 


-- 12

select c.customer_id , c.contact_name 
from customers c 
where c.fax is null;

