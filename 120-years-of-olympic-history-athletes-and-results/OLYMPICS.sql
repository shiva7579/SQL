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

--11.SQL Query to fetch the top 5 athletes who have won the most medals (Medals include gold, silver and bronze).
WITH t1 AS(
        SELECT name,count(medal) as medal,team
         FROM olympics_history
        WHERE medal <> 'NA'
        GROUP BY name,team
        ),
t2 AS (
     SELECT t1.*,DENSE_Rank() OVER(order by medal DESC) as rnk
	 FROM t1
	 )
SELECT t2.name as NAME,
       t2.team as Team,
	   t2.medal as Medal
	   FROM t2
	   WHERE rnk<=5
       ORDER BY rnk ;
	 
--12.SQL query to fetch the top 5 athletes who have won the most gold medals.
WITH t1 AS(
   SELECT name,Count(medal) as medal,team
	FROM olympics_history
	WHERE medal='Gold'
	GROUP BY name,team),
t2 AS (
     SELECT t1.*,DENSE_Rank() OVER(order by medal DESC) as rnk
	 FROM t1
	 )
SELECT t2.name as NAME,
       t2.team as Team,
	   t2.medal as Gold_Medal
	   FROM t2
	   WHERE rnk<=5
       ORDER BY rnk ;

--13.Write a SQL query to fetch the top 5 most successful countries in olympics. (Success is defined by no of medals won).
WITH t1 AS(
   SELECT nr.region,Count(oh.medal) as medal
	FROM olympics_history oh
	JOIN olympics_history_noc_regions nr ON oh.noc=nr.noc
	WHERE medal <>'NA'
	GROUP BY nr.region),
t2 AS (
     SELECT t1.*,DENSE_Rank() OVER(order by medal DESC) as rnk
	 FROM t1
	 )
SELECT t2.region as Country,
       t2.medal as Total_medal_won,
	   t2.rnk as Rank
	   FROM t2
	   WHERE rnk<=5
       ORDER BY rnk ;

--14.List down total gold, silver and bronze medals won by each country.
SELECT nr.region,
COUNT(CASE WHEN medal='Gold' THEN medal END) AS Total_gold_medal,
COUNT(CASE WHEN medal='Silver' THEN medal END) AS Total_silver_medal,
COUNT(CASE WHEN medal='Bronze' THEN medal END) AS Total_bronze_medal
FROM olympics_history oh
   JOIN olympics_history_noc_regions nr ON nr.noc = oh.noc
   GROUP BY nr.region
   ORDER BY Total_gold_medal DESC;
   
--15.Write a SQL query to list down the  total gold, silver and bronze medals won by each country corresponding to each olympic games.
SELECT oh.games,nr.region,
   COUNT(CASE WHEN medal='Gold' THEN 'medal'  END) AS Gold,
   COUNT(CASE WHEN medal='Silver' THEN 'medal'  END) AS Silver,
   COUNT(CASE WHEN medal='Bronze' THEN 'medal'  END) AS Bronze
   FROM olympics_history oh
   JOIN olympics_history_noc_regions nr ON nr.noc = oh.noc
   GROUP BY oh.games,nr.region
   ORDER BY oh.games,nr.region;

--16. Write SQL query to display for each Olympic Games, which country won the highest gold, silver and bronze medals.
WITH t1 AS(
SELECT oh.games,nr.region,
   COUNT(CASE WHEN medal='Gold' THEN 'medal'  END) AS Gold,
   COUNT(CASE WHEN medal='Silver' THEN 'medal'  END) AS Silver,
   COUNT(CASE WHEN medal='Bronze' THEN 'medal'  END) AS Bronze,
   MAX(COUNT(CASE WHEN medal='Gold' THEN 'medal' END)) OVER (Partition by games) AS max_gold,
   MAX(COUNT(CASE WHEN medal='Silver' THEN 'medal' END)) OVER (Partition by games) AS max_silver, 
   MAX(COUNT(CASE WHEN medal='Bronze' THEN 'medal' END)) OVER (Partition by games) AS max_bronze 
   FROM olympics_history oh
   JOIN olympics_history_noc_regions nr ON nr.noc = oh.noc
   GROUP BY oh.games,nr.region),
