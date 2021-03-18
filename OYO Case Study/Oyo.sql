create database oyo;
use oyo;
create table oyo_hotels(
booking_id integer not null,
customer_id bigint,
 source text,
 status text,
 check_in text,
 check_out text,
 no_of_rooms integer,
 hotel_id integer,
 amount float,
 discount float,
 date_of_booking text); 
 select * from oyo_hotels;
 show tables;
 select * from city_hotel;
 alter table oyo_hotels add column newcheck_in date;
 update oyo_hotels 
 set newcheck_in = str_to_date(substr(check_in ,1,10),'%d-%m-%Y');
 alter table oyo_hotels add column newdate_of_booking date;
 update oyo_hotels 
 set newdate_of_booking = str_to_date(substr(date_of_booking ,1,10),'%d-%m-%Y');
 alter table oyo_hotels add column newcheck_out date;
 update oyo_hotels 
 set newcheck_out = str_to_date(substr(check_out ,1,10),'%d-%m-%Y');
 select round(avg(amount),2)as average_rate_in_Jan,city 
 from oyo_hotels o ,city_hotel c 
 where o.hotel_id=c.hotel_id and month(newcheck_in)=1 group by city; 
 select round(avg(amount),2)as average_rate,city 
 from oyo_hotels o ,city_hotel c 
 where o.hotel_id=c.hotel_id group by city; 
 select avg(discount),city from oyo_hotels o, city_hotel c where o.hotel_id=c.hotel_id group by city;
 select max(newcheck_in) from oyo_hotels;
 select distinct(month(newdate_of_booking)) from oyo_hotels;
select distinct(month(newcheck_in)), count(customer_id),month(newcheck_in) from oyo_hotels group by 3;
select * , datediff(newcheck_out,newcheck_in) as no_of_nights from oyo_hotels having datediff(newcheck_out,newcheck_in)>10;
select round((discount/amount),2)*100,city from oyo_hotels o, city_hotel c 
where o.hotel_id=c.hotel_id 
group by city ;
alter table oyo_hotels add column price float;
update oyo_hotels set price= amount + discount;
select (discount/price)*100 as discount, city, o.hotel_id 
from oyo_hotels o, city_hotel c where o.hotel_id=c.hotel_id 
group by o.hotel_id;
select * from city_hotel;
select * from oyo_hotels;
select sum(amount) from oyo_hotels; 
select sum(amount) from oyo_hotels where status='stayed' or status='No show';

select *, 
datediff(newcheck_in, newdate_of_booking)
as booked_before_days from oyo_hotels order by datediff(newcheck_in, newdate_of_booking);
select 
select count(booking_id)as Bookings,city,status 
from oyo_hotels o, city_hotel c 
where o.hotel_id=c.hotel_id group by city,status;
select distinct(status) from oyo_hotels;
select distinct(city) from city_hotel;
update oyo_hotels set status= 'Stayed' where status =2;
update oyo_hotels set status= 'Cancelled' where status =3;
update oyo_hotels set status= 'No Show' where status =4;