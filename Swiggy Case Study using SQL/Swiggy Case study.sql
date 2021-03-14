create database swiggy;
use swiggy;
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
select count(*) from pre_diwali;
select * from post_diwali;
drop table pre_diwali;
drop table post_diwali; 
alter table pre_diwali add column ndt date; 
update pre_diwali set ndt= str_to_date(substr(dt,1,10),'%d-%m-%Y');
alter table post_diwali add column ndt date; 
update post_diwali set ndt= str_to_date(substr(dt,1,10),'%d-%m-%Y');
select * from post_diwali;
select distinct(category) as item from pre_diwali where name like'%ADYAR%';
select count(distinct(item_name)) as item from post_diwali where name like'%ADYAR%';
select count(*) from pre_diwali;
drop view pre_sweet;
select * from pre_sweet;
select * from pre_diwali;
select sum(Item_GMV),name from pre_diwali group by name order by 1 desc;
create view pre_sweet as (select count(*) as Total from pre_diwali);
select distinct(Category) from pre_sweet;
select distinct(item_name) from pre_diwali where Category='Biryani';
select sum(item_GMV),name from pre_diwali group by name order by sum(Item_GMV) desc;
select distinct(name) from post_diwali where name not in(select name from pre_diwali) limit 100;
 select sum(item_GMV), category from pre_diwali group by category  having sum(item_GMV)>=1000 order by sum(item_GMV) desc;
 select sum(item_GMV),category from pre_diwali where sum(item_GMV)>1000 group by category order by sum(item_GMV) desc;
/*ANALYSIS OF PRE DIWALI */
use swiggy;
/*No. of rows in the table*/
select count(*) from pre_diwali;
/*Date period of the table*/
select distinct(ndt) from pre_diwali order by ndt asc;
select sum(orders) from post_diwali;
select sum(orders)/7 from pre_diwali;
/*DISTINCT ITEM_NAME AND NAME*//*NO. OF RESTAURANTS AND ITEMS*/
select count(distinct name) from pre_diwali;
select count(distinct category) from pre_diwali;
select count(distinct item_name) from pre_diwali;
select count(distinct city) from pre_diwali;
select sum(Item_GMV),name from pre_diwali  group by name order by 1 asc;
/*No.of orders of the table*/
select sum(orders) from pre_diwali;
select sum(orders) from post_diwali;
select sum(item_GMV),name from pre_diwali group by name order by 1 desc; 
select sum(item_GMV), city from pre_diwali group by city order by 1 desc;
select sum(item_GMV), item_name from pre_diwali group by 2 order by 1 desc;
select * from pre_diwali;
select * from post_diwali;
select sum(orders),hr_of_the_day from pre_diwali group by hr_of_the_day order by hr_of_the_day;
select sum(orders) as no_of_orders, 
dayname(ndt) as day, ndt as date from pre_diwali 
group by dayname(ndt), ndt order by ndt;
select sum(orders),name from pre_diwali group by name order by 1 desc;
select sum(orders),category from pre_diwali group by category order by 1 asc;
select * from pre_diwali where category like '%SOUTH%';
select sum(qty), item_name from pre_diwali group by item_name order by 1 desc;
select sum(orders), city from pre_diwali group by city order by 1 desc;
select sum(qty), item_name from pre_diwali group by item_name order by 1 desc;
/*POST DIWALI*/
select count(*) from post_diwali;
select count(distinct name) from post_diwali;
select count(distinct category) from post_diwali;
select count(distinct item_name) from post_diwali;
select count(distinct city) from post_diwali;

select sum(orders)/7 from pre_diwali;
select sum(orders),hr_of_the_day from post_diwali group by hr_of_the_day order by 1 desc;
select sum(orders),name from post_diwali group by name order by 1 desc;
select sum(orders),item_name,name from post_diwali group by item_name order by 1 desc;
select sum(orders),city,name from post_diwali group by city order by 1 desc;
select sum(orders), category from post_diwali group by name order by 1 desc;
select sum(orders), ndt, dayname(ndt) from post_diwali group by ndt order by ndt;
select sum(orders), hr_of_the_day ;
create view temp3 as(select distinct(item_name) from post_diwali);
create view temp4 as(select distinct(item_name) from pre_diwali);
select name from temp2 where name not in(select name from temp1); 
select sum(orders), name from pre_diwali group by name order by 1 desc;
select count(distinct city) from post_diwali; 
select sum(qty), category from post_diwali group by category;
select sum(qty), item_name from post_diwali group by item_name order by 1;
select sum(orders)/10 from post_diwali;

select sum(item_GMV),name from post_diwali group by name order by 1 desc; 
select sum(item_GMV), city from post_diwali group by city order by 1 desc;
select sum(item_GMV), item_name from post_diwali group by 2 order by 1 desc;

select item_name from pre_diwali where name not in (select item_name from post_diwali); 