t2 AS (
SELECT Distinct(t1.games),
CASE WHEN t1.Gold=t1.max_gold THEN concat(t1.region,'-',t1.max_gold) END AS Max_Gold_by_region,
CASE WHEN t1.Silver=t1.max_silver THEN concat(t1.region,'-',t1.max_silver) END AS Max_Silver_by_region,
CASE WHEN t1.Bronze=t1.max_bronze THEN concat(t1.region,'-',t1.max_bronze) END AS Max_Bronze_by_region
FROM t1)
SELECT t2.games,
string_agg(t2.Max_Gold_by_region,' ') AS Max_Gold_by_region,
string_agg(t2.Max_Silver_by_region,' ') AS Max_Silver_by_region,
string_agg(t2.Max_Bronze_by_region,' ') AS Max_Bronze_by_region
FROM t2
GROUP BY t2.games
ORDER BY t2.games;

--17.Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.

WITH t1 AS(
SELECT oh.games,nr.region,
   COUNT(CASE WHEN medal='Gold' THEN 'medal'  END) AS Gold,
   COUNT(CASE WHEN medal='Silver' THEN 'medal'  END) AS Silver,
   COUNT(CASE WHEN medal='Bronze' THEN 'medal'  END) AS Bronze,
   COUNT(CASE WHEN medal<>'NA' THEN 'medal' END) AS Total_no_of_medal,
   MAX(COUNT(CASE WHEN medal='Gold' THEN 'medal' END)) OVER (Partition by games) AS max_gold,
   MAX(COUNT(CASE WHEN medal='Silver' THEN 'medal' END)) OVER (Partition by games) AS max_silver, 
   MAX(COUNT(CASE WHEN medal='Bronze' THEN 'medal' END)) OVER (Partition by games) AS max_bronze,
   MAX(COUNT(CASE WHEN medal<>'NA' THEN 'medal' END)) OVER (Partition by games) AS max_medals
   FROM olympics_history oh
   JOIN olympics_history_noc_regions nr ON nr.noc = oh.noc
   GROUP BY oh.games,nr.region),
t2 AS (
SELECT Distinct(t1.games),
CASE WHEN t1.Gold=t1.max_gold THEN concat(t1.region,'-',t1.max_gold) END AS Max_Gold_by_region,
CASE WHEN t1.Silver=t1.max_silver THEN concat(t1.region,'-',t1.max_silver) END AS Max_Silver_by_region,
CASE WHEN t1.Bronze=t1.max_bronze THEN concat(t1.region,'-',t1.max_bronze) END AS Max_Bronze_by_region,
CASE WHEN t1.Total_no_of_medal=t1.max_medals THEN concat(t1.region,'-',t1.max_medals) END AS Max_Medals_by_region
FROM t1)
SELECT t2.games,
string_agg(t2.Max_Gold_by_region,' ') AS Max_Gold_by_region,
string_agg(t2.Max_Silver_by_region,' ') AS Max_Silver_by_region,
string_agg(t2.Max_Bronze_by_region,' ') AS Max_Bronze_by_region,
string_agg(t2.Max_Medals_by_region,' ') AS Max_Medals_by_region
FROM t2
GROUP BY t2.games
ORDER BY t2.games;

--18.Write a SQL Query to fetch details of countries which have won silver or bronze medal but never won a gold medal.
WITH t1 AS(
SELECT nr.region,
   COUNT(CASE WHEN medal='Gold' THEN 'medal'  END) AS Gold,
   COUNT(CASE WHEN medal='Silver' THEN 'medal'  END) AS Silver,
   COUNT(CASE WHEN medal='Bronze' THEN 'medal'  END) AS Bronze
   FROM olympics_history oh
   JOIN olympics_history_noc_regions nr ON nr.noc = oh.noc
   GROUP BY nr.region
   ORDER BY nr.region),
t2 AS(
SELECT t1.region,
	t1.Gold,t1.Silver,t1.Bronze
	FROM t1
	WHERE t1.Gold='0' AND (t1.Silver>0 OR t1.Bronze>0))
SELECT * FROM t2;
	





 
 
 
 
 
 
 
 
 
 
 
 
 
 