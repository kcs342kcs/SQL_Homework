use sakila;
# 1a.
select first_name,last_name from actor;
# 1b.
select upper(concat(first_name, " ",last_name)) as 'Actor Name' from actor;
# 2a.
select actor_id,first_name,last_name from actor where first_name = 'Joe';
# 2b.
select concat(first_name, " ",last_name) as 'Actor Name' from actor where last_name like '%GEN%';
# 2c.
select last_name,first_name from actor where last_name like '%LI%';
# 2d.
select country_id from country where country in ('Afghanistan','Bangladesh','China');
# 3a.
alter table actor add description blob;
# 3b.
alter table actor drop description;
# 4a.
select concat(first_name, " ",last_name) as 'Actor Name',count(*) as 'Count of Last Names' from actor group by last_name;
# 4b.
select last_name,count(*) as count from actor group by last_name having count(*) > 1;
# 4c.
update actor set first_name='HARPO' where first_name='GROUCHO' and last_name='WILLIAMS';
# 4d.
update actor set first_name='GROUCHO' where first_name='HARPO';
# 5a.
# below is the command to show how to create the table
show create table address;
# below is the sql command to create the address table it can't be run because the table already exists
#create table address (address_id SMALLINT(5) unsigned NOT NULL AUTO_INCREMENT, address VARCHAR(50) NOT NULL, address2 VARCHAR(50) DEFAULT NULL, district VARCHAR(20) NOT NULL, city_id SMALLINT(5) unsigned NOT NULL, postal_code VARCHAR(10) DEFAULT NULL, phone VARCHAR(20) NOT NULL, location GEOMETRY NOT NULL, last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, PRIMARY KEY (address_id), KEY idx_fk_city_id (city_id), SPATIAL KEY idx_location (location), CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES city (city_id) ON UPDATE CASCADE) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8;
# 6a.
select first_name,last_name,address from staff join address on staff.address_id = address.address_id;
# 6b.
select concat(staff.first_name," ",staff.last_name) as 'Staff Member', sum(payment.amount) as 'Total' from staff,payment where payment.payment_date between '2005-08-01' and '2005-08-31' and payment.staff_id = staff.staff_id group by staff.staff_id;
# 6c.
select title,count(actor_id) as 'Actor Count' from film inner join film_actor on film.film_id = film_actor.film_id where film.film_id = film_actor.film_id group by title;
# 6d.
select count(inventory.film_id) as '# of copies' from inventory,film where film.title = 'Hunchback Impossible' and film.film_id = inventory.film_id;
# 6e.
select customer.first_name,customer.last_name,sum(payment.amount) as 'Total Amount Paid' from customer,payment where customer.customer_id = payment.customer_id group by customer.last_name order by customer.last_name;
# 7a.
select film.title from film,language where film.title like 'K%' or film.title like 'Q%' and language.name = "English" and film.language_id = language.language_id group by film.title;
# 7b.
select first_name,last_name from actor where actor_id in (select film_actor.actor_id from film,film_actor where film.title = 'Alone Trip' and film.film_id = film_actor.film_id);
# 7c.
select customer.first_name,customer.last_name,customer.email from customer,customer_list where customer_list.country = 'Canada' and customer_list.ID = customer.customer_id;
# 7d.
select title as 'Family Films' from film where film_id in (select film.film_id from film,film_category,category where category.name = 'Family' and film_category.category_id = category.category_id and film_category.film_id = film.film_id);
# 7e.
select film.title,count(rental.inventory_id) as 'Rentals' from film,rental,inventory where inventory.inventory_id = rental.inventory_id and inventory.film_id = film.film_id group by rental.inventory_id order by Rentals DESC;
# 7f.
select store.store_id,sum(payment.amount) as 'Sales' from store,payment,staff where store.store_id = staff.store_id and payment.staff_id = staff.staff_id group by store.store_id;
# 7g.
select store.store_id,city.city,country.country from store,address,city,country where store.address_id = address.address_id and address.city_id = city.city_id and city.country_id = country.country_id group by store.store_id;
# 7h.
select category.name as 'Genres',sum(payment.amount) as 'Revenue' from category,film_category,inventory,payment,rental where category.category_id = film_category.category_id and film_category.film_id = inventory.film_id and inventory.inventory_id = rental.inventory_id and rental.rental_id = payment.rental_id group by category.name order by Revenue DESC limit 5;
# 8a.
create view genres_view as select category.name as 'Genres',sum(payment.amount) as 'Revenue' from category,film_category,inventory,payment,rental where category.category_id = film_category.category_id and film_category.film_id = inventory.film_id and inventory.inventory_id = rental.inventory_id and rental.rental_id = payment.rental_id group by category.name order by Revenue DESC limit 5;
# 8b.
select * from genres_view;
# 8c.
drop view genres_view;
