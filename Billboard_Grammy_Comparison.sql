
--Total Chart Weeks by Top Artists
SELECT Top 10
	Artists,
	SUM(WeeksOnChart) As "Total Weeks on Chart"
FROM Billboard_Chart
WHERE WeeksOnChart IS NOT NULL
GROUP BY Artists
ORDER BY "Total Weeks on Chart" desc

--Total Chart Weeks by Top Songs
SELECT Top 10
	Name,
	SUM(WeeksOnChart) As "Total Weeks on Chart"
FROM Billboard_Chart
WHERE WeeksOnChart IS NOT NULL
GROUP BY Name
ORDER BY "Total Weeks on Chart" desc

--Most Awarded Artist 
SELECT 
	Artist,
	count(GrammyAward) As "Award_Count"
FROM Grammy
WHERE Artist != ' '
GROUP BY Artist
ORDER BY Award_Count Desc

--Most Awarded Genre 
SELECT 
	Genre,
	count(GrammyAward) As "Award_Count"
FROM Grammy
GROUP BY Genre
ORDER BY Award_Count Desc

--Award Count and Chart Apperance
WITH GrammyAwardCounts AS (
    SELECT Artist, COUNT(GrammyAward) AS GrammyAwardsCount
    FROM Grammy 
    GROUP BY Artist
),
BillboardChartCounts AS (
    SELECT Artists, COUNT(Name) AS ChartAppearances
    FROM Billboard_Chart B
    GROUP BY Artists
)
SELECT G.Artist, G.GrammyAwardsCount, B.ChartAppearances
FROM GrammyAwardCounts G
INNER JOIN BillboardChartCounts B ON G.Artist = B.Artists
ORDER BY G.GrammyAwardsCount DESC, B.ChartAppearances DESC;

--Most Awarded Genre by each year
WITH GenreRank As
	(SELECT
	GrammyYear As "Year",
	Genre,
	count(GrammyAward) As "AwardCount",
	DENSE_RANK() OVER(partition by GrammyYear order by count(GrammyAward) desc) As "Rank"
FROM Grammy
GROUP BY GrammyYear,Genre)
SELECT G.Year,G.Genre,G.AwardCount
FROM GenreRank G
WHERE G.Rank=1
ORDER BY G.Year DESC

--Top 10 Song with highest peak position
SELECT Top 10
	Name, 
	Artists, 
	PeakPosition
FROM Billboard_Chart
WHERE PeakPosition IS NOT NULL
ORDER BY PeakPosition

--Grammy Winning Song on Billboard Chart
SELECT b.Name, b.Artists,g.GrammyAward, g.GrammyYear
FROM Billboard_Chart b
JOIN Grammy g ON b.Name = g.Name;









