use world;
-- Question 1 : Count how many cities are there in each country? in sql
select c.country_name , count(ci.city_id) as city_count
from country c
left join city ci on c.country_code = ci.countrycode
group by c.country_name;

-- Question 2 : Display all continents having more than 30 countries
select continent from country group by continent having count(country_name) > 30;

-- Question 3 : List regions whose total population exceeds 200 million
select * from country_language;
select region from country where country_pop > 200000000;

-- Question 4 : Find the top 5 continents by average GNP per country. 
select continent ,
avg(gnp) as avg_gnp
from country 
group by continent
order by avg_gnp desc
limit 5;

-- Question 5 : Find the total number of official languages spoken in each continent
select c.continent,
count(distinct cl.language) as Total_official_language
from country c
join country_language cl
on c.country_code = cl.countrycode
where isofficial = 'T'
group by c.continent;

-- Question 6 : Find the maximum and minimum GNP for each continent.
select continent,
max(gnp) as max_gnp ,
min(gnp) as min_gnp from country 
group by continent;
select * from city;
-- Question 7 : Find the country with the highest average city population. 
select c.country_name ,
avg(ci.city_pop) as avg_city_poppulation
from country c
join city ci
on c.country_code = ci.countrycode
group by c.country_name
order by avg_city_poppulation desc
limit 1;

-- Question 8 : List continents where the average city population is greater than 200,000
select c.continent
from country c
join city ci
on c.country_code  =  ci.countrycode
group by c.continent
having avg(ci.city_pop) >200000;
select * from country;
-- Question 9 : Find the total population and average life expectancy for each continent, ordered by average life
-- expectancy descending -- 
select continent ,
sum(country_pop) as total_poppulation,
avg(lifeExpectancy) as avg_life_Expectancy
from country
group by continent
order by avg_life_expectancy desc;

-- Question 10 : Find the top 3 continents with the highest average life expectancy, but only include those where
-- tal population is over 200 million.

select continent ,
sum(country_pop) as total_poppulation,
avg(lifeExpectancy) as avg_life_expectancy
from country
group by continent
having sum(country_pop) > 200000000
order by avg_life_expectancy desc
limit 3;


