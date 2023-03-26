--1.Write a SQL query to find the total no of Olympic Games held as per the dataset.
SELECT COUNT(DISTINCT(games)) AS total_no_of_games_held
FROM olympics_history;

--2.Write a SQL query to list down all the Olympic Games held so far.
WITH t1 as (
SELECT DISTINCT(games) AS total_no_of_games_held,
year,
season,
city 
FROM olympics_history)
SELECT year AS Year,
season As Season,
city As City
FROM t1
ORDER BY Year;

SELECT DISTINCT year,season,city
FROM olympics_history
ORDER BY year;

--3.SQL query to fetch total no of countries participated in each olympic games.
SELECT oh.games,
COUNT(DISTINCT(nr.region)) as No_of_countries
FROM olympics_history oh 
JOIN olympics_history_noc_regions nr ON 
nr.noc=oh.noc
GROUP BY oh.games
ORDER BY oh.games;

--4.Write a SQL query to return the Olympic Games which had the highest participating countries and the lowest participating countries.

WITH t1 AS (SELECT oh.games,
            COUNT(DISTINCT(nr.region)) as No_of_countries
            FROM olympics_history oh 
            JOIN olympics_history_noc_regions nr ON 
            nr.noc=oh.noc
            GROUP BY oh.games
            ORDER BY oh.games)
 SELECT DISTINCT
      concat(first_value(games) over(order by No_of_countries)
      , ' - '
      , first_value(No_of_countries) over(order by No_of_countries)) as Lowest_Countries,
      concat(first_value(games) over(order by No_of_countries desc)
      , ' - '
      , first_value(No_of_countries) over(order by No_of_countries desc)) as Highest_Countries
      from t1;
     
--5.SQL query to return the list of countries who have been part of every Olympics games.
WITH t1 AS (SELECT COUNT(DISTINCT(games)) AS total_no_of_games
			FROM olympics_history),
t2 AS (SELECT COUNT(DISTINCT(oh.games)) as no_of_participations,
            nr.region
            FROM olympics_history oh 
            JOIN olympics_history_noc_regions nr ON 
            nr.noc=oh.noc
            GROUP BY nr.region
            ORDER BY nr.region)
SELECT t2.region AS Countries
,t2.no_of_participations FROM t2
JOIN t1 ON t2.no_of_participations=t1.total_no_of_games;

--6.SQL query to fetch the list of all sports which have been part of every summer olympics.
WITH t1 AS (
SELECT sport,COUNT(DISTINCT(games)) as no_of_participation from olympics_history
WHERE season='Summer'
GROUP BY sport
ORDER BY no_of_participation DESC),
t2 AS (
SELECT COUNT(DISTINCT(games)) as no_of_games from olympics_history
WHERE season='Summer')
SELECT t1.sport AS Sports,
       t1.no_of_participation AS No_of_participation,
	   t2.no_of_games AS Total_no_of_games
FROM t1 JOIN t2 ON t1.no_of_participation=t2.no_of_games
ORDER BY Sports;

--7.Using SQL query, Identify the sport which were just played once in all of olympics.
WITH t1 AS(SELECT sport,COUNT(DISTINCT(games)) as no_of_participation
        from olympics_history
        GROUP BY sport),
t2 AS (SELECT t1.sport,
	  t1.no_of_participation
	  FROM t1
	  WHERE no_of_participation=1 )
SELECT DISTINCT(oh.games) as Games,
       t2.sport,
       t2.no_of_participation
	   FROM t2 JOIN olympics_history oh
       ON t2.sport=oh.sport
	   ORDER BY t2.sport;

WITH t1 AS(
      SELECT DISTINCT(games),
      sport
      FROM olympics_history
	  ORDER BY sport),
t2 AS (SELECT
	   t1.sport,
	   count(1) AS total_no_of_participations
	   from t1
	  GROUP BY t1.sport)
SELECT t2.*,t1.games
FROM t2 JOIN t1 ON t1.sport=t2.sport
WHERE t2.total_no_of_participations=1;

--8.Write SQL query to fetch the total no of sports played in each olympics.
WITH t1 AS(
SELECT 
DISTINCT(sport),
games
FROM olympics_history
ORDER BY games),
t2 AS(SELECT
      t1.games,
      count(1) AS No_of_sports
      FROM t1
	 GROUP BY t1.games)
