-- Netflix project---

create table netfix
(
 show_id varchar(6),
 type varchar(10),
 title varchar(150),
 director varchar(208),
 cast varchar(1000),
 country varchar(150),
 date_added 
)

-- Count the number of movies vs Tv shows--

select * from netflix;

select type, count(type) as total_content
from netflix
group by type;

--find the most common rating for TV shows and movies--

select type, rating
from (select type,rating,count(*),
RANK() OVER (PARTITION BY TYPE ORDER BY count(*) desc) as ranking
from netflix
group by 1,2) as t1
where ranking = '1' ;

-- list of all movies released in 2020--

select * from netflix;

select *
from netflix
where release_year = 2020 and
type = 'Movie';

--Find the top 5 countries with the most content on netflix--

select unnest(string_to_array(country,',')),count(show_id) as total_content
from netflix
where country is not null
group by 1
order by total_content desc
limit 5;

--identify the longest movie--

select * from netflix;

select *
from netflix
where type = 'Movie'
and duration = (select max(duration) 
from netflix);

--find the content added in the last 5 years--

select * from netflix
where release_year between 2020 and 2025;

--Find all movies and tv shows with director rajiv chilaka--

select type,director_name
from (select type,unnest(string_to_array(director,',')) as director_name
from netflix)
where director_name = 'Rajiv Chilaka';

--list all tv shows with more than 5 seasons--

select * FROM NETFLIX;

SELECT *
from netflix
where type = 'TV Show' 
and split_part(duration,' ',1) :: numeric > 5;

--COUNT THE NUMBER OF CONTENT ITEMS IN EACH GENRE--

SELECT count(type),UNNEST(STRING_TO_ARRAY(listed_in,',')) as Genre
from netflix
group by 2;

--list all movies that are documentries--

select * from netflix;

select *
from (select * ,unnest(string_to_array(listed_in,',')) as genre
from netflix)
where type = 'Movie'
and genre = 'Documentaries';

-- how many movies actor salman khan appeared in last ten years--

select * from netflix
where casts ilike '%Salman Khan%'
and release_year between 2015 and 2025;

-- categories movies based on key words (like kill and violense as bad and
-- others as good) based on description

WITH new_table
as 
(select * ,
case when description ilike '%kill%'or
          description ilike '%violence%' then 'Bad_content' else 
		  'Good Content'
		  END Category
from netflix)
select 
category,count(*) as total_content
from new_table
group by 1;








