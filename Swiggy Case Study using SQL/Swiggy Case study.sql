create database swiggy;
use swiggy;
/*Creating tables pre_diwali and post_diwali*/
create table pre_diwali(dt text, 
id integer, 
city integer, 
name text, 
item_id bigint, 
item_name text, 
Hr_of_the_day integer, 
orders integer, 
qty integer,
Item_GMV integer, 
Category text);
create table post_diwali(dt text, 
id integer, 
city integer, 
name text, 
item_id bigint,
item_name text, 
Hr_of_the_day integer, 
orders integer, 
qty integer,
Item_GMV integer, 
Category text);
/*No. of rows in the table*/
select count(*) from pre_diwali;

/*Date period of the table*/
select distinct(ndt) from pre_diwali order by ndt asc;


/*No.of restaurants*/
select count(distinct name) from pre_diwali; 

/*No.of Categories*/
select count(distinct category) from pre_diwali;
/*No.of items*/
select count(distinct item_name) from pre_diwali;

/*No.of cities*/
select count(distinct city) from pre_diwali;

select sum(Item_GMV),name from pre_diwali  group by name order by 1 asc;

/*Orders of pre diwali table*/

/*No.of orders */
select sum(orders) from pre_diwali;

/*No.of orders based on the time/hr of the day*/
select sum(orders),hr_of_the_day from pre_diwali group by hr_of_the_day order by hr_of_the_day;

/*No.of orders based on day and date*/
select sum(orders) as no_of_orders, 
dayname(ndt) as day, ndt as date from pre_diwali 
group by dayname(ndt), ndt order by ndt;

/*No.of orders based on the restaurant*/
select sum(orders),name from pre_diwali group by name order by 1 desc;

/*No. of orders based on the category*/
select sum(orders),category from pre_diwali group by category order by 1 desc;

/*No.of orders based on the city*/
select sum(orders), city from pre_diwali group by city order by 1 desc;






/*Quantity of pre Diwali table*/

/*Quantity Based on item*/
select sum(qty), item_name from pre_diwali group by item_name order by 1 desc;

/*Quantity Based on Category*/
select sum(qty), category from pre_diwali group by category order by 1 desc;


/*GMV of pre Diwali table*/

/*GMV based on restaurant*/
select sum(item_GMV),name from post_diwali group by name order by 1 desc; 

/*GMV based on city*/
select sum(item_GMV), city from post_diwali group by city order by 1 desc;

/*GMV based on item name*/
select sum(item_GMV), item_name from post_diwali group by 2 order by 1 desc;

/*POST DIWALI*/


/*No. of rows in the table*/
select count(*) from post_diwali;

/*Date period of the table*/
select distinct(ndt) from post_diwali order by ndt asc;


/*No.of restaurants*/
select count(distinct name) from post_diwali; 

/*No.of Categories*/
select count(distinct category) from post_diwali;

/*No.of items*/
select count(distinct item_name) from post_diwali;

/*No.of cities*/
select count(distinct city) from post_diwali;



/*Orders of post Diwali table*/

/*No.of orders */
select sum(orders) from post_diwali;

/*No.of orders based on the time/hr of the day*/
select sum(orders),hr_of_the_day from post_diwali group by hr_of_the_day order by hr_of_the_day;

/*No.of orders based on day and date*/
select sum(orders) as no_of_orders, 
dayname(ndt) as day, ndt as date from post_diwali 
group by dayname(ndt), ndt order by ndt;

/*No.of orders based on the restaurant*/
select sum(orders),name from post_diwali group by name order by 1 desc;

/*No. of orders based on the category*/
select sum(orders),category from post_diwali group by category order by 1 desc;

/*No.of orders based on the city*/
select sum(orders), city from post_diwali group by city order by 1 desc;






/*Quantity of Post Diwali Table*/

/*Quantity Based on item*/
select sum(qty), item_name from post_diwali group by item_name order by 1 desc;

/*Quantity Based on Category*/
select sum(qty), category from post_diwali group by category order by 1 desc;

/*GMV of Post Diwali Table*/

/*GMV based on restaurant*/
select sum(item_GMV),name from post_diwali group by name order by 1 desc; 

/*GMV based on city*/
select sum(item_GMV), city from post_diwali group by city order by 1 desc;

/*GMV based on item name*/
select sum(item_GMV), item_name from post_diwali group by 2 order by 1 desc;

/*Average daily orders of both the tables*/
select sum(orders)/7 from pre_diwali;
select sum(orders)/10 from post_diwali;/*Div by 10 because post Diwali period is for 10 days*/


/*Restaurants not present in the pre Diwali table but present in the post Diwali table and vice versa*/

create view temp2 as(select distinct(item_name) from post_diwali);
create view temp1 as(select distinct(item_name) from pre_diwali);

/*Restaurants present in post Diwali but not present in pre Diwali.*/
select name from temp2 where name not in (select item_name from temp1);

/*Restaurants present in pre Diwali but not present in post Diwali.*/
select name from temp1 where item_name not in (select item_name from temp1);



/*Items not present in the pre Diwali table but present in the post Diwali table and vice versa*/

/*Views were created  using the concept of distinct as it was easy to execute*/

create view temp3 as(select distinct(item_name) from post_diwali);
create view temp4 as(select distinct(item_name) from pre_diwali);

/*Items present in post Diwali but not present in pre Diwali.*/
select item_name from temp3 where item_name not in (select item_name from temp4);

/*Items present in pre Diwali but not present in post Diwali.*/
select item_name from temp4 where item_name not in (select item_name from temp3);