SELECT * FROM t2;

--9.SQL Query to fetch the details of the oldest athletes to win a gold medal at the olympics.
SELECT * FROM olympics_history;
WITH t1 AS(
    SELECT name,
       sex,
	   CAST(CASE WHEN age='NA' THEN '0' else age end as int) as age,
	   height,
	   weight,
	   team,
	   noc,
	   games,
	   year,
	   season,
	   city,
	   sport,
	   event,
	   medal
FROM olympics_history),
t2 AS(SELECT max(t1.age) as oldest
	  FROM t1
	 WHERE t1.medal='Gold')
SELECT t1.* FROM t2
JOIN t1 ON t2.oldest=t1.age
WHERE t1.medal='Gold';

WITH t1 AS(
    SELECT name,
       sex,
	   CAST(CASE WHEN age='NA' THEN '0' else age end as int) as age,
	   height,
	   weight,
	   team,
	   noc,
	   games,
	   year,
	   season,
	   city,
	   sport,
	   event,
	   medal
FROM olympics_history),
t2 AS(SELECT *,DENSE_rank() OVER(ORDER BY t1.age DESC) AS rank
	  FROM t1
	 WHERE t1.medal='Gold')
SELECT * FROM t2
WHERE t2.rank=1;
 
--10.Write a SQL query to get the ratio of male and female participants
WITH t1 AS(
SELECT COUNT(1) AS male
FROM olympics_history
WHERE sex='M'),
t2 AS (
SELECT COUNT(1) AS female
FROM olympics_history
WHERE sex='F')
SELECT concat('1 : ', round(t1.male::decimal/t2.female, 2)) as ratio 
FROM t2,t1;











SELECT * FROM olympics_history;
with t1 as(
 SELECT COUNT(DISTINCT(games)) as total_number_of_games
 FROM olympics_history 
 WHERE season='Summer'
),
t2 AS (
SELECT 	DISTINCT(sport),games
FROM olympics_history 
 WHERE season='Summer' ORDER BY games
),
t3 AS (
SELECT sport,COUNT(games) as no_of_games
FROM t2
GROUP BY sport
)
SELECT * FROM t3
JOIN t1 ON t1.total_number_of_games=t3.no_of_games;

WITH t1 AS(
 SELECT name ,Count(1) as total_medal
 FROM olympics_history
 WHERE medal='Gold'
 GROUP BY name
 ORDER BY total_medal DESC),
t2 AS (
SELECT name,total_medal,Dense_rank() over(order by total_medal DESC) as rnk
FROM t1 )
SELECT * FROM t2 
WHERE rnk<=5;

SELECT country
    ,COALESCE(gold,0) AS gold
    ,COALESCE(silver,0) AS silver
    ,COALESCE(bronze,0) AS bronze
 FROM crosstab(
     'SELECT nr.region as country,
     oh.medal,
     count(1) AS total_medal
     FROM olympics_history oh
     JOIN olympics_history_noc_regions nr ON nr.noc=oh.noc
     WHERE oh.medal <> ''NA''
     GROUP BY country,oh.medal
     ORDER BY country,oh.medal',
     'VALUES (''Gold''),(''Silver''),(''Bronze'')')
 AS RESULT (Country varchar,gold bigint,silver bigint,bronze bigint)
 ORDER BY gold DESC,silver DESC,bronze DESC;

  SELECT country
    	, coalesce(gold, 0) as gold
    	, coalesce(silver, 0) as silver
    	, coalesce(bronze, 0) as bronze
    from crosstab('SELECT nr.region as country
    			, medal
    			, count(1) as total_medals
    			FROM olympics_history oh
    			JOIN olympics_history_noc_regions nr ON nr.noc = oh.noc
    			where medal <> ''NA''
    			GROUP BY nr.region,medal
    			order BY nr.region,medal',
            'values (''Bronze''), (''Gold''), (''Silver'')')
    AS RESULT(country varchar, bronze bigint, gold bigint, silver bigint)
    order by gold desc, silver desc, bronze desc;


















 
 
 
 
 
 
 
 
 
 
 
 
 
 