create database research_project;
use research_project;
create table station(stationid char(5), 
stationname text, 
city char(100), 
 status text,
constraint s_pk primary key(stationid));
select * from station;
drop table station;
create table station_day(stationid char(5),
date text,
PM2_5 float,
PM10 float,
NO float,
NO2 float,
NOX float,
NH3 float,
CO float,
SO2 float,
O3 float,
benzene float,
Toulene float,
Xylene float,
AQI int,
AQI_Bucket text,
constraint s1_fk foreign key (stationid) references station(stationid));
drop table city_day;
select * from station;
create table city_day(city char(100),
date text,
PM2_5 float,
PM10 float,
NO float,
NO2 float,
NOX float,
NH3 float,
CO float,
SO2 float,
O3 float,
benzene float,
Toulene float,
Xylene float,
AQI int,
AQI_Bucket text);
select distinct(stationname),city from station order by city asc;
select city, count(stationid) from
(select city,count(stationid), dense_rank()over 
(Order by count(stationid) desc) 
as city_with_second_highest_number_stations from station)
as temp_table where city_with_second_highest_number_stations=2;
select city, count(stationname) from station group by city having count(stationname)=10;
select * from station;
select * from city_day where city='Mumbai';
select city, count(stationname) from station group by city order by count(stationname) desc;
alter table station rename column status to state;
update city_day set PM10 =NULL where PM10=0;
alter table city_day add column newdate date;
alter table station_day add column newdate date;
update city_day set  newdate =str_to_date(substr(date,1,10),'%d-%m-%YYYY');
update station_day set newdate = Str_to_date(substr(date,1,10),'%d-%m-%YYYY');
select * from city_day where PM2_5 is not NULL and month(newdate) between 1 and 5 and year(newdate)=2018;
select count(*), city from city_day where PM2_5 is NULL and year(newdate) >2017 and year(newdate)< 2020 group by city ;
select * from   station_day;
select * from city_day;



