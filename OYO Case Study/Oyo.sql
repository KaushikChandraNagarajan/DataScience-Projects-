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
 
/*Creating a database*/
create database oyo;
/*Use oyo as a database*/
use oyo;
/*Creating a table for booking details*/
create table oyo_hotels(
booking_id integer not null,
customer_id bigint,
 status text,
 check_in text,
 check_out text,
 no_of_rooms integer,
 hotel_id integer,
 amount float,
 discount float,
 date_of_booking text); 
/*Hotel details are imported directly as the file is small*/
/*No. of hotels in the dataset*/
select count(distinct(hotel_id)) from city_hotel;
/*No. of cities in the data set*/
select count(distinct(city)) from city_hotel;
/*Changing the check in , check out and date of booking to SQL format*/
alter table oyo_hotels add column newcheck_in date;
 update oyo_hotels 
 set newcheck_in = str_to_date(substr(check_in ,1,10),'%d-%m-%Y');
 alter table oyo_hotels add column newdate_of_booking date;
 update oyo_hotels 
 set newdate_of_booking = str_to_date(substr(date_of_booking ,1,10),'%d-%m-%Y');
 alter table oyo_hotels add column newcheck_out date;
 update oyo_hotels 
 set newcheck_out = str_to_date(substr(check_out ,1,10),'%d-%m-%Y');

/*No. of hotels by city*/
select count(hotel_id),city from city_hotel group by city;
/*New column price is added*/
/*Amount represents the money paid by the customer. So if discount is added then it represents the total cost which is shown as price*/
alter table oyo_hotels add column price float;
update oyo_hotels set price= amount + discount;
/*New column no.of nights is added.*/
update oyo_hotels set no_of_nights=datediff(newcheck_out, newcheck_in);
/*New column rate is added*/
alter table oyo_hotels add column rate float;
update oyo_hotels set rate = round(if(no_of_rooms=1, (price/no_of_nights), (price/no_of_nights)/no_of_rooms),2); /*If condition here says, if the no.of rooms booked is 1 then the price is divided by no_of nights else if the no.of rooms is greater than 1 then the price is divided by no.of nights which in turn is divided by no.of rooms. Rate represents price of a single room for single night*/

/*Average room rate by city*/
select round(avg(rate),2),city from oyo_hotels o, city_hotel c where o.hotel_id=c.hotel_id group by city order by 1 desc;

/*Bookings made in the months of January, February and March. This can even contain bookings made for months other than Jan, Feb and March also*/
select count(booking_id),city, month(newdate_of_booking) from oyo_hotels o, city_hotel c where month(newdate_of_booking) between 1 and 3 and o.hotel_id =c.hotel_id group by city, month(newdate_of_booking) order by city, month(newdate_of_booking);
/*Bookings made for the months of January, February and March. */
select count(booking_id),city, month(newcheck_in) from oyo_hotels o, city_hotel c where month(newcheck_in) between 1 and 3 and o.hotel_id =c.hotel_id group by city, month(newcheck_in) order by city, month(newcheck_in);



/*How many days prior the bookings were made*/
select count(*), datediff(newcheck_in, newdate_of_booking) from oyo_hotels group by 2 order by 2 asc;

/*No. of rooms of bookings. This query is for analysing the trend how many rooms are booked in each booking*/
select count(*), no_of_rooms from oyo_hotels group by 2 order by 2;
/*No. of nights of bookings. This query is for analysing the trend how many rooms are booked in each booking*/
select count(*), no_of_nights from oyo_hotels group by 2 order by 2;
/*Revenue by city*/
select sum(amount),city from oyo_hotels o, city_hotel c where o.hotel_id=c.hotel_id group by city;
/*Revenue by month */
select sum(amount),month(newdate_of_booking) from oyo_hotels  group by 2 order by 2;
/*Net Revenue by city. Net Revenue excludes the cancelled bookings*/
select sum(amount),city from oyo_hotels o, city_hotel c where o.hotel_id=c.hotel_id and status <> ‘Cancelled’ group by city;
/*Net Revenue by month*/
select sum(amount),month(newdate_of_booking) from oyo_hotels where status <>’Cancelled’  group by 2 order by 2;
/*Total Revenue*/
Select sum(amount) from oyo_hotels;
/*Net Revenue*/
Select sum(amount) from oyo_hotels where status <>’Cancelled’;
/*Discount by city*/
select avg(discount/price)*100,city from oyo_hotels o, city_hotel c where o.hotel_id=c.hotel_id group by city;
/*Discount by month*/
select avg(discount/price)*100,month(newdate_of_booking) from oyo_hotels o, city_hotel c where o.hotel_id=c.hotel_id group by month(newdate_of_booking);